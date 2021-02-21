

CREATE FUNCTION dbo.ufn_GetTipoPessoaByIdDebito
(
	@IdDebito INT
)
RETURNS SMALLINT
AS
BEGIN
	DECLARE @TipoPessoa SMALLINT
	SELECT @TipoPessoa = CASE 
	                          WHEN IdPessoaJuridica IS NOT NULL THEN 0
	                          WHEN IdProfissional IS NOT NULL THEN 1
	                          WHEN IdPessoa IS NOT NULL THEN 2
	                          ELSE -1
	                     END
	FROM   Debitos
	WHERE  IdDebito = @IdDebito
	
	RETURN @TipoPessoa
END
