

/*OC19718-19885*/
CREATE PROCEDURE dbo.sp_DeleInscricaoExameOrdem @IdProfissional Int
AS
SET NOCOUNT ON
DELETE FROM InscricaoExameOrdem 
WHERE IdProfissional = @IdProfissional
SET NOCOUNT OFF




