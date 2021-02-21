
CREATE FUNCTION dbo.RetiraZero(@Registro Varchar(20))
RETURNS VARCHAR(20)
AS
BEGIN
  WHILE (@Registro <> '') AND (SUBSTRING(@Registro, 1, 1) = '0')
  	SET @Registro = SUBSTRING(@Registro, 2, LEN(@Registro))
  RETURN(@Registro)
END
