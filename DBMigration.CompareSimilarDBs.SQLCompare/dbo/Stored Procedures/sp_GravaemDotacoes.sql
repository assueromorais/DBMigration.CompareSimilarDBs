

CREATE  PROCEDURE dbo.sp_GravaemDotacoes

@IdTransp int,
@Exercicio int,
@TRANSPMAIS int,
@TRANSPMENOS int,
@CentroCusto bit = 0,
@CentroCustoConta bit = 0,
@Conta bit = 0
AS

SET NOCOUNT ON

DECLARE @Texto varchar

IF @CentroCusto = 1
BEGIN
	DELETE FROM DotacoesCentroCusto
  	WHERE IdTransposicao = @IdTransp
	AND Year(DataDotacao) = @Exercicio

	INSERT INTO DotacoesCentroCusto
	  (IdTransposicao,IdCentroCusto,TipoMov,DataDotacao,ValorDotacao,SaldoDotacao)
	SELECT 
	   IdTransposicao,
	   IdCentroCusto,
	   TipoMov,
	   DataDotacao,
	   ValorDotacao,
	   0.00 As SaldoDotacao
	  FROM
	   TransposicoesCentroCusto
	  WHERE
	   IdTransposicao = @IdTransp
	   AND Year(DataDotacao) = @Exercicio
END

IF @CentroCustoConta = 1
BEGIN
	DELETE FROM DotacoesCentroCusto
  	WHERE IdTransposicao = @IdTransp
	AND Year(DataDotacao) = @Exercicio

	DELETE FROM DotacoesConta
  	WHERE IdTransposicao = @IdTransp
	AND Year(DataDotacao) = @Exercicio

	DELETE FROM DotacoesCentroCustoConta
  	WHERE IdTransposicao = @IdTransp
	AND Year(DataDotacao) = @Exercicio

	INSERT INTO DotacoesCentroCustoConta
		(IdTransposicao,IdCentroCusto,IdConta,TipoMov,DataDotacao,ValorDotacao,SaldoDotacao)
	SELECT IdTransposicao,IdCentroCusto,IdConta,TipoMov,DataDotacao,ValorDotacao,0.00 As SaldoDotacao
	FROM TransposicoesCentroCustoConta
  	WHERE IdTransposicao = @IdTransp
	AND Year(DataDotacao) = @Exercicio

	DECLARE @IdTransposicao int,@IdCentroCusto int,@IdConta int,@DataDotacao datetime,@ValorDotacao money

	DECLARE TransposicoesCCusto_cursor CURSOR FAST_FORWARD FOR
	SELECT 
	   IdTransposicao,
	   IdCentroCusto,
	   DataDotacao,
	   SUM(ValorDotacao) As ValorDotacao
	FROM
	   TransposicoesCentroCustoConta
	WHERE
	   IdTransposicao = @IdTransp
	AND Year(DataDotacao) = @Exercicio
	GROUP BY IdTransposicao,IdCentroCusto,DataDotacao
	OPEN TransposicoesCCusto_cursor
	FETCH NEXT FROM TransposicoesCCusto_cursor
	INTO @IdTransposicao,@IdCentroCusto,@DataDotacao,@ValorDotacao
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @ValorDotacao <> 0
		BEGIN
			print 'teste'
			IF @ValorDotacao > 0
			BEGIN
				INSERT INTO DotacoesCentroCusto
	  				(IdTransposicao,IdCentroCusto,TipoMov,DataDotacao,ValorDotacao,SaldoDotacao)
				VALUES
					(@IdTransposicao,
					 @IdCentroCusto,
					 @TRANSPMAIS,
					 @DataDotacao,
					 @ValorDotacao,
					 0.00)
			END
			ELSE
			BEGIN
				INSERT INTO DotacoesCentroCusto
	  				(IdTransposicao,IdCentroCusto,TipoMov,DataDotacao,ValorDotacao,SaldoDotacao)
				VALUES
					(@IdTransposicao,
					 @IdCentroCusto,
					 @TRANSPMENOS,
					 @DataDotacao,
					 @ValorDotacao,
					 0.00)
			END
		END
		FETCH NEXT FROM TransposicoesCCusto_cursor
		INTO @IdTransposicao,@IdCentroCusto,@DataDotacao,@ValorDotacao
	END
	CLOSE TransposicoesCCusto_cursor
	DEALLOCATE TransposicoesCCusto_cursor

	DECLARE TransposicoesConta_cursor CURSOR FAST_FORWARD FOR
	SELECT 
	   IdTransposicao,
	   IdConta,
	   DataDotacao,
	   SUM(ValorDotacao) As ValorDotacao
	FROM
	   TransposicoesCentroCustoConta
	WHERE
	   IdTransposicao = @IdTransp
	AND Year(DataDotacao) = @Exercicio
	GROUP BY IdTransposicao,IdConta,DataDotacao
	OPEN TransposicoesConta_cursor
	FETCH NEXT FROM TransposicoesConta_cursor
	INTO @IdTransposicao,@IdConta,@DataDotacao,@ValorDotacao
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @ValorDotacao <> 0
		BEGIN
			IF @ValorDotacao > 0
			BEGIN
				INSERT INTO DotacoesConta
	  				(IdTransposicao,IdConta,TipoMov,DataDotacao,ValorDotacao,SaldoDotacao)
				VALUES
					(@IdTransposicao,
					 @IdConta,
					 @TRANSPMAIS,
					 @DataDotacao,
					 @ValorDotacao,
					 0.00)
			END
			ELSE
			BEGIN
				INSERT INTO DotacoesConta
	  				(IdTransposicao,IdConta,TipoMov,DataDotacao,ValorDotacao,SaldoDotacao)
				VALUES
					(@IdTransposicao,
					 @IdConta,
					 @TRANSPMENOS,
					 @DataDotacao,
					 @ValorDotacao,
					 0.00)
			END
		END
		FETCH NEXT FROM TransposicoesConta_cursor
		INTO @IdTransposicao,@IdConta,@DataDotacao,@ValorDotacao
	END
	CLOSE TransposicoesConta_cursor
	DEALLOCATE TransposicoesConta_cursor
END

IF @Conta = 1
BEGIN
	DELETE FROM DotacoesConta
  	WHERE IdTransposicao = @IdTransp
	AND Year(DataDotacao) = @Exercicio

	INSERT INTO DotacoesConta
	  (IdTransposicao, IdConta, TipoMov, DataDotacao, ValorDotacao, SaldoDotacao)
	SELECT 
	   IdTransposicao,
	   IdConta,
	   TipoMov,
	   DataDotacao,
	   ValorDotacao,
	   0.00 As SaldoDotacao
	  FROM
	   TransposicoesConta
	  WHERE
	   IdTransposicao = @IdTransp
	   AND Year(DataDotacao) = @Exercicio
END

IF @CentroCusto = 1
   SELECT COUNT(IdTransposicao) FROM DotacoesCentroCusto
IF @CentroCustoConta = 1
   SELECT COUNT(IdTransposicao) FROM DotacoesCentroCustoConta
IF @Conta = 1
   SELECT COUNT(IdTransposicao) FROM DotacoesConta




