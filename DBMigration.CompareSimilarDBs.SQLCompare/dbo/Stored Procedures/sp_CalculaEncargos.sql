


























CREATE  PROCEDURE dbo.sp_CalculaEncargos

@Valor Float,
@Percentual float,
@CE_ValorFixo float = 0,
@Indice int,
@DataVencimento datetime,
@DataCalculo datetime,
@IdMoeda  int = 1,
@DataFixa bit, 
@lChamadaInterna int = 0,
@Total float OUTPUT

AS

SET NOCOUNT ON
DECLARE  @QtdeIndice int, @Data datetime, @UfirVcto float, @UfirPgto float, @ValorIndice float, @IndiceAcum float

CREATE TABLE #tmpErros (Rotina int, DataVenc DateTime, DataCalculo DateTime, TipoErro int, DataErro DateTime)


SET @Total = 0.00

IF @Indice = 1 /*MULTA*/
BEGIN
	IF (@Percentual > 0) and (@DataVencimento < @DataCalculo) 	
        		SET @Total = @Valor * @Percentual / 100.00
	ELSE
  		SET @Total = 0.00
END

IF @Indice = 2 /*JUROS*/
BEGIN
	IF (@Percentual > 0) and (@DataVencimento < @DataCalculo) 
  	BEGIN
		SET @QtdeIndice = 0
    		SET @Data = @DataVencimento
		WHILE Cast(Cast(Year(@DataVencimento) As Varchar(4))  + REPLICATE('0', 2 - LEN(MONTH(@DataVencimento))) + Cast(Month(@DataVencimento) As Varchar(2)) As Int)  < Cast(Cast(Year(@DataCalculo) As Varchar(4))  + REPLICATE('0', 2 - LEN(MONTH(@DataCalculo))) + Cast(Month(@DataCalculo) As Varchar(2)) As int)
    		BEGIN
      			SET @QtdeIndice = @QtdeIndice + 1
      			SET @DataVencimento = DATEADD(MONTH,  @QtdeIndice, @Data)
    		END
    		IF @DataVencimento < @DataCalculo
      			SET @QtdeIndice = @QtdeIndice + 1
        		SET @Total = @QtdeIndice * @Valor * @Percentual / 100
	END
	ELSE
 		SET @Total = 0
END

IF @Indice = 3 /*UFIR*/
BEGIN
	IF @DataCalculo > '20001027'
		SET @DataCalculo = '20001027'
	IF @DataVencimento  <=  '19940831'
		SET @UfirVcto = (SELECT ISNULL(Valor,0)  FROM Indices WHERE IdIndice = 2 AND Data = @DataVencimento)
	ELSE
		SET @UfirVcto = (SELECT ISNULL(Valor,0) FROM UfirMes WHERE Ano = YEAR(@DataVencimento) AND Mes =  REPLICATE('0', 2 - LEN(MONTH(@DataVencimento))) + CAST(MONTH(@DataVencimento) AS VARCHAR(2)))
	IF @DataCalculo <=  '19940831' 
		SET @UfirPgto = (SELECT ISNULL(Valor,0) FROM Indices WHERE IdIndice = 2 AND Data = @DataCalculo)
	ELSE
		SET @UfirPgto = (SELECT ISNULL(Valor,0) FROM UfirMes WHERE Ano = YEAR(@DataCalculo) AND Mes = REPLICATE('0', 2 - LEN(MONTH(@DataCalculo))) + CAST(MONTH(@DataCalculo) AS VARCHAR(2)))
	IF @IdMoeda = 2 
		SET @Valor = @Valor * @UfirVcto	
	IF @UfirPgto = 0 
		SET @Total = 0
	ELSE
		IF @IdMoeda = 2
			SET @Total = @Valor * (@UfirPgto / @UfirVcto) 
		ELSE
			SET @Total = (@Valor * (@UfirPgto / @UfirVcto)) - @Valor	
END

IF @Indice = 4 /*SELIC Acumulada*/
BEGIN
	IF (@DataVencimento < '19890101') OR (@DataCalculo < '19940701')
	BEGIN
		SET @Total = -2
		INSERT INTO #tmpErros Values(@Indice, @DataVencimento, @DataCalculo, @Total, NULL)
	END	

	SET @DataVencimento = CAST(YEAR(@DataVencimento) AS VARCHAR(4)) + REPLICATE('0', 2 - LEN(MONTH(@DataVencimento))) + CAST(MONTH(@DataVencimento) AS VARCHAR(4)) + '01'
	SET @DataCalculo = CAST(YEAR(@DataCalculo) AS VARCHAR(4)) + REPLICATE('0', 2 - LEN(MONTH(@DataCalculo))) + CAST(MONTH(@DataCalculo) AS VARCHAR(4)) + '01'
	IF @DataFixa = 1		
		SET @DataCalculo = DATEADD(MONTH, 1, @DataCalculo)
	SET @QtdeIndice = 0
    	SET @Data = @DataVencimento
	WHILE @Data < @DataCalculo
    	BEGIN
		IF 1 <> (SELECT 1 FROM Indices WHERE IdIndice = 1 AND Data = @Data)
		BEGIN
			SET @Total = -1
			INSERT INTO #tmpErros Values(@Indice, @DataVencimento, @DataCalculo, @Total, @Data)
		END	
      		SET @QtdeIndice = @QtdeIndice + 1
      		SET @Data = DATEADD(MONTH,  @QtdeIndice, @DataVencimento)
    	END
	IF @Total >= 0 
	BEGIN	
		SET @IndiceAcum = 1
		DECLARE SELICAcumulada_Cursor
		CURSOR FAST_FORWARD FOR
		SELECT Valor
		FROM Indices
		WHERE IdIndice = 1 AND (Data >= @DataVencimento AND Data < @DataCalculo)
			OPEN SELICAcumulada_Cursor	
			FETCH NEXT FROM SELICAcumulada_Cursor
			INTO @ValorIndice
			WHILE @@FETCH_STATUS = 0 
				BEGIN
					SET @IndiceAcum = (@IndiceAcum * @ValorIndice/100 + (@IndiceAcum + @ValorIndice))
		             			FETCH NEXT FROM SELICAcumulada_Cursor
					INTO @ValorIndice
				END
			CLOSE SELICAcumulada_Cursor
			DEALLOCATE SELICAcumulada_Cursor
		SET @Total = @Valor * (@IndiceAcum / 100)
	END	
END
IF @Indice = 5 /*SELIC Capitalizada*/
BEGIN	
	IF (@DataVencimento < '19890101') OR (@DataCalculo < '19940701')
	BEGIN
		SET @Total = -2
		INSERT INTO #tmpErros Values(@Indice, @DataVencimento, @DataCalculo, @Total, NULL)
	END

	SET @DataVencimento =  CAST(YEAR(@DataVencimento) AS VARCHAR(4)) + REPLICATE('0', 2 - LEN(MONTH(@DataVencimento))) + CAST(MONTH(@DataVencimento) AS VARCHAR(4)) + '01' 
	SET @DataCalculo = CAST(YEAR(@DataCalculo) AS VARCHAR(4)) + REPLICATE('0', 2 - LEN(MONTH(@DataCalculo))) + CAST(MONTH(@DataCalculo) AS VARCHAR(4)) + '01'	
	IF @DataFixa = 1		
		SET @DataCalculo = DATEADD(MONTH, 1, @DataCalculo)
	SET @QtdeIndice = 0
    	/*SET @Data = @DataVencimento	*/
	SET @Data = DATEADD(MONTH,  1, @DataVencimento)
	WHILE @Data < @DataCalculo
    	BEGIN
		IF NOT EXISTS (SELECT 1 FROM Indices WHERE IdIndice = 1 AND Data = @Data)
		BEGIN
			SET @Total = -1
			INSERT INTO #tmpErros Values(@Indice, @DataVencimento, @DataCalculo, @Total, @Data)
		END	
      		SET @QtdeIndice = @QtdeIndice + 1
      		SET @Data = DATEADD(MONTH,  @QtdeIndice, @DataVencimento)
    	END 
	IF @Total >= 0 
	BEGIN
		SET @IndiceAcum = 1
		DECLARE SELICCapitalizada_Cursor
		CURSOR FAST_FORWARD FOR
		SELECT (Valor / 100 + 1) AS Valor
		FROM Indices
		WHERE IdIndice = 1 AND Data >= @DataVencimento AND Data <= @DataCalculo
			OPEN SELICCapitalizada_Cursor	
			FETCH NEXT FROM SELICCapitalizada_Cursor
			INTO @ValorIndice
			WHILE @@FETCH_STATUS = 0 
				BEGIN
					SET @IndiceAcum = @IndiceAcum * @ValorIndice
		             			FETCH NEXT FROM SELICCapitalizada_Cursor
					INTO @ValorIndice
				END
			CLOSE SELICCapitalizada_Cursor
			DEALLOCATE SELICCapitalizada_Cursor
		IF NOT EXISTS (SELECT 1 FROM Indices WHERE IdIndice = 1 AND Data = @DataCalculo)
			SET @Total =  ((@IndiceAcum * 1.01) - 1) * @Valor 
		ELSE
			SET @Total =  ((@IndiceAcum - 1)) * @Valor
	END	
END

IF @Indice = 6 /*ICV */
BEGIN
	SET @DataVencimento = CAST(YEAR(@DataVencimento) AS VARCHAR(4)) +  '0101'
	SET @DataCalculo = CAST(YEAR(@DataCalculo) AS VARCHAR(4)) +  '0101'	
	IF @DataFixa = 1		
		SET @DataCalculo = DATEADD(YEAR, 1, @DataCalculo)
	SET @QtdeIndice = 0
    	SET @Data = @DataVencimento
	WHILE @Data < @DataCalculo
    	BEGIN
		IF 1 <> (SELECT 1 FROM Indices WHERE IdIndice = 3 AND Data = @Data)
		BEGIN
			SET @Total = -1
			INSERT INTO #tmpErros Values(@Indice, @DataVencimento, @DataCalculo, @Total, @Data)
		END	
      		SET @QtdeIndice = @QtdeIndice + 1
      		SET @Data = DATEADD(MONTH,  @QtdeIndice, @DataVencimento)
    	END
	IF @Total >= 0 
	BEGIN
		SET @IndiceAcum = 1
		DECLARE ICV_Cursor
		CURSOR FAST_FORWARD FOR
		SELECT (Valor / 100 + 1) AS Valor
		FROM Indices
		WHERE IdIndice = 3 AND Data >= @DataVencimento AND Data < @DataCalculo
			OPEN ICV_Cursor	
			FETCH NEXT FROM ICV_Cursor
			INTO @ValorIndice
			WHILE @@FETCH_STATUS = 0 
				BEGIN
					SET @IndiceAcum = @IndiceAcum * @ValorIndice
		             			FETCH NEXT FROM ICV_Cursor
					INTO @ValorIndice
				END
			CLOSE ICV_Cursor
			DEALLOCATE ICV_Cursor
		SET @Total = @Valor * (@IndiceAcum -1)
	END	
END

IF @Indice = 7 /*INPC*/
BEGIN
	SET @DataVencimento = CAST(YEAR(@DataVencimento) AS VARCHAR(4)) + REPLICATE('0', 2 - LEN(MONTH(@DataVencimento))) + CAST(MONTH(@DataVencimento) AS VARCHAR(4)) + '01'
	SET @DataCalculo = CAST(YEAR(@DataCalculo) AS VARCHAR(4)) + REPLICATE('0', 2 - LEN(MONTH(@DataCalculo))) + CAST(MONTH(@DataCalculo) AS VARCHAR(4)) + '01'	
	IF @DataFixa = 1		
		SET @DataCalculo = DATEADD(MONTH, 1, @DataCalculo)
	SET @QtdeIndice = 0
    	SET @Data = @DataVencimento
	WHILE @Data < @DataCalculo
    	BEGIN
		IF 1 <> (SELECT 1 FROM Indices WHERE IdIndice = 4 AND Data = @Data)
		BEGIN

			SET @Total = -1
			INSERT INTO #tmpErros Values(@Indice, @DataVencimento, @DataCalculo, @Total, @Data)
		END	
      		SET @QtdeIndice = @QtdeIndice + 1
      		SET @Data = DATEADD(MONTH,  @QtdeIndice, @DataVencimento)
    	END
	IF @Total >= 0 
	BEGIN
		SET @IndiceAcum = 1
		DECLARE INPC_Cursor
		CURSOR FAST_FORWARD FOR
		SELECT (Valor / 100 + 1) AS Valor
		FROM Indices
		WHERE IdIndice = 4 AND Data >= @DataVencimento AND Data < @DataCalculo
			OPEN INPC_Cursor	
			FETCH NEXT FROM INPC_Cursor
			INTO @ValorIndice
			WHILE @@FETCH_STATUS = 0 
				BEGIN
					SET @IndiceAcum = @IndiceAcum * @ValorIndice
		             			FETCH NEXT FROM INPC_Cursor
					INTO @ValorIndice				END
			CLOSE INPC_Cursor
			DEALLOCATE INPC_Cursor
		SET @Total = @Valor * (@IndiceAcum - 1)
	END	
END

IF @Indice = 8 /*IPCA/IBGE*/
BEGIN
	SET @DataVencimento = CAST(YEAR(@DataVencimento) AS VARCHAR(4)) + REPLICATE('0', 2 - LEN(MONTH(@DataVencimento))) + CAST(MONTH(@DataVencimento) AS VARCHAR(4)) + '01'
	SET @DataCalculo = CAST(YEAR(@DataCalculo) AS VARCHAR(4)) + REPLICATE('0', 2 - LEN(MONTH(@DataCalculo))) +  CAST(MONTH(@DataCalculo) AS VARCHAR(4)) + '01'
	IF @DataFixa = 1		
		SET @DataCalculo = DATEADD(MONTH, 1, @DataCalculo)	
	SET @QtdeIndice = 0
    	SET @Data = @DataVencimento
	WHILE @Data < @DataCalculo
    	BEGIN
		IF 1 <> (SELECT 1 FROM Indices WHERE IdIndice = 6 AND Data = @Data)
		BEGIN
			SET @Total = -1
			INSERT INTO #tmpErros Values(@Indice, @DataVencimento, @DataCalculo, @Total, @Data)
		END	
      		SET @QtdeIndice = @QtdeIndice + 1
      		SET @Data = DATEADD(MONTH,  @QtdeIndice, @DataVencimento)
    	END
	IF @Total >= 0 
	BEGIN
		SET @IndiceAcum = 0
		DECLARE IPCA_Cursor
		CURSOR FAST_FORWARD FOR
		SELECT (Valor / 100 + 1) AS Valor
		FROM Indices
		WHERE IdIndice = 6 AND Data >= @DataVencimento AND Data < @DataCalculo
			OPEN IPCA_Cursor	
			FETCH NEXT FROM IPCA_Cursor
			INTO @ValorIndice
			WHILE @@FETCH_STATUS = 0 
				BEGIN
					SET @IndiceAcum = @IndiceAcum * @ValorIndice
		             			FETCH NEXT FROM IPCA_Cursor
					INTO @ValorIndice
				END
			CLOSE IPCA_Cursor
			DEALLOCATE IPCA_Cursor
		SET @Total = @Valor * (@IndiceAcum - 1)
	END	
END

IF @Indice = 9 /*POUPANÇA*/
BEGIN
	SET @DataVencimento = CAST(YEAR(@DataVencimento) AS VARCHAR(4)) + REPLICATE('0', 2 - LEN(MONTH(@DataVencimento))) + CAST(MONTH(@DataVencimento) AS VARCHAR(4)) + '01'
	SET @DataCalculo = CAST(YEAR(@DataCalculo) AS VARCHAR(4)) + REPLICATE('0', 2 - LEN(MONTH(@DataCalculo))) + CAST(MONTH(@DataCalculo) AS VARCHAR(4)) + '01'		
	SET @QtdeIndice = 0
    	SET @Data = @DataVencimento
	WHILE @Data < @DataCalculo
    	BEGIN
		IF 1 <> (SELECT 1 FROM Indices WHERE IdIndice = 5 AND Data = @Data)
		BEGIN
			SET @Total = -1
			INSERT INTO #tmpErros Values(@Indice, @DataVencimento, @DataCalculo, @Total, @Data)
		END	
      		SET @QtdeIndice = @QtdeIndice + 1
      		SET @Data = DATEADD(MONTH,  @QtdeIndice, @DataVencimento)
    	END
	IF @Total >= 0 
	BEGIN	
		SET @IndiceAcum = 1
		DECLARE POUPANCA_Cursor
		CURSOR FAST_FORWARD FOR
		SELECT Valor
		FROM Indices
		WHERE IdIndice = 5 AND (Data >= @DataVencimento AND Data <= @DataCalculo)
			OPEN POUPANCA_Cursor	
			FETCH NEXT FROM POUPANCA_Cursor
			INTO @ValorIndice
			WHILE @@FETCH_STATUS = 0 
				BEGIN
					SET @IndiceAcum = (@IndiceAcum * @ValorIndice/100 + (@IndiceAcum + @ValorIndice))
		             			FETCH NEXT FROM POUPANCA_Cursor
					INTO @ValorIndice
				END
			CLOSE POUPANCA_Cursor
			DEALLOCATE POUPANCA_Cursor
		SET @Total = @Valor * (@IndiceAcum / 100)
	END	
END

IF (@CE_ValorFixo > 0) AND (@Total >= 0) 
	SET @Total = @Total + @CE_ValorFixo

IF @lChamadaInterna = 0 
	SELECT * FROM #tmpErros 






















































