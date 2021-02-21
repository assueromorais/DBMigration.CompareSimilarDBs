																	
-- ============================================================================
--	sp_mostraFases
-- ============================================================================	
CREATE PROCEDURE sp_MostraFases
	@IdProcesso INT
AS
BEGIN
	SELECT IdProcesso,
	       CONVERT(VARCHAR(10), dataFase, 103) + ' ' + CONVERT(VARCHAR(8), dataFase, 108) [dataFase],
	       Fase = CASE 
	                   WHEN Processo_Fases.VisualizarWeb = 1 OR 
	                        Fases.VisualizarWeb = 1 THEN Fases.Fase
	                   ELSE 'NÃ£o disponÃ­vel pela internet.'
	              END,
	       Nota
	FROM   Processo_fases,
	       Fases
	WHERE  Fases.IdFase = Processo_fases.IdFase
	       AND IdProcesso = @IdProcesso
	ORDER BY
	       CAST([dataFASe] AS DATETIME) 
	       DESC
END
