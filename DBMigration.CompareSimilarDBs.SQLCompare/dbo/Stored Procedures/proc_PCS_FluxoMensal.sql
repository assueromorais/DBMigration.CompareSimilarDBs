/*Alteração Nelson / Lucimara - Ocorr. 88150 - 14/03/2012*/
/* PCS - André - 07/10/2009 - Oc. 50733 */

CREATE PROCEDURE [dbo].[proc_PCS_FluxoMensal]
	@idCentroCusto VARCHAR(10) = '0',
	@idCentroCustoReceita VARCHAR(10) = '0',
	@DataInicial DATETIME,
	@DataFinal DATETIME,
	@mov BIT = 0,
	@IdContaFinanceira INT = 0,
	@idUsuario VARCHAR(5)
AS
	SET NOCOUNT ON
	DECLARE @inserirContasMOV             VARCHAR(8000),
	        @inserirContasMOVDESTINO      VARCHAR(8000),
	        @sqlAExec                     NVARCHAR(3500),
	        @sqlAndContaFinanceira        VARCHAR(50),
	        @sqlSelectFinalMOV            VARCHAR(8000),
	        @sqlTableTempMOV              VARCHAR(8000),
	        @sqlTableTempMOVDestino       VARCHAR(8000),
	        @sqlInserirSaldoFinal         VARCHAR(1000),
	        @sqlValoresIniciaisTRANSF     VARCHAR(8000),
	        @sqlValoresFINAIS             VARCHAR(8000),
	        @sqlValoresIniciais           VARCHAR(5000),
	        @sqlValoresIniciaisReceitas   VARCHAR(5000),
	        @sqlValoresIniciaisDESP       VARCHAR(5000),
	        @sqlValoresIniciaisMOV        VARCHAR(5000),
	        @ValorMoney                   MONEY,
	        @Valor                        VARCHAR(25),
	        @ValorNegativo                VARCHAR(25),
	        @sqlTableTemp                 VARCHAR(8000),
	        @sqlTableTempDESP             VARCHAR(8000),
	        @inserirContasReceita         VARCHAR(8000),
	        @inserirContasDespesa         VARCHAR(8000),
	        @sqlCamposTemp                VARCHAR(8000),
	        @sVirgula                     VARCHAR(1),
	        @sqlSelectFinal               VARCHAR(8000),
	        @sqlSelectFormatado           VARCHAR(8000),
	        @sqlCamposFiltroMovimentacao  VARCHAR(8000),
	        @diaInicial                   INT,
	        @qtdDias                      INT,
	        @NomeCampo                    VARCHAR(30),
	        @DataLoop                     DATETIME,
	        @sqlCampoACampo               VARCHAR(1000),
	        @i                            INT,
	        @Alias_campo                  VARCHAR(20),
	        @dataVarchar                  NVARCHAR(10),	        						
	        
	        /* Debug Mode Flag (0 - Debug not active, 1 - Debug active) */
	        @bDebugMode	BIT							
	
	
	/* Sets Debug Mode */
	SET @bDebugMode = 1
	
	SET @sqlValoresIniciaisTRANSF = ''
	SET @sqlValoresFINAIS = ''
	SET @sqlValoresIniciais = ''
	SET @sqlValoresIniciaisReceitas = ''
	SET @sqlValoresIniciaisDESP = ''
	SET @sqlValoresIniciaisMOV = ''
	
	SET @diaInicial = MONTH(@DataInicial)
	SET @sqlInserirSaldoFinal = ''
	SET @qtdDias = DATEDIFF(MONTH, @DataInicial, @DataFinal) 
	SET @i = @diaInicial 
	SET @sqlCamposTemp = ''
	SET @inserirContasReceita = ''
	SET @inserirContasDespesa = ''
	SET @sqlSelectFinal = ''
	SET @sqlSelectFormatado = ''
	SET @sVirgula = ''
	SET @sqlTableTemp = 
	    'CREATE TABLE #tempRelRECEITAS (identificador int  ,nomeConta varchar(200) ';
	SET @sqlCamposFiltroMovimentacao = 
	    ' where 1=0 or nomeConta =''__SALDO FINAL->'' or nomeConta =''__SALDO INICIAL->'' or nomeConta =''__SAÍDAS->'' or nomeConta =''__DESPESAS->'' or nomeConta =''__TRANSFERÊNCIAS->'' or nomeConta = ''__RECEITA->'''
	
	/* Se IdContaFinanceira for maior que zero */
	IF @IdContaFinanceira > 0
	BEGIN
	    SET @sqlAndContaFinanceira = ' =  ' + CAST(@IdContaFinanceira AS VARCHAR(10))
	END
	ELSE
	BEGIN
	    SET @sqlAndContaFinanceira = ' >  ' + CAST(@IdContaFinanceira AS VARCHAR(10))
	END
		
	/*  
	* @qtdDias -> é a diferença da Data de Inicio de Data de Término
	* @diaInicial -> É o 
	*/		
	SET @DataLoop = @DataInicial
	SET @sqlCampoACampo = ''
	WHILE (@i <= (@qtdDias + @diaInicial))
	BEGIN
			/* Converte Data de Inicio para String */
	    SELECT @dataVarchar = CONVERT(VARCHAR, CONVERT(VARCHAR, @dataLoop, 120))
	    
	     /* Obtém o mês literal para a data de Inicio */
	    SELECT @Alias_campo = '[' + CASE CAST(MONTH(@DataLoop) AS INT)
	                                     WHEN 1 THEN 'Janeiro'
	                                     WHEN 2 THEN 'Fevereiro'
	                                     WHEN 3 THEN 'Março'
	                                     WHEN 4 THEN 'Abril'
	                                     WHEN 5 THEN 'Maio'
	                                     WHEN 6 THEN 'Junho'
	                                     WHEN 7 THEN 'Julho'
	                                     WHEN 8 THEN 'Agosto'
	                                     WHEN 9 THEN 'Setembro'
	                                     WHEN 10 THEN 'Outubro'
	                                     WHEN 11 THEN 'Novembro'
	                                     WHEN 12 THEN 'Dezembro'
	                                END + '/' + CAST(YEAR(@DataLoop) AS VARCHAR(4)) + ']'
	    
	    
	    /* Monta Nome do Alias para coluna data no formato Mês Literal/Ano (ex. Janeiro/2011) */
	    SET @nomeCampo = '_' + CAST(DAY(@DataLoop) AS VARCHAR(2)) + '_' + CAST(MONTH(@DataLoop) AS VARCHAR(2))
	        + '_' + CAST(YEAR(@DataLoop) AS VARCHAR(4))
			
			/* Montando String com campos que serão selecionados */	        
	    SET @sqlSelectFormatado = @sqlSelectFormatado + @sVirgula +
	        ' dbo.format_currency(dia' + @nomeCampo + ') as ' + @Alias_campo
	    
	    SET @sqlCamposTemp = @sqlCamposTemp + ',' + 'dia' + @nomeCampo +
	        ' money'    
	    
	    SET @sqlCampoACampo = @sqlCampoACampo + ',' + 'dia' + @nomeCampo
	      
	     /* Filtro Movimentação */
	    SET @sqlCamposFiltroMovimentacao = @sqlCamposFiltroMovimentacao + ' or ' 
	        + 'dia' + @nomeCampo + ' <> 0'
	    
	    /***** Total Receitas *****/
	    SET @sqlAExec = 
	        'SELECT @Valor = ISNULL(SUM(valor),0) ' + 
	        ' FROM (SELECT SUM(wc.valorTotal) AS valor ' +
					'					FROM web_ContasFinanceiras wcf ' +
					'							 LEFT JOIN  web_receitas wc ON wc.IdContaFinanceira = wcf.IdContaFinanceira ' +
					'							   AND MONTH(dataReceita) = MONTH(''' + @dataVarchar + ''')	' +
					'								 AND YEAR(dataReceita) = YEAR(''' + @dataVarchar + ''') ' +
					'								 AND wc.IdCentroCusto = ' + @idCentroCusto +
	        '								 AND wc.IdCentroCustoReceita = ' + @idCentroCustoReceita +
	        '        WHERE wcf.IdContaFinanceira ' + @sqlAndContaFinanceira +
	        '					 AND wc.DataReceita IS NOT NULL ' +
					'			GROUP BY wcf.IdContaFinanceira,saldoinicial ' +
					') a'
	    	    
	    IF @bDebugMode = 1
	        PRINT @sqlAExec
	    
	    /* Executa consulta */
	    EXEC sp_executesql @sqlAExec, N'@Valor money output', @valorMoney OUTPUT
	    	    
	    /* Converte "Valor Tota de Receitas" para String */
	    SET @Valor = CAST(@ValorMoney AS VARCHAR)
	    
	    /* Valor Inicial das Receitas */ 
	    SET @sqlValoresIniciaisRECEITAS = @sqlValoresIniciaisRECEITAS + ',' + @Valor
	    
	    
	    /***** Total Despesas *****/
	    SET @sqlAExec = 
	        'SELECT @Valor = ISNULL(SUM(valor),0) ' + 
	        '  FROM (SELECT SUM(wc.valorEfetivo) AS VALOR ' +
					'					 FROM web_ContasFinanceiras wcf ' +
					'					      LEFT JOIN web_Despesas wc ON wc.IdContaFinanceira = wcf.IdContaFinanceira ' +
					'							 	  AND MONTH(dataEfetiva) = MONTH(''' + @dataVarchar + ''') ' +
					'							 		AND YEAR(dataEfetiva) = ' + CAST(YEAR(@dataVarchar) AS VARCHAR(4)) +
					'							 		AND wc.IdCentroCusto = ' + @idCentroCusto +
					'							 	INNER JOIN PlanoContas p ON wc.idconta = p.idconta ' +
					'					WHERE wcf.IdContaFinanceira ' + @sqlAndContaFinanceira +
					'					  AND wc.DataEfetiva IS NOT NULL ' +
					'			 GROUP BY wcf.IdContaFinanceira,saldoinicial ' +
					') a'
	    
	    IF @bDebugMode = 1
				PRINT @sqlAExec
	    
	    /* Executa consulta */	
	    EXEC sp_executesql @sqlAExec, N'@Valor money output', @valorMoney OUTPUT
			
			/* Converte "Valor Tota de Despesas" para String */    
	    SET @Valor = CAST(@ValorMoney AS VARCHAR)
	    
	    /* Valor Inicial das Despesas */
	    SET @sqlValoresIniciaisDESP = @sqlValoresIniciaisDESP + ',' + @Valor
	    	    
			/***** Valor Negativo ??? O que é valor Negativo ??? *****/	    
	    SET @sqlAExec = 
	        'SELECT @ValorNegativo = ISNULL(SUM(valor),0) ' + 
	        '  FROM (SELECT ISNULL(SUM(wc.valorPrevisto),0) AS valor ' +
					'					 FROM web_ContasFinanceiras wcf ' +
					'								LEFT JOIN web_MovimentacoesFinanceiras wc ON wc.IdContaOrigem = wcf.IdContaFinanceira ' +
					'									AND MONTH(dataTransacao) = MONTH(''' + @dataVarchar + ''') ' +
					'									AND YEAR(dataTransacao) = ' + CAST(YEAR(@dataVarchar) AS VARCHAR(4)) +
					'									AND wc.IdCentroCusto = ' + @idCentroCusto +
					'					WHERE wcf.IdContaFinanceira ' + @sqlAndContaFinanceira +
					'						AND wc.DataTransacao IS NOT NULL ' +
					'GROUP BY wcf.IdContaFinanceira, saldoinicial ' +
					') a'
	    
	    IF @bDebugMode = 1
				PRINT @sqlAExec
	    
	    /* Executa consulta para recuperar valor negativo */
	    EXEC sp_executesql @sqlAExec, N'@valorNegativo money output', @valorMoney OUTPUT
	    
	    /* Converte "Valor Valor Negativo" para String */ 
	    SET @ValorNegativo = CAST(@ValorMoney AS VARCHAR)
	    	    
	    /***** Valor ??? O que é Valor ??? *****/
	    SET @sqlAExec = 
	        'SELECT @Valor = ISNULL(SUM(valor),0) ' + 
	        '	 FROM (SELECT ISNULL(sum(wc.valorPrevisto),0) AS valor ' +
					'					 FROM web_ContasFinanceiras wcf ' +
					'								LEFT JOIN web_MovimentacoesFinanceiras wc ON wc.IdContaDestino = wcf.IdContaFinanceira ' +
					'								  AND MONTH(dataTransacao) = MONTH(''' + @dataVarchar + ''') ' +
					'									AND YEAR(dataTransacao) =' + CAST(YEAR(@dataVarchar) AS VARCHAR(4)) +
					'								  AND wc.IdCentroCusto = ' + @idCentroCusto +
					'					WHERE wcf.IdContaFinanceira ' + @sqlAndContaFinanceira +
					'						AND wc.DataTransacao IS NOT NULL ' +
					'GROUP BY wcf.IdContaFinanceira, saldoinicial ' +
					') a'
	    
	    IF @bDebugMode = 1
				PRINT @sqlAExec
	    
	    /* Executa consulta */
	    EXEC sp_executesql @sqlAExec, N'@Valor money output', @valorMoney OUTPUT
	    
	    /* Cornverte valor retornada para String */
	    SET @Valor = CAST(@ValorMoney AS VARCHAR)
	    	    
	    /***** Subtrai Valor Total do Valor Negativo ******/
	    SET @valor = CAST(
	            CAST(@valor AS MONEY) - CAST(@valorNegativo AS MONEY) AS VARCHAR(25)
	        )
	    
	    SET @sqlValoresIniciaisMOV = @sqlValoresIniciaisMOV + ',' + @Valor
	    
	    IF @bDebugMode = 1
				PRINT 'sqlValoresIniciaisMOV ' + @sqlValoresIniciaisMOV
	        
	    /***** SALDO INICIAL *****/
	    PRINT '<< - Chamando SP_SALDOINICIO ->> ' 
	    PRINT '----- INICIO Parâmetros -----'
	    PRINT '@Data = ' + @dataVarchar
	    PRINT '@IdContaFinanceira = ' + CONVERT(VARCHAR(10), @IdContaFinanceira) 
			PRINT '@IF = I'
			PRINT '@IdCentroCusto = ' + CONVERT(VARCHAR(10), @IdCentroCusto)
			PRINT '@idCentroCustoReceita = ' + CONVERT(VARCHAR(10), @idCentroCustoReceita)
			PRINT '----- FIM Parâmetros -----'
	    EXEC sp_saldoInicio @dataVarchar,
	         @IdContaFinanceira,
	         'I',
	         @IdCentroCusto,
	         @idCentroCustoReceita,
	         @valorMoney OUTPUT	    
	    SET @Valor = CAST(@ValorMoney AS VARCHAR)	    	    	    
	    SET @sqlValoresIniciais = @sqlValoresIniciais + ',' + @Valor + ' AS ' + @Alias_campo
	    
	    PRINT 'Saldo Inicial = ' + CAST(@ValorMoney AS VARCHAR)
	    PRINT '<< - Fim chamada SP_SALDOINICIO ->> '
			/***** FIM SALDO INICIAL *****/	    
	    
	    /***** SALDO FINAL *****/
	    PRINT '<< - Chamando SP_SALDOINICIO ->> ' 
	    PRINT '----- INICIO Parâmetros -----'
	    PRINT '@Data = ' + @dataVarchar
	    PRINT '@IdContaFinanceira = ' + CONVERT(VARCHAR(10), @IdContaFinanceira) 
			PRINT '@IF = F'
			PRINT '@IdCentroCusto = ' + CONVERT(VARCHAR(10), @IdCentroCusto)
			PRINT '@idCentroCustoReceita = ' + CONVERT(VARCHAR(10), @idCentroCustoReceita)
			PRINT '----- FIM Parâmetros -----'	    
	    EXEC sp_saldoInicio @dataVarchar,
	         @IdContaFinanceira,
	         'F',
	         @IdCentroCusto,
	         @idCentrocustoReceita,
	         @valorMoney OUTPUT	    
	    SET @Valor = CAST(@ValorMoney AS VARCHAR)	    	    
	    SET @sqlValoresFINAIS = @sqlValoresFINAIS + ',' + @Valor
	    
	    PRINT 'Saldo Final = ' + CAST(@ValorMoney AS VARCHAR)
	    PRINT '<< - Fim chamada SP_SALDOINICIO ->> '
	    /***** FIM SALDO FINAL *****/
	    	    
	    SET @sVirgula = ','
	    SET @DataLoop = DATEADD(MONTH, 1, @DataLoop)
	    SET @i = @i + 1 ;	    
	    
	    IF @bDebugMode = 1
	    BEGIN
				PRINT '[Valor Inicial] ' + @sqlValoresIniciais
				PRINT '[Valor Final] ' + @sqlValoresFINAIS
			END
	    
	END /* WHILE */
	
	SET @sqlCamposTemp = @sqlCamposTemp + ')'
	SET @sqlTableTemp = @sqlTableTemp + @sqlCamposTemp 
	SET @sVirgula = ''
	SET @i = @diaInicial 
	SET @DataLoop = @DataInicial	
	
	SET @sqlValoresINICIAIS = 'SELECT ''__SALDO INICIAL->'' AS nomeConta ' + @sqlValoresIniciais
	SET @sqlValoresIniciaisRECEITAS = 'SELECT ''__RECEITA->'' AS nomeConta ' + @sqlValoresIniciaisRECEITAS 
	SET @sqlValoresIniciaisDesp = 'SELECT ''__DESPESAS->'' AS nomeConta ' + @sqlValoresIniciaisDESP
	SET @sqlValoresIniciaisTRANSF = 'SELECT ''__TRANSFERÊNCIAS->'' AS nomeConta ' + @sqlValoresIniciaisTRANSF	
	SET @sqlValoresFINAIS = 'SELECT ''__SALDO FINAL->'' AS nomeConta ' + @sqlValoresFINAIS
	 
	SET @sqlValoresIniciaisMOV = 'SELECT ''__TRANSFERÊNCIAS->'' AS nomeConta ' + @sqlValoresIniciaisMOV 
	
	/* Monta Relatório de Receitas */
	SET @DataLoop = @DataInicial	
	WHILE (@i <= (@qtdDias + @diaInicial))
	BEGIN
	    SET @nomeCampo = '_' + CAST(DAY(@DataLoop) AS VARCHAR(2)) + '_' + CAST(MONTH(@DataLoop) AS VARCHAR(2))
	        + '_' + CAST(YEAR(@DataLoop) AS VARCHAR(4))
	    
	    SET @sqlSelectFinal = @sqlSelectFinal + @sVirgula + 
				' dbo.format_Currency(SUM(dia' + @nomeCampo + ')) as dia' + @nomeCampo
	    
	    SET @sqlTableTemp = @sqlTableTemp + ' ' +
	        ' INSERT INTO #tempRelRECEITAS(identificador, nomeConta, dia' + @nomeCampo + ') ' +
	        '		SELECT wr.idConta, nomeConta, SUM(ValorTotal) AS ValorTotal ' +
					'			FROM PlanoContas p' +
	        '					 INNER JOIN ContasPersonalizada cp ON   p.IdConta = cp.IdConta ' +
	        '					 INNER JOIN Usuarios u ON u.NomeContaPersonalizada = cp.NomePersonalizado ' +
	        '					 LEFT JOIN web_Receitas wr ON wr.IdConta = p.IdConta ' +
					'					   AND 1 = 1 ' +	        
	        '						 AND MONTH(dataReceita) =' + CAST(MONTH(@DataLoop) AS VARCHAR(2)) +
	        '						 AND YEAR(dataReceita) =' + CAST(YEAR(@DataLoop) AS VARCHAR(4)) +
	        '						 AND wr.IdCentroCusto = ' + @idCentroCusto +
	        '						 AND wr.IdCentroCustoReceita = ' + @idCentroCustoReceita +
	        '						 AND wr.IdContaFinanceira ' + @sqlAndContaFinanceira +	        
	        '		 WHERE p.Grupo IN (3,6) ' +
	        '			 AND u.IdUsuario = ' + @IdUsuario +
	        ' GROUP BY wr.idConta,nomeConta'	    
	    
	    SET @DataLoop = DATEADD(MONTH, 1, @DataLoop)
	    SET @i = @i + 1 ;
	    SET @sVirgula = ','
	    
	    IF @bDebugMode = 1
				PRINT @sqlTableTemp
	    
	END /* while */
	
	/*-------------------- Monta Relatório de Despesas ------------------*/	
	SET @diaInicial = MONTH(@DataInicial)
	SET @qtdDias = DATEDIFF(MONTH, @DataInicial, @DataFinal) 
	SET @i = @diaInicial 
	SET @sqlCamposTemp = ''
	
	SET @sqlSelectFinal = ''
	SET @sVirgula = ''
	SET @sqlTableTempDESP = 
	    'CREATE TABLE #tempRelDESPESAS (identificador int, nomeConta varchar(200) ';	
	
	SET @DataLoop = @DataInicial
	WHILE (@i <= (@qtdDias + @diaInicial))
	BEGIN
		SET @nomeCampo = 
				'_' + CAST(DAY(@DataLoop) AS VARCHAR(2)) + 
				'_' + CAST(MONTH(@DataLoop) AS VARCHAR(2))
			+ '_' + CAST(YEAR(@DataLoop) AS VARCHAR(4))

		SET @sqlCamposTemp = @sqlCamposTemp + ',' + 'dia' + @nomeCampo + ' money'    

		SET @sqlCamposFiltroMovimentacao = @sqlCamposFiltroMovimentacao + ' or ' 
			+ 'dia' + @nomeCampo + ' <> 0'    

		SET @DataLoop = DATEADD(MONTH, 1, @DataLoop)
		SET @i = @i + 1 ;
	END /* while */
	
	SET @sqlCamposTemp = @sqlCamposTemp + ')'
	SET @sqlTableTempDESP = @sqlTableTempDESP + @sqlCamposTemp
	
	
	/***** Monta Relatório de Despesas *****/	
	SET @i = @diaInicial 
	SET @DataLoop = @DataInicial
	WHILE (@i <= (@qtdDias + @diaInicial))
	BEGIN
	    SET @nomeCampo = '_' + CAST(DAY(@DataLoop) AS VARCHAR(2)) + '_' + CAST(MONTH(@DataLoop) AS VARCHAR(2))
	        + '_' + CAST(YEAR(@DataLoop) AS VARCHAR(4))
	    
	    SET @sqlSelectFinal = @sqlSelectFinal + @sVirgula + ' sum(dia' + @nomeCampo
	        + ') as dia' + @nomeCampo
	    
	    SET @sqlTableTempDESP = @sqlTableTempDesp + ' ' +
	        ' INSERT INTO #tempRelDESPESAS(identificador, nomeConta, dia' + @nomeCampo + ') ' +
	        '		SELECT wd.idConta, nomeConta, SUM(-ValorEfetivo) AS ValorTotal ' +
					'			FROM PlanoContas p ' +
	        '						INNER JOIN ContasPersonalizada cp ON p.IdConta = cp.IdConta ' +
	        '						INNER JOIN Usuarios u ON u.NomeContaPersonalizada = cp.NomePersonalizado ' +
	        '						LEFT JOIN web_DESPESAS wd on wd.idConta = p.idConta ' +
					'						  AND 1 = 1 ' +	        
	        '							AND MONTH(dataEfetiva) = ' + CAST(MONTH(@DataLoop) AS VARCHAR(2)) +
	        '							AND YEAR(dataEfetiva) = ' + CAST(YEAR(@DataLoop) AS VARCHAR(4)) +
	        '							AND wd.IdCentroCusto = ' + @idCentroCusto +
	        '							AND wd.IdContaFinanceira ' + @sqlAndContaFinanceira +
	        '		 WHERE p.Grupo IN (4,5) AND u.IdUsuario =  ' + @IdUsuario +
	        ' GROUP BY wd.idConta, nomeConta'
	    
	    SET @DataLoop = DATEADD(MONTH, 1, @DataLoop)
	    SET @i = @i + 1 ;
	    SET @sVirgula = ','
	    
	    IF @bDebugMode = 1
				PRINT @sqlTableTempDESP
	END /* while */
	/*----------------- Fim Monta Relatório de Despesas -------------*/	
	
	
	/*----------------- Relatório de Movimentações -----------------*/	
	SET @diaInicial = MONTH(@DataInicial)
	SET @qtdDias = DATEDIFF(MONTH, @DataInicial, @DataFinal) 
	SET @i = @diaInicial 
	SET @sqlCamposTemp = ''
	SET @sVirgula = ''
	SET @sqlTableTempMOV = 
	    ' CREATE TABLE #tempRelMOV (identificador int  ,nomeConta varchar(200) ';	    
	SET @sqlTableTempMOVDestino = 
	    ' CREATE TABLE #tempRelMOVDESTINO (identificador int  ,nomeConta varchar(200) ';
		
	SET @DataLoop = @DataInicial
	WHILE (@i <= (@qtdDias + @diaInicial))
	BEGIN
		SET @nomeCampo = 
				'_' + CAST(DAY(@DataLoop) AS VARCHAR(2)) 
			+ '_' + CAST(MONTH(@DataLoop) AS VARCHAR(2))
			+ '_' + CAST(YEAR(@DataLoop) AS VARCHAR(4))

		SET @sqlCamposTemp = @sqlCamposTemp + ',' + 'dia' + @nomeCampo + ' money'        

		SET @DataLoop = DATEADD(MONTH, 1, @DataLoop)
		SET @i = @i + 1 ;
	END /* while */
		
	SET @sqlCamposTemp = @sqlCamposTemp + ')'
	SET @sqlTableTempMOV = @sqlTableTempMOV + @sqlCamposTemp
	SET @sqlTableTempMOVDestino = @sqlTableTempMOVDestino + @sqlCamposTemp
	
	/***** Monta Relatório de Movimentações *****/
	SET @i = @diaInicial 	
	SET @DataLoop = @DataInicial
	WHILE (@i <= (@qtdDias + @diaInicial))
	BEGIN
    SET @nomeCampo = 
				'_' + CAST(DAY(@DataLoop) AS VARCHAR(2)) 
			+ '_' + CAST(MONTH(@DataLoop) AS VARCHAR(2))
      + '_' + CAST(YEAR(@DataLoop) AS VARCHAR(4))
    
    SET @sqlSelectFinalMOV = @sqlSelectFinalMOV + @sVirgula + ' sum(dia' + @nomeCampo
        + ') as dia' + @nomeCampo
    	    
    SET @sqlTableTempMOV = @sqlTableTempMOV + ' ' +
        ' INSERT INTO #tempRelMov(identificador, nomeConta, dia' + @nomeCampo + ') ' +
        '		SELECT wff.idContaOrigem, nomeContaFinanceira, SUM(-ValorPrevisto) AS ValorTotal ' +
				'			FROM web_MovimentacoesFinanceiras wff,web_contasFinanceiras ' +
				'		 WHERE wff.IdContaOrigem = web_contasFinanceiras.IdContaFinanceira ' +	        
        '			 AND MONTH(DataTransacao) = ' + CAST(MONTH(@DataLoop) AS VARCHAR(2)) +
        '			 AND YEAR(DataTransacao) = ' + CAST(YEAR(@DataLoop) AS VARCHAR(4)) +
        '			 AND wff.IdCentroCusto = ' + @idCentroCusto +
        '			 AND wff.IdCentroCustoReceita = ' + @idCentroCustoReceita +
        '			 AND web_contasFinanceiras.IdContaFinanceira ' + @sqlAndContaFinanceira +
        ' GROUP BY wff.idContaOrigem,nomeContaFinanceira,month(DataTransacao)'
    
    SET @DataLoop = DATEADD(MONTH, 1, @DataLoop)
    SET @i = @i + 1 ;
    SET @sVirgula = ','
    
    IF @bDebugMode = 1
			PRINT @sqlTableTempMOV
	END /* while */
	/*----------------- Fim Relatório de Movimentações -----------------*/	
	
	
	/*----------------- Relatório de Movimentações Destino -----------------*/			
	SET @DataLoop = @DataInicial
	SET @i = @diaInicial 
	WHILE (@i <= (@qtdDias + @diaInicial))
	BEGIN
		SET @nomeCampo = 
			'_' + CAST(DAY(@DataLoop) AS VARCHAR(2)) 
		+ '_' + CAST(MONTH(@DataLoop) AS VARCHAR(2))
		+ '_' + CAST(YEAR(@DataLoop) AS VARCHAR(4))

		SET @sqlSelectFinalMOV = @sqlSelectFinalMOV + @sVirgula + ' sum(dia' + @nomeCampo 
			+ ') as dia' + @nomeCampo

		SET @sqlTableTempMOVDESTINO = @sqlTableTempMOVDESTINO + ' ' +
			' INSERT INTO #tempRelMovDESTINO(identificador, nomeConta, dia' + @nomeCampo + ') ' +
			'		SELECT wfa.idContaDestino, nomeContaFinanceira, SUM(ValorPrevisto) as ValorTotal ' +
			'			FROM web_MovimentacoesFinanceiras wfa,web_contasFinanceiras ' +
			'		 WHERE wfa.idContaDestino = web_contasFinanceiras.IdContaFinanceira' +
			'			 AND MONTH(DataTransacao) = ' + CAST(MONTH(@DataLoop) AS VARCHAR(2)) +
			'			 AND YEAR(DataTransacao) = ' + CAST(YEAR(@DataLoop) AS VARCHAR(4)) +
			'			 AND wfa.IdCentroCusto = ' + @idCentroCusto +
			'			 AND wfa.IdCentroCustoReceita = ' + @idCentroCustoReceita +
			'			 AND web_contasFinanceiras.IdContaFinanceira ' + @sqlAndContaFinanceira +
			' GROUP BY wfa.idContaDestino, nomeContaFinanceira, MONTH(DataTransacao)'

		SET @DataLoop = DATEADD(MONTH, 1, @DataLoop)
		SET @i = @i + 1 ;
		SET @sVirgula = ','
		
		IF @bDebugMode = 1
			PRINT @sqlTableTempMOVDESTINO
	END /* while */
	
	IF @mov = 0
	  SET @sqlCamposFiltroMovimentacao = ''	
/*----------------- Fim Relatório de Movimentações Destino -----------------*/	
	
	
/*-------------------------- Montando Resultado Final -------------------------*/			

	SET @inserirContasReceita = 
	    ' INSERT INTO #tempRelRECEITAS (identificador, nomeConta) ' + 
	    '		SELECT DISTINCT p.idConta,nomeConta ' + 
	    '			FROM planoContas p, web_Receitas w ' +
	    '		 WHERE p.idconta = w.idconta '
	
	SET @inserirContasDespesa = 
	    ' INSERT INTO #tempRelDESPESAS (identificador, nomeConta) ' +
	    '	SELECT DISTINCT p.idConta, nomeConta ' +
	    '		FROM planoContas p, web_Despesas w ' +
	    '	 WHERE p.idconta = w.idconta '
	IF @bDebugMode = 1
	BEGIN
		PRINT '.... Start here ....'	
		PRINT ' CREATE Table #Resultado (nomeConta varchar(200)' + @sqlCamposTemp + ' '
	END
		
	PRINT @sqlTableTemp
	PRINT @inserirContasReceita
	PRINT @sqlTableTempDesp 
	PRINT @sqlTableTempMOV 
	PRINT @sqlTableTempMOVDESTINO 
	PRINT @inserirContasDespesa 
	PRINT @inserirContasMOV 
	PRINT @inserirContasMOVDESTINO 
	PRINT @sqlInserirSaldoFinal
	
	IF @bDebugMode = 1
	BEGIN
		PRINT ' INSERT INTO #Resultado(nomeConta' + @sqlCampoACampo + ')'
		PRINT @sqlValoresIniciais 
		
		PRINT ' UNION ALL '
			
		PRINT @sqlValoresIniciaisReceitas
			
		PRINT ' UNION ALL '
			
		PRINT '   SELECT nomeConta,' + @sqlSelectFinal
		PRINT '     FROM #tempRelRECEITAS ' + @sqlCamposFiltroMovimentacao
		PRINT ' GROUP BY identificador,nomeConta UNION ALL '
		PRINT @sqlValoresIniciaisDESP 
				
		PRINT ' UNION ALL '
			
		PRINT '   SELECT nomeConta,' + @sqlSelectFinal
		PRINT '     FROM #tempRelDESPESAS ' + @sqlCamposFiltroMovimentacao
		PRINT ' GROUP BY identificador,nomeConta UNION ALL ' + @sqlValoresIniciaisMOV 
					
		PRINT ' UNION ALL '
			
		PRINT '   SELECT nomeConta,' + @sqlSelectFinal
		PRINT '     FROM #tempRelMOV ' + @sqlCamposFiltroMovimentacao
		PRINT ' GROUP BY identificador,nomeConta '
			
		PRINT ' UNION ALL '

		PRINT '   SELECT nomeConta,' + @sqlSelectFinal
		PRINT '     FROM #tempRelMOVDESTINO ' + @sqlCamposFiltroMovimentacao
		PRINT ' GROUP BY identificador, nomeConta '
			
		PRINT ' UNION ALL '
			
		PRINT @sqlValoresFINAIS 
		PRINT ' SELECT NomeConta as [Nome da conta],' + @sqlSelectFormatado
		PRINT '   FROM #Resultado '		
	END
	
	EXEC (' CREATE Table #Resultado (nomeConta varchar(200)' + @sqlCamposTemp + ' ' +
		
		@sqlTableTemp +
		@inserirContasReceita +
		@sqlTableTempDesp +
		@sqlTableTempMOV + 
		@sqlTableTempMOVDESTINO +
		@inserirContasDespesa +
		@inserirContasMOV + 
		@inserirContasMOVDESTINO +
		@sqlInserirSaldoFinal +
		
		' INSERT INTO #Resultado(nomeConta' + @sqlCampoACampo + ')' +
			@sqlValoresIniciais + 
		
		' UNION ALL ' + 
		
			@sqlValoresIniciaisReceitas +
		
		' UNION ALL ' +
		
			'   SELECT nomeConta,' + @sqlSelectFinal + 
			'     FROM #tempRelRECEITAS ' + @sqlCamposFiltroMovimentacao +
			' GROUP BY identificador,nomeConta UNION ALL ' +
				@sqlValoresIniciaisDESP + 
			
		' UNION ALL ' +
		
			'   SELECT nomeConta,' + @sqlSelectFinal + 
			'     FROM #tempRelDESPESAS ' + @sqlCamposFiltroMovimentacao +
			' GROUP BY identificador,nomeConta UNION ALL ' + @sqlValoresIniciaisMOV + 
				
		' UNION ALL ' +
		
			'   SELECT nomeConta,' + @sqlSelectFinal + 
			'     FROM #tempRelMOV ' + @sqlCamposFiltroMovimentacao +
			' GROUP BY identificador,nomeConta ' +
		
		' UNION ALL ' +

			'   SELECT nomeConta,' + @sqlSelectFinal +
			'     FROM #tempRelMOVDESTINO ' + @sqlCamposFiltroMovimentacao +
			' GROUP BY identificador, nomeConta ' +
		
		' UNION ALL ' + 
		
			@sqlValoresFINAIS + 
			' SELECT NomeConta as [Nome da conta],' + @sqlSelectFormatado +
			'   FROM #Resultado '
	)
