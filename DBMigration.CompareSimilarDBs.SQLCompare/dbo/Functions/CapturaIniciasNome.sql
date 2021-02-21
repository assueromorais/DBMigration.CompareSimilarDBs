


CREATE FUNCTION dbo.CapturaIniciasNome(@Nome VARCHAR(200))
RETURNS VARCHAR(50)
AS
BEGIN
  DECLARE @TripaNome VARCHAR(200),@IniciaisNome VARCHAR(20)
  SET @TripaNome = @Nome + ' '
  SET @IniciaisNome = SUBSTRING(@Nome,1,1) + '.'
  WHILE CHARINDEX(' ',@TripaNome) > 0
  BEGIN
     SET @TripaNome = SUBSTRING(@TripaNome,CHARINDEX(' ',@TripaNome)+ 1,LEN(@TripaNome)) 
    IF (LEN(SUBSTRING(@TripaNome,1,CHARINDEX(' ',@TripaNome))) < 4 ) 
        SET @IniciaisNome = @IniciaisNome + SUBSTRING(@TripaNome,1,(LEN(SUBSTRING(@TripaNome,1,CHARINDEX(' ',@TripaNome))))) + ' ' 	   
     ELSE    
     	SET @IniciaisNome = @IniciaisNome + SUBSTRING(@TripaNome,1,1) + '.'
  END
  RETURN(@IniciaisNome)
END



