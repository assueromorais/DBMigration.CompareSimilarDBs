

/*oc. 24646*/ 
CREATE  PROCEDURE dbo.sp_ComposicaoDebitoAjuste
@IdProfissional int,
@NumConjRen int,
@DataCalculo datetime,
@lFisica bit,
@lRenegociacao bit,
@IdDebito int,
@lEmissao bit = 0

AS

/* function AchaProcedimento, function Calc_Ufir, function Calc_PagoMenor, function AtualizaDebitosAll, function AchaProcedimento */

SET NOCOUNT ON

DECLARE @IdDebitoOrig int, @IdDebitoDest int,  @ValorOrig Decimal(10,2), @ValorParc Decimal(10,2), @IdMoedaOrig int, @ValorPago Decimal(10,2), @ValorPrincipal Decimal(10,2),
      @DataVcto datetime,  @Saldo Decimal(10,2), @SaldoAtual Decimal(10,2), @Multa Decimal(10,2), @Juros Decimal(10,2), @Atualizacao Decimal(10,2), @IdProcedimento int, 
      @IdTpDebito int, @TotalAtual Decimal(10,2), @MultaPgto Decimal(10,2), @JurosPgto Decimal(10,2), @AtualizacaoPgto Decimal(10,2), @Principal Decimal(10,2), @IdDebCotaUnica int, 
      @PercentAcresc Decimal(10,2), @IndAcresc Float, @TextoSql Varchar(8000), @ValorTmp Decimal(10,2), @Resto Decimal(10,2), @NumParc int, @SubPrincipal Decimal(10,2),
      @IdRenegociacao int, @IdRecobranca int, @teste decimal(10,2), @Registros int, @CodErro int, @Diferenca Decimal(10,2), @ParcUnica bit, @IdSituacao int, @RotinaAcrescimo int,
      @TotalOrigem Decimal (10,2), @TotalParcelas Decimal (10,2), @IdDebitoParc int, @PrincipalParc Decimal(10,2), @MultaJuros Decimal(10,2), @ValorMulta Decimal(10,2), @ValorJuros Decimal(10,2),
      @QtdeParcelas int, @RecNo int, @First bit, @NumeroParcelaOrigem int	


CREATE TABLE #tmpAtualiza (Multa float, Juros float, Atualizacao float, Total float, PercAtualiz float, PercMulta float, PercJuros float, IdProcedimento float)

SELECT  @PercentAcresc = ISNULL(PercAcrescimoCumulativo, 0) FROM ParametrosSiscafw
SET @IndAcresc = 1
SET @Saldo = 0
SET @Registros = 0
SET @Diferenca = 0
SET @SaldoAtual = 0
SET @ParcUnica = 0
SET @IdDebCotaUnica = 0
SET @IdDebitoParc = 0
SET @RecNo = 1
SET @First = 0

SELECT @IdRenegociacao = IdTipoDebito FROM TiposDebito WHERE NomeDebito = 'Renegociação'
SELECT @IdRecobranca = IdTipoDebito FROM TiposDebito WHERE NomeDebito = 'Recobrança'

IF @lFisica = 1
  SET @ParcUnica = ISNULL((SELECT 1 WHERE EXISTS (SELECT TOP 1 1 FROM Debitos WHERE IdProfissional = @IdProfissional AND NumConjReneg = @NumConjRen AND NumeroParcela > 0 AND (IdTipoDebito = @IdRenegociacao OR IdTipoDebito = @IdRecobranca))), 0)
ELSE
  SET @ParcUnica = ISNULL((SELECT 1 WHERE EXISTS (SELECT TOP 1 1 FROM Debitos WHERE IdPessoaJuridica = @IdProfissional AND NumConjReneg = @NumConjRen AND NumeroParcela > 0 AND (IdTipoDebito = @IdRenegociacao OR IdTipoDebito = @IdRecobranca))), 0)

IF @lRenegociacao = 1
BEGIN
  SET @IdDebito = 0
  /*Debitos de origem */
  IF @lFisica = 1
  BEGIN
	
    DECLARE OrigDeb_Cursor
    SCROLL CURSOR FOR
    SELECT IdDebito, IdMoeda, 
	   CASE WHEN ValorPago > 0 THEN dbo.Calc_PagoMenor(IdDebito, 1) ELSE ValorDevido END, 
	   DataVencimento, IdTipoDebito, IdSituacaoAtual, ValorPago
    FROM Debitos
    WHERE IdProfissional = @IdProfissional AND NumConjReneg = @NumConjRen AND (IdSituacaoAtual = 6 OR IdSituacaoAtual = 14)
    ORDER BY NumConjReneg, DataReferencia, NumeroParcela

     SELECT @TotalOrigem = SUM(CASE WHEN ValorPago > 0 THEN (dbo.Calc_PagoMenor(IdDebito, CASE WHEN IdProfissional IS NOT NULL THEN 1 ELSE 0 END)) 
		      ELSE CASE WHEN IdMoeda = 2 THEN (dbo.Calc_Ufir(ValorDevido, DataVencimento, @DataCalculo, IdMoeda)) 
				WHEN IdMoeda = 3 THEN (dbo.Calc_URH(ValorDevido, @DataCalculo, IdMoeda)) ELSE
		      VAlorDevido END END) 
   		      FROM Debitos WHERE IdProfissional = @IdProfissional			
	    	      AND NumConjReneg = @NumConjRen
		      AND IdSituacaoAtual IN (6,14)	

  END
  ELSE
  BEGIN
    DECLARE OrigDeb_Cursor
    SCROLL CURSOR FOR
    SELECT IdDebito, IdMoeda, ValorDevido, DataVencimento, IdTipoDebito, IdSituacaoAtual, ValorPago
    FROM Debitos
    WHERE IdPessoaJuridica = @IdProfissional AND NumConjReneg = @NumConjRen AND (IdSituacaoAtual = 6 OR IdSituacaoAtual = 14)
    ORDER BY NumConjReneg, DataReferencia, NumeroParcela

    SELECT @TotalOrigem = SUM(CASE WHEN ValorPago > 0 THEN (dbo.Calc_PagoMenor(IdDebito, CASE WHEN IdProfissional IS NOT NULL THEN 1 ELSE 0 END)) 
		  	    ELSE CASE WHEN IdMoeda <> 1 THEN (dbo.Calc_Ufir(ValorDevido, DataVencimento, @DataCalculo, IdMoeda)) 
			    WHEN IdMoeda = 3 THEN (dbo.Calc_URH(ValorDevido, @DataCalculo, IdMoeda)) ELSE	
		     	    VAlorDevido END END) 
   		     	    FROM Debitos WHERE IdPessoaJuridica = @IdProfissional			
	    	     	    AND NumConjReneg = @NumConjRen
		      	   AND IdSituacaoAtual IN (6,14)	
	

  END
  OPEN OrigDeb_Cursor
  FETCH NEXT FROM OrigDeb_Cursor
  INTO @IdDebitoOrig, @IdMoedaOrig, @ValorOrig, @DataVcto, @IdTpDebito, @IdSituacao, @ValorPago
  IF @ValorPago > 0 
    SET @IdSituacao = 3		 
  /*Parcelas da Renegociacao*/
  IF @lFisica = 1
  BEGIN
    DECLARE DestDeb_Cursor
    CURSOR FAST_FORWARD FOR
    SELECT IdDebito, ValorDevido, NumeroParcela
    FROM Debitos
    WHERE IdProfissional = @IdProfissional AND NumConjReneg = @NumConjRen AND (IdTipoDebito = @IdRenegociacao OR IdTipoDebito = @IdRecobranca)
    ORDER BY NumConjReneg, DataReferencia, NumeroParcela

    SELECT @TotalParcelas = SUM(ValorDevido) FROM Debitos WHERE IdProfissional = @IdProfissional
			    AND NumConjReneg = @NumConjRen
    			    AND IdTipoDebito IN (@IdRenegociacao,@IdRecobranca)
    SELECT @QtdeParcelas = COUNT(*) FROM Debitos  WHERE IdProfissional = @IdProfissional AND NumConjReneg = @NumConjRen AND (IdTipoDebito = @IdRenegociacao OR IdTipoDebito = @IdRecobranca)
  END
  ELSE
  BEGIN
    DECLARE DestDeb_Cursor
    CURSOR FAST_FORWARD FOR
    SELECT IdDebito, ValorDevido, NumeroParcela
    FROM Debitos
    WHERE IdPessoaJuridica = @IdProfissional AND NumConjReneg = @NumConjRen AND (IdTipoDebito = @IdRenegociacao OR IdTipoDebito = @IdRecobranca)
    ORDER BY NumConjReneg, DataReferencia, NumeroParcela

    SELECT @TotalParcelas = SUM(ValorDevido) FROM Debitos WHERE IdPessoaJuridica = @IdProfissional
			    AND NumConjReneg = @NumConjRen
    			    AND IdTipoDebito IN (@IdRenegociacao,@IdRecobranca)

    SELECT @QtdeParcelas = COUNT(*) FROM Debitos WHERE IdPessoaJuridica = @IdProfissional AND NumConjReneg = @NumConjRen AND (IdTipoDebito = @IdRenegociacao OR IdTipoDebito = @IdRecobranca)   

  END
  OPEN DestDeb_Cursor
  FETCH NEXT FROM DestDeb_Cursor
  INTO @IdDebitoDest, @ValorParc, @NumParc
  SET @PrincipalParc = @TotalOrigem * @ValorParc / @TotalParcelas
  WHILE @@FETCH_STATUS = 0
  BEGIN
    /*Atualiza o debito de origem*/
    IF @IdDebito <> @IdDebitoOrig
    BEGIN
      SET @IdDebito = @IdDebitoOrig

      SELECT @NumeroParcelaOrigem = d.NumeroParcela FROM Debitos d WHERE d.IdDebito = @IdDebito

      SET @Multa = (SELECT TOP 1 PercentualMultaJuros FROM SequenciasCalculos 
		    WHERE IdProcedimentoAtraso = (SELECT dbo.AchaProcedimento (@DataVcto, @DataCalculo, @lFisica, @IdTpDebito, @NumeroParcelaOrigem))
		    AND RotinaCalculo = 1)			
							   
      IF @IdSituacao = 3 
        SET @ValorOrig =  (SELECT dbo.Calc_PagoMenor(@IdDebitoOrig, @lFisica))
      ELSE    		
        IF @IdMoedaOrig = 2
          SET @ValorOrig =  (SELECT dbo.Calc_Ufir(@ValorOrig, @DataVcto, @DataCalculo, 2)) 
	ELSE
	  IF @IdMoedaOrig = 3
	    SET @ValorOrig =  (SELECT dbo.Calc_URH(@ValorOrig, @DataCalculo, 3))
 	
      IF @SaldoAtual < 0.01
        SET @SaldoAtual = @ValorOrig
    END

    /* Se a parcela é composta por mais de uma origem*/   
    IF @SaldoAtual <= @PrincipalParc
    BEGIN
      /* calculo proporcional*/
      SET @Principal = @SaldoAtual
      SET @MultaPgto = 0
      SET @JurosPgto = 0
      IF @IdDebitoParc <> @IdDebitoDest 
      BEGIN
             SET @First = 1 
	SET @IdDebitoParc = @IdDebitoDest  
	/*SET @PrincipalParc = @TotalOrigem * @ValorParc / @TotalParcelas*/
	SET @MultaJuros = @ValorParc - @PrincipalParc
      END
      IF @MultaJuros > 0
      BEGIN
	SELECT @MultaPgto = Multa, @Juros = Juros, @Atualizacao = Atualizacao, @CodErro = CodErro FROM dbo.AtualizaDebitosAll (@DataVcto, @DataCalculo, @Principal, @lFisica, @IdTpDebito, 1, 0, 0, 1)
	/*SET @MultaPgto = @Multa / 100 * @Principal */
	SET @JurosPgto = @Juros + @Atualizacao 
	IF @MultaPgto <= @MultaJuros
		SET @MultaJuros = @MultaJuros - @MultaPgto 

	ELSE
	BEGIN
		SET @MultaPgto = @MultaJuros
		SET @MultaJuros = 0
	END
	IF @MultaJuros > 0
	BEGIN
		IF @JurosPgto <= @MultaJuros 
			SET @MultaJuros = @MultaJuros - @JurosPgto
		ELSE
		BEGIN
			SET @JurosPgto = @MultaJuros
			SET @MultaJuros = 0
		END
	END
      END
      IF @Diferenca = 0
        SET @Diferenca = @PrincipalParc - @ValorOrig
      ELSE
        IF @Diferenca > 0
          SET @Diferenca = @Diferenca - @ValorOrig
        ELSE
          SET @Diferenca = @PrincipalParc - @SaldoAtual	
      /*SET @MultaPgto = @Multa / 100 * @Principal
      SET @JurosPgto = @ValorParc - @Principal - @MultaPgto*/
      /*SET @AtualizacaoPgto = @Atualizacao * @Principal / @ValorOrig*/

      IF @Diferenca <= 0 
	SET @JurosPgto = @JurosPgto + @MultaJuros
      
      SELECT @ValorPrincipal = ISNULL(SUM(ISNULL(ValorEsperadoPrincipal, 0)), 0) FROM ComposicoesDebito WHERE IdDebitoOrigemRen = @IdDebitoOrig AND IdDebito <> @IdDebCotaUnica AND IdDebito <> @IdDebitoOrig
         												AND IdDebito NOT IN (SELECT Debitos.IdDebito FROM Debitos WHERE Debitos.IdDebito = ComposicoesDebito.IdDebito AND (NumConjReneg IS NULL OR NumConjReneg = 0) )	   
      IF @First = 1 
      BEGIN
        IF @ValorPrincipal > 0 	
        BEGIN
           IF (@ValorPrincipal + @Principal <> @ValorOrig) 
           BEGIN
   	  SET @Principal = @Principal + (@ValorOrig -(@ValorPrincipal + @Principal))
           END
        END
      END
      ELSE
	IF @QtdeParcelas = @RecNo
		IF @Principal <> @ValorOrig
			SET @Principal = @ValorOrig 
      IF @First = 1
        SET @First = 0
      INSERT INTO ComposicoesDebito (IdDebito, IdDebitoOrigemRen, ValorEsperadoPrincipal, ValorEsperadoMulta,
                 ValorEsperadoJuros, ValorEsperadoAtualizacao, IdMoedaValorEsperado)
      VALUES (@IdDebitoDest, @IdDebitoOrig, @Principal, @MultaPgto, @JurosPgto, @AtualizacaoPgto, @IdMoedaOrig)
      /* abate o saldo anterior*/
/*
      IF @Diferenca = 0
        SET @Diferenca = @ValorParc - @ValorOrig
      ELSE
        IF @Diferenca > 0
          SET @Diferenca = @Diferenca - @ValorOrig
        ELSE
          SET @Diferenca = @ValorParc - @SaldoAtual
       */

      /* Se a origem foi totalmente pagra passa para a próxima origem			*/
      IF (@Diferenca < 0) OR ((@Diferenca <= 0.01) AND (@Diferenca >= - 0.01))
      BEGIN
             SET @Teste = (SELECT SUM(ISNULL(ValorEsperadoPrincipal, 0) + ISNULL(ValorEsperadoJuros, 0) + ISNULL(ValorEsperadoMulta, 0)) FROM ComposicoesDebito WHERE IdDebito = @IdDebitoDest)
	UPDATE ComposicoesDebito SET ValorEsperadoJuros = ValorEsperadoJuros + (@ValorParc - (SELECT SUM(ISNULL(ValorEsperadoPrincipal, 0) + ISNULL(ValorEsperadoJuros, 0) + ISNULL(ValorEsperadoMulta, 0)) FROM ComposicoesDebito WHERE IdDebito = @IdDebitoDest))
	WHERE IdComposicaoDebito = (SELECT MAX (IdComposicaoDebito) FROM ComposicoesDebito WHERE IdDebito = @IdDebitoDest)
      END	

      IF  @Diferenca >= 0
      BEGIN
        IF  ((@Diferenca < 0.01) AND (@Diferenca > - 0.01)) AND (@NumParc =  0 AND @ParcUnica = 1)
        BEGIN
	FETCH FIRST FROM OrigDeb_Cursor
        	INTO @IdDebitoOrig, @IdMoedaOrig, @ValorOrig, @DataVcto, @IdTpDebito, @IdSituacao, @ValorPago
		IF @ValorPago > 0 
    			SET @IdSituacao = 3
		SET @IdDebCotaUnica = @IdDebitoDest
        END
	ELSE
	BEGIN
        	FETCH NEXT FROM OrigDeb_Cursor
        	INTO @IdDebitoOrig, @IdMoedaOrig, @ValorOrig, @DataVcto, @IdTpDebito, @IdSituacao, @ValorPago
		IF @ValorPago > 0 
    			SET @IdSituacao = 3
	END
        
        IF (@NumParc =  0 AND @ParcUnica = 1)
	      SET @SaldoAtual = @ValorOrig
        ELSE
        BEGIN
	 	IF @ValorOrig <= @Diferenca
	     		SET @SaldoAtual = @ValorOrig
	 	ELSE
	      		SET @SaldoAtual = @Diferenca
        END

        IF (@Diferenca < 0.01) AND (@Diferenca > - 0.01)
        BEGIN	
          FETCH NEXT FROM DestDeb_Cursor
          INTO @IdDebitoDest, @ValorParc, @NumParc
          SET @PrincipalParc = @TotalOrigem * @ValorParc / @TotalParcelas
          /*SET @IndAcresc = @IndAcresc * (1 + @PercentAcresc / 100)*/
          SET @Saldo = 0
	  SET @ValorParc = @ValorParc 
          SET @RecNo = @RecNo + 1
        END
      END
      ELSE
      BEGIN
        FETCH NEXT FROM DestDeb_Cursor
        INTO @IdDebitoDest, @ValorParc, @NumParc
 	SET @PrincipalParc = @TotalOrigem * @ValorParc / @TotalParcelas	
        /*SET @IndAcresc = @IndAcresc * (1 + @PercentAcresc / 100)*/
        SET @Saldo = 0
        SET @ValorParc = @ValorParc
        SET @SaldoAtual = ABS(@Diferenca)
        SET @RecNo = @RecNo + 1
      END
    END
    ELSE
    BEGIN
      /* parcela é composta por uma única origem*/
      SET @Principal = @TotalOrigem * @ValorParc / @TotalParcelas
      SET @MultaPgto = @Multa / 100 * @Principal
      SET @JurosPgto = @ValorParc - @Principal - @MultaPgto
      /*SET @AtualizacaoPgto = @Atualizacao * @Principal / @ValorOrig*/

      IF (@Principal + @MultaPgto + @JurosPgto) > @ValorParc 
      BEGIN
        SET @Resto =  (@Principal + @MultaPgto + @JurosPgto) - @ValorParc 
        IF @Juros > 0
        BEGIN
          SET @JurosPgto = @JurosPgto - @Resto
          SET @Resto = 0
        END
        IF @JurosPgto < 0
        BEGIN
          SET @Resto = ABS(@JurosPgto)
          SET @JurosPgto = 0
        END
        IF (@Resto > 0) AND (@MultaPgto > 0)
        BEGIN
          SET @MultaPgto = @MultaPgto - @Resto
          SET @Resto = 0
        END
        IF @MultaPgto < 0
        BEGIN
            SET @Resto = ABS(@MultaPgto)
          SET @MultaPgto = 0
        END
        IF @Resto > 0
          SET @AtualizacaoPgto = @AtualizacaoPgto - @Resto
      END
      IF (@Principal + @MultaPgto + @JurosPgto) < @ValorParc 
      BEGIN
        SET @Resto = @IndAcresc * @ValorParc- (@Principal + @MultaPgto + @JurosPgto)
        IF @JurosPgto > 0
          SET @JurosPgto = @JurosPgto + @Resto
        ELSE
          SET @JurosPgto = @Resto  
      END

      INSERT INTO ComposicoesDebito (IdDebito, IdDebitoOrigemRen, ValorEsperadoPrincipal, ValorEsperadoMulta,
                 ValorEsperadoJuros, ValorEsperadoAtualizacao, IdMoedaValorEsperado)
      VALUES (@IdDebitoDest, @IdDebitoOrig, @Principal, @MultaPgto, @JurosPgto, @AtualizacaoPgto, @IdMoedaOrig)
      SET @SaldoAtual = @SaldoAtual - @Principal
      FETCH NEXT FROM DestDeb_Cursor
      INTO @IdDebitoDest, @ValorParc, @NumParc
      SET @PrincipalParc = @TotalOrigem * @ValorParc / @TotalParcelas 	
      SET @Saldo = 0
      SET @ValorParc = @ValorParc 
      SET @Diferenca = -1 *  @SaldoAtual
      SET @RecNo = @RecNo + 1
    END
  END
  IF  (@SaldoAtual > 0) AND (@PercentAcresc > 0)
    UPDATE ComposicoesDebito SET ValorEsperadoAtualizacao = ValorEsperadoAtualizacao +  @SaldoAtual WHERE IdComposicaoDebito IN (SELECT TOP 1 IdComposicaoDebito FROM ComposicoesDebito  WHERE IdDebito = @IdDebitoDest ORDER BY IdComposicaoDebito DESC)
  CLOSE OrigDeb_Cursor
  DEALLOCATE OrigDeb_Cursor
  CLOSE DestDeb_Cursor
  DEALLOCATE DestDeb_Cursor
END
ELSE
BEGIN

  IF @lEmissao = 1
  BEGIN
    SET @IdTpDebito = 1
    SELECT TOP 1 @ValorParc = ValorDevido, @DataVcto = DataVencimento, @IdMoedaOrig = DetalhesEmissao.IdMoedaDevida, @IdSituacao = 0
    FROM ComposicoesEmissao, DetalhesEmissao
    WHERE ComposicoesEmissao.IdDetalheEmissao = DetalhesEmissao.IdDetalheEmissao
    AND IdDebito = @IdDebito
    ORDER BY IdComposicaoEmissao DESC
  END
  ELSE
  BEGIN
    SELECT @ValorParc = ValorDevido, @DataVcto = DataVencimento, @IdMoedaOrig = IdMoeda, @IdTpDebito = IdTipoDebito, @IdSituacao = IdSituacaoAtual
    FROM Debitos
    WHERE IdDebito = @IdDebito

  END
  SET @Principal = @ValorParc
  IF @IdMoedaOrig = 2
    SET @Principal =  (SELECT dbo.Calc_Ufir(@ValorOrig, @DataVcto, @DataCalculo, 2))
  IF @IdMoedaOrig = 3
    SET @Principal =  (SELECT dbo.Calc_URH(@Principal, @DataCalculo, 3))

  /* atualiza o débito e gera a composição	*/
  SELECT @Multa = Multa, @Juros = Juros, @Atualizacao = Atualizacao, @TotalAtual = ValorTotal, @CodErro = CodErro FROM dbo.AtualizaDebitosAll (@DataVcto, @DataCalculo, @ValorParc, @lFisica, @IdTpDebito, @IdMoedaOrig, 0, @IdDebito, @IdSituacao)
  SET @IdDebitoDest = 0
  SELECT @IdDebitoDest = 1 WHERE EXISTS(SELECT NULL FROM ComposicoesDebito WHERE IdDebito = @IdDebito)

  IF @CodErro = 0
  IF ((@IdTpDebito = 2)  AND (@NumConjRen <> NULL)) OR (@IdDebitoDest = 0)
  BEGIN
    IF @IdTpDebito = 2
      SET @ValorParc = 0
    SELECT TOP 1 @IdDebitoOrig = IdDebitoOrigemRen
    FROM ComposicoesDebito
    WHERE IdDebito = @IdDebito

    INSERT INTO ComposicoesDebito(IdDebito,
          ValorEsperadoPrincipal,
          IdMoedaValorEsperado,
          ValorEsperadoAtualizacao,
          ValorEsperadoMulta,
          ValorEsperadoJuros,
          IdDebitoOrigemRen)
     VALUES(@IdDebito,
      @ValorParc,
      @IdMoedaOrig,
      @Atualizacao,
      @Multa,
      @Juros,
      @IdDebitoOrig)
  END
  ELSE
  BEGIN
    SELECT @ValorParc = 0 WHERE EXISTS (SELECT 1 FROM ComposicoesDebito WHERE IdDebito = @IdDebito)
    INSERT INTO ComposicoesDebito(IdDebito,
          ValorEsperadoPrincipal,
          IdMoedaValorEsperado,
          ValorEsperadoAtualizacao,
          ValorEsperadoMulta,
          ValorEsperadoJuros)
     VALUES(@IdDebito,
      @ValorParc,
      @IdMoedaOrig,
      @Atualizacao,
      @Multa,
      @Juros)
  END
END
