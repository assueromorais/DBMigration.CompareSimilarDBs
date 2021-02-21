						
-- ============================================================================
--	Sp_CarregaDadosBASicosPFWEB
-- ============================================================================
CREATE PROCEDURE [dbo].[Sp_CarregaDadosBASicosPFWEB]
	@IdProfissional INT = 0
AS
BEGIN
	SET NOCOUNT ON        
	
	IF @IdProfissional > 0
	BEGIN
	    SELECT IdProfissional,
	           Nome,
	           RegistroConselhoAtual,
	           SituacaoAtual,
	           CategoriaAtual AS NomeCategoria,
	           (
	               SELECT Nome
	               FROM   PessoAS
	               WHERE  E_ConselhoProfissao = 1
	                      AND IdPessoa = Profissionais.IdUnidadeConselho
	           ) AS NomeRegiao,
	           (
	               SELECT Nome
	               FROM   PessoAS
	               WHERE  E_ConselhoProfissao = 1
	                      AND IdPessoa = Profissionais.IdSubRegiao
	           ) AS NomeSubRegiao,
	           CASE 
	                WHEN (
	                         (
	                             SELECT CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) = 1
	                     ) THEN (
	                         SELECT TOP 1 ENDerecos.E_Residencial
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = Profissionais.IdProfissional
	                                AND E_Divulgacao = 1
	                     )
	                ELSE E_Residencial
	           END AS E_Residencial,
	           CASE 
	                WHEN (
	                         (
	                             SELECT CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) = 1
	                     ) THEN (
	                         SELECT TOP 1 ENDerecos.CEP
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = Profissionais.IdProfissional
	                                AND E_Divulgacao = 1
	                     )
	                ELSE CEP
	           END AS CEP,
	           CASE 
	                WHEN (
	                         (
	                             SELECT CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) = 1
	                     ) THEN (
	                         SELECT TOP 1 ENDerecos.SiglaUF
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = Profissionais.IdProfissional
	                                AND E_Divulgacao = 1
	                     )
	                ELSE SiglaUF
	           END AS SiglaUF,
	           CASE 
	                WHEN (
	                         (
	                             SELECT CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) = 1
	                     ) THEN (
	                         SELECT TOP 1 ENDerecos.ENDereco
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = Profissionais.IdProfissional
	                                AND E_Divulgacao = 1
	                     )
	                ELSE ENDereco
	           END AS ENDereco,
	           CASE 
	                WHEN (
	                         (
	                             SELECT CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) = 1
	                     ) THEN (
	                         SELECT TOP 1 ENDerecos.NomeCidade
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = Profissionais.IdProfissional
	                                AND E_Divulgacao = 1
	                     )
	                ELSE NomeCidade
	           END AS NomeCidade,
	           CASE 
	                WHEN (
	                         (
	                             SELECT CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) = 1
	                     ) THEN (
	                         SELECT TOP 1 ENDerecos.NomeBairro
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = Profissionais.IdProfissional
	                                AND E_Divulgacao = 1
	                     )
	                ELSE NomeBairro
	           END AS NomeBairro,
	           CASE 
	                WHEN (
	                         (
	                             SELECT CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) = 1
	                     ) THEN (
	                         SELECT TOP 1 ENDerecos.E_Divulgacao
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = Profissionais.IdProfissional
	                                AND E_Divulgacao = 1
	                     )
	                ELSE E_Divulgacao
	           END AS E_Divulgacao,
	           CONVERT(VARCHAR(10), DataUltimaAtualizacao, 103) AS 
	           DataUltimaAtualizacao,
	           Atualizado,
	           ENDerecoEMail,
	           ENDerecoEMail2,
	           SITE,
	           Site2,
	           TelefoneResid,
	           TelefoneTrab,
	           TelefoneCelular,
	           TelefoneOutros,
	           ISNULL(ExibirDadosWeb, 1) AS ExibirDadosWeb,
	           CONVERT(VARCHAR(10), DataInscricaoConselho, 103) AS 
	           DataInscricaoConselho,
	           (
	               SELECT TipoInscricao
	               FROM   TiposInscricao
	               WHERE  IdTipoInscricao = Profissionais.IdTipoInscricao
	           ) AS TipoInscricao,
	           SiteDivulgacao,
	           Site2Divulgacao,
	           EmailDivulgacao,
	           Email2Divulgacao,
	           TelResidDivulgacao,
	           TelCelDivulgacao,
	           TelTrabDivulgacao,
	           TelRecadoFaxDivulgacao,
	           IndicativoProf1,
	           IndicativoProf2,
	           IndicativoProf3,
	           IndicativoProf4,
	           IndicativoProf5,
	           IndicativoProf6,
	           DetalheSituacaoAtual = ISNULL(
	               (
	                   SELECT TOP 1 ds.Detalhe
	                   FROM   Profissionais_SituacoesPF 
	                          ps
	                          JOIN DetalhesSituacao ds
	                               ON  ds.IdDetalheSituacao = ps.IdDetalheSituacao
	                   WHERE  ps.IdProfissional = Profissionais.IdProfissional
	                   ORDER BY
	                          ps.DataInicioSituacao DESC
	               ),
	               ''
	           ),
	           InibirVisualizacaoRegistroConselhoAtual = ISNULL(
	               (
	                   SELECT TOP 1 s.InibirRegistrosWeb
	                   FROM   Profissionais_SituacoesPF 
	                          ps
	                          JOIN SituacoesPFPJ s
	                               ON  s.IdSituacaoPFPJ = ps.IdSituacaoPFPJ
	                   WHERE  ps.IdProfissional = Profissionais.IdProfissional
	                   ORDER BY
	                          ps.DataInicioSituacao DESC
	               ),
	               ''
	           )
	    FROM   Profissionais
	    WHERE  IdProfissional = @IdProfissional
	END        
	
	SET NOCOUNT OFF
END
