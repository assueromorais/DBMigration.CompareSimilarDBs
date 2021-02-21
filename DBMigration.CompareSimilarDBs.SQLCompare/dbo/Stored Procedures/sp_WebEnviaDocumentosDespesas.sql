

CREATE procedure sp_WebEnviaDocumentosDespesas  
@idUsuario int,  
@dataEnvio varchar(10),  
@despesas varchar(5000)  
as  
set nocount on  
  
CREATE TABLE #TempList (  
 OrderID int  
)  
  
DECLARE @OrderID varchar(10), @Pos int, @sql varchar(50)    
SET @despesas = LTRIM(RTRIM(@despesas))+ ','  
SET @Pos = CHARINDEX(',', @despesas, 1)  
  
IF REPLACE(@despesas, ',', '') <> ''  
BEGIN  
 WHILE @Pos > 0  
 BEGIN  
  SET @OrderID = LTRIM(RTRIM(LEFT(@despesas, @Pos - 1)))  
  IF @OrderID <> ''  
  BEGIN  
   INSERT INTO #TempList (OrderID) VALUES (CAST(@OrderID AS int))  
  END  
  SET @despesas = RIGHT(@despesas, LEN(@despesas) - @Pos)  
  SET @Pos = CHARINDEX(',', @despesas, 1)  
 END  
END   
  
BEGIN TRAN

INSERT INTO WEB_EnvioDocumentacao (IdUsuarioSubSecao, DataEnvio) VALUES (@idUsuario, @dataEnvio)  
  
DECLARE @idEnvio int  
SET @idEnvio = (select @@IDENTITY)  
  
DECLARE #cursor CURSOR FOR  
SELECT * FROM #TempList  
OPEN #cursor  
FETCH NEXT FROM #cursor INTO @OrderID  
WHILE @@FETCH_STATUS = 0          
BEGIN          
  
 INSERT INTO Web_EnvioDocumentacao_Web_Despesas (IdEnvioDocumentacao, IdDespesaWeb) VALUES ( @idEnvio ,  @OrderID )  
  
FETCH NEXT FROM #cursor INTO @OrderID  
          
END
CLOSE #cursor  
DEALLOCATE #cursor  

SET @sql = 'SELECT 0 as OK' 

IF (@@ERROR = 0)
BEGIN
	UPDATE Web_Despesas SET Status = 'Pendente' WHERE IdDespesa IN (SELECT * FROM #TempList)  
	SET @sql = 'SELECT 1 as OK' 
	COMMIT TRAN
END
ELSE
	ROLLBACK
  
EXEC(@sql)
DROP TABLE #TempList
SET NOCOUNT OFF




