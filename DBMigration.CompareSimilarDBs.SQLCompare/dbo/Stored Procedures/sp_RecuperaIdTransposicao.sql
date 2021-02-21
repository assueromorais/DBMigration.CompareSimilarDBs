



























CREATE  PROCEDURE sp_RecuperaIdTransposicao

@IdUsuario integer,
@Exercicio integer,
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
					 WHERE Year(DataDotacao) = @Exercicio
					 AND IdTransposicao > 0)

	IF  @UltimoIdTransposicao <> NULL
		SET @IdTransposicao =	@UltimoIdTransposicao+1
	ELSE
		SET @IdTransposicao = 1

	UPDATE TransposicoesCentroCusto
	SET IdTransposicao = @IdTransposicao
	WHERE IdTransposicao = @IdUsuario /* Id Negativo */
END

IF @CentroCustoConta = 1
BEGIN
	SET @UltimoIdTransposicao =	(SELECT Max(IdTransposicao) As IdTransposicao
					 FROM TransposicoesCentroCustoConta
					 WHERE Year(DataDotacao) = @Exercicio
					 AND IdTransposicao > 0)

	IF  @UltimoIdTransposicao <> NULL
		SET @IdTransposicao =	@UltimoIdTransposicao+1
	ELSE
		SET @IdTransposicao = 1

	UPDATE TransposicoesCentroCustoConta
	SET IdTransposicao = @IdTransposicao
	WHERE IdTransposicao = @IdUsuario /* Id Negativo */
END

SELECT @IdTransposicao





























































