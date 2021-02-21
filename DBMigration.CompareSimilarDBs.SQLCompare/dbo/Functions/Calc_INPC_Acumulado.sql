/*oc. 22151*/  
		CREATE    FUNCTION [dbo].[Calc_INPC_Acumulado] (@Valor float, @DataVencimento datetime, @DataCalculo datetime, @DataFixa bit, @DataFixaVenc bit, @AplicaPercentual bit)  
		RETURNS decimal (10,2)  
		AS  
		BEGIN  
		  DECLARE @IndiceAcum float, @result float, @Indice float  
		  SET @DataVencimento = @DataVencimento - (Day(@DataVencimento) - 1)   
		  SET @DataCalculo = @DataCalculo - (Day(@DataCalculo) - 1)  
		  IF @DataVencimento >= @DataCalculo  
			SET @result =  0  
		  ELSE  
		  BEGIN  
			IF @DataFixaVenc = 0  
			  SET @DataVencimento = DATEADD(MONTH, 1, @DataVencimento)   
			IF @DataFixa = 1  
			  SET @DataCalculo = DATEADD(MONTH, 1, @DataCalculo)  
			IF @DataVencimento = @DataCalculo  
			BEGIN
			  SELECT TOP 1 @IndiceAcum = ISNULL(Valor/100, 0) FROM Indices WHERE IdIndice = 4 AND Data = @DataCalculo 
			  IF @AplicaPercentual = 0
      			IF @IndiceAcum IS NOT NULL AND @IndiceAcum > 0  
        			SET @result = @Valor * @IndiceAcum	 	       
      			ELSE
			BEGIN
      				SELECT TOP 1 @IndiceAcum = ISNULL(Valor/100, 0) FROM Indices WHERE IdIndice = 4 ORDER BY Data Desc
	      			IF @IndiceAcum IS NOT NULL AND @IndiceAcum > 0  
					SET @result = @Valor * @IndiceAcum
 				ELSE
					SET @result = 0	     
			END
			ELSE
			IF @IndiceAcum = 0 OR @IndiceAcum IS NULL		
				SET @result = @Valor * 0.01
			ELSE
	      			SET @result =  0 
			END	
			ELSE     
			BEGIN     
			 IF (SELECT ISNULL(COUNT(*),0) FROM Indices WHERE IdIndice = 4 AND Data >= @DataVencimento AND Data < DATEADD(MONTH, -1, @DataCalculo)) =  
			   DATEDIFF(MONTH,@DataVencimento,DATEADD(MONTH, -1, @DataCalculo))  
			 BEGIN  
			   SET @IndiceAcum = 1  
			   SELECT @IndiceAcum = @IndiceAcum *  (Valor / 100 + 1)  
			   FROM Indices  
			   WHERE IdIndice = 4 AND Data >= @DataVencimento AND Data <= @DataCalculo  
			   IF (SELECT COUNT(*) FROM Indices WHERE IdIndice = 4 AND Data = DATEADD(MONTH, -1, @DataCalculo)) = 0
			   BEGIN
			 IF @AplicaPercentual = 1 	
				 SET @result =  ((@IndiceAcum * 1.01) - 1) * @Valor  
			 ELSE
			 BEGIN
        			SELECT @Indice = (Valor / 100 + 1) FROM Indices WHERE IdIndice = 4 AND Data = DATEADD(MONTH, -2, @DataCalculo)
        			SET @result =  ((@IndiceAcum * @Indice) - 1) * @Valor  
			 END
			   END	
			   ELSE  
				 SET @result =  ((@IndiceAcum - 1)) * @Valor  
			 END  
			 ELSE  
			   SET @result = -100000  
			END  
		  END  
		  RETURN(@result)  
		END