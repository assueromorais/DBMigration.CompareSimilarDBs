																								
-- ============================================================================
--	sp_CarregaEnderecoPFWEB
-- ============================================================================																								
CREATE PROCEDURE dbo.Sp_CarregaENDerecoPFWEB
	@IdProf INT = 0,
	@TipoExec INT = 0,
	@IdENDereco INT = 0
AS
BEGIN
	SET NOCOUNT ON
	
	IF @TipoExec = 1
	    SELECT Profissionais.Nome,
	           Profissionais.RegistroConselhoAtual,
	           '' AS IdENDereco,
	           Profissionais.CEP,
	           Profissionais.ENDereco,
	           Profissionais.Atualizado,
	           Profissionais.SiglaUF,
	           Profissionais.NomeCidade,
	           Profissionais.NomeBairro,
	           Profissionais.DataUltimaAtualizacao,
	           Profissionais.E_Residencial,
	           '1' AS Correspondecia,
	           0 AS E_Divulgacao
	    FROM   Profissionais
	    WHERE  IdProfissional = @IdProf 
	    UNION
	
	SELECT '' AS Nome,
	       '' AS RegistroConselhoAtual,
	       ENDerecos.IdENDereco,
	       ENDerecos.CEP,
	       ENDerecos.ENDereco,
	       ENDerecos.Atualizado,
	       ENDerecos.SiglaUf,
	       ENDerecos.NomeCidade,
	       ENDerecos.NomeBairro,
	       ENDerecos.DataUltimaAtualizacao,
	       ENDerecos.E_Residencial,
	       ENDerecos.Correspondencia,
	       E_Divulgacao
	FROM   ENDerecos
	WHERE  IdProfissional = @IdProf
	       AND ISNULL(AtualizacaoWeb, '') <> 'E:'
	ORDER BY
	       Nome 
	       DESC
	
	IF @TipoExec = 2
	    SELECT *
	    FROM   ENDerecos
	    WHERE  IdENDereco = @IdENDereco
	
	SET NOCOUNT OFF
END
