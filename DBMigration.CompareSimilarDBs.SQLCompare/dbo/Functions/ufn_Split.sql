
CREATE FUNCTION dbo.ufn_Split
(
	@Texto VARCHAR(MAX),
	@Separador VARCHAR(5)
)
RETURNS @Result TABLE ( Valor VARCHAR(255) )
BEGIN
	WHILE LEN(@Texto) > 0 
	BEGIN
		IF CHARINDEX(@Separador,@Texto) > 0
		BEGIN 
			INSERT INTO @Result VALUES (SUBSTRING(@Texto, 1, CHARINDEX(@Separador,@Texto)-1))
			SET @Texto = SUBSTRING(@Texto, CHARINDEX(@Separador,@Texto) + 1, LEN(@Texto))
		END
		ELSE
		BEGIN
			INSERT INTO @Result VALUES (@Texto)
			SET @Texto = ''
		END	
	END
		
	RETURN
END
