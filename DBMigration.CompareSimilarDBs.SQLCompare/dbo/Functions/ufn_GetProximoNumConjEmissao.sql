
CREATE FUNCTION dbo.ufn_GetProximoNumConjEmissao(@TipoPessoa TINYINT, @IdPessoa INT)
RETURNS INT
AS
BEGIN
	DECLARE @NumConjEmissao INT
	SET @NumConjEmissao = NULL
		
	IF @TipoPessoa = 0
	BEGIN
		SELECT @NumConjEmissao = MAX(NumConjEmissao) 
		FROM   Debitos
		WHERE  IdPessoaJuridica = @IdPessoa
	END

	IF @TipoPessoa = 1
	BEGIN
		SELECT @NumConjEmissao = MAX(NumConjEmissao) 
		FROM   Debitos
		WHERE  IdProfissional = @IdPessoa
	END
	
	IF @TipoPessoa = 2
	BEGIN
		SELECT @NumConjEmissao = MAX(NumConjEmissao) 
		FROM   Debitos
		WHERE  IdPessoa = @IdPessoa
	END	
	
	
	RETURN ISNULL(@NumConjEmissao,0) + 1
END
