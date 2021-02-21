
CREATE PROCEDURE [dbo].[SP_GetScriptForeignKey]
	@ForeignKeyName VARCHAR(100)
AS
	DECLARE @IS_NOT_TRUSTED             BIT,
	        @delete_referential_action  TINYINT,
	        @update_referential_action  TINYINT,
	        @Ordem                      TINYINT,
	        @TabelaOrigem               VARCHAR(256),
	        @TabelaDestino              VARCHAR(256),
	        @CamposOrigem               VARCHAR(1000),
	        @CamposDestino              VARCHAR(1000)
	
	CREATE TABLE #Campos
	(
		TabelaOrigem   VARCHAR(256),
		CampoOrigem    VARCHAR(256),
		TabelaDestino  VARCHAR(256),
		CampoDestino   VARCHAR(256),
		Ordem          TINYINT
	) 
	
	SELECT @IS_NOT_TRUSTED = is_not_trusted,
	       @delete_referential_action = delete_referential_action,
	       @update_referential_action = update_referential_action
	FROM   sys.foreign_keys
	WHERE  NAME = @ForeignKeyName  
	
	INSERT INTO #Campos
	  (
	    TabelaOrigem,
	    CampoOrigem,
	    TabelaDestino,
	    CampoDestino,
	    Ordem
	  )
	SELECT tp.name AS TabelaOrigem,
	       cp.name AS CampoOrigem,
	       tf.name AS TabelaDestino,
	       cf.name AS CampoDestino,
	       f.keyno AS Ordem
	FROM   sys.sysobjects o
	       JOIN sys.sysforeignkeys f
	            ON  o.id = f.constid
	       JOIN sys.sysobjects tp
	            ON  tp.id = f.rkeyid
	       JOIN sys.sysobjects tf
	            ON  tf.id = f.fkeyid
	       JOIN sys.syscolumns cp
	            ON  cp.colid = f.rkey
	            AND cp.Id = f.rkeyid
	       JOIN sys.syscolumns cf
	            ON  cf.colid = f.fkey
	            AND cf.Id = f.fkeyid
	WHERE  o.name = @ForeignKeyName
	ORDER BY
	       f.keyno       
	
	SELECT @Ordem = MIN(Ordem)
	FROM   #Campos
	
	SELECT @TabelaOrigem = TabelaOrigem,
	       @TabelaDestino = TabelaDestino,
	       @CamposOrigem = '',
	       @CamposDestino = ''
	FROM   #Campos
	WHERE  Ordem = @Ordem	       
	
	WHILE @Ordem IS NOT NULL
	BEGIN
	    SELECT @CamposOrigem = CASE 
	                                WHEN LEN(@CamposOrigem) = 0 THEN '[' + 
	                                     CampoOrigem + ']'
	                                ELSE @CamposOrigem + ',[' + CampoOrigem + 
	                                     ']'
	                           END,
	           @CamposDestino = CASE 
	                                 WHEN LEN(@CamposDestino) = 0 THEN '[' + 
	                                      CampoDestino + ']'
	                                 ELSE @CamposDestino + ',[' + CampoDestino + 
	                                      ']'
	                            END
	    FROM   #Campos
	    WHERE  Ordem = @Ordem
	    
	    SELECT @Ordem = MIN(Ordem)
	    FROM   #Campos
	    WHERE  Ordem > @Ordem
	END
	
	SELECT 
	       'IF NOT EXISTS ( SELECT TOP 1 1
                        FROM   sysobjects o
                        WHERE  o.Name = ''' + @ForeignKeyName + 
	       '''
                               AND  o.xType = ''F'') 
	       ALTER TABLE ' + @TabelaDestino +
	       CASE 
	            WHEN @IS_NOT_TRUSTED = 1 THEN ' WITH NOCHECK'
	            ELSE ''
	       END +
	       ' ADD CONSTRAINT ' + @ForeignKeyName +
	       ' FOREIGN KEY (' + @CamposDestino + ')' +
	       ' REFERENCES ' + @TabelaOrigem + ' (' + @CamposOrigem + ')' +
	       CASE 
	            WHEN @delete_referential_action = 1 THEN ' ON DELETE CASCADE'
	            WHEN @delete_referential_action = 2 THEN ' ON DELETE SET NULL'
	            WHEN @delete_referential_action = 3 THEN 
	                 ' ON DELETE SET DEFAULT'
	            ELSE ''
	       END +
	       CASE 
	            WHEN @update_referential_action = 1 THEN ' ON UPDATE CASCADE'
	            WHEN @update_referential_action = 2 THEN ' ON UPDATE SET NULL'
	            WHEN @update_referential_action = 3 THEN 
	                 ' ON UPDATE SET DEFAULT'
	            ELSE ''
	       END
