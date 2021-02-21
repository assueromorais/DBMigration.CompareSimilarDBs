

CREATE  PROCEDURE dbo.Sp_AtualizaSaldos
@IdCC int = 0,
@IdCT int = 0,
@IdTRANSP int = 0
AS

SET NOCOUNT ON

DECLARE	@Texto varchar(1000), @IdDotacaoCCustoConta int, @IdTransposicao int, @IdCentroCusto int, 
		@IdConta int, @TipoMov int, @DataDotacao datetime, @ValorDotacao money, @SaldoDotacao money, 
		@IdContaAtual int, @IdCentroCustoAtual int, @Saldo money

SET @Texto =	'SELECT IdDotacaoCCustoConta, IdTransposicao, IdCentroCusto, IdConta, TipoMov, DataDotacao, ValorDotacao '+
		'FROM DotacoesCentroCustoConta '+
		'WHERE IdDotacaoCCustoConta > 0'

IF @IdCC > 0 
	SET @Texto = 	@Texto+'AND IdCentroCusto in ('+CAST(@IdCC As varchar)+')'
IF @IdCT > 0 
	SET @Texto = 	@Texto+'AND IdConta in ('+CAST(@IdCT As varchar)+')'
IF @IdTRANSP > 0 
	SET @Texto = 	@Texto+'AND IdTransposicao in ('+CAST(@IdTRANSP As varchar)+')'

CREATE TABLE #DOTACOES
 (
	IdDotacaoCCustoConta int,
	IdTransposicao  int,
	IdCentroCusto int,
	IdConta int,
	TipoMov int,
	DataDotacao datetime,
	ValorDotacao money
 )
INSERT #DOTACOES
EXEC(@Texto)

DECLARE dotacoes_cursor CURSOR FAST_FORWARD FOR 
SELECT *  FROM #DOTACOES
ORDER BY IdCentroCusto,IdConta,DataDotacao,TipoMov
OPEN dotacoes_cursor

SET @Saldo = 0
SET @IdCentroCustoAtual = 0
SET @IdContaAtual = 0

FETCH NEXT FROM dotacoes_cursor
INTO @IdDotacaoCCustoConta,@IdTransposicao,@IdCentroCusto,@IdConta,@TipoMov,@DataDotacao,@ValorDotacao
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @IdCentroCusto <> @IdCentroCustoAtual
	BEGIN
		SET @Saldo = 0
		SET @IdCentroCustoAtual = @IdCentroCusto
	END
	IF @IdConta <> @IdContaAtual
	BEGIN
		SET @Saldo = 0
		SET @IdContaAtual = @IdConta
	END
	SET @Saldo = @Saldo + @ValorDotacao
	UPDATE DotacoesCentroCustoConta
	SET SaldoDotacao = @Saldo
	WHERE IdDotacaoCCustoConta = @IdDotacaoCCustoConta
	FETCH NEXT FROM dotacoes_cursor
	INTO @IdDotacaoCCustoConta,@IdTransposicao,@IdCentroCusto,@IdConta,@TipoMov,@DataDotacao,@ValorDotacao
END
CLOSE dotacoes_cursor
DEALLOCATE dotacoes_cursor




