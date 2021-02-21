
    CREATE PROCEDURE [dbo].[sp_lista_tabela_campo_Log]
    AS
    	CREATE TABLE #tabtemp_Campo_Chave_Tabela
    	(
    		Tabela          VARCHAR(128),
    		Chave_Primaria  VARCHAR(128)
    	)
    	
    	
    	CREATE TABLE #tabtemp_completa
    	(	Tabela          VARCHAR(128),
    		Campo           VARCHAR(128),
    		Chave_Primaria  VARCHAR(1)
    	)
    	
    	
    	CREATE TABLE #tabtemp_campos_a_serem_excluidos
    	(	Tabela  VARCHAR(128),
    		Campo   VARCHAR(128)
    	)
    	
    	INSERT INTO #tabtemp_completa
    	  (
    	    Tabela,
    	    Campo,
    	    Chave_Primaria
    	  )
    	SELECT t.name,
    	       c.name,
    	       'N'
    	FROM   sys.columns AS c,
    	       sys.tables AS t,
    	       sys.schemas s
    	WHERE  t.[object_id] = c.[object_id]
    	       AND t.[schema_id] = s.[schema_id]
    	       AND s.name = 'dbo'
    	ORDER BY
    	       t.name,
    	       c.name
    	
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	SELECT SO.[NAME] AS Tabela,
    	       X.Coluna AS PK
    	FROM   SYSOBJECTS SO
    	       LEFT JOIN (
    	                SELECT OBJECT_NAME(SI.ID) AS TABELA,
    	                       SC.[NAME] AS Coluna
    	                FROM   SYSINDEXES SI
    	                       LEFT JOIN SYSINDEXKEYS SK
    	                            ON  SK.ID = SI.ID
    	                            AND SK.INDID = SI.INDID
    	                       LEFT JOIN SYSCOLUMNS SC
    	                            ON  SC.COLID = SK.COLID
    	                            AND SC.ID = SK.ID
    	                WHERE  OBJECTPROPERTY(SI.ID, 'ISUSERTABLE') = 1
    	                       AND OBJECT_NAME(SI.ID) NOT LIKE 'DTPROPERTIES'
    	                       AND COALESCE(OBJECTPROPERTY(OBJECT_ID(SI.NAME), 'ISPRIMARYKEY'), 0) = 
    	                           1
    	            ) X
    	            ON  X.TABELA = SO.[NAME]
    	WHERE  OBJECTPROPERTY(SO.ID, 'ISUSERTABLE') = 1
    	       AND x.Coluna IS NOT NULL
            and x.tabela <> 'detalhesemissao_registro_online'
    	
    	-- Obtem todas as colunas que não tem chave primária
    	SELECT id
    	       INTO #TABTEMP2
    	FROM   SYSOBJECTS SO
    	       LEFT JOIN (
    	                SELECT OBJECT_NAME(SI.ID) AS TABELA,
    	                       SC.[NAME] AS Coluna
    	                FROM   SYSINDEXES SI
    	                       LEFT JOIN SYSINDEXKEYS SK
    	                            ON  SK.ID = SI.ID
    	                            AND SK.INDID = SI.INDID
    	                       LEFT JOIN SYSCOLUMNS SC
    	                            ON  SC.COLID = SK.COLID
    	                            AND SC.ID = SK.ID
    	                WHERE  OBJECTPROPERTY(SI.ID, 'ISUSERTABLE') = 1
    	                       AND OBJECT_NAME(SI.ID) NOT LIKE 'DTPROPERTIES'
    	                       AND COALESCE(OBJECTPROPERTY(OBJECT_ID(SI.NAME), 'ISPRIMARYKEY'), 0) = 
    	                           1
    	            ) X
    	            ON  X.TABELA = SO.[NAME]
    	WHERE  OBJECTPROPERTY(SO.ID, 'ISUSERTABLE') = 1
    	       AND x.Coluna IS NULL
    	
    	-- Inclui na tabela #tabtemp_Campo_Chave_Tabela todas tabela e as respectivas colunas que são identity
    	-- e que não tem chave primária definida.
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	SELECT t.name,
    	       c.name
    	FROM   sys.columns AS c
    	       INNER JOIN sys.tables AS t
    	            ON  t.[object_id] = c.[object_id]
    	       INNER JOIN #TABTEMP2 t3
    	            ON  t.[object_id] = t3.id
    	WHERE  c.is_identity = 1 
    	
    	
    	/* Incluir as tabelas que não tem chave primaria ou chave identity definidas
    	* 
    	*/
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Acessos',
    	    'IdSistema'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Acessos',
    	    'IdUsuario'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Acessos',
    	    'IdPessoa'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'AtuacoesTrabalho',
    	    'TipoMovimento'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'AtuacoesTrabalho',
    	    'ConjuntoAnalisado'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'AtuacoesTrabalho',
    	    'IdConjunto'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'CamposSelecaoProf',
    	    'IdPreCadastroProf'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'CarteiraImpressa',
    	    'idprofissional'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'CarteiraImpressa',
    	    'DtExpedicao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'CodFiscalPrestServicoPagto',
    	    'IdPagamento'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'CodFiscalPrestServicoPagto',
    	    'IdCFPS'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'ConfigRegistroConselho',
    	    'IdCategoria'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'ConfigRegistroConselho',
    	    'IdTipoInscricao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'ConfigSituacoes',
    	    'IdSituacaoPFPJANT'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'ConfigSituacoes',
    	    'IdSituacaoPFPJPOS'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'ConfigSituacoes',
    	    'IdSituacaoPFPJPOS'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Cliente',
    	    'IdConselho'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Configuracoes',
    	    'AgrupaCredito'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'ConfiguracaoModuloGerencial',
    	    'NU_CONFIG'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'ConfiguracoesLogon',
    	    'UltimaVerificao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'ConfiguracoesSG',
    	    'AvisaA4'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'ConfiguracoesSispad',
    	    'UtilizaMotivoViagem'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'ConfiguracoesSipro',
    	    'ImprimeChequeDataServidor'
    	  )
    	
    	/*   Que tabela é essa ????
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	(Tabela,Chave_Primaria)
    	VALUES ('COREXP Consulta','IdDocumento')
    	*/
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DataKitJulgamento',
    	    'DataRecebimento'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Debitos_SituacoesDebito',
    	    'IdDebito'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Debitos_SituacoesDebito',
    	    'IdSituacaoDebito'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Debitos_SituacoesDebito',
    	    'DataSituacao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DebitosDividaAtivaHistorico',
    	    'IdDebitoDividaAtiva'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DebitosDocumentos',
    	    'IdDocumento'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DebitosDocumentos',
    	    'IdDebito'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DivAtiva_Documentos',
    	    'IdDividaAtiva'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Documentos',
    	    'IdDonoDoc'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Documentos',
    	    'TituloDoc'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DominiosPessoas',
    	    'NomeCampo'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DominiosPessoas',
    	    'Alias_Campo'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DominiosSipro',
    	    'NomeCampo'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DominiosSipro',
    	    'Alias_Campo'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DominiosSiscafwFiscalizacoes',
    	    'NomeCampo'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DominiosSiscafwFiscalizacoes',
    	    'Alias_Campo'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DominiosSiscafwOrdem',
    	    'NomeCampo'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DominiosSiscafwOrdem',
    	    'Alias_Campo'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DominiosSiscafwProcessos',
    	    'NomeCampo'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'DominiosSiscafwProcessos',
    	    'Alias_Campo'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'EncerramentoConta',
    	    'ContaOrigem'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'EncerramentoConta',
    	    'ContaDestino'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Fiscalizacoes_Documentos',
    	    'IdFiscalizacao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Fiscalizacoes_Documentos',
    	    'IdDocumento'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'GruposPerfisLogon',
    	    'IdGrupo'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'GruposPerfisLogon',
    	    'IdPerfil'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'LancamentosExtratosIds',
    	    'IdLancamentoExtrato'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Locks',
    	    'HoraLock'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Locks',
    	    'IdUsuario'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'OcorrenciasItensCertificacao',
    	    'IdItemCertificacaoCertificacao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'OcorrenciasItensCertificacao',
    	    'IdOcorrencia'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'ParametrosEdital',
    	    'IdFase'
    	  )
    	
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'ParametrosSiscafWeb',
    	    'IdConselhoProprietario'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Processos_Documentos',
    	    'IdProcesso'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Processos_Documentos',
    	    'IdDocumento'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Processos_Edital',
    	    'IdProcesso'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Processos_Edital',
    	    'IdDocumento'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Processos_ProcessosLista1',
    	    'IdProcesso'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Processos_ProcessosLista1',
    	    'IdProcessoLista1'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Profissionais_Foto',
    	    'IdProfissional'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'RespostasPFPJ_Questoes',
    	    'IdRespostaPFPJ'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'RespostasPFPJ_Questoes',
    	    'IdQuestao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'SituacoesDivAtiva',
    	    'IdDividaAtiva'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'SituacoesDivAtiva',
    	    'SituacaoDivAtiva'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TelasDefinicoes',
    	    'CodigoTela'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TelasDefinicoes',
    	    'NomeTabela'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TelasDefinicoes',
    	    'NomeCampo'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TipoProcesso_Departamento',
    	    'IdTipoProcesso'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TipoProcesso_Departamento',
    	    'IdDepartamento'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TipoProcesso_TiposInscricao',
    	    'IdTipoProcesso'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TipoProcesso_TiposInscricao',
    	    'IdTipoInscricao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TipoProcesso_Unidade',
    	    'IdTipoProcesso'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TipoProcesso_Unidade',
    	    'IdUnidade'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TransposicoesCentroCusto',
    	    'IdTransposicao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TransposicoesCentroCusto',
    	    'IdCentroCusto'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TransposicoesCentroCusto',
    	    'TipoMov'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TransposicoesCentroCusto',
    	    'DataDotacao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TransposicoesCentroCustoConta',
    	    'IdTransposicao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TransposicoesCentroCustoConta',
    	    'IdConta'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TransposicoesCentroCustoConta',
    	    'IdCentroCusto'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TransposicoesCentroCustoConta',
    	    'TipoMov'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TransposicoesCentroCustoConta',
    	    'DataDotacao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TransposicoesConta',
    	    'IdTransposicao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TransposicoesConta',
    	    'IdConta'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TransposicoesConta',
    	    'TipoMov'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TransposicoesConta',
    	    'DataDotacao'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TributosPadroes',
    	    'IdTributo'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'TributosPadroes',
    	    'IdConta'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'UltimoNumeroDocumento',
    	    'NumeroDocumento'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'UltimoNumeroDocumento',
    	    'IdTipoDocumento'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'UsuariosSiscafWeb',
    	    'IdProfissional'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Web_EnvioDocumentacaoReceitas_Web_Receitas',
    	    'IdEnvioDocumentacaoReceitas'
    	  )
    	
    	INSERT INTO #tabtemp_Campo_Chave_Tabela
    	  (
    	    Tabela,
    	    Chave_Primaria
    	  )
    	VALUES
    	  (
    	    'Web_EnvioDocumentacaoReceitas_Web_Receitas',
    	    'IdReceita'
    	  )
    	
    	
    	UPDATE #tabtemp_completa
    	SET    Chave_Primaria = 'S'
    	FROM   #tabtemp_completa t1,
    	       #tabtemp_Campo_Chave_Tabela t2
    	WHERE  t1.Tabela = t2.Tabela
    	       AND t1.Campo = t2.Chave_Primaria 
    	
    	-- Todos os campos image,text,nvarchar,uniqueidentify,etc serão excluidos da trigger de log
    	INSERT INTO #tabtemp_campos_a_serem_excluidos
    	  (
    	    Tabela,
    	    Campo
    	  )
    	SELECT O.Name AS Tabela,
    	       C.Name AS Campo
    	FROM   SysObjects O,
    	       SysColumns C,
    	       SysTypes T
    	WHERE  C.Id = O.Id
    	       AND C.xUserType = T.xUserType
    	       AND O.xType = 'U'
    	       AND  (T.xUserType  IN (173, 34, 239, 99, 231, 231, 35, 189, 36, 165,241) OR c.iscomputed = 1 OR C.length = -1)
    	
    	
    	DELETE #tabtemp_completa
    	FROM   #tabtemp_completa t1,
    	       #tabtemp_campos_a_serem_excluidos t2
    	WHERE  t1.Tabela = t2.Tabela
    	       AND t1.Campo = t2.Campo 
    	
    	-- Exclusão das tabelas que não terão log    
    	DELETE #tabtemp_completa
    	FROM   #tabtemp_completa
    	WHERE  Tabela IN ('LOG', 'DOMINIOSPROF', 'DOMINIOSPJ', 'DTPROPERTIES', 
    	                 'LogEmailsEnviados', 'Web_DotacoesLog')

       	DELETE #tabtemp_completa
    	FROM   #tabtemp_completa
    	WHERE  Tabela COLLATE Latin1_General_CI_AI IN (SELECT [Tabela] COLLATE Latin1_General_CI_AI FROM [ImplantaLog].[dbo].[Tabela_Log] WHERE [Efetua_Log]='N')
   
    	
    	SELECT t1.*
    	       INTO #LISTA_COMPLETA
    	FROM   #tabtemp_completa t1
    	WHERE  t1.Campo NOT IN ('DataUltimaAtualizacao', 'OrdemDtAtualiz', 
    	                       'UsuarioUltimaAtualizacao', 
    	                       'DepartamentoUltimaAtualizacao', 'OrdemCorresp')
    	ORDER BY
    	       Tabela,
    	       Campo
    	
    	DELETE 
    	FROM   #LISTA_COMPLETA
    	WHERE  TABELA IN (SELECT TABELA
    	                  FROM   #LISTA_COMPLETA
    	                  GROUP BY
    	                         TABELA
    	                  HAVING COUNT(TABELA) = 1) 
    	
    	DELETE 
    	FROM   #LISTA_COMPLETA
    	WHERE  TABELA NOT IN (SELECT DISTINCT TABELA
    	                      FROM   #LISTA_COMPLETA
    	                      WHERE  CHAVE_PRIMARIA = 'S')
    	
    	SELECT *
    	FROM   #LISTA_COMPLETA
