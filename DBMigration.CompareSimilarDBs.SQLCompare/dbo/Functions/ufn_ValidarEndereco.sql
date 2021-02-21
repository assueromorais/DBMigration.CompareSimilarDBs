
CREATE FUNCTION dbo.ufn_ValidarEndereco
(
	@IdPessoa       INT,
	@TipoPessoa     SMALLINT
)
RETURNS BIT
AS
BEGIN
	DECLARE @Return BIT
	
	/* Profissionais */
	IF @TipoPessoa = 1
		SELECT @Return = 1
		WHERE  EXISTS(
		           SELECT TOP 1 1
		           FROM   Enderecos
		           WHERE  IdProfissional = @IdPessoa
		                  AND ISNULL(Endereco, '') <> ''
		                  AND ISNULL(NomeCidade, '') <> ''
		                  AND ISNULL(SiglaUF, '') <> ''
		                  AND ISNULL(CEP, '') <> ''	
		       )
	/* Pessoas Jurídicas */	
	ELSE IF @TipoPessoa = 0
		SELECT @Return = 1
		WHERE  EXISTS(
		           SELECT TOP 1 1
		           FROM   Enderecos
		           WHERE  IdPessoaJuridica = @IdPessoa
		                  AND ISNULL(Endereco, '') <> ''
		                  AND ISNULL(NomeCidade, '') <> ''
		                  AND ISNULL(SiglaUF, '') <> ''
		                  AND ISNULL(CEP, '') <> ''
		       )
	/* Pessoas */
	ELSE
		SELECT @Return = 1
		WHERE  EXISTS(
		           SELECT TOP 1 1
		           FROM   Pessoas
		           WHERE  IdPessoa = @IdPessoa
		                  AND ISNULL(Endereco, '') <> ''
		                  AND ISNULL(NomeCidade, '') <> ''
		                  AND ISNULL(SiglaUF, '') <> ''
		                  AND ISNULL(CEP, '') <> ''	
		       )	
	         
RETURN ISNULL(@Return,0)
END
