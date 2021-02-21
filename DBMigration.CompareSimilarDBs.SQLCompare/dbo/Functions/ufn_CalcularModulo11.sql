

CREATE FUNCTION dbo.ufn_CalcularModulo11
(
	@Codigo VARCHAR(100)
)
RETURNS CHAR(1)
AS
BEGIN
	DECLARE @Peso      TINYINT,
	        @Total     SMALLINT
	
	SELECT @Total = 0,
	       @PESO = 2
	
	WHILE LEN(@Codigo) > 0
	BEGIN
	    SELECT @Total   = @Total + CAST(SUBSTRING(@Codigo, LEN(@Codigo), 1) AS INT) * @Peso,
	           @Codigo  = SUBSTRING(@Codigo, 1, LEN(@Codigo) - 1),
	           @Peso    = CASE WHEN @Peso < 9 THEN @Peso + 1 ELSE 2 END
	END
	
	RETURN CASE WHEN 11 - (@Total % 11) > 9 THEN 0 ELSE 11 - (@Total % 11) END
END
