CREATE FUNCTION [dbo].[Calc_IPCA_IBGE] (@Valor float, @DataVencimento datetime, @DataCalculo datetime, @DataFixa bit)
			RETURNS decimal (10,2)
			AS
			BEGIN
			  DECLARE @Indice float, @IndiceAcum float, @result float

			  SET @DataVencimento = (@DataVencimento - Day(@DataVencimento)) + 1
			  SET @DataCalculo = (@DataCalculo - Day(@DataCalculo)) + 1

			  IF @DataFixa = 1
				SET @DataCalculo = DATEADD(MONTH, 1, @DataCalculo)

			  IF (SELECT COUNT(*) FROM Indices WHERE IdIndice = 6 AND Data >= @DataVencimento AND Data < @DataCalculo) =
				DATEDIFF(MONTH,@DataVencimento, @DataCalculo)
			  BEGIN
				SET @IndiceAcum = 1
				SELECT @Indice = (Valor / 100 + 1), @IndiceAcum = (@IndiceAcum * @Indice)
				FROM Indices
				WHERE IdIndice = 6 AND Data >= @DataVencimento AND Data < @DataCalculo
				SET @result =  @Valor * (@IndiceAcum -1)
			  END
			  ELSE
				SET @result = -100000

			  RETURN(@result)
			/*
			  SELECT dbo.Calc_IPCA_IBGE(15.2,'20000201','20020101',0)
			*/
			END