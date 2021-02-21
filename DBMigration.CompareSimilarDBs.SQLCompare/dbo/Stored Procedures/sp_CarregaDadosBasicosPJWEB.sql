							
-- ============================================================================
--	sp_CarregaDadosBasicosPJWEB
-- ============================================================================
CREATE PROCEDURE [dbo].[sp_CarregaDadosBasicosPJWEB]
	@IdPessoaJuridica INT = 0
AS
BEGIN
	SET NOCOUNT ON
	IF @IdPessoaJuridica > 0
	    SELECT PessoASJuridicAS.IdPessoaJuridica,
	           ISNULL(PessoASJuridicAS.RegistroConselhoAtual, '') AS 
	           RegistroConselhoAtual,
	           ISNULL(PessoASJuridicAS.Nome, '') AS Nome,
	           ISNULL(PessoASJuridicAS.CNPJ, '') AS CNPJ,
	           ISNULL(PessoASJuridicAS.SituacaoAtual, '') AS SituacaoAtual,
	           ISNULL(PessoASJuridicAS.CategoriaAtual, '') AS CategoriaAtual,
	           ISNULL(PessoASJuridicAS.CEP, '') AS CEP,
	           ISNULL(PessoASJuridicAS.SiglaUf, '') AS SiglaUf,
	           ISNULL(PessoASJuridicAS.NomeCidade, '') AS NomeCidade,
	           ISNULL(PessoASJuridicAS.ENDereco, '') AS ENDereco,
	           ISNULL(PessoASJuridicAS.NomeBairro, '') AS NomeBairro,
	           ISNULL(PessoASJuridicAS.Atualizado, '') AS Atualizado,
	           ISNULL(PessoASJuridicAS.DataUltimaAtualizacao, '') AS 
	           DataUltimaAtualizacao,
	           ISNULL(PessoASJuridicAS.Email, '') AS Email,
	           ISNULL(PessoASJuridicAS.Telefone, '') AS Telefone,
	           ISNULL(Reg.Nome, '') AS Regiao,
	           ISNULL(Sub.Nome, '') AS SubRegiao,
	           ExibirDadosWeb,
	           1 AS ExibirDadosWeb,
	           DetalheSituacaoAtual = ISNULL(
	               (
	                   SELECT TOP 1 ds.Detalhe
	                   FROM   PessoASJuridicAS_SituacoesPFPJ 
	                          ps
	                          JOIN DetalhesSituacao 
	                               ds
	                               ON  ds.IdDetalheSituacao = ps.IdDetalheSituacao
	                   WHERE  ps.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                   ORDER BY
	                          ps.DataInicioSituacao 
	                          DESC
	               ),
	               ''
	           ),
	           NomeCidadeFuncionamento = ISNULL(
	               (
	                   SELECT TOP 1 NomeCidade
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 1
	                   ORDER BY
	                          IdENDereco DESC,
	                          Correspondencia DESC
	               ),
	               ''
	           ),
	           ENDerecoFuncionamento = ISNULL(
	               (
	                   SELECT TOP 1 ENDereco
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 1
	                   ORDER BY
	                          IdENDereco DESC,
	                          Correspondencia DESC
	               ),
	               ''
	           ),
	           BairroFuncionamento = ISNULL(
	               (
	                   SELECT TOP 1 NomeBairro
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 1
	                   ORDER BY
	                          IdENDereco DESC,
	                          Correspondencia DESC
	               ),
	               ''
	           ),
	           SiglaUfFuncionamento = ISNULL(
	               (
	                   SELECT TOP 1 SiglaUf
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 1
	                   ORDER BY
	                          IdENDereco DESC,
	                          Correspondencia DESC
	               ),
	               ''
	           ),
	           CEPFuncionamento = ISNULL(
	               (
	                   SELECT TOP 1 CEP
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 1
	                   ORDER BY
	                          IdENDereco DESC,
	                          Correspondencia DESC
	               ),
	               ''
	           ),
	           AtualizadoFuncionamento = ISNULL(
	               (
	                   SELECT TOP 1 atualizado
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 1
	                   ORDER BY
	                          IdENDereco DESC,
	                          Correspondencia DESC
	               ),
	               ''
	           ),
	           DataUltimaAtualizacaoFuncionamento = ISNULL(
	               (
	                   SELECT TOP 1 
	                          DataUltimaAtualizacao
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 1
	                   ORDER BY
	                          IdENDereco DESC,
	                          Correspondencia DESC
	               ),
	               ''
	           ),
	           IdENDerecoFuncionamento = ISNULL(
	               (
	                   SELECT TOP 1 IdENDereco
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 1
	                   ORDER BY
	                          IdENDereco DESC,
	                          Correspondencia DESC
	               ),
	               ''
	           ),
	           NomeCidadeOutros = ISNULL(
	               (
	                   SELECT TOP 1 NomeCidade
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 0
	                   ORDER BY
	                          IdENDereco DESC
	               ),
	               ''
	           ),
	           ENDerecoOutros = ISNULL(
	               (
	                   SELECT TOP 1 ENDereco
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 0
	                   ORDER BY
	                          IdENDereco DESC
	               ),
	               ''
	           ),
	           BairroOutros = ISNULL(
	               (
	                   SELECT TOP 1 NomeBairro
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 0
	                   ORDER BY
	                          IdENDereco DESC
	               ),
	               ''
	           ),
	           SiglaUfOutros = ISNULL(
	               (
	                   SELECT TOP 1 SiglaUf
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 0
	                   ORDER BY
	                          IdENDereco DESC
	               ),
	               ''
	           ),
	           CEPOutros = ISNULL(
	               (
	                   SELECT TOP 1 CEP
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 0
	                   ORDER BY
	                          IdENDereco DESC
	               ),
	               ''
	           ),
	           AtualizadoOutros = ISNULL(
	               (
	                   SELECT TOP 1 atualizado
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 0
	                   ORDER BY
	                          IdENDereco DESC
	               ),
	               ''
	           ),
	           DataUltimaAtualizacaoOutros = ISNULL(
	               (
	                   SELECT TOP 1 
	                          DataUltimaAtualizacao
	                   FROM   ENDerecos
	                   WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                          AND ENDerecos.E_Residencial = 0
	                   ORDER BY
	                          IdENDereco DESC
	               ),
	               ''
	           ),
	           IdENDerecoOutros = (
	               SELECT TOP 1 IdENDereco
	               FROM   ENDerecos
	               WHERE  ENDerecos.IdPessoaJuridica = PessoASJuridicAS.IdPessoaJuridica
	                      AND ENDerecos.E_Residencial = 0
	               ORDER BY
	                      IdENDereco DESC
	           ),
	           ISNULL(PessoasJuridicas.RedesSociais, '') AS RedeSocial,
	           ISNULL(PessoasJuridicas.Site, '') AS SITE
	    FROM   PessoASJuridicAS
	           LEFT JOIN PessoAS Reg
	                ON  Reg.IdPessoa = PessoASJuridicAS.IdUnidadeConselho
	           LEFT JOIN PessoAS Sub
	                ON  Sub.IdPessoa = PessoASJuridicAS.IdSubRegiao
	    WHERE  PessoASJuridicAS.IdPessoaJuridica = @IdPessoaJuridica
	
	SET NOCOUNT OFF
END
