
CREATE FUNCTION dbo.ufn_RetornarListaEmailsValidos
(
	@ListaEmails VARCHAR(MAX),
	@Separador VARCHAR(5) = ','
)
RETURNS @Result TABLE ( Email VARCHAR(255), Valido BIT )
AS
BEGIN
	SET @ListaEmails = LOWER(ISNULL(@ListaEmails,''))
	
	INSERT INTO @Result ( Email, Valido )
	SELECT SUBSTRING(e.Valor, 1, 255),
		   dbo.ufn_ValidarEmail(e.Valor)
	FROM   dbo.ufn_Split( @ListaEmails, @Separador ) e
	WHERE  LTRIM(e.valor) <> ''
		
	RETURN 
END  
