/* OC 122787 - Adicionado por Diego*/
/* OC 142218 - Seila*/

CREATE FUNCTION [dbo].[formatarCPF](@cpf VARCHAR(11))
RETURNS VARCHAR(14)
AS
BEGIN
	DECLARE @retorno VARCHAR(14)  
	SET @retorno = SUBSTRING(@cpf, 1, 3) + '.' + SUBSTRING(@cpf, 4, 3) + '.' + 
	    SUBSTRING(@cpf, 7, 3) + '-' + SUBSTRING(@cpf, 10, 2)
	
	RETURN @retorno
END
