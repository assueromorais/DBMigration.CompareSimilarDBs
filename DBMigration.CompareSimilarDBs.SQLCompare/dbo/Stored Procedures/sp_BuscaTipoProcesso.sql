	 					
-- ============================================================================
--	sp_BuscaTipoProcesso
-- ============================================================================
CREATE PROCEDURE [dbo].[sp_BuscaTipoProcesso]
	@IdProcessoPFPJ VARCHAR(9)
AS
BEGIN
	DECLARE @Sql VARCHAR(1500)
	
	SET @sql = 
	    'SELECT Processos.IdProcesso,
	            TipoProcesso.ProcessoTipo  
         FROM Processos,TipoProcesso  
	      WHERE Processos.IdTipoProcesso = TipoProcesso.IdTipoProcesso  
          AND Processos.IdProcesso = ' + @IdProcessoPFPJ		
	
	EXEC (@sql)
END
