
-- ============================================================================
--	sp_SelecionaProcesso
-- ============================================================================	
CREATE PROCEDURE sp_SelecionaProcesso
	@IdProcessoPFPJ VARCHAR(10)
AS
BEGIN
	DECLARE @IdTipoProcesso          VARCHAR(9),
	        @campoGridDinamico       VARCHAR(30),
	        @CampoGrid               VARCHAR(30),
	        @IdTabela1Pessoa         VARCHAR(30),
	        @IdTabela2Pessoa         VARCHAR(30),
	        @IdTabela3Pessoa         VARCHAR(30),
	        @IdTabela4Pessoa         VARCHAR(30),
	        @IdTabela5Pessoa         VARCHAR(30),
	        @IdTabela1Proc           VARCHAR(30),
	        @IdTabela2Proc           VARCHAR(30),
	        @IdTabela3Proc           VARCHAR(30),
	        @IdTabela4Proc           VARCHAR(30),
	        @IdTabela5Proc           VARCHAR(30),
	        @Alfa1Proc               VARCHAR(30),
	        @Alfa2Proc               VARCHAR(30),
	        @Alfa3Proc               VARCHAR(30),
	        @Alfa4Proc               VARCHAR(30),
	        @Alfa5Proc               VARCHAR(30),
	        @chk1                    VARCHAR(30),
	        @chk2                    VARCHAR(30),
	        @chk3                    VARCHAR(30),
	        @Data1Proc               VARCHAR(30),
	        @Data2Proc               VARCHAR(30),
	        @Data3Proc               VARCHAR(30),
	        @Data4Proc               VARCHAR(30),
	        @Data5Proc               VARCHAR(30),
	        @Num1Proc                VARCHAR(30),
	        @Num2Proc                VARCHAR(30),
	        @Num3Proc                VARCHAR(30),
	        @Num4Proc                VARCHAR(30),
	        @Num5Proc                VARCHAR(30),
	        @Valor1Proc              VARCHAR(30),
	        @Valor2Proc              VARCHAR(30),
	        @Valor3Proc              VARCHAR(30),
	        @Turma                   VARCHAR(30),
	        @sql                     VARCHAR(8000),
	        @sqlProcesso             VARCHAR(5000),
	        @PrefSufNumDoc_Processo  VARCHAR(100),
	        @FiscPrefSufProc         VARCHAR(100) 
	
	SET @CampoGrid = '--'
	SET @IdTabela1Pessoa = '--'
	SET @IdTabela2Pessoa = '--'
	SET @IdTabela3Pessoa = '--'
	SET @IdTabela4Pessoa = '--'
	SET @IdTabela5Pessoa = '--'          
	SET @IdTabela1Proc = '--'
	SET @IdTabela2Proc = '--'
	SET @IdTabela3Proc = '--'
	SET @IdTabela4Proc = '--'
	SET @IdTabela5Proc = '--'          
	SET @Alfa1Proc = '--'
	SET @Alfa2Proc = '--'
	SET @Alfa3Proc = '--'
	SET @Alfa4Proc = '--'
	SET @Alfa5Proc = '--'                 
	SET @chk1 = '--'
	SET @chk2 = '--'
	SET @chk3 = '--'               
	SET @Data1Proc = '--'
	SET @Data2Proc = '--'
	SET @Data3Proc = '--'
	SET @Data4Proc = '--'
	SET @Data5Proc = '--'                 
	SET @Num1Proc = '--'
	SET @Num2Proc = '--'
	SET @Num3Proc = '--'
	SET @Num4Proc = '--'
	SET @Num5Proc = '--'
	SET @Valor1Proc = '--'
	SET @Valor2Proc = '--'
	SET @Valor3Proc = '--'
	SET @Turma = '--'  
	
	SELECT @idTipoProcesso = Idtipoprocesso
	FROM   processos
	WHERE  IdProcesso = @IdProcessoPFPJ
	
	SELECT @Turma = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'turma'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso  
	
	SELECT @CampoGrid = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'CampoGrid'
	
	SELECT @CampoGridDinamico = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'CampoGridDinamico'
	
	SELECT @IdTabela1Pessoa = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'IdTabela1Pessoa'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @IdTabela2Pessoa = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'IdTabela2Pessoa'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @IdTabela3Pessoa = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'IdTabela3Pessoa'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @IdTabela4Pessoa = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'IdTabela4Pessoa'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @IdTabela5Pessoa = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'IdTabela5Pessoa'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso          
	
	SELECT @IdTabela1Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'IdTabela1Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @IdTabela2Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'IdTabela2Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @IdTabela3Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'IdTabela3Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @IdTabela4Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'IdTabela4Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @IdTabela5Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'IdTabela5Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso          
	
	SELECT @Alfa1Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Alfa1Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Alfa2Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Alfa2Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Alfa3Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Alfa3Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Alfa4Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Alfa4Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Alfa5Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Alfa5Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso          
	
	SELECT @chk1 = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'chk1'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @chk2 = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'chk2'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @chk3 = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'chk3'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso          
	
	SELECT @Data1Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Data1Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Data2Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Data2Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Data3Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Data3Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Data4Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Data4Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Data5Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Data5Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso          
	
	SELECT @Num1Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Num1Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Num2Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Num2Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Num3Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Num3Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Num4Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Num4Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Num5Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Num5Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso          
	
	SELECT @Valor1Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Valor1Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Valor2Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Valor2Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso
	
	SELECT @Valor3Proc = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'Valor3Proc'
	       AND codigoTela = 1
	       AND VisualizarWeb = 1
	       AND IdTipoProcesso = @IdTipoProcesso          
	
	SELECT @FiscPrefSufProc = FiscPrefSufProc,
	       @PrefSufNumDoc_Processo = PrefSufNumDoc_Processo
	FROM   TipoProcesso
	WHERE  IdTipoProcesso IN (SELECT IdTipoProcesso
	                          FROM   processos
	                          WHERE  IdProcesso = @IdProcessoPFPJ)        
	
	IF @PrefSufNumDoc_Processo = '0'
	    SET @sqlProcesso = 'ISNULL((CAST(CAST(NumProt AS varchar (25))+' +
	        '''.''' + ' AS varchar (25) )),''''' + ')+ ' +
	        '(CAST(Processos.NumeroProc AS varchar (100) ))'
	ELSE 
	IF @PrefSufNumDoc_Processo = '1'
	    SET @sqlProcesso = '(CAST(Processos.NumeroProc AS varchar (100) ))' + 
	        '+' + ' 
				ISNULL((CAST(' + '''.''' + 
	        '+ CAST(NumProt AS varchar (25)) AS varchar (25) )),' + '''''' + ')'
	ELSE
	    SET @sqlProcesso = '(CAST(Processos.NumeroProc AS varchar (100)))'          
	
	
	IF @FiscPrefSufProc = '0'
	    SET @sqlProcesso = ' ISNULL((cASt(Processos.anoProc AS varchar (5) )),' 
	        + '''' + ')+ ' +
	        '''/''' + '+ ' + @sqlProcesso
	ELSE 
	IF @FiscPrefSufProc = '1'
	    SET @sqlProcesso = @sqlProcesso + ' +' + '''/''' + 
	        '+ 
				ISNULL((cASt(Processos.anoProc AS varchar (5) )),' + '''''' + 
	        ')'
	
	SET @sql = 'SELECT Processos.IdProcesso,' + @sqlProcesso + 
	    'AS [Processo],      
						(SELECT TOP 1 
								CASE 
									WHEN Processo_Fases.VisualizarWeb = 1 AND Fases.VisualizarWeb = 1 THEN 
										Fases.Fase
									ELSE 
										''NÃ£o disponÃ­vel pela internet.'' 
								END
						 FROM Processos p
									JOIN Processo_Fases ON Processo_Fases.IdProcesso = p.IdProcesso
									JOIN Fases ON Processos.IdProcesso = Processo_Fases.IdProcesso AND Fases.IdFase = Processo_Fases.IdFase
									 AND Processo_Fases.DataFase = (SELECT MAX(pf1.dataFase) 
									                                  FROM Processo_Fases pf1
																						       WHERE Processos.Idprocesso = pf1.IdProcesso 
																						         AND pf1.IdFase IN (SELECT f1.IdFase FROM Fases f1))
									 AND p.IdProcesso = Processos.IdProcesso) AS [Ãšltimo ANDamento],          
									( SELECT TOP 1 Processo_Fases.Nota
											FROM Processos p
													 JOIN Processo_Fases ON Processo_FASes.IdProcesso = p.IdProcesso
													 JOIN Fases ON Processos.IdProcesso = Processo_FASes.IdProcesso
															AND FASes.IdFASe = Processo_FASes.IdFASe
															AND Processo_FASes.DataFASe = (SELECT MAX(pf1.dataFASe)
																															 FROM Processo_Fases pf1
																															WHERE  Processos.Idprocesso = pf1.IdProcesso
																																AND pf1.IdFASe IN (SELECT f1.IdFASe
																																										 FROM FASes f1))
															AND p.IdProcesso = Processos.IdProcesso
									) AS [Nota],' +
	    
	    'CASE           
											WHEN Processos.IdTabela1Prof IS NOT NULL THEN           
												(SELECT Nome FROM Profissionais WHERE IdProfissional = Processos.IdTabela1Prof )          
											WHEN Processos.IdTabela1PJ IS NOT NULL THEN           
												(SELECT Nome FROM PessoASJuridicAS WHERE IdPessoaJuridica = Processos.IdTabela1PJ)          
											WHEN Processos.IdTabela1Pessoa IS NOT NULL THEN           
												(SELECT Nome FROM PessoAS WHERE IdPessoa = Processos.IdTabela1Pessoa )           										
									  END AS [' + @IdTabela1Pessoa + 
	    '],          

									CASE           
										WHEN Processos.IdTabela2Prof IS NOT NULL THEN           
											(SELECT Nome FROM Profissionais WHERE IdProfissional = Processos.IdTabela2Prof )          
										WHEN Processos.IdTabela2PJ IS NOT NULL THEN           
											(SELECT Nome FROM PessoASJuridicAS WHERE IdPessoaJuridica = Processos.IdTabela2PJ)          
										WHEN Processos.IdTabela2Pessoa IS NOT NULL THEN           
											(SELECT Nome FROM PessoAS WHERE IdPessoa = Processos.IdTabela2Pessoa )           
									END AS [' + @IdTabela2Pessoa + 
	    '],

									CASE           
										WHEN Processos.IdTabela3Prof IS NOT NULL THEN           
											(SELECT Nome FROM Profissionais WHERE IdProfissional = Processos.IdTabela3Prof )          
										WHEN Processos.IdTabela3PJ IS NOT NULL THEN           
											(SELECT Nome FROM PessoASJuridicAS WHERE IdPessoaJuridica = Processos.IdTabela3PJ)          
										WHEN Processos.IdTabela3Pessoa IS NOT NULL THEN           
											(SELECT Nome FROM PessoAS WHERE IdPessoa = Processos.IdTabela3Pessoa )           
									END AS [' + @IdTabela3Pessoa + 
	    '],

									CASE           
										WHEN Processos.IdTabela4Prof IS NOT NULL THEN           
											(SELECT Nome FROM Profissionais WHERE IdProfissional = Processos.IdTabela4Prof )          
										WHEN Processos.IdTabela4PJ IS NOT NULL THEN           
											(SELECT Nome FROM PessoASJuridicAS WHERE IdPessoaJuridica = Processos.IdTabela4PJ)          
										WHEN Processos.IdTabela4Pessoa IS NOT NULL THEN           
											(SELECT Nome FROM PessoAS WHERE IdPessoa = Processos.IdTabela4Pessoa )           
									END AS [' + @IdTabela4Pessoa + 
	    '],          

									CASE           
										WHEN Processos.IdTabela5Prof IS NOT NULL THEN           
											(SELECT Nome FROM Profissionais WHERE IdProfissional = Processos.IdTabela5Prof )          
										WHEN Processos.IdTabela5PJ IS NOT NULL THEN           
											(SELECT Nome FROM PessoASJuridicAS WHERE IdPessoaJuridica = Processos.IdTabela5PJ)          
										WHEN Processos.IdTabela5Pessoa IS NOT NULL THEN           
											(SELECT Nome FROM PessoAS WHERE IdPessoa = Processos.IdTabela5Pessoa )           
									END AS [' + @IdTabela5Pessoa + 
	    '],          

									(SELECT Descricao 
									   FROM processosTabela1 
									   WHERE IdTabela1Proc = Processos.IdTabela1Proc)AS ['
	    + @IdTabela1Proc + 
	    '],
									             
									(SELECT Descricao 
									   FROM processosTabela2 
									  WHERE IdTabela2Proc = Processos.IdTabela2Proc)AS [' 
	    + @IdTabela2Proc + 
	    '],
									  
									(SELECT Descricao 
									   FROM processosTabela3 
									  WHERE IdTabela3Proc = Processos.IdTabela3Proc) AS [' 
	    + @IdTabela3Proc + 
	    '],
									  
									(SELECT Descricao 
									   FROM processosTabela4 
									  WHERE IdTabela4Proc = Processos.IdTabela4Proc) AS [' 
	    + @IdTabela4Proc + 
	    '],
									            
									(SELECT Descricao 
									   FROM processosTabela5 
									  WHERE IdTabela5Proc = Processos.IdTabela5Proc) AS [' 
	    + @IdTabela5Proc + '],          

									Alfa1Proc  AS  [' + @Alfa1Proc + 
	    '],          
									Alfa2Proc  AS  [' + @Alfa2Proc + 
	    '],          
									Alfa3Proc  AS  [' + @Alfa3Proc + 
	    '],          
									Alfa4Proc  AS  [' + @Alfa4Proc + 
	    '],          
									Alfa5Proc  AS  [' + @Alfa5Proc + 
	    '],          

								 CASE chk1 WHEN 1 THEN ''SIM''          
									 ELSE ''NÃƒO'' END    AS  [' + @chk1 + 
	    '],

								 CASE chk2 WHEN 1 THEN ''SIM''          
								   ELSE ''NÃƒO''  END    AS  [' + @chk2 + 
	    '],
								          
								 CASE chk3 WHEN 1 THEN ''SIM''          
								   ELSE ''NÃƒO''  END    AS  [' + @chk3 + 
	    '],          

								 Data1Proc AS  [' + @Data1Proc + 
	    '],          
								 Data2Proc AS  [' + @Data2Proc + 
	    '],          
								 Data3Proc AS  [' + @Data3Proc + 
	    '],          
								 Data4Proc AS  [' + @Data4Proc + 
	    '],          
								 Data5Proc AS  [' + @Data5Proc + 
	    '],          

								 Num1Proc AS  [' + @Num1Proc + 
	    '],          
								 Num2Proc AS  [' + @Num2Proc + 
	    '],          
								 Num3Proc AS  [' + @Num3Proc + 
	    '],          
								 Num4Proc AS  [' + @Num4Proc + 
	    '],          
								 Num5Proc AS  [' + @Num5Proc + 
	    '],          

								 Valor1Proc  AS  [' + @Valor1Proc + 
	    '],          
								 Valor2Proc  AS  [' + @Valor2Proc + 
	    '],          
								 Valor3Proc  AS  [' + @Valor3Proc + 
	    '],
								  
								 (SELECT t.NomeTurma 
									  FROM TurmAS t 
									 WHERE t.IdTurma = Processos.IdTurma) AS [' 
	    + @Turma + ']

 FROM Processos 
WHERE Processos.IdProcesso = ' + @IdProcessoPFPJ +
	    ' AND Processos.IdTipoProcesso IN (SELECT IdTipoProcesso FROM TipoProcesso WHERE VisualizarWeb = 1)' 
	
	EXEC (@sql)
END
