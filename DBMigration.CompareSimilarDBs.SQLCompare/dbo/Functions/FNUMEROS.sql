


CREATE FUNCTION [dbo].[FNUMEROS](@Texto VarChar(8000))
RETURNS VarChar(8000)
BEGIN
 DECLARE
     @Retorno VarChar(8000),
  @I INT

SELECT
  @Retorno = '',
  @I = 0
 WHILE @I < LEN(@Texto)
  BEGIN
   SELECT
    @I = @I + 1,
    @Retorno = @Retorno + CASE
          WHEN SUBSTRING(@Texto,@I,1) = '-' THEN ''
          WHEN SUBSTRING(@Texto,@I,1) = '.' THEN ''
          WHEN SUBSTRING(@Texto,@I,1) = '+' THEN ''
          WHEN SUBSTRING(@Texto,@I,1) = '$' THEN ''
          WHEN SUBSTRING(@Texto,@I,1) = ',' THEN ''
          WHEN ISNUMERIC(SUBSTRING(@Texto, @I, 1)) = 1 THEN SUBSTRING(@Texto, @I, 1)
          ELSE ''
           END
  END
RETURN @Retorno
END



