﻿


























CREATE Procedure dbo.sp_DeleComplementosProf @IdProfissional Int

AS

SET NOCOUNT ON

DELETE FROM ComplementosProfissional
 WHERE IdProfissional = @IdProfissional

DELETE FROM Profissionais_CategoriasProf
 WHERE IdProfissional = @IdProfissional

SET NOCOUNT OFF






















































