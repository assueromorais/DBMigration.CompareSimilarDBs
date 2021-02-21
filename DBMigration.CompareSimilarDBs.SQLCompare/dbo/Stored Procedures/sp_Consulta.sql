


























CREATE PROCEDURE dbo.sp_Consulta AS

DECLARE Consulta_Cursor  CURSOR FAST_FORWARD FOR
	SELECT RegistroConselhoAtual FROM Profissionais

OPEN Consulta_Cursor  

WHILE @@FETCH_STATUS = 0
BEGIN
	FETCH NEXT FROM Consulta_Cursor

END


CLOSE Consulta_Cursor  
DEALLOCATE Consulta_Cursor






















































