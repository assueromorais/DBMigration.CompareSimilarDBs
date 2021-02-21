CREATE procedure sp_WebEnviaDocumentosReceitas
@idUsuario int,  
@dataEnvio varchar(10),  
@receitas varchar(5000)  
as  
set nocount on  
  
CREATE TABLE #TempList (  
 OrderID int  
)  
  
DECLARE @OrderID varchar(10), @Pos int, @sql varchar(50)  
SET @receitas = LTRIM(RTRIM(@receitas))+ ','  
SET @Pos = CHARINDEX(',', @receitas, 1)  
  
IF REPLACE(@receitas, ',', '') <> ''  
BEGIN  
 WHILE @Pos > 0  
 BEGIN  
  SET @OrderID = LTRIM(RTRIM(LEFT(@receitas, @Pos - 1)))  
  IF @OrderID <> ''  
  BEGIN  
   INSERT INTO #TempList (OrderID) VALUES (CAST(@OrderID AS int))  
  END  
  SET @receitas = RIGHT(@receitas, LEN(@receitas) - @Pos)  
  SET @Pos = CHARINDEX(',', @receitas, 1)  
 END  
END   

BEGIN TRAN

INSERT INTO WEB_EnvioDocumentacaoReceitas (IdUsuarioSubSecao, DataEnvio) VALUES (@idUsuario, @dataEnvio)  
  
DECLARE @idEnvio int  
SET @idEnvio = SCOPE_IDENTITY() 
  
DECLARE #cursor CURSOR FOR  
SELECT * FROM #TempList  
OPEN #cursor  
FETCH NEXT FROM #cursor INTO @OrderID  
WHILE @@FETCH_STATUS = 0          
BEGIN          
  
 INSERT INTO Web_EnvioDocumentacaoReceitas_Web_Receitas (IdEnvioDocumentacaoReceitas, IdReceita) VALUES ( @idEnvio ,  @OrderID )  
  
FETCH NEXT FROM #cursor INTO @OrderID  
          
END -- FIM CURSOR          
CLOSE #cursor  
DEALLOCATE #cursor  

SET @sql = 'SELECT 0 as OK' 

IF (@@ERROR = 0)
BEGIN
	UPDATE Web_Receitas SET Status = 'Pendente' WHERE IdReceita IN (SELECT * FROM #TempList) 
	SET @sql = 'SELECT 1 as OK' 
	COMMIT TRAN
END
ELSE
	ROLLBACK
  
EXEC(@sql)
  
SET NOCOUNT OFF 