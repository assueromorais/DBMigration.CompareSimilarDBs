CREATE FUNCTION dbo.AdicionaDias (@data varchar(10))
	RETURNS varchar(8)
	as 
	BEGIN
	  DECLARE @int int
	  DECLARE @mudou bit
	  
	  SET @int = 0
	  SET @mudou = 1
	  
	  WHILE (@mudou <> 0)
	  BEGIN
	    SET @mudou = 0
	  
	    IF (SELECT ((DATEPART(dw, @data) + @@datefirst)%7) AS 'hj') = 0 
	    BEGIN
	      SET @data = CONVERT(varchar, CAST(@data as datetime) + 2, 112)
	      SET @mudou = 1
	    END
	    
	    IF (SELECT ((DATEPART(dw, @data) + @@datefirst)%7) AS 'hj') = 1 
	    BEGIN
	      SET @data = CONVERT(varchar, CAST(@data as datetime) + 1, 112)
	      SET @mudou = 1
	    END
	    
	    IF (dbo.EhFeriado(@data) = 1) 
	    BEGIN
	    	SET @data = CONVERT(varchar, CAST(@data as datetime) + 1, 112)
	      SET @mudou = 1
	    END
	    
	  END
	  
	  return @data
	
	END