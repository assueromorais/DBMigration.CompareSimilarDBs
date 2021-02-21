/*Oc. 132475*/
CREATE  PROCEDURE [dbo].[sp_ChecaConsistenciaRenegociacao]
@IdProfissional int = -1,
@lFisica int,
@Executar bit,
@NumConj bigint,
@ParamSQL varchar(8000),
@VerificarTodasPagas bit = 0 

AS

/* function Calc_Ufir, function Calc_PagoMenor */

SET NOCOUNT ON 
DECLARE @TextoSQl varchar(8000), @IdRenegociacao int, @IdRecobranca int,   @NumConjRen INT
DECLARE @TemOrigem bit, @Pagou bit, @ValorDevido float, @ValorEsperado float, @ValorPagoPrincipal float, @ValorPago float
DECLARE  @Qtde as Int, 	@MRPercent Decimal(10,2), @MRValor Decimal(10,2), @MRDif Decimal(10,2), @Desconto Float

SELECT @IdRenegociacao = IdTipoDebito FROM TiposDebito WHERE NomeDebito = 'Renegociação'
SELECT @IdRecobranca = IdTipoDebito FROM TiposDebito WHERE NomeDebito = 'Recobrança'
SELECT  @MRPercent = ISNULL(ValorMargemRecebPercentual, 0), @MRValor = ISNULL(ValorMargemReceb, 0)  FROM ParametrosSiscafW

IF @IdProfissional <> -1
BEGIN
	SET @TextoSQl = 'SELECT DISTINCT IdProfissional, NumConjReneg, 0 as Ok, 1 AS Fisica, ''  '' AS Causa FROM Debitos WHERE IdProfissional = ' + RTRIM(CAST(@IdProfissional AS CHAR(10)))  +
		        ' AND IdTipoDebito IN ( ' + RTRIM(CAST(@IdRenegociacao AS CHAR(10))) + ', ' + RTRIM(CAST( @IdRecobranca AS CHAR(10))) +
			' ) AND NumConjReneg IS NOT NULL AND NumConjReneg = ' + RTRIM(CAST(@NumConj AS CHAR(12)))  +
			' ORDER BY IdProfissional, NumConjReneg ' 

	IF @lFisica = 0
		SET @TextoSQl = 'SELECT DISTINCT IdPessoaJuridica AS IdProfissional, NumConjReneg, 0 AS Ok,  0 AS Fisica, '' '' AS Causa FROM Debitos WHERE IdPessoaJuridica = '  + RTRIM(CAST(@IdProfissional AS CHAR(10)))  +
		 '  AND  IdTipoDebito IN ( ' + RTRIM(CAST(@IdRenegociacao AS CHAR(10))) + ', ' + RTRIM(CAST( @IdRecobranca AS CHAR(10))) +
		 ' )  AND NumConjReneg IS NOT NULL AND NumConjReneg = ' + RTRIM(CAST(@NumConj AS CHAR(12))) +
   	              ' ORDER BY IdProfissional, NumConjReneg ' 
	IF @lFisica = 2
		SET @TextoSQl = 'SELECT DISTINCT IdPessoa AS IdProfissional, NumConjReneg, 0 AS Ok,  2 AS Fisica, '' '' AS Causa FROM Debitos WHERE IdPessoa = '  + RTRIM(CAST(@IdProfissional AS CHAR(10)))  +
		 '  AND  IdTipoDebito IN ( ' + RTRIM(CAST(@IdRenegociacao AS CHAR(10))) + ', ' + RTRIM(CAST( @IdRecobranca AS CHAR(10))) +
		 ' )  AND NumConjReneg IS NOT NULL AND NumConjReneg = ' + RTRIM(CAST(@NumConj AS CHAR(12))) +
   	              ' ORDER BY IdProfissional, NumConjReneg '	
END
ELSE
	SET @TextoSQl = @ParamSQL	

CREATE TABLE #tmpConsist (IdProfissional int, NumConjRen int, Ok bit, Fisica int, Causa varchar(30) COLLATE database_default ) 
INSERT INTO #tmpConsist
EXEC(@TextoSQl)

/*Oc132475 - Garante a transação*/
IF NOT EXISTS (SELECT TOP 1 * FROM #tmpConsist)
BEGIN
  IF @Executar = 1
	SELECT 0 AS IdProfissional, 0 AS NumConjRen, CAST(0 AS BIT) AS Ok, CAST(@lFisica AS int) AS Fisica , ' ' AS Causa
  ELSE
	SELECT * FROM #tmpConsist
  RETURN	
END

DECLARE Renegociacoes_Cursor
CURSOR FAST_FORWARD FOR
SELECT IdProfissional int, NumConjRen int
FROM #tmpConsist
OPEN Renegociacoes_Cursor
FETCH NEXT FROM Renegociacoes_Cursor
INTO @IdProfissional, @NumConjRen

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @lFisica = 1
		SET @TemOrigem = ISNULL((SELECT TOP 1 1 WHERE EXISTS (SELECT TOP 1 1 FROM Debitos 
							WHERE IdProfissional = @IdProfissional 
							AND NumConjReneg = @NumConjRen 
							AND IdSituacaoAtual IN (6,14) )), 0)
	IF @lFisica = 0
		SET @TemOrigem = ISNULL((SELECT TOP 1 1 WHERE EXISTS (SELECT TOP 1 1 FROM Debitos 
							WHERE IdPessoaJuridica = @IdProfissional 
							AND NumConjReneg = @NumConjRen 
							AND IdSituacaoAtual IN (6,14) )), 0)
	IF @lFisica = 2
		SET @TemOrigem = ISNULL((SELECT TOP 1 1 WHERE EXISTS (SELECT TOP 1 1 FROM Debitos 
							WHERE IdPessoa = @IdProfissional 
							AND NumConjReneg = @NumConjRen 
							AND IdSituacaoAtual IN (6,14) )), 0)
	IF @lFisica = 1
		SET @Pagou = ISNULL((SELECT TOP 1 1 WHERE EXISTS (SELECT TOP 1 1 FROM Debitos 
								WHERE IdProfissional = @IdProfissional 
								AND NumConjReneg = @NumConjRen 
								AND ValorPago > 0 AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) )), 0)
	IF @lFisica = 0
		SET @Pagou = ISNULL((SELECT TOP 1 1 WHERE EXISTS (SELECT TOP 1 1 FROM Debitos 
								WHERE IdPessoaJuridica = @IdProfissional 
								AND NumConjReneg = @NumConjRen 
								AND ValorPago > 0 AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) )), 0)
	IF @lFisica = 2
		SET @Pagou = ISNULL((SELECT TOP 1 1 WHERE EXISTS (SELECT TOP 1 1 FROM Debitos 
								WHERE IdPessoa = @IdProfissional 
								AND NumConjReneg = @NumConjRen 
								AND ValorPago > 0 AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) )), 0) 	

	IF @TemOrigem = 0
		UPDATE #tmpConsist SET Ok = 0, Causa = 'Renegociação sem Deb. Origem'  WHERE IdProfissional = @IdProfissional AND NumConjRen = @NumConjRen 
	ELSE
	BEGIN
		IF @Pagou = 1
		BEGIN	
			SET @Qtde = 0 /* 13518*/
			IF @lFisica = 1
				SELECT @Qtde = ISNULL(Count(IdDebito), 0)
				FROM Debitos D
				WHERE IdProfissional = @IdProfissional
				AND NumConjReneg = @NumConjRen
				AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao)
				GROUP BY IdProfissional, NumConjReneg
				HAVING COUNT(IdDebito) = (SELECT COUNT(IdDebito) 
							FROM Debitos 
							WHERE IdProfissional = D.IdProfissional AND NumConjReneg = D.NumConjReneg
							AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) 
							AND ValorPago > 0 AND IdSituacaoAtual IN (2,4,5,8,11))
				ORDER BY IdProfissional, NumConjReneg
			IF @lFisica = 0
				SELECT @Qtde = ISNULL(Count(IdDebito), 0)
				FROM Debitos D
				WHERE IdPessoaJuridica = @IdProfissional
				AND NumConjReneg = @NumConjRen
				AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao)
				GROUP BY IdPessoaJuridica, NumConjReneg
				HAVING COUNT(IdDebito) = (SELECT COUNT(IdDebito) 
							FROM Debitos 
							WHERE IdPessoaJuridica = D.IdPessoaJuridica AND NumConjReneg = D.NumConjReneg
							AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) 
							AND ValorPago > 0 AND IdSituacaoAtual IN (2,4,5,8,11))
				ORDER BY IdPessoaJuridica, NumConjReneg
			IF @lFisica = 2
				SELECT @Qtde = ISNULL(Count(IdDebito), 0)
				FROM Debitos D
				WHERE IdPessoa = @IdProfissional
				AND NumConjReneg = @NumConjRen
				AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao)
				GROUP BY IdPessoa, NumConjReneg
				HAVING COUNT(IdDebito) = (SELECT COUNT(IdDebito) 
							FROM Debitos 
							WHERE IdPessoa = D.IdPessoa AND NumConjReneg = D.NumConjReneg
							AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) 
							AND ValorPago > 0 AND IdSituacaoAtual IN (2,4,5,8,11))
				ORDER BY IdPessoa, NumConjReneg
                                       			
			IF (@Qtde > 0) AND (@VerificarTodasPagas = 0)
				UPDATE #tmpConsist SET Ok = 0, Causa = 'Parcela(s) Paga(s)'  WHERE IdProfissional = @IdProfissional and NumConjRen = @NumConjRen
			ELSE
			BEGIN
				IF @lFisica = 1	
				BEGIN
					SELECT  @ValorDevido = ISNULL(Sum(
					CASE WHEN ISNULL(ValorPago,0) > 0
						THEN 
							dbo.Calc_PagoMenor ( IdDebito, 1 ) 
						ELSE
							CASE 
							WHEN IdMoeda = 2 THEN
								dbo.Calc_Ufir(ValorDevido, DataVencimento, CASE WHEN DataAtualizacao IS NOT NULL THEN DataAtualizacao ELSE '20001030' END, IdMoeda) 
							WHEN IdMoeda = 3 THEN
								dbo.Calc_URH(ValorDevido, CASE WHEN DataAtualizacao IS NOT NULL THEN DataAtualizacao ELSE GetDate() END, IdMoeda)	
							ELSE
								ISNULL(ValorDevido,0)
							END
					END),0)
					FROM Debitos WHERE IdProfissional = @IdProfissional
					AND NumConjReneg = @NumConjRen AND IdSituacaoAtual IN (6,14)

					SELECT  @Desconto = ISNULL(SUM( ISNULL( Desconto, 0) ),0)
					FROM Debitos WHERE IdProfissional = @IdProfissional
					AND NumConjReneg = @NumConjRen AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) 

				END
				IF @lFisica = 0	
				BEGIN
					SELECT  @ValorDevido = ISNULL(Sum(
					CASE WHEN ISNULL(ValorPago,0) > 0
						THEN 
							dbo.Calc_PagoMenor ( IdDebito, 1 ) 
						ELSE
							CASE 
							WHEN IdMoeda = 2 THEN
								dbo.Calc_Ufir(ValorDevido, DataVencimento, CASE WHEN DataAtualizacao IS NOT NULL THEN DataAtualizacao ELSE '20001030' END, IdMoeda) 
							WHEN IdMoeda = 3 THEN
								dbo.Calc_URH(ValorDevido, CASE WHEN DataAtualizacao IS NOT NULL THEN DataAtualizacao ELSE GetDate() END, IdMoeda)
							ELSE
								Isnull(ValorDevido,0)
							END
					END),0)
					FROM Debitos WHERE IdPessoaJuridica = @IdProfissional




					AND NumConjReneg = @NumConjRen AND IdSituacaoAtual IN (6,14)

					SELECT  @Desconto = ISNULL(SUM( ISNULL( Desconto, 0) ),0)
					FROM Debitos WHERE IdPessoaJuridica = @IdProfissional
					AND NumConjReneg = @NumConjRen AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) 
				END
				IF @lFisica = 2
				BEGIN
					SELECT  @ValorDevido = ISNULL(Sum(
					CASE WHEN ISNULL(ValorPago,0) > 0
						THEN 
							dbo.Calc_PagoMenor ( IdDebito, 1 ) 
						ELSE
							CASE 
							WHEN IdMoeda = 2 THEN
								dbo.Calc_Ufir(ValorDevido, DataVencimento, CASE WHEN DataAtualizacao IS NOT NULL THEN DataAtualizacao ELSE '20001030' END, IdMoeda) 
							WHEN IdMoeda = 3 THEN
								dbo.Calc_URH(ValorDevido, CASE WHEN DataAtualizacao IS NOT NULL THEN DataAtualizacao ELSE GetDate() END, IdMoeda)
							ELSE
								Isnull(ValorDevido,0)
							END
					END),0)
					FROM Debitos WHERE IdPessoa = @IdProfissional
					AND NumConjReneg = @NumConjRen AND IdSituacaoAtual IN (6,14)

					SELECT  @Desconto = ISNULL(SUM( ISNULL( Desconto, 0) ),0)
					FROM Debitos WHERE IdPessoa = @IdProfissional
					AND NumConjReneg = @NumConjRen AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) 

				END

				IF @lFisica = 1
					SELECT @ValorEsperado = SUM(ISNULL(ValorEsperadoPrincipal,0) + ISNULL(ValorDescontoPrincipal,0))   
					FROM ComposicoesDebito WHERE IdDebito IN ( SELECT Debitos.IdDebito FROM Debitos 
											join ComposicoesDebito on ComposicoesDebito.IdDebito = Debitos.IdDebito
											WHERE Debitos.IdProfissional = @IdProfissional
											AND Debitos.NumConjReneg = @NumConjRen AND Debitos.IdTipoDebito IN (@IdRecobranca, @IdRenegociacao))
				IF @lFisica = 0
					SELECT @ValorEsperado = SUM(ISNULL(ValorEsperadoPrincipal,0) + ISNULL(ValorDescontoPrincipal,0))
					FROM ComposicoesDebito WHERE IdDebito IN ( SELECT Debitos.IdDebito FROM Debitos 
											join ComposicoesDebito on ComposicoesDebito.IdDebito = Debitos.IdDebito
											WHERE Debitos.IdPessoaJuridica = @IdProfissional
											AND Debitos.NumConjReneg = @NumConjRen AND Debitos.IdTipoDebito IN (@IdRecobranca, @IdRenegociacao))
				IF @lFisica = 2
					SELECT @ValorEsperado = SUM(ISNULL(ValorEsperadoPrincipal,0) + ISNULL(ValorDescontoPrincipal,0))
					FROM ComposicoesDebito WHERE IdDebito IN ( SELECT Debitos.IdDebito FROM Debitos 
											join ComposicoesDebito on ComposicoesDebito.IdDebito = Debitos.IdDebito
											WHERE IdPessoa = @IdProfissional
											AND Debitos.NumConjReneg = @NumConjRen AND Debitos.IdTipoDebito IN (@IdRecobranca, @IdRenegociacao))
				IF @lFisica = 1
					SELECT @ValorPago = ISNULL(Sum( ISNULL(ValorPago,0)) ,0)
					FROM Debitos WHERE IdProfissional = @IdProfissional
					AND NumConjReneg = @NumConjRen AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) 
				IF @lFisica = 0
					SELECT @ValorPago = ISNULL(Sum( ISNULL(ValorPago,0)) ,0)
					FROM Debitos WHERE IdPessoaJuridica = @IdProfissional
					AND NumConjReneg = @NumConjRen AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) 
				IF @lFisica = 2
					SELECT @ValorPago = ISNULL(Sum( ISNULL(ValorPago,0)) ,0)
					FROM Debitos WHERE IdPessoa = @IdProfissional
					AND NumConjReneg = @NumConjRen AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) 

			
				IF @lFisica = 1
					SELECT @ValorPagoPrincipal = ISNULL(Sum( ISNULL(ValorPagoPrincipal,0) + ISNULL(ValorPagoAtualizacao,0)+
						ISNULL(ValorPagoMulta,0) +  ISNULL(ValorPagoJuros,0)
					+  ISNULL(ValorPagoDespBco,0) + ISNULL(ValorPagoDespAdv,0) +  ISNULL(ValorPagoDespPostais,0)/*DM41788*/
					),0)
					FROM ComposicoesDebito 
					WHERE IdDebito IN ( SELECT Debitos.IdDebito FROM Debitos 
							join ComposicoesDebito on ComposicoesDebito.IdDebito = Debitos.IdDebito
							WHERE IdProfissional = @IdProfissional
							AND NumConjReneg = @NumConjRen AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao))
				IF @lFisica = 0
					SELECT @ValorPagoPrincipal = ISNULL(Sum( ISNULL(ValorPagoPrincipal,0) + ISNULL(ValorPagoAtualizacao,0)+
						ISNULL(ValorPagoMulta,0) +  ISNULL(ValorPagoJuros,0)
					+  ISNULL(ValorPagoDespBco,0) + ISNULL(ValorPagoDespAdv,0) +  ISNULL(ValorPagoDespPostais,0)/*DM41788*/
					),0)
					FROM ComposicoesDebito 
					WHERE IdDebito IN ( SELECT Debitos.IdDebito FROM Debitos 
							join ComposicoesDebito on ComposicoesDebito.IdDebito = Debitos.IdDebito
							WHERE IdPessoaJuridica = @IdProfissional
							AND NumConjReneg = @NumConjRen AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao))
				IF @lFisica = 2
					SELECT @ValorPagoPrincipal = ISNULL(Sum( ISNULL(ValorPagoPrincipal,0) + ISNULL(ValorPagoAtualizacao,0)+
						ISNULL(ValorPagoMulta,0) +  ISNULL(ValorPagoJuros,0)
					+  ISNULL(ValorPagoDespBco,0) + ISNULL(ValorPagoDespAdv,0) +  ISNULL(ValorPagoDespPostais,0)/*DM41788*/
					),0)
					FROM ComposicoesDebito 
					WHERE IdDebito IN ( SELECT Debitos.IdDebito FROM Debitos 
							join ComposicoesDebito on ComposicoesDebito.IdDebito = Debitos.IdDebito
							WHERE IdPessoa = @IdProfissional
							AND NumConjReneg = @NumConjRen AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao))

				IF ( CAST(@ValorDevido AS CHAR(20)) = CAST(@ValorEsperado AS CHAR(20)) ) AND 
				   ( CAST(@ValorPago AS CHAR(20)) = CAST(@ValorPagoPrincipal AS CHAR(20)) )
					UPDATE #tmpConsist SET Ok = 1, Causa = 'OK' WHERE IdProfissional = @IdProfissional AND NumConjRen = @NumConjRen 			
				ELSE
				BEGIN
			               	SET @MrDif = 0
			              	IF @MRPercent > 0 
			             			SET @MRDif = (@ValorPagoPrincipal / 100) * @MRPercent
			              	IF @MRValor > 0 
			                		SET @MRDif = @MRValor

					IF ( @ValorEsperado = 0 ) OR (@ValorPagoPrincipal = 0 and @ValorPago > 0)
						UPDATE #tmpConsist SET Ok = 0, Causa = 'Reneg. sem Composição'   WHERE IdProfissional = @IdProfissional AND NumConjRen = @NumConjRen 
					ELSE
					BEGIN
						IF CAST(@ValorPago AS CHAR(20)) <> CAST(@ValorPagoPrincipal AS CHAR(20))
						BEGIN
					              	IF ((@ValorPagoPrincipal + @MRDif) >= @ValorPago) and ((@ValorPagoPrincipal - @MRDif) <= @ValorPago) 
								UPDATE #tmpConsist SET Ok = 1, Causa = 'Ok' WHERE IdProfissional = @IdProfissional AND NumConjRen = @NumConjRen 			
					              	IF (@ValorPagoPrincipal - @MRDif) > @ValorPago 
								UPDATE #tmpConsist SET Ok = 0, Causa = 'Erro Composição Paga -'   WHERE IdProfissional = @IdProfissional AND NumConjRen = @NumConjRen 
					              	IF (@ValorPagoPrincipal + @MRDif) < @ValorPago 
								UPDATE #tmpConsist SET Ok = 0, Causa = 'Erro Composição Paga +'   WHERE IdProfissional = @IdProfissional AND NumConjRen = @NumConjRen 
						END
						ELSE
						BEGIN
							IF CAST(@ValorDevido AS CHAR(20)) <> CAST(@ValorEsperado AS CHAR(20))
							BEGIN
						               	SET @MrDif = 0
						              	IF @MRPercent > 0 
						             			SET @MRDif = (@ValorEsperado / 100) * @MRPercent
						              	IF @MRValor > 0 
						                		SET @MRDif = @MRValor
								IF CAST(@ValorDevido AS CHAR(20)) <> CAST(@ValorEsperado AS CHAR(20))
								BEGIN
							              	IF ((@ValorEsperado + @MRDif) >= @ValorDevido) and ((@ValorEsperado - @MRDif) <= @ValorDevido) 
										UPDATE #tmpConsist SET Ok = 1, Causa = 'Ok' WHERE IdProfissional = @IdProfissional AND NumConjRen = @NumConjRen 			
							              	IF (@ValorEsperado - @MRDif) > @ValorDevido 
										UPDATE #tmpConsist SET Ok = 0, Causa = 'Composição Inconsistente -'   WHERE IdProfissional = @IdProfissional AND NumConjRen = @NumConjRen 
							              	IF (@ValorEsperado + @MRDif) < @ValorDevido 				
										UPDATE #tmpConsist SET Ok = 0, Causa = 'Composição Inconsistente +'   WHERE IdProfissional = @IdProfissional AND NumConjRen = @NumConjRen 
								END
							END
						END
					END
				END
			END
		END
		ELSE
			UPDATE #tmpConsist SET Ok = 1, Causa = 'Ok' WHERE IdProfissional = @IdProfissional AND NumConjRen = @NumConjRen 
	END
	FETCH NEXT FROM Renegociacoes_Cursor
	INTO @IdProfissional, @NumConjRen
END
CLOSE Renegociacoes_Cursor
DEALLOCATE Renegociacoes_Cursor

IF @Executar = 1
BEGIN
	EXEC sp_DesfazRenegociacao 'SELECT * FROM #tmpConsist WHERE Ok = 1'
	SELECT 0 AS IdProfissional, 0 AS NumConjRen, CAST(0 AS BIT) AS Ok, CAST(@lFisica AS int) AS Fisica , ' ' AS Causa
END
ELSE
	SELECT * FROM #tmpConsist
