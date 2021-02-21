																													
-- ============================================================================
--	spQtdParcelasPJ
-- ============================================================================																													
CREATE PROCEDURE spQtdParcelASPJ
	@valor DECIMAL(9, 2)
AS
BEGIN
	DECLARE @contador  INT,
	        @sql       VARCHAR(8000),
	        @sqlUnion  VARCHAR(15) 
	
	DECLARE @qtdParc   INT
	
	SET @contador = 0
	SET @sql = ' '
	SET @sqlUnion = ' '
	SET @qtdParc = 0          
	
	SELECT @qtdParc = ISNULL(MAX(qtdParcelAS), 0)
	FROM   FaixaValoresRenegociacaoPJ fvr
	WHERE  @valor >= valor 
	
	IF (@qtdParc < > 0)
	BEGIN
	    WHILE (@contador < @qtdParc)
	    BEGIN
	        SET @contador = @contador + 1
	        
	        SET @sql = @sql + @sqlUnion +
	            ' SELECT ' + CAST(@contador AS VARCHAR(10)) +
	            ' AS idParcela,          
CASE qtdParcelAS          
WHEN -1 THEN CAST(' + CAST(@valor AS VARCHAR(15)) +
	            ' AS NUMERIC(9, 2))          
ELSE CAST((' + CAST(@valor AS VARCHAR(15)) + ') / ' +
	            CAST(@contador AS VARCHAR(10)) 
	            +
	            ' AS NUMERIC(9, 2))          
END AS valor          
FROM   FaixaValoresRenegociacaoPJ         
WHERE  valor <= ' + CAST(@valor AS VARCHAR(15))          
	        
	        
	        SET @sqlUnion = ' UNION ALL '
	    END
	END          
	
	IF (@sql = '')
	    SET @sql = 'SELECT 0 AS idParcela,0 AS valor' 
	
	EXEC ('SELECT Distinct * FROM (' + @sql + ') a')
END
