



























CREATE  PROCEDURE sp_PrimeiraTransposicao

@IdCentroCusto integer = 0,
@IdConta integer = 0,
@TipoMov integer,
@DataDotacao varchar(10),
@ValorDotacao float,
@CentroCusto bit = 0,
@CentroCustoConta bit = 0,
@Conta bit = 0
AS

SET NOCOUNT ON

DECLARE @UltimoIdTransposicao int,@IdTransposicao int

IF @CentroCusto = 1
BEGIN
	SET @UltimoIdTransposicao =	(SELECT Max(IdTransposicao) As IdTransposicao
					 FROM TransposicoesCentroCusto
					 WHERE Year(DataDotacao) = Year(@DataDotacao))

	IF  @UltimoIdTransposicao <> NULL
		SET @IdTransposicao =	@UltimoIdTransposicao+1
	ELSE
		SET @IdTransposicao = 1

	INSERT INTO TransposicoesCentroCusto
		(IdTransposicao,
		 IdCentroCusto,
		 TipoMov,
		 DataDotacao,
		 ValorDotacao)
	VALUES	(@IdTransposicao,
		 @IdCentroCusto,
		 @TipoMov,
		 @DataDotacao,
		 @ValorDotacao)
END

IF @CentroCustoConta = 1
BEGIN
	SET @UltimoIdTransposicao = (SELECT Max(IdTransposicao) As IdTransposicao FROM TransposicoesCentroCustoConta)

	IF  @UltimoIdTransposicao <> NULL
		SET @IdTransposicao =	@UltimoIdTransposicao+1
	ELSE
		SET @IdTransposicao = 1

	INSERT INTO TransposicoesCentroCustoConta
		(IdTransposicao,
		 IdConta,
		 IdCentroCusto,
		 TipoMov,
		 DataDotacao,
		 ValorDotacao)
	VALUES	(@IdTransposicao,
		 @IdConta,
		 @IdCentroCusto,
		 @TipoMov,
		 @DataDotacao,
		 @ValorDotacao)
END

SELECT @IdTransposicao





























































