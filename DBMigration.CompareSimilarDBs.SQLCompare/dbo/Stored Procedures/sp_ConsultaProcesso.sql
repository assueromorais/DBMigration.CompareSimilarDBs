									
-- ============================================================================
--	sp_ConsultaProcesso
-- ============================================================================
CREATE PROCEDURE sp_ConsultaProcesso
	@NumeroProc VARCHAR(11),
	@NumeroProtocolo VARCHAR(20)
AS
BEGIN
	DECLARE @sql     VARCHAR(500),
	        @ano     VARCHAR(10),
	        @Numero  VARCHAR(11)  
	
	SET @ano = ''    
	SET @Numero = @NumeroProc  	
	
	IF CHARINDEX('/', @Numero) <> 0
	    SET @NumeroProc = SUBSTRING(@Numero, 1, CHARINDEX('/', @Numero) - 1)    
	
	IF CHARINDEX('/', @Numero) <> 0
	    SET @ano = SUBSTRING(@Numero, CHARINDEX('/', @Numero) + 1, 10)      	
	
	SET @sql = 'SELECT IdProcesso FROM processos WHERE numeroProc = ' + @NumeroProc      
	
	IF (@ano <> '')
	    SET @sql = @sql + ' AND anoProc = ' + @ano
	ELSE
	    SET @sql = @sql + ' AND anoProc = 0'  
	
	IF @NumeroProtocolo <> ''
	    SET @sql = @sql + ' AND NumProt = ' + @NumeroProtocolo      
	
	SET @sql = @sql + 
	    ' AND Processos.IdTipoProcesso IN (SELECT IdTipoProcesso FROM TipoProcesso WHERE VisualizarWeb = 1)  ' 
	
	EXEC (@sql)
END
