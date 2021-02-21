


























Create Procedure dbo.sp_DeleResponsabilidades @IdExperiencia Int

AS

SET NOCOUNT ON

DECLARE @IdResponsavelTecnico Int

DECLARE Cursor_Responsabilidade CURSOR FAST_FORWARD READ_ONLY
FOR SELECT IdResponsavelTecnico
      FROM ResponsaveisTecnicosPJ
     WHERE IdExperienciaProfissional = @IdExperiencia

OPEN Cursor_Responsabilidade
FETCH NEXT FROM Cursor_Responsabilidade INTO @IdResponsavelTecnico
WHILE (@@fetch_status <> -1)
BEGIN
  DELETE FROM HorariosResponsavelTecnico 
        WHERE IdResponsavelTecnico = @IdResponsavelTecnico
  
  FETCH NEXT FROM Cursor_Responsabilidade INTO @IdResponsavelTecnico
END
CLOSE Cursor_Responsabilidade
DEALLOCATE Cursor_Responsabilidade

DELETE FROM ResponsaveisTecnicosPJ 
WHERE IdExperienciaProfissional = @IdExperiencia

SET NOCOUNT OFF






















































