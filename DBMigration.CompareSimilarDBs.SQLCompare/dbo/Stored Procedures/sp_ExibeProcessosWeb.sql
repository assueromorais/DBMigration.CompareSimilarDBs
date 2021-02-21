
-- ============================================================================
--	sp_ExibeDebitosWeb
-- ============================================================================	
CREATE PROCEDURE [dbo].[sp_ExibeProcessosWeb]
	@idProf VARCHAR(10)
AS
BEGIN
	DECLARE @SQL VARCHAR(5000)
	
	SET @SQL = 
	    ' SELECT Processos.IdProcesso, 
	                   TipoProcesso.ProcessoTipo,    
										 NumeroProc,AnoProc, NumProt     
								FROM processos,processos_Prof_pj,TipoProcesso        
							 WHERE processos_Prof_pj.IdProcesso = Processos.IdProcesso        
								 AND TipoProcesso.IdTipoProcesso = Processos.IdtipoProcesso
								 AND TipoProcesso.VisualizarWeb = 1    
								 AND processos_Prof_pj.IdProfissional = ' + @idProf        
	
	EXEC (@SQL)
END
