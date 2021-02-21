

/*OC19718-19885*/
CREATE PROCEDURE dbo.sp_DeleFotografia @IdProfissional Int
AS
SET NOCOUNT ON
DELETE FROM Profissionais_Foto 
WHERE IdProfissional = @IdProfissional
SET NOCOUNT OFF




