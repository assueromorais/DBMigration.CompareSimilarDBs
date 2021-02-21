
-- ============================================================================
--	sp_emissoes
-- ============================================================================
CREATE PROCEDURE [dbo].[sp_emissoes]
	@sigla VARCHAR(50),
	@id VARCHAR(13),
	@pessoa CHAR(1),
	@DBMainName VARCHAR(100) = 'siscafweb_java'
AS
BEGIN
	DECLARE @tabela      VARCHAR(50),
	        @campo       VARCHAR(50),
	        @IdRegional  INT,
	        @SQL         VARCHAR(MAX),
	        @SQLTmp      NVARCHAR(4000)
	
	IF UPPER(@pessoa) = 'F'
	    SELECT @campo = 'IdProfissional'
	ELSE
	    SELECT @campo = 'IdPessoaJuridica' 
	
	/* Buscar IdRegional */                
	
	SET @SQLTmp = 'SELECT @Valor = ' + @DBMainName + 
	    '.dbo.Regionais.IdRegional ' +
	    '  FROM ' + @DBMainName + '.dbo.Conselhos ' +
	    '       LEFT JOIN ' + @DBMainName + '.dbo.Regionais ON ' + @DBMainName + 
	    '.dbo.Regionais.IdConselho = ' +
	    @DBMainName + '.dbo.Conselhos.IdConselho ' +
	    '				LEFT JOIN ' + @DBMainName + '.dbo.Estados ON ' + @DBMainName 
	    + '.dbo.Estados.IdEstado = ' +
	    @DBMainName + '.dbo.Regionais.IdEstado ' +
	    ' WHERE (SiglaConselho+UF = ''' + @sigla + 
	    ''' OR SiglaConselhoFederal = ''' + @sigla + ''')'
	
	--PRINT @SQLTmp
	
	EXEC sp_executesql @SQLTmp,
	     N'@Valor int output',
	     @IdRegional OUTPUT
	
	--PRINT '@IdRegional = ' + CAST(@IdRegional AS VARCHAR(100))
	
	SET @SQL = 
	    ' SELECT IdDetalheEmissao,  
							 (SELECT top 1 UsuarioWeb 
							    FROM ' + @DBMainName + 
	    '.dbo.HistoricoAcessoUsuarioWebPrincipal hauw 
							   WHERE hauw.IdRegional = ' + CAST(@IdRegional AS VARCHAR) 
	    +
	    ' AND IdHistoricoAcesso IN(SELECT IdHistoricoAcesso 
																							FROM ' 
	    + @DBMainName + 
	    '.dbo.HistoricoImpressaoBoleto 
							                               WHERE nossoNumero COLLATE Latin1_General_CI_AS = de.NossoNumero COLLATE Latin1_General_CI_AS )) AS Usuario, 
							                                     (dbo.fnReferenciaDetalheEmissao(de.IdDetalheEmissao)) AS Referencia,
							                                     NossoNumero,de.DataEmissao AS dt,  
							                                     (CONVERT(VARCHAR(11), de.DataEmissao, 103)+ '' ''+ CONVERT(VARCHAR(11), de.DataEmissao, 114)) AS DataEmissao,  
							                                     CONVERT(VARCHAR(11), de.DataVencimento, 103) AS DataVencimento, 
							                                     valorEmissao 
																							FROM DetalhesEmissao de WHERE de.IdDetalheEmissao IN( SELECT idDetalheEmissao FROM ComposicoesEmissao ce WHERE ce.IdDebito IN(SELECT  iddebito FROM Debitos d WHERE d.' 
	    + @campo + ' = ' + @id + ') ) ORDER BY de.DataEmissao desc  '
	
	EXEC (@SQL)
END
