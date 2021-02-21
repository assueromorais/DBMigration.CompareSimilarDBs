/*Oc. 64821 - Victor*/

CREATE PROCEDURE [dbo].[sp_exclui_assunto] (@Id_Assunto SMALLINT)
AS
BEGIN
	CREATE TABLE #Assunto_Log_Exclusao
	(
		Id_Assunto  SMALLINT,
		Verificado  TINYINT
	)
	DECLARE @fim_exclusão BIT
	SET @fim_exclusão = 0
	INSERT INTO #Assunto_Log_Exclusao
	  (
	    Id_Assunto,
	    Verificado
	  )
	VALUES
	  (
	    @Id_Assunto,
	    0
	  )
	WHILE @fim_exclusão = 0
	BEGIN
	    IF EXISTS (
	           SELECT 1
	           FROM   ImplantaLog.dbo.Assunto_Log t1,
	                  #Assunto_Log_Exclusao t2
	           WHERE  t1.id_AssuntoPai = t2.Id_Assunto
	                  AND Verificado = 0
	       )
	    BEGIN
	        INSERT INTO #Assunto_Log_Exclusao
	          (
	            Id_Assunto,
	            Verificado
	          )
	        SELECT t1.Id_Assunto,
	               9
	        FROM   ImplantaLog.dbo.Assunto_Log t1,
	               #Assunto_Log_Exclusao t2
	        WHERE  t1.id_AssuntoPai = t2.Id_Assunto
	               AND Verificado = 0
	        
	        UPDATE #Assunto_Log_Exclusao
	        SET    Verificado = 1
	        FROM   #Assunto_Log_Exclusao
	        WHERE  Verificado = 0
	        
	        UPDATE #Assunto_Log_Exclusao
	        SET    Verificado  = 0
	        FROM   #Assunto_Log_Exclusao
	        WHERE  Verificado  = 9
	    END
	    ELSE
	    BEGIN
	        SET @fim_exclusão = 1
	    END
	END
	DELETE ImplantaLog.dbo.Assunto_Tabela_Log
	FROM   #Assunto_Log_Exclusao t1,
	       ImplantaLog.dbo.Assunto_Tabela_Log t2
	WHERE  t1.Id_Assunto = t2.Id_Assunto
	
	DELETE ImplantaLog.dbo.Assunto_Log
	FROM   #Assunto_Log_Exclusao t1,
	       ImplantaLog.dbo.Assunto_Log t2
	WHERE  t1.Id_Assunto = t2.Id_Assunto
END
