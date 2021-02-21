

CREATE PROCEDURE dbo.sp_AtualizaComposicao
@Data        datetime,
@Percentual  decimal(10,5),
@Indice      int
/* PauloR         - 27/02/2004 - Rotina que atualiza os débitos a vencer conforme configurado na tela de parâmetros */
/* Rodrigo Landim - 03/03/2005 - Atualiza renegociações com data atual e outros débitos da maneira antiga */
AS
SET NOCOUNT ON

DECLARE 
  @flTotal Decimal(10,2), 
  @flDiferenca Decimal(10,2), 
  @IdDebito  int,  
  @IdDebitoOrig int, 
  @IdCompDebi int, 
  @ValorDevido Decimal(10,2),
  @ValorEsperadoPrincipal Decimal(10,2), 
  @ValorEsperadoAtualizacao Decimal(10,2), 
  @ValorEsperadoMulta Decimal(10,2),
  @ValorEsperadoJuros Decimal(10,2), 
  @ValorEsperadoDespBco Decimal(10,2), 
  @ValorEsperadoDespAdv Decimal(10,2),
  @ValorEsperadoDespPostais Decimal(10,2), 
  @ValorEsperado Decimal(10,2), 
  @flVlrAtualizado Decimal(10,2),
  @Registros int, 
  @StrSQL varchar(100),
  @IdRenegociacao INT,
  @IdRecobranca INT

SELECT @IdRenegociacao = IdTipoDebito FROM TiposDebito WHERE NomeDebito = 'Renegociação'
SELECT @IdRecobranca   = IdTipoDebito FROM TiposDebito WHERE NomeDebito = 'Recobrança'

SET @Percentual = ( @Percentual/100 ) + 1

DECLARE OrigDeb_Cursor
CURSOR FAST_FORWARD FOR

SELECT IdDebito, ValorDevido 
FROM Debitos 
WHERE IdSituacaoAtual in (1,3)
AND   NumeroParcela <> 0 
/**/
AND  ((IdTipoDebito     IN (@IdRenegociacao, @IdRecobranca) AND DataVencimento >= CONVERT(VARCHAR(10), GETDATE(), 112)) OR
      (IdTipoDebito NOT IN (@IdRenegociacao, @IdRecobranca) AND DataVencimento >= CONVERT(VARCHAR(10), @Data    , 112)))
/**/
AND    IdTipoDebito     IN (SELECT IdTipoDebito FROM AtualizacaoIndices WHERE IdIndice = @Indice) 
ORDER BY IdDebito
OPEN OrigDeb_Cursor

FETCH NEXT FROM OrigDeb_Cursor
INTO @IdDebitoOrig, @ValorDevido

DECLARE CompDeb_Cursor
CURSOR SCROLL FOR

SELECT 
  IdDebito,
  ISNULL(ValorEsperadoPrincipal, 0) AS ValorEsperadoPrincipal, 
  ISNULL(ValorEsperadoAtualizacao, 0) AS ValorEsperadoAtualizacao,  ISNULL(ValorEsperadoMulta, 0) AS ValorEsperadoMulta, 
  ISNULL(ValorEsperadoJuros, 0) AS ValorEsperadoJuros, ISNULL(ValorEsperadoDespBco, 0) AS ValorEsperadoDespBco,
  ISNULL(ValorEsperadoDespAdv, 0) AS ValorEsperadoDespAdv, ISNULL(ValorEsperadoDespPostais, 0) AS ValorEsperadoDespPostais, IdComposicaoDebito
FROM ComposicoesDebito WHERE EXISTS (
  SELECT TOP 1 1 FROM Debitos 
  WHERE ComposicoesDebito.IdDebito = Debitos.IdDebito 
  AND NumeroParcela <> 0 
  AND IdSituacaoAtual in (1,3)  
  /**/
  AND  ((IdTipoDebito     IN (@IdRenegociacao, @IdRecobranca) AND DataVencimento >= CONVERT(VARCHAR(10), GETDATE(), 112)) OR
        (IdTipoDebito NOT IN (@IdRenegociacao, @IdRecobranca) AND DataVencimento >= CONVERT(VARCHAR(10), @Data    , 112)))
  /**/
  AND EXISTS (SELECT IdTipoDebito FROM AtualizacaoIndices  WHERE IdIndice = @Indice AND Debitos.IdTipoDebito = AtualizacaoIndices.IdTipoDebito) 
)
ORDER BY IdDebito
OPEN CompDeb_Cursor

SET @Registros = 0

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Registros = @Registros + 1
	SET @flVlrAtualizado  = (@ValorDevido * @Percentual)

	UPDATE Debitos 
	SET ValorDevido = @flVlrAtualizado
	WHERE IdDebito = @IdDebitoOrig

   	FETCH NEXT FROM CompDeb_Cursor
	INTO @IdDebito, @ValorEsperadoPrincipal, @ValorEsperadoAtualizacao, @ValorEsperadoMulta, @ValorEsperadoJuros,
		@ValorEsperadoDespBco, @ValorEsperadoDespAdv, @ValorEsperadoDespPostais, @IdCompDebi

	SET @flTotal = 0
	SET @flDiferenca = 0

	WHILE ( @@FETCH_STATUS = 0 )  AND  (@IdDebito = @IdDebitoOrig)
	BEGIN
		SET @flTotal = ROUND( @ValorEsperadoPrincipal + @ValorEsperadoAtualizacao +  @ValorEsperadoMulta + @ValorEsperadoJuros +
		           @ValorEsperadoDespBco + @ValorEsperadoDespAdv + @ValorEsperadoDespPostais , 2) 		
		SET @ValorEsperado = ROUND (@ValorEsperadoAtualizacao + (( @Percentual * @flTotal) - @flTotal), 2)

		UPDATE ComposicoesDebito 
		SET ValorEsperadoAtualizacao = @ValorEsperado
		WHERE IdComposicaoDebito =  @IdCompDebi

		SET @flDiferenca = ROUND (@flDiferenca + @ValorEsperadoPrincipal + @ValorEsperado +  @ValorEsperadoMulta + @ValorEsperadoJuros +
		               @ValorEsperadoDespBco + @ValorEsperadoDespAdv + @ValorEsperadoDespPostais, 2)
		
   		FETCH NEXT FROM CompDeb_Cursor
		INTO @IdDebito,  @ValorEsperadoPrincipal, @ValorEsperadoAtualizacao, @ValorEsperadoMulta, @ValorEsperadoJuros,
			@ValorEsperadoDespBco, @ValorEsperadoDespAdv, @ValorEsperadoDespPostais, @IdCompDebi
	END

	FETCH PRIOR FROM CompDeb_Cursor
	INTO @IdDebito,  @ValorEsperadoPrincipal, @ValorEsperadoAtualizacao, @ValorEsperadoMulta, @ValorEsperadoJuros, @ValorEsperadoDespBco, @ValorEsperadoDespAdv, @ValorEsperadoDespPostais, @IdCompDebi

	IF @flDiferenca <> @flVlrAtualizado
	BEGIN
		IF @flDiferenca > @flVlrAtualizado
		BEGIN
			UPDATE ComposicoesDebito 
			SET ValorEsperadoAtualizacao = ValorEsperadoAtualizacao - (@flDiferenca - @flVlrAtualizado)
			WHERE IdComposicaoDebito =  @IdCompDebi		
		END
		ELSE
		BEGIN
			UPDATE ComposicoesDebito 
			SET ValorEsperadoAtualizacao = ValorEsperadoAtualizacao + (@flVlrAtualizado - @flDiferenca )
			WHERE IdComposicaoDebito =  @IdCompDebi
		END
	END 	

   	FETCH NEXT FROM OrigDeb_Cursor
  	INTO @IdDebitoOrig, @ValorDevido

END 

CLOSE CompDeb_Cursor
DEALLOCATE CompDeb_Cursor 

CLOSE OrigDeb_Cursor
DEALLOCATE OrigDeb_Cursor
SELECT @Registros




