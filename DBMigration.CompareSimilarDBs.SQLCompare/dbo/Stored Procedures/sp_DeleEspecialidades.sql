﻿


























Create Procedure dbo.sp_DeleEspecialidades @IdProfissional Int

AS

SET NOCOUNT ON

DELETE FROM EspecialidadesProfissional 
WHERE IdProfissional = @IdProfissional

SET NOCOUNT OFF





















































