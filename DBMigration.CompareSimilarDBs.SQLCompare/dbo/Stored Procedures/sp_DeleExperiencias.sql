


























Create Procedure dbo.sp_DeleExperiencias @IdProfissional Int

AS

SET NOCOUNT ON

DECLARE @IdExperiencia Int

DECLARE Cursor_Experiencias CURSOR FAST_FORWARD READ_ONLY
FOR SELECT IdExperienciaProfissional
      FROM ExperienciasProfissionais
     WHERE IdProfissional = @IdProfissional

OPEN Cursor_Experiencias
FETCH NEXT FROM Cursor_Experiencias INTO @IdExperiencia
WHILE (@@fetch_status <> -1)
BEGIN
  Exec sp_DeleResponsabilidades @IdExperiencia
  
  FETCH NEXT FROM Cursor_Experiencias INTO @IdExperiencia
END
CLOSE Cursor_Experiencias
DEALLOCATE Cursor_Experiencias

DELETE FROM ExperienciasProfissionais 
WHERE IdProfissional = @IdProfissional

SET NOCOUNT OFF






















































