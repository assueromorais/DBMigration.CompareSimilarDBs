CREATE PROCEDURE [dbo].[sp_Periodo_AnoRef] @Sql VARCHAR(8000)
AS
BEGIN
/*Declaração de Variáveis=====================================================*/
  DECLARE @Result VARCHAR(250),
		  @I INT,
		  @AnoInicial INT,
		  @AnoRegAtual INT,
		  @AnoRegPosterior INT,
		  @AnoRegAnterior INT,
		  @QtdReg INT,
		  @AnoIntervalo INT,
		  @AnoIntervaloAnterior INT
  DECLARE @Periodo Table (IdPeriodo INT IDENTITY(1,1),AnoRef CHAR(4),Intervalo INT)  

  /*Seta valores iniciais========================================================*/  
  INSERT INTO @Periodo(AnoRef)  	
  EXEC(@Sql)
  
  SELECT @QtdReg = COUNT(*) FROM @Periodo  
  SELECT @AnoInicial =  MIN(AnoRef) FROM @Periodo    
  SET @result = @AnoInicial 
  /*Calcula periodo===============================================================*/
  IF @QtdReg > 1 	  
  BEGIN
  	SET @I = 1
	SET @result = ''	
	/*Insere na coluna Intervalo a quantidade de anos da subtração de AnoPosterior - AnoAtual*/	
	UPDATE @Periodo SET Intervalo = 0 WHERE IdPeriodo = 1
	WHILE @I <= @QtdReg 
    BEGIN
    	SET @AnoRegAtual = (SELECT AnoRef FROM @Periodo WHERE IdPeriodo = @I)
    	SET @AnoRegPosterior = (SELECT AnoRef FROM @Periodo WHERE IdPeriodo = @I + 1)
		UPDATE @Periodo SET Intervalo = @AnoRegPosterior - @AnoRegAtual WHERE IdPeriodo = @I + 1
		SET @I = @I + 1 		
    END       
	
	SET @I = 1
	SET @result = ''  
	WHILE @I <= @QtdReg 
    BEGIN
    	SELECT @AnoRegAtual = AnoRef ,@AnoIntervalo = Intervalo FROM @Periodo WHERE IdPeriodo = @I --Ano Atual
    	 
    	SELECT @AnoRegAnterior = AnoRef ,@AnoIntervaloAnterior = Intervalo FROM @Periodo WHERE IdPeriodo = @I - 1 --Ano Anterior  
		
		IF (@AnoIntervalo = 0) 
		  SET @result = CAST(@AnoInicial AS CHAR(4))
		  
		ELSE IF (@AnoIntervalo <> 1) 
		BEGIN
		  IF (@AnoIntervaloAnterior = 1) 
			SET @result = @result + ' até ' + CAST(@AnoRegAnterior AS CHAR(4)) + ',' + CAST(@AnoRegAtual AS CHAR(4))
		  ELSE
			SET @result = @result + ',' + CAST(@AnoRegAtual AS CHAR(4))
		END
		ELSE
		BEGIN
			IF @I = @QtdReg
			SET @result = @result + ' até ' + CAST(@AnoRegAtual AS CHAR(4))
		END		
		SET @I = @I + 1	
    END
    
    IF  SUBSTRING (@result,LEN(@result),1) = ',' 
		SET @result = SUBSTRING(@result,1,(LEN(@result)-1))	
END
SELECT @result
END
