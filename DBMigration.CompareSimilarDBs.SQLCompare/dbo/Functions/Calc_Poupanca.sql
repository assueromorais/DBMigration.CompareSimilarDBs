CREATE FUNCTION [dbo].[Calc_Poupanca] (@Valor float, @DataVencimento datetime, @DataCalculo datetime, @DataFixa bit)
	RETURNS decimal (10,2)
	AS
	BEGIN
	  DECLARE @Indice float, @IndiceAcum float, @result float

	  SET @DataVencimento = (@DataVencimento - Day(@DataVencimento)) + 1
	  SET @DataCalculo = (@DataCalculo - Day(@DataCalculo)) + 1


	  IF (SELECT COUNT(*) FROM Indices WHERE IdIndice = 5 AND Data >= @DataVencimento AND Data < @DataCalculo) =
		DATEDIFF(MONTH,@DataVencimento, @DataCalculo)
	  BEGIN
		SET @IndiceAcum = 1
		SELECT @Indice = Valor, @IndiceAcum = (@IndiceAcum * @Indice/100 + (@IndiceAcum + @Indice))
		FROM Indices
		WHERE IdIndice = 5 AND Data >= @DataVencimento AND Data <= @DataCalculo
		SET @result =  @Valor * (@IndiceAcum /100)
	  END
	  ELSE
		SET @result = -100000

	  RETURN(@result)
	END