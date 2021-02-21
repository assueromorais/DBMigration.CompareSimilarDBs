	 
-- ============================================================================
--	sp_BuscaCampoLista1
-- ============================================================================	
CREATE PROCEDURE [dbo].[sp_BuscaCampoLista1]
	@IdProcessoPFPJ 
	 VARCHAR(9)
AS
BEGIN
	SELECT DISTINCT 
	       ppl.IdProcesso,
	       CampoLista1 = pl.Descricao,
	       td.TituloMonitor
	FROM   Processos_ProcessosLista1 
	       ppl
	       JOIN ProcessosLista1 
	            pl
	            ON  pl.IdProcessoLista1 = ppl.IdProcessoLista1
	       JOIN TelASDefinicoes 
	            td
	            ON  td.IdTipoProcesso = pl.IdTipoProcesso
	WHERE  ppl.IdProcesso = @IdProcessoPFPJ
	       AND td.nomeCampo = 'processoLista1'
	       AND td.visualizarWeb = 1
END
