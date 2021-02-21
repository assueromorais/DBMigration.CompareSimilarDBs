
CREATE FUNCTION dbo.ufn_GetEmail
(
	@IdEmissao INT
) 
RETURNS VARCHAR(1000)
AS
BEGIN
	DECLARE @Email VARCHAR(1000)
	
	SET @Email = ''

	SELECT @Email = CASE 
	                     WHEN e.IdProfissional   IS NOT NULL THEN pf.EnderecoEMail
	                     WHEN e.IdPessoaJuridica IS NOT NULL THEN pj.EMail
	                     WHEN e.IdPessoa         IS NOT NULL THEN pe.Email
	                END
	FROM   Emissoes e
	       LEFT JOIN Profissionais pf    ON pf.IdProfissional = e.IdProfissional
	       LEFT JOIN PessoasJuridicas pj ON pj.IdPessoaJuridica = e.IdPessoaJuridica
	       LEFT JOIN Pessoas pe          ON pe.IdPessoa = e.IdPessoa
	WHERE  e.IdEmissao = @IdEmissao	
	
	SELECT @Email = CAST( REPLACE( REPLACE( (
                    SELECT EMAIL
                    FROM   dbo.ufn_ValidarListaEmails( @Email, ';')
                    WHERE  Valido = 1 FOR XML PATH('A')
                ), '<A><EMAIL>', '' ), '</EMAIL></A>', ';' ) AS VARCHAR(1000) )
	
	RETURN @Email
END
