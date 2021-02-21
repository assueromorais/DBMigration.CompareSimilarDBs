
 CREATE FUNCTION [dbo].[TelefoneCelularTexto]  
(  
 @TelefoneCelular VARCHAR(100)
)  
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE 
	@numero VARCHAR(100),
	@resultado VARCHAR (100), 
	@letra VARCHAR(1),
	@qtd_palavra INTEGER,
	@cont INTEGER
	
	SET @numero = ''

	IF @TelefoneCelular IS NOT NULL AND @TelefoneCelular <> ''
	BEGIN
		SET @cont = 0 
		SET @qtd_palavra = LEN(@TelefoneCelular)
		SET @resultado = '' 
		WHILE @cont < @qtd_palavra 
		BEGIN 
			SET @cont = @cont + 1 
			SET @letra = SUBSTRING(@TelefoneCelular,@cont,1)
			IF @letra COLLATE Latin1_General_CI_AI IN ('a','b','c','d','e','f','g','h','i','j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '.',':',',',' ')
			BEGIN
				SET @resultado = @resultado + @letra
			END
		END		
		
			SET @numero = @resultado
	END
		RETURN @resultado
END



