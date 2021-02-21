CREATE FUNCTION [dbo].[Calc_SelicCapitalizada] (@Valor float, @DataVencimento datetime, @DataCalculo datetime, @DataFixa bit, @DataFixaVenc bit)
	RETURNS decimal (10,2)
	AS
	BEGIN
	  DECLARE @IndiceAcum float, @result float
	  SET @DataVencimento = @DataVencimento - (Day(@DataVencimento) - 1)
	  SET @DataCalculo = @DataCalculo - (Day(@DataCalculo) - 1)
	  IF @DataVencimento = @DataCalculo
		SET @result =  0
	  ELSE
	  BEGIN
		IF @DataFixaVenc = 0
		  SET @DataVencimento = DATEADD(MONTH, 1, @DataVencimento)
		IF @DataFixa = 1
		  SET @DataCalculo = DATEADD(MONTH, 1, @DataCalculo)
		IF (SELECT COUNT(*) FROM Indices WHERE IdIndice = 1 AND Data >= @DataVencimento AND Data < @DataCalculo) =
		  DATEDIFF(MONTH,@DataVencimento,@DataCalculo)
		BEGIN
		  SET @IndiceAcum = 1
		  SELECT @IndiceAcum = @IndiceAcum *  (Valor / 100 + 1)
		  FROM Indices
		  WHERE IdIndice = 1 AND Data >= @DataVencimento AND Data <= @DataCalculo
		  IF (SELECT COUNT(*) FROM Indices WHERE IdIndice = 1 AND Data = @DataCalculo) = 0
			SET @result =  ((@IndiceAcum * 1.01) - 1) * @Valor
		  ELSE
			SET @result =  ((@IndiceAcum - 1)) * @Valor
		END
		ELSE
		  SET @result = -100000
	  END
	  RETURN(@result)
	END