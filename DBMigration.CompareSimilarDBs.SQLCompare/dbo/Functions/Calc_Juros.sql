CREATE  FUNCTION dbo.Calc_Juros (@Valor decimal (10,2), @Percentual float, @DataVencimento datetime, @DataCalculo datetime)
	RETURNS decimal (10,2)
	AS
	BEGIN
	  DECLARE @result float, @QtdeMes int,  @QtdeIndice int

	  IF @Percentual > 0 AND @DataVencimento < @DataCalculo
	  BEGIN
		SET @QtdeMes = Datediff(month,@DataVencimento,@DataCalculo) + (CASE WHEN Day(@DataVencimento) < Day(@DataCalculo) THEN 1 ELSE 0 END)
		SET @result = @QtdeMes * @Valor * @Percentual / 100
	  END
	  ELSE
		SET @result = 0

	  RETURN(@result)
	END