/*Lucimara - 22/02/2011 - OC 74440*/

CREATE PROCEDURE [dbo].[spCalculaPorcentagensRepasse] (@IdConta INT, @idRepasseContaEdit INT)
as

DECLARE  @TotalGeral FLOAT,@Soma_RepIndependentes FLOAT, @Soma_RepAplicados FLOAT,
         @IdRepasseConta INT, @ValorPerRepasse FLOAT, @Aplicacao VARCHAR(100),
         @AplicacaoTeste VARCHAR(100), @IdTeste INT, @FlagValorPreenchido VARCHAR(3),
         @ValorCalculado FLOAT, @QtdRegistros INT, @TimeOut INT, @RepassarCalculo VARCHAR(3)
         
CREATE TABLE #TABTEMPREP(
ID INT IDENTITY,
IdRepasseconta INT,
ValorPercRepasse REAL,
ValorPercCalculado REAL,
AplicarSobreRepasse VARCHAR(100))
	
CREATE TABLE #TABTEMP1 (
ID INT IDENTITY,
VALOR REAL)


IF @idRepasseContaEdit IS NULL
	INSERT INTO #TABTEMPREP (IdRepasseconta, ValorPercRepasse, ValorPercCalculado, AplicarSobreRepasse)
	SELECT	R1.IdRepasseConta, 
			R1.ValorPercRepasse,
			CASE WHEN R1.AplicarSobreRepasse IS NULL THEN R1.ValorPercRepasse ELSE 0 END,
			R1.AplicarSobreRepasse
	FROM RepassesContas R1
	WHERE R1.IdConta = @IdConta AND R1.E_Percentual = 1
ELSE	 
	INSERT INTO #TABTEMPREP (IdRepasseconta, ValorPercRepasse, ValorPercCalculado, AplicarSobreRepasse)
	SELECT	R1.IdRepasseConta, 
			R1.ValorPercRepasse,
			CASE WHEN R1.AplicarSobreRepasse IS NULL THEN R1.ValorPercRepasse ELSE 0 END,
			R1.AplicarSobreRepasse
	FROM RepassesContas R1
	WHERE R1.IdConta = @IdConta AND R1.E_Percentual = 1 AND R1.IdRepasseConta <> @idRepasseContaEdit


SELECT @QtdRegistros = Count(IdRepasseConta)
FROM #TABTEMPREP 
WHERE AplicarSobreRepasse IS NOT NULL

SET @TimeOut = 0
SET @RepassarCalculo = 'Nao'

DECLARE RepassesContasAplicacao_Cursor
	CURSOR FAST_FORWARD FOR
		SELECT IdRepasseConta
		FROM #TABTEMPREP 
		WHERE AplicarSobreRepasse IS NOT NULL
		ORDER BY LEN(AplicarSobreRepasse), AplicarSobreRepasse 		
	OPEN RepassesContasAplicacao_Cursor
	FETCH NEXT FROM RepassesContasAplicacao_Cursor
	INTO @IdRepasseConta
	
	WHILE @@FETCH_STATUS = 0
	BEGIN	
	  SET @FlagValorPreenchido = 'Sim'
	  SELECT @ValorCalculado = ValorPercCalculado FROM #TABTEMPREP rc WHERE rc.IdRepasseConta = @IdRepasseConta
	  IF @ValorCalculado <= 0
	  BEGIN
	    /*Verificando se o valor está calculado para os repasses que estão na aplicação */ 
		SET @Aplicacao = (SELECT AplicarSobreRepasse FROM #TABTEMPREP rc WHERE rc.IdRepasseConta = @IdRepasseConta) 
		SET @Aplicacao = SUBSTRING(@Aplicacao, 2, len(@aplicacao)-1) 
		SET @AplicacaoTeste = @Aplicacao
 
		WHILE CHARINDEX(',', @AplicacaoTeste) > 0 
		BEGIN
			SET @IdTeste = SUBSTRING(@AplicacaoTeste, 1, CHARINDEX(',', @AplicacaoTeste)-1)
			IF @IdTeste <> ''
			BEGIN
			  SELECT @ValorCalculado = ValorPercCalculado FROM #TABTEMPREP rc WHERE rc.IdRepasseConta = @IdTeste
			  
			  IF @ValorCalculado <= 0
			  BEGIN
			    SET @FlagValorPreenchido = 'Nao'
			    SET @RepassarCalculo = 'Sim'
			  END  
			END
          
			IF CHARINDEX(',', @AplicacaoTeste) < len(@AplicacaoTeste)
				SET @AplicacaoTeste = SUBSTRING(@AplicacaoTeste, CHARINDEX(',', @AplicacaoTeste)+1, len(@AplicacaoTeste))
			ELSE
				SET @AplicacaoTeste = ''   
		END
		SET @Aplicacao = SUBSTRING(@Aplicacao, 1, len(@aplicacao)-1) 
 
		IF @FlagValorPreenchido = 'Sim'
		BEGIN
			EXEC('
			INSERT INTO #TABTEMP1 (VALOR)
			SELECT ValorPercRepasse * (
			SELECT 100 - IsNull(SUM(ValorPercCalculado),0)
			FROM #TABTEMPREP  
			WHERE IdRepasseconta IN (' + @Aplicacao + ') 
			)/100
			FROM #TABTEMPREP rc WHERE rc.IdRepasseConta = ' + @IdRepasseConta)
		
			SET @ValorPerRepasse = (SELECT VALOR FROM #TABTEMP1 WHERE ID = (SELECT MAX(ID) FROM #TABTEMP1))
		
			UPDATE #TABTEMPREP SET ValorPercCalculado = @ValorPerRepasse WHERE IdRepasseConta = @IdRepasseConta 
		END	
	  END   
	  
	  FETCH NEXT FROM RepassesContasAplicacao_Cursor
	  INTO @IdRepasseConta
	  
	  IF @@FETCH_STATUS <> 0 /*Se for final da tabela, se nao foi preenchida alguma vez, retornar ao início*/
		IF @RepassarCalculo = 'Sim' AND @TimeOut < @QtdRegistros
		BEGIN
		  SET @TimeOut = @TimeOut + 1
		  SET @RepassarCalculo = 'Nao'
          FETCH FIRST FROM RepassesContasAplicacao_Cursor
	      INTO @IdRepasseConta
	    END  
	END
	CLOSE RepassesContasAplicacao_Cursor
	DEALLOCATE RepassesContasAplicacao_Cursor

SET @TotalGeral = @Soma_RepIndependentes + @Soma_RepAplicados

DROP TABLE #TABTEMP1

--- Retornando o Resultado ---
Select * FROM #TABTEMPREP                                  

DROP TABLE #TABTEMPREP
