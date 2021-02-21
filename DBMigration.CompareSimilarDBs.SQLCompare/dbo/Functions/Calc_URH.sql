CREATE  FUNCTION dbo.Calc_URH (@Valor Float, @DataCalculo datetime, @IdMoeda int = 1)
	RETURNS decimal (15,2)
	AS
	BEGIN
	  DECLARE @URH float, @Result float 	

	  /*SELECT @URH = ISNULL(Valor,0) FROM Indices WHERE IdIndice = 7 AND Data = CAST(YEAR(@DataCalculo) AS VARCHAR(4)) + '0101'*/
	  SELECT @URH = ISNULL(Valor,0) FROM Indices WHERE IdIndice = 7 AND Data = (SELECT MAX(Data) FROM Indices WHERE IdIndice = 7)
	  IF @URH = 0 
		  SET @result = @Valor
	  ELSE
		  IF @IdMoeda <> 1
			SET @result = @Valor * @URH 
		  ELSE
			SET @result = 0

	  RETURN(@result)
	END