

CREATE PROCEDURE Sp_CarregaEnderecoPfWebNova /*1,44,'0'*/
	@Residencial INT = 1,
	@IdProf INT = 0,
	@EnderecoPrincipal INT = 0
AS
BEGIN
	SET NOCOUNT ON  
	IF @EnderecoPrincipal = 0
	    SELECT TOP 1 Enderecos.IdEndereco,
	           Enderecos.IdProfissional,
	           Enderecos.CEP,
	           Enderecos.Endereco,
	           Enderecos.Endereco1,
	           Enderecos.Atualizado,
	           Enderecos.SiglaUf,
	           Enderecos.NomeCidade,
	           Enderecos.NomeBairro,
	           Enderecos.DataUltimaAtualizacao,
	           Enderecos.E_Residencial,
	           Enderecos.Correspondencia,
	           Enderecos.E_Exterior,
	           E_Divulgacao,
	           Enderecos.ComplementoEndereco,
	           Enderecos.Numero,
	           Enderecos.CaixaPostal,
	           Enderecos.Endereco1,
	           COALESCE(Enderecos.Logradouro, Enderecos.Endereco) AS 
	           Logradouro,
	           Enderecos.AtualizacaoWeb
	    FROM   Enderecos
	    WHERE  IdProfissional = @IdProf
	           AND E_Residencial = @Residencial
	    ORDER BY
	           Enderecos.IdEndereco DESC
	ELSE
	    /*Endereco principal*/ 
	    SELECT '0' AS IdEndereco,
	           Profissionais.IdProfissional,
	           Profissionais.CEP,
	           Profissionais.Endereco,
	           Profissionais.Atualizado,
	           Profissionais.SiglaUF,
	           Profissionais.NomeCidade,
	           Profissionais.NomeBairro,
	           Profissionais.DataUltimaAtualizacao,
	           Profissionais.E_Residencial,
	           Profissionais.E_Exterior,
	           '1' AS Correspondencia,
	           0 AS E_Divulgacao,
	           Profissionais.ComplementoEndereco,
	           '' AS Numero,
	           Profissionais.CaixaPostal,
	           Profissionais.Endereco AS Endereco1,
	           Profissionais.Endereco AS Logradouro,
	           '' AS AtualizacaoWeb
	    FROM   Profissionais
	    WHERE  IdProfissional = @IdProf
	
	SET NOCOUNT OFF 
END
