
CREATE  PROCEDURE dbo.sp_PagaComposicaoAjuste
@ID int,
@NumConjReneg int,
@Prof int,
@IdDebito int = 0,
@Bloco bit = 0

AS

/* function AchaProcedimento */

SET NOCOUNT ON

DECLARE @ValorDevido float, @qtdeRegistro int, @Cont int, @ValorTotal decimal(10,2), @IdComposicaoDebito int, @ValorParcela decimal(10,2), @ValorSobra decimal(10,2),
      @ValorEsperado decimal(10,2), @ValorPago decimal(10,2), @Cont2 int,  @qtdeDebito int, @DataVencimento DateTime, @DataPgto DateTime, @IdTpDebito Int,
      @IdProcedimento int, @IdDebitoOrig int, @TotalPrincipal decimal(10,2), @MultaJuros decimal(10,2), @Multa decimal(10,2), @Juros decimal(10,2), 
      @ValorMulta decimal(10,2), @ValorJuros decimal(10,2), @ValorPrincipal decimal(10,2), @Principal decimal(10,2), @NumeroParcela int, @IdRecobranca INT, @IdRenegociacao int

SELECT @IdRecobranca =  td.IdTipoDebito FROM TiposDebito td WHERE td.NomeDebito='Recobrança'
SELECT @IdRenegociacao =  td.IdTipoDebito FROM TiposDebito td WHERE td.NomeDebito='Renegociação'

IF @NumConjReneg <> 0
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
    SELECT @TotalPrincipal = ISNULL(SUM(ISNULL(ValorEsperadoPrincipal,0)), 0) FROM ComposicoesDebito WHERE IdDebito = @IdDebito
 IF @ValorParcela < @TotalPrincipal
	SET @TotalPrincipal = @ValorParcela
    SET @MultaJuros = @ValorPago - @TotalPrincipal
    WHILE @Cont <= @qtdeRegistro AND @ValorParcela > 0 
    BEGIN
      SET @Cont = @Cont + 1
      SET @Multa = 0
      SET @Juros = 0
      SELECT TOP 1 @IdComposicaoDebito = IdComposicaoDebito, @ValorPrincipal = ISNULL(ValorEsperadoPrincipal, 0), @ValorMulta = ISNULL(ValorEsperadoMulta, 0), @ValorJuros = ISNULL(ValorEsperadoJuros, 0) FROM ComposicoesDebito 
      WHERE IdDebito = @IdDebito AND  IdComposicaoDebito > @IdComposicaoDebito ORDER BY IdComposicaoDebito	
     IF @ValorPrincipal <= @TotalPrincipal 
	    SET @Principal = @ValorPrincipal
      ELSE
      BEGIN	
	    SET @Principal = @TotalPrincipal
	    SET @MultaJuros = 0     		
      END	
      SET @TotalPrincipal = @TotalPrincipal - @Principal
      IF @MultaJuros > 0
      BEGIN
	IF @ValorMulta <= @MultaJuros
	BEGIN
		SET @Multa = @ValorMulta
		SET @MultaJuros = @MultaJuros - @ValorMulta
	END	
	ELSE
	BEGIN
		SET @Multa = @MultaJuros
		SET @MultaJuros = 0
	END
	IF @MultaJuros > 0
	BEGIN
		IF @ValorJuros <= @MultaJuros 
		BEGIN 
			SET @Juros  = @ValorJuros
			SET @MultaJuros = @MultaJuros - @ValorJuros
		END	
		ELSE
		BEGIN
			SET @Juros = @MultaJuros
			SET @MultaJuros = 0
		END
	END
      END
      IF @Principal > 0
      BEGIN
          UPDATE ComposicoesDebito SET
          ValorPagoPrincipal = @Principal, 
          ValorPagoMulta = @Multa, 
          ValorPagoJuros = @Juros 
          WHERE IdComposicaoDebito = @IdComposicaoDebito	
      END	
    END    
    
    IF @MultaJuros > 0 
      UPDATE ComposicoesDebito SET ValorPagoJuros = ValorPagoJuros  + @MultaJuros WHERE IdComposicaoDebito = @IdComposicaoDebito
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
