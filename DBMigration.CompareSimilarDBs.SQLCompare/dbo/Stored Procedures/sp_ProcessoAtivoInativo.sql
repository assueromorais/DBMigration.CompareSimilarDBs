																				
-- ============================================================================
--	sp_ProcessoAtivoInativo
-- ============================================================================	
CREATE PROCEDURE [dbo].[sp_ProcessoAtivoInativo]
	@IdProcesso 
	 VARCHAR(10)
AS
BEGIN
	DECLARE @Encerrado 
	        VARCHAR(50)
	
	SELECT @Encerrado = IdProcesso
	FROM   Processo_FASes
	WHERE  IdProcesso = @IdProcesso
	       AND EXISTS(
	               SELECT 1
	               FROM   FASes
	               WHERE  FASes.IdFASe = Processo_FASes.IdFASe
	                      AND FASeTermino = 1
	           )
	ORDER BY
	       DatafASe,
	       IdProcessoFASes 
	       DESC
	
	IF @Encerrado 
	   IS 
	   NULL
	    SET @Encerrado = 'ATIVO'
	ELSE
	    SET @Encerrado = 'INATIVO'    
	
	SELECT @Encerrado
END
