/*Oc 50562 PauloR*/

CREATE PROCEDURE dbo.sp_PagaComposicao

@ID int,
@NumConjReneg decimal(10,2),
@Prof int,
@IdDebito int = 0,
@Bloco bit = 0

AS

/* function AchaProcedimento */

SET NOCOUNT ON

DECLARE @ValorDevido float, @qtdeRegistro int, @Cont int, @ValorTotal decimal(10,2), @IdComposicaoDebito int, @ValorParcela decimal(10,2), @ValorSobra decimal(10,2),
      @ValorEsperado decimal(10,2), @ValorPago decimal(10,2), @Cont2 int,  @qtdeDebito int, @DataVencimento DateTime, @DataPgto DateTime, @IdTpDebito Int,
      @IdProcedimento int, @IdDebitoOrig int, @NumeroParcela INT, @IdRecobranca INT, @IdRenegociacao int

SELECT @IdRecobranca =  td.IdTipoDebito FROM TiposDebito td WHERE td.NomeDebito='Recobrança'
SELECT @IdRenegociacao =  td.IdTipoDebito FROM TiposDebito td WHERE td.NomeDebito='Renegociação' 


IF @NumConjReneg > 0
BEGIN	
  IF @Bloco = 1 
  BEGIN
    IF @Prof = 1 
      SELECT @qtdeDebito = COUNT (IdDebito) FROM Debitos WHERE IdProfissional = @ID AND NumConjReneg = @NumConjReneg AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao)
    IF @Prof = 0 
      SELECT @qtdeDebito = COUNT (IdDebito) FROM Debitos WHERE IdPessoaJuridica = @ID AND NumConjReneg = @NumConjReneg AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao)
    IF @Prof = 2
      SELECT @qtdeDebito = COUNT (IdDebito) FROM Debitos WHERE IdPessoa = @ID AND NumConjReneg = @NumConjReneg AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao)
  END
  ELSE
    SET @qtdeDebito = 1
  SET @Cont2 = 1
  IF @Bloco = 1
    SET @IdDebito = 0
  WHILE @Cont2 <= @qtdeDebito 
  BEGIN
    SET @Cont2 = @Cont2 + 1
    IF @Bloco = 1
    BEGIN
      IF @Prof = 1 
        SELECT TOP 1 @IdDebito = IdDebito, @ValorPago = ValorPago FROM Debitos WHERE IdProfissional = @ID AND NumConjReneg = @NumConjReneg AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) AND IdDebito > @IdDebito ORDER BY IdDebito
      IF @Prof = 0 
        SELECT TOP 1 @IdDebito = IdDebito, @ValorPago = ValorPago FROM Debitos WHERE IdPessoaJuridica = @ID AND NumConjReneg = @NumConjReneg AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) AND IdDebito > @IdDebito ORDER BY IdDebito
      IF @Prof = 2 
        SELECT TOP 1 @IdDebito = IdDebito, @ValorPago = ValorPago FROM Debitos WHERE IdPessoa = @ID AND NumConjReneg = @NumConjReneg AND IdTipoDebito IN (@IdRecobranca, @IdRenegociacao) AND IdDebito > @IdDebito ORDER BY IdDebito
    END
    ELSE
      SELECT  @ValorPago = ValorPago FROM Debitos WHERE IdDebito = @IdDebito 

    SELECT @qtdeRegistro = COUNT(IdComposicaoDebito) FROM ComposicoesDebito WHERE IdDebito = @IdDebito
    SET @Cont = 1
    SET @IdComposicaoDebito = 0
    SET @ValorSobra = 0
    SET @ValorParcela = @ValorPago
    PRINT @IdDebito
    WHILE @Cont <= @qtdeRegistro AND @ValorParcela > 0 
    BEGIN
      SET @Cont = @Cont + 1
      SELECT TOP 1 @ValorTotal = (ISNULL(ValorEsperadoPrincipal, 0) + ISNULL(ValorEsperadoMulta, 0) + ISNULL(ValorEsperadoJuros, 0) + ISNULL(ValorEsperadoAtualizacao, 0) + ISNULL(ValorEsperadoDespBco, 0) + ISNULL(ValorEsperadoDespAdv, 0) + 
            ISNULL(ValorEsperadoDespPostais, 0)), @IdComposicaoDebito = IdComposicaoDebito, @ValorEsperado = ValorEsperadoPrincipal, @IdDebitoOrig = IdDebitoOrigemRen FROM ComposicoesDebito 
            WHERE IdDebito = @IdDebito AND  IdComposicaoDebito > @IdComposicaoDebito ORDER BY IdComposicaoDebito	
      IF @ValorTotal <= @ValorParcela 
      BEGIN
        UPDATE ComposicoesDebito SET
          ValorPagoPrincipal = ValorEsperadoPrincipal, 
          ValorPagoMulta = ValorEsperadoMulta, 
          ValorPagoJuros = ValorEsperadoJuros, 
          ValorPagoAtualizacao = ValorEsperadoAtualizacao,
          ValorPagoDespBco = ValorEsperadoDespBco, 
          ValorPagoDespAdv = ValorEsperadoDespAdv,
          ValorPagoDespPostais = ValorEsperadoDespPostais
          WHERE IdComposicaoDebito = @IdComposicaoDebito
        SET @ValorParcela = @ValorParcela - @ValorTotal
        SET @ValorSobra = @ValorSobra + @ValorTotal
      END
      ELSE
      BEGIN
        UPDATE ComposicoesDebito SET
        ValorPagoPrincipal = ValorEsperadoPrincipal * @ValorParcela / @ValorTotal, 
        ValorPagoMulta = ValorEsperadoMulta * @ValorParcela / @ValorTotal, 
        ValorPagoJuros = ValorEsperadoJuros * @ValorParcela / @ValorTotal, 
        ValorPagoAtualizacao = ValorEsperadoAtualizacao * @ValorParcela / @ValorTotal,
        ValorPagoDespBco = ValorEsperadoDespBco * @ValorParcela / @ValorTotal,
        ValorPagoDespAdv = ValorEsperadoDespAdv * @ValorParcela / @ValorTotal,
        ValorPagoDespPostais = ValorEsperadoDespPostais * @ValorParcela / @ValorTotal
        WHERE IdComposicaoDebito = @IdComposicaoDebito
				
        SET @ValorParcela = @ValorParcela - @ValorTotal
        SET @ValorSobra =  @ValorSobra + (SELECT (ISNULL(ValorPagoPrincipal, 0) + ISNULL(ValorPagoMulta, 0) + ISNULL(ValorPagoJuros, 0) + ISNULL(ValorPagoAtualizacao, 0) + ISNULL(ValorPagoDespBco, 0) + ISNULL(ValorPagoDespAdv, 0) + 
          ISNULL(ValorPagoDespPostais, 0)) FROM ComposicoesDebito 
          WHERE IdComposicaoDebito = @IdComposicaoDebito)

        /*
        SELECT @ValorTotal = (ISNULL(ValorPagoPrincipal, 0) + ISNULL(ValorPagoMulta, 0) + ISNULL(ValorPagoJuros, 0) + ISNULL(ValorPagoAtualizacao, 0) + ISNULL(ValorPagoDespBco, 0) + ISNULL(ValorPagoDespAdv, 0) + 
          ISNULL(ValorPagoDespPostais, 0)) FROM ComposicoesDebito 
          WHERE IdComposicaoDebito = @IdComposicaoDebito */
      END	
    END
    IF @IdComposicaoDebito > 0 
    BEGIN
      SET @ValorSobra = @ValorPago - @ValorSobra
      IF @ValorSobra > 0
      BEGIN
      	
        SELECT @NumeroParcela = NumeroParcela, @DataVencimento = DataVencimento, @DataPgto = DataPgto, @IdTpDebito = IdTipoDebito FROM Debitos WHERE IdDebito = @IdDebitoOrig
        SET @IdProcedimento = (SELECT dbo.AchaProcedimento(@DataVencimento , @DataPgto, @Prof, @IdTpDebito, @NumeroParcela))
        IF (@IdProcedimento IS NOT NULL) AND (@IdProcedimento > 0) 
          IF EXISTS( SELECT TOP 1 1 FROM ProcedimentosAtraso, SequenciasCalculos WHERE ProcedimentosAtraso.IdProcedimentoAtraso = SequenciasCalculos.IdProcedimentoAtraso AND ProcedimentosAtraso.IdProcedimentoAtraso = @IdProcedimento AND RotinaCalculo > 2)	
            UPDATE ComposicoesDebito SET ValorPagoAtualizacao = ValorPagoAtualizacao + @ValorSobra WHERE IdComposicaoDebito = @IdComposicaoDebito
          ELSE
            IF EXISTS( SELECT TOP 1 1 FROM ProcedimentosAtraso, SequenciasCalculos WHERE ProcedimentosAtraso.IdProcedimentoAtraso = SequenciasCalculos.IdProcedimentoAtraso AND ProcedimentosAtraso.IdProcedimentoAtraso = @IdProcedimento AND RotinaCalculo = 2)		
              UPDATE ComposicoesDebito SET ValorPagoJuros = ValorPagoJuros + @ValorSobra WHERE IdComposicaoDebito = @IdComposicaoDebito
            ELSE
              UPDATE ComposicoesDebito SET ValorPagoMulta = ValorPagoMulta + @ValorSobra WHERE IdComposicaoDebito = @IdComposicaoDebito
        ELSE
          UPDATE ComposicoesDebito SET ValorPagoAtualizacao = ValorPagoAtualizacao + @ValorSobra WHERE IdComposicaoDebito = @IdComposicaoDebito
      END
    END
  END
END
ELSE
BEGIN
  SET @ValorSobra = 0	
  SELECT @NumeroParcela = NumeroParcela, @ValorPago = ValorPago, @DataVencimento = DataVencimento, @DataPgto =  DataPgto, @IdTpDebito = IdTipoDebito FROM Debitos WHERE IdDebito = @IdDebito 
  SET @ValorParcela = @ValorPago
  SELECT TOP 1 @ValorTotal = (ISNULL(ValorEsperadoPrincipal, 0) + ISNULL(ValorEsperadoMulta, 0) + ISNULL(ValorEsperadoJuros, 0) + ISNULL(ValorEsperadoAtualizacao, 0) + ISNULL(ValorEsperadoDespBco, 0) + ISNULL(ValorEsperadoDespAdv, 0) + 
        ISNULL(ValorEsperadoDespPostais, 0)), @IdComposicaoDebito = IdComposicaoDebito, @ValorEsperado = ValorEsperadoPrincipal FROM ComposicoesDebito 
        WHERE IdDebito = @IdDebito 
  IF @ValorTotal <= @ValorParcela 
  BEGIN
    UPDATE ComposicoesDebito SET
      ValorPagoPrincipal = ValorEsperadoPrincipal, 
      ValorPagoMulta = ValorEsperadoMulta, 
      ValorPagoJuros = ValorEsperadoJuros, 
      ValorPagoAtualizacao = ValorEsperadoAtualizacao,
      ValorPagoDespBco = ValorEsperadoDespBco, 
      ValorPagoDespAdv = ValorEsperadoDespAdv,
      ValorPagoDespPostais = ValorEsperadoDespPostais
      WHERE IdComposicaoDebito = @IdComposicaoDebito
    SET @ValorParcela = @ValorParcela - @ValorTotal
    SET @ValorSobra = @ValorSobra + @ValorTotal
  END
  ELSE
  BEGIN
    UPDATE ComposicoesDebito SET

    ValorPagoPrincipal = ValorEsperadoPrincipal * @ValorParcela / @ValorTotal,
    ValorPagoMulta = ValorEsperadoMulta * @ValorParcela / @ValorTotal, 
    ValorPagoJuros = ValorEsperadoJuros * @ValorParcela / @ValorTotal, 
    ValorPagoAtualizacao = ValorEsperadoAtualizacao * @ValorParcela / @ValorTotal,
    ValorPagoDespBco = ValorEsperadoDespBco * @ValorParcela / @ValorTotal, 
    ValorPagoDespAdv = ValorEsperadoDespAdv * @ValorParcela / @ValorTotal,
    ValorPagoDespPostais = ValorEsperadoDespPostais * @ValorParcela / @ValorTotal
    WHERE IdComposicaoDebito = @IdComposicaoDebito

    SET @ValorParcela = @ValorParcela - @ValorTotal
    SET @ValorSobra =  @ValorSobra + (SELECT (ISNULL(ValorPagoPrincipal, 0) + ISNULL(ValorPagoMulta, 0) + ISNULL(ValorPagoJuros, 0) + ISNULL(ValorPagoAtualizacao, 0) + ISNULL(ValorPagoDespBco, 0) + ISNULL(ValorPagoDespAdv, 0) + 
      ISNULL(ValorPagoDespPostais, 0)) FROM ComposicoesDebito 
      WHERE IdComposicaoDebito = @IdComposicaoDebito)
  END	
	
  SET @ValorSobra = @ValorPago - @ValorSobra
  IF @ValorSobra > 0
  BEGIN	
  	 	
    SET @IdProcedimento = (SELECT dbo.AchaProcedimento(@DataVencimento , @DataPgto, @Prof, @IdTpDebito, @NumeroParcela))
    IF (@IdProcedimento IS NOT NULL) AND (@IdProcedimento > 0) 	
      IF EXISTS( SELECT TOP 1 1 FROM ProcedimentosAtraso, SequenciasCalculos WHERE ProcedimentosAtraso.IdProcedimentoAtraso = SequenciasCalculos.IdProcedimentoAtraso AND ProcedimentosAtraso.IdProcedimentoAtraso = @IdProcedimento AND RotinaCalculo > 2) 
        UPDATE ComposicoesDebito SET ValorPagoAtualizacao = ValorPagoAtualizacao + @ValorSobra WHERE IdDebito = @IdDebito
      ELSE
        IF EXISTS( SELECT TOP 1 1 FROM ProcedimentosAtraso, SequenciasCalculos WHERE ProcedimentosAtraso.IdProcedimentoAtraso = SequenciasCalculos.IdProcedimentoAtraso AND ProcedimentosAtraso.IdProcedimentoAtraso = @IdProcedimento AND RotinaCalculo = 2)			
          UPDATE ComposicoesDebito SET ValorPagoJuros = ValorPagoJuros + @ValorSobra WHERE IdDebito = @IdDebito
        ELSE
          UPDATE ComposicoesDebito SET ValorPagoMulta = ValorPagoMulta + @ValorSobra WHERE IdDebito = @IdDebito
    ELSE
      UPDATE ComposicoesDebito SET ValorPagoAtualizacao = ValorPagoAtualizacao + @ValorSobra WHERE IdDebito = @IdDebito
		
  END	
END







