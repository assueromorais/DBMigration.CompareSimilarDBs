CREATE FUNCTION [dbo].[Calc_IGPM] (@Valor float, @DataVencimento datetime, @DataCalculo datetime, @DataFixa bit)
	RETURNS decimal (10,2)
	AS
	BEGIN
	  DECLARE @IndiceAcum float, @result float

	  SET @DataVencimento = @DataVencimento - (Day(@DataVencimento) - 1)
	  SET @DataCalculo = @DataCalculo - (Day(@DataCalculo) - 1)

	  IF @DataFixa = 1
		SET @DataCalculo = DATEADD(MONTH, 1, @DataCalculo)

	  IF (SELECT COUNT(*) FROM Indices WHERE IdIndice = 13 AND Data >= @DataVencimento AND Data < @DataCalculo) =
		DATEDIFF(MONTH,@DataVencimento, @DataCalculo)
	  BEGIN
		SET @IndiceAcum = 1
		SELECT @IndiceAcum = (@IndiceAcum *  (Valor / 100 + 1))
		FROM Indices
		WHERE IdIndice = 13 AND Data >= @DataVencimento AND Data < @DataCalculo
		SET @result =  @Valor * (@IndiceAcum -1)
	  END
	  ELSE
		SET @result = -100000

	  RETURN(@result)
	END