CREATE  FUNCTION dbo.Calc_MultaDiaria (@Valor decimal (10,5), @Percentual float, @DataVencimento datetime, @DataCalculo datetime)
		RETURNS decimal (10,2)
		AS
		BEGIN
		  DECLARE @result float, @QtdeDia int,  @QtdeIndice int
		  IF @Percentual > 0 AND @DataVencimento < @DataCalculo
		  BEGIN
			SET @QtdeDia = Datediff(DAY,@DataVencimento,@DataCalculo)
			IF @QtdeDia = 0 SET @QtdeDia = 1
			SET @result = @QtdeDia * (@Valor * @Percentual / 100)
		  END
		  ELSE
			SET @result = 0
		  RETURN(@result)
		END