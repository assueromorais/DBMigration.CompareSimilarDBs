

/*DM19039*/
CREATE PROCEDURE dbo.sp_DeleCarteiraPF @IdProfissional Int
AS
SET NOCOUNT ON
DELETE FROM ProfissionaisCarteira 
WHERE IdProfissional = @IdProfissional
SET NOCOUNT OFF




