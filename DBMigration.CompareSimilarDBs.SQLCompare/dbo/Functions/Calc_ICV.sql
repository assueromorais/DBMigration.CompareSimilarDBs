CREATE FUNCTION [dbo].[Calc_ICV] (@Valor float, @DataVencimento datetime, @DataCalculo datetime, @DataFixa bit)
	RETURNS decimal (10,2)
	AS
	BEGIN
	  DECLARE @IndiceAcum float, @result float

	  SET @DataVencimento = CAST(YEAR(@DataVencimento) AS VARCHAR(4)) +  '0101'
	  SET @DataCalculo = CAST(YEAR(@DataCalculo) AS VARCHAR(4)) +  '0101'

	  IF @DataFixa = 1
		SET @DataCalculo = DATEADD(YEAR, 1, @DataCalculo)


	  IF (SELECT COUNT(*) FROM Indices WHERE IdIndice = 3 AND Data >= @DataVencimento AND Data < @DataCalculo) =
		DATEDIFF(YEAR,@DataVencimento, @DataCalculo)
	  BEGIN
		SET @IndiceAcum = 1
		SELECT  @IndiceAcum = @IndiceAcum * (Valor / 100 + 1)
		FROM Indices
		WHERE IdIndice = 3 AND Data >= @DataVencimento AND Data < @DataCalculo
		SET @result =  @Valor * (@IndiceAcum -1)
	  END
	  ELSE
		SET @result = -100000

	  RETURN(@result)
	END