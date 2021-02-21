


























CREATE PROCEDURE [dbo].[sp_Joins] (@Tabelas VARCHAR(100)) AS

DECLARE @TabelaPK VARCHAR(100), @TabelaFK VARCHAR(100)

DECLARE Cursor_Join  CURSOR FAST_FORWARD FOR
		SELECT  TabelaPK.Name AS TabelaPK , TabelaFK.Name AS TabelaFK ,
			   ColPK.Name AS ColunaPK,  ColFK.Name AS ColunaFK
		FROM 	SysForeignKeys, 
			SysObjects TabelaPK, 
			SysObjects TabelaFK,
			SysColumns ColPK,
			SysColumns ColFK
		WHERE TabelaPK.Id = SysForeignKeys.rkeyid 
			AND TabelaFK.Id = SysForeignKeys.fkeyid 
			AND TabelaPK.Id = ColPK.Id
			AND TabelaFK.Id = ColFK.Id
			AND ColPK.ColId = SysForeignKeys.rkey 
			AND ColFK.ColId = SysForeignKeys.fkey  
			AND TabelaPK.Name IN ('+@Tabelas+')
			AND TabelaFK.Name IN ('+@Tabelas+') 

OPEN Cursor_Join

WHILE @@FETCH_STATUS = 0
BEGIN
	FETCH NEXT FROM Cursor_Join 
	INTO @TabelaPK, @TabelaFK


END


CLOSE Cursor_Join
DEALLOCATE Cursor_Join






















































