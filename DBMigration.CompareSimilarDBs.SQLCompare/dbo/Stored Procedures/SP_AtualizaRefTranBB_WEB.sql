
-- ============================================================================
--	SP_AtualizaRefTranBB_WEB
-- ============================================================================
CREATE PROCEDURE SP_AtualizaRefTranBB_WEB
	@sigla VARCHAR(20)
AS
	UPDATE ParametrosSiscafweb
	SET    BBRefTran = BBRefTran + 1
	WHERE  siglaConselho = @sigla
	
	SELECT BBRefTran
	FROM   ParametrosSiscafweb
