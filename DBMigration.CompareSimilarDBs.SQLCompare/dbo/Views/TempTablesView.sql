

CREATE VIEW TempTablesView AS 
SELECT LEFT(name, charindex('_',name)-1) AS TempTable 
  FROM tempdb..sysobjects 
 WHERE charindex('_',name) > 0 
   AND xtype = 'u' 
   AND not object_id('tempdb..'+name) is NULL



