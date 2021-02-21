CREATE  FUNCTION dbo.Calc_JurosCompostos(@Valor decimal (10,2), @Percentual float, @DataVencimento datetime, @DataCalculo datetime)
	RETURNS decimal (10,2)
	AS
	BEGIN
	  DECLARE @result float, @QtdeMes int,  @QtdeIndice int, @intContador int, @perc float
	  SET @result = 0
	  IF @Percentual > 0 AND @DataVencimento < @DataCalculo
	  BEGIN
		SET @QtdeMes = Datediff(month,@DataVencimento,@DataCalculo) + (CASE WHEN Day(@DataVencimento) < Day(@DataCalculo) THEN 1 ELSE 0 END)
		SET @intContador = 1
		SET @result = @valor
		SET @perc =  (@Percentual / 100 ) + 1
		WHILE @intContador <= @QtdeMes
		BEGIN
		SET @result = @result  * @perc 
		SET @intContador = @intContador + 1
		END
		SET @result = @Result - @Valor
	  END
	  RETURN(@result)
	END