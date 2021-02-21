/*oc. 21837*/ 
		CREATE  FUNCTION [dbo].[Calc_SelicAcumulada] (@Valor float, @DataVencimento datetime, @DataCalculo datetime, @DataFixa bit, @DataFixaVenc bit)
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
			IF @DataVencimento = @DataCalculo  
			  SET @result =  0 	
			ELSE     
			BEGIN
			IF (SELECT ISNULL(COUNT(*),0) FROM Indices WHERE IdIndice = 1 AND Data >= @DataVencimento AND Data < DATEADD(MONTH, -1, @DataCalculo)) =  
				   DATEDIFF(MONTH,@DataVencimento,DATEADD(MONTH, -1, @DataCalculo))  
				BEGIN 	
				  SELECT @IndiceAcum = SUM(Valor)
				  FROM Indices
				  WHERE IdIndice = 1 AND Data >= @DataVencimento AND Data <= @DataCalculo
				  /*IF (SELECT COUNT(*) FROM Indices WHERE IdIndice = 1 AND Data = @DataCalculo) = 0
					SET @result =  ((@IndiceAcum + 1 )/100) * @Valor
				  ELSE*/
					SET @result =  ((@IndiceAcum)/100) * @Valor
				END
				ELSE
				  SET @result = -100000
			END	
		  END
		  RETURN(@result)
		/*
		  SELECT dbo.Calc_SelicCapitalizada(15.2,'19950201','20030101',0)
		*/
		END