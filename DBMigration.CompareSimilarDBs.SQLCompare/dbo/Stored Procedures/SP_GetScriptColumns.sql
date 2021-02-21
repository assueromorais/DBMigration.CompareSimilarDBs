
CREATE PROCEDURE [dbo].[SP_GetScriptColumns]
	@TableName VARCHAR(256),
	@CreateInWebTables BIT = 0
AS
BEGIN
	DECLARE @SQL                VARCHAR(8000),
	        @ID                 INT,
	        @ForeignKey         VARCHAR(256),
	        @TableNameOriginal  VARCHAR(256)
	
	CREATE TABLE #Scripts
	(
		Id         INT IDENTITY(1, 1),
		ScriptSQL  VARCHAR(8000)
	)
	
	CREATE TABLE #Fields
	(
		FieldName   VARCHAR(256),
		FieldType   VARCHAR(256),
		FieldSize   SMALLINT,
		IsNullable  BIT,
		ColOrder    SMALLINT
	) 
	
	CREATE TABLE #ForeignKeys
	(
		Id    INT IDENTITY(1, 1),
		NAME  VARCHAR(256)
	)
	
	---- CONSULTA OS CAMPOS DA TABELA	
	
	INSERT INTO #Fields
	  (
	    FieldName,
	    FieldType,
	    FieldSize,
	    IsNullable,
	    ColOrder
	  )
	SELECT c.name,
	       tp.name,
	       c.length,
	       c.isnullable,
	       c.colorder
	FROM   sys.sysobjects t
	       JOIN sys.syscolumns c
	            ON  c.id = t.id
	       JOIN sys.systypes tp
	            ON  tp.xtype = c.xtype
	WHERE  t.name = @TableName
	ORDER BY
	       c.colorder	
	
	SET @TableNameOriginal = @TableName
	
	IF @CreateInWebTables = 1
	    SET @TableName = 'WEB_' + @TableName
	
	--- GERA O SCRIPT PARA CRIAÃ‡ÃƒO DOS CAMPOS	
	
	INSERT INTO #Scripts
	  (
	    ScriptSQL
	  )
	SELECT 
	       'IF NOT EXISTS ( SELECT TOP 1 1                                                                                                         
                             FROM   sysobjects o                                                                                                    
                                    JOIN syscolumns s ON s.id = o.id                                                                                
                             WHERE  o.Name = ''' + @TableName + 
	       '''                                                                           
                               AND  s.name = ''' + f.FieldName + 
	       ''')                                                                          
               ALTER TABLE ' + @TableName + ' ADD ' + f.FieldName +
	       CASE 
	            WHEN f.FieldType = 'VARCHAR' THEN ' ' + f.FieldType + '(' +
	                 CASE 
	                      WHEN f.FieldSize = -1 THEN CASE 
	                                                      WHEN @CreateInWebTables 
	                                                           = 1 THEN '8000'
	                                                      ELSE 'MAX'
	                                                 END
	                      ELSE CAST(f.FieldSize AS VARCHAR)
	                 END + ')'
	            WHEN f.FieldType = 'TEXT' AND @CreateInWebTables = 1 THEN 
	                 ' VARCHAR(8000) '
	            ELSE ' ' + f.FieldType
	       END +
	       CASE 
	            WHEN f.IsNullable = 0 THEN ' NOT NULL '
	            ELSE ''
	       END +
	       CASE 
	            WHEN dc.Name IS NOT NULL THEN ' CONSTRAINT ' + dc.Name + CASE 
	                                                                          WHEN 
	                                                                               @CreateInWebTables 
	                                                                               = 
	                                                                               1 THEN 
	                                                                               '_WEB'
	                                                                          ELSE 
	                                                                               ''
	                                                                     END + 
	                 ' DEFAULT ' + dc.definition
	            ELSE ''
	       END
	FROM   #Fields f
	       LEFT JOIN sys.default_constraints dc
	            ON  dc.parent_object_id = OBJECT_ID(@TableNameOriginal)
	            AND dc.parent_column_id = f.ColOrder 
	
	--- GERA O SCRIPT PARA CRIAÃ‡ÃƒO DOS VALORES DEFAULT
	
	INSERT INTO #Scripts
	  (
	    ScriptSQL
	  )
	SELECT 
	       'IF NOT EXISTS ( SELECT TOP 1 1
						FROM   SysObjects o
							   JOIN SysColumns c
									ON  o.id = c.Id
							   JOIN Sys.Default_Constraints dc
									ON  dc.parent_object_id = o.id
									AND dc.parent_column_id = c.colid
						WHERE  o.Name = ''' + @TableName + 
	       '''
						  AND  c.Name = ''' + f.FieldName + 
	       ''')
		 ALTER TABLE ' + @TableName +
	       ' ADD CONSTRAINT ' + dc.Name + CASE 
	                                           WHEN @CreateInWebTables = 1 THEN 
	                                                '_WEB'
	                                           ELSE ''
	                                      END +
	       ' DEFAULT ' + dc.definition +
	       ' FOR ' + f.FieldName
	FROM   #Fields f
	       JOIN sys.default_constraints dc
	            ON  dc.parent_object_id = OBJECT_ID(@TableNameOriginal)
	            AND dc.parent_column_id = f.ColOrder
	
	--- GERA O SCRIPT PARA CRIAÃ‡ÃƒO DAS FOREIGN KEY
	
	IF @CreateInWebTables = 0
	BEGIN
	    INSERT INTO #ForeignKeys
	      (
	        NAME
	      )
	    SELECT fk.name
	    FROM   sys.foreign_keys fk
	    WHERE  fk.parent_object_id = OBJECT_ID(@TableName)
	    
	    SELECT @ID = MIN(ID)
	    FROM   #ForeignKeys        
	    
	    WHILE @ID IS NOT NULL
	    BEGIN
	        SELECT @ForeignKey = NAME
	        FROM   #ForeignKeys
	        WHERE  ID = @ID
	        
	        INSERT INTO #Scripts
	          (
	            ScriptSQL
	          )
	        EXEC dbo.SP_GetScriptForeignKey @ForeignKey
	        
	        SELECT @ID = MIN(ID)
	        FROM   #ForeignKeys
	        WHERE  ID > @ID
	    END
	END
	
	--- Exibe os SCRIPTS
	
	SELECT *
	FROM   #Scripts
END
