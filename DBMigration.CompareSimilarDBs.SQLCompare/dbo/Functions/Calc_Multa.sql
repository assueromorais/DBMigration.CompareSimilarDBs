CREATE FUNCTION dbo.Calc_Multa (@Valor Float, @Percentual float)
	RETURNS decimal (10,2)
	AS
	BEGIN
	  DECLARE  @result float

	  IF @Percentual > 0
		SET @result = @Valor * @Percentual / 100.00
	  ELSE
		SET @result = 0.00
	  RETURN(@result)
	END