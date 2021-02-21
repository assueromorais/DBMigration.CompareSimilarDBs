/*OC 122787 - Adicionado por Diego*/
/* OC 142218 - Seila*/

CREATE FUNCTION [dbo].[formatarCNPJ](@cnpj VARCHAR(14))
RETURNS VARCHAR(18)
AS
BEGIN
	DECLARE @retorno VARCHAR(18)                          
	SET @retorno = SUBSTRING(@cnpj, 1, 2) + '.' + SUBSTRING(@cnpj, 3, 3) + '.' + 
	    SUBSTRING(@cnpj, 6, 3) + '/' + SUBSTRING(@cnpj, 9, 4) + '-' + SUBSTRING(@cnpj, 13, 2)
	
	RETURN @retorno
END
