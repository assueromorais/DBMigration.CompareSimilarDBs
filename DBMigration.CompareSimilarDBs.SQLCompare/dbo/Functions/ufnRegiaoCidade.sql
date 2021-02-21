/*Ocorr - 58774 - Selvino*/

CREATE FUNCTION [dbo].[ufnRegiaoCidade]
(
	@IdEndereco INT
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @Regiao VARCHAR(100)
	SET @Regiao = NULL;
	
	SELECT @Regiao = r.Descricao
	FROM   Cidades c
	       JOIN Regioes r
	            ON  r.IdRegiao = c.IdRegiao
	WHERE  c.NomeCidade = (
	           SELECT e.NomeCidade
	           FROM   Enderecos e
	           WHERE  e.IdEndereco = @IdEndereco
	       ); 
	RETURN @Regiao;
END
