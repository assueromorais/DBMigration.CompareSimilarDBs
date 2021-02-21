

CREATE PROCEDURE dbo.sp_ChecaTransaction AS
  CREATE TABLE #Transacoes ( Dados Varchar(20) COLLATE database_default, Trans Varchar(60) COLLATE database_default   )
  INSERT INTO #Transacoes
  EXEC ('DBCC OPENTRAN WITH TABLERESULTS')
  SELECT * FROM #Transacoes




