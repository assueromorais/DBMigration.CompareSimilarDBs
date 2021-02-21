

CREATE FUNCTION dbo.ufn_GetTipoPessoaDebito
(
	@IdProfissional INT, @IdPessoaJuridica INT, @IdPessoa INT
)
RETURNS SMALLINT
AS
BEGIN
	DECLARE @TipoPessoa SMALLINT
	SELECT @TipoPessoa = CASE 
	                          WHEN @IdPessoaJuridica IS NOT NULL THEN 0
	                          WHEN @IdProfissional IS NOT NULL THEN 1
	                          WHEN @IdPessoa IS NOT NULL THEN 2
	                          ELSE -1
	                     END
	
	RETURN @TipoPessoa
END
