CREATE FUNCTION dbo.Calc_Ufir (@Valor Float, @DataVencimento datetime, @DataCalculo datetime, @IdMoeda int = 1)
	RETURNS decimal (15,2)
	AS
	BEGIN
	  DECLARE @UfirVcto float, @UfirPgto float, @Result float 	
	  IF @DataCalculo > '20001027'
		SET @DataCalculo = '20001027'
	/*
		IF @DataVencimento > '20001027'
		  SET @DataVencimento = '20001027'

		IF @DataVencimento  <=  '19940831'
		  SELECT @UfirVcto = ISNULL(Valor,0) FROM Indices WHERE IdIndice = 2 AND Data = @DataVencimento
		ELSE
		SELECT @UfirVcto = ISNULL(Valor,0) FROM Indices WHERE IdIndice = 2 AND Data = (@DataVencimento - (Day(@DataVencimento) - 1))
	*/

	  IF @DataCalculo <=  '19940831'
		  SELECT @UfirPgto = ISNULL(Valor,0) FROM Indices WHERE IdIndice = 2 AND Data = @DataCalculo
	  ELSE
		SELECT @UfirPgto = ISNULL(Valor,0) FROM Indices WHERE IdIndice = 2 AND Data = (@DataCalculo - (Day(@DataCalculo) - 1))

	  IF @UfirPgto = 0 
		  SET @result = @Valor
	  ELSE
		  IF @IdMoeda <> 1
			SET @result = @Valor * @UfirPgto 
		  ELSE
			SET @result = 0

	  RETURN(@result)

	END