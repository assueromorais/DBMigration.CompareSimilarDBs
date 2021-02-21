

/*OC19718-19885*/
CREATE PROCEDURE dbo.sp_DeleCredenciados @IdProfissional Int
AS
SET NOCOUNT ON
DELETE FROM Credenciados 
WHERE IdProfissional = @IdProfissional
SET NOCOUNT OFF




