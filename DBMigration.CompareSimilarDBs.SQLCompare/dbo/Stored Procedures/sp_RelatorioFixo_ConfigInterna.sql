
CREATE PROCEDURE [dbo].[sp_RelatorioFixo_ConfigInterna]
AS

	CREATE TABLE #Configuracao (Tabela VARCHAR(100), Id INT, Profissional BIT)
	DECLARE @XMLConfig AS XML, @Idoc INT
	
	SELECT 
		@XMLConfig = ps.ConfigRelatorioFixoXML
	FROM
		ParametrosSiscafw ps
	
	/*Inicia a decodificação do arquivo XML*/
	EXEC sp_xml_preparedocument @Idoc OUTPUT, @XMLConfig
	
	INSERT INTO #Configuracao(Tabela, Id, Profissional)	
	SELECT 'SITUACAO', id, profissional
	FROM OPENXML(@idoc, '/configuracao/situacoes/situacao', 2)
	     WITH (id INT, profissional BIT)
	       
	INSERT INTO #Configuracao(Tabela, Id, Profissional)	
	SELECT 'CATEGORIA', id, profissional
	FROM OPENXML(@idoc, '/configuracao/categorias/categoria', 2)
	     WITH (id INT, profissional BIT)
	     
	INSERT INTO #Configuracao(Tabela, Id, Profissional)	
	SELECT 'TIPOINSCRICAO', id, profissional
	FROM OPENXML(@idoc, '/configuracao/tiposInscricoes/tipoinscricao', 2)
	     WITH (id INT, profissional BIT)
	
	SELECT * FROM #Configuracao ORDER BY Tabela
	
	IF EXISTS (SELECT * FROM TEMPDB.SYS.SYSOBJECTS WHERE XTYPE = 'U' AND NAME = '#Configuracao') 
	DROP TABLE  #Configuracao