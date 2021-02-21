			
-- ============================================================================
--	sp_CarregaDadosBasicosPFWEB_Nova
-- ============================================================================																																				
CREATE PROCEDURE dbo.Sp_CarregaDadosBASicosPFWEB_Nova
	@IdProfissional INT = 0
AS
BEGIN
	SET NOCOUNT ON                          
	
	IF @IdProfissional > 0
	BEGIN
	    SELECT IdProfissional,
	           dbo.DeficienciaSplit(idProfissional) AS 
	           Deficiencias,
	           Nome,
	           NomeSocial,
	           (
	               SELECT IdDeficiencia
	               FROM   deficiencia
	               WHERE  Deficiencia.idDeficiencia = 
	                      Profissionais.IdDeficiencia
	           ) AS Deficiencia,
	           (
	               SELECT Deficiencia
	               FROM   deficiencia
	               WHERE  Deficiencia.idDeficiencia = 
	                      Profissionais.IdDeficiencia
	           ) AS NomeDeficiencia,
	           RegistroConselhoAtual,
	           SituacaoAtual,
	           Cidades.NomeCidade,
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
	                             SELECT 
	                                    CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) 
	                         =
	                         1
	                     ) THEN (
	                         SELECT TOP 
	                                1 
	                                ENDerecos.E_Residencial
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = 
	                                Profissionais.IdProfissional
	                                AND E_Divulgacao = 1
	                     )
	                ELSE E_Residencial
	           END AS E_Residencial,
	           CASE 
	                WHEN (
	                         (
	                             SELECT 
	                                    CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) 
	                         =
	                         1
	                     ) THEN (
	                         SELECT TOP 
	                                1 
	                                ENDerecos.CEP
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = 
	                                Profissionais.IdProfissional
	                                AND E_Divulgacao = 1
	                     )
	                ELSE Profissionais.CEP
	           END AS CEP,
	           CASE 
	                WHEN (
	                         (
	                             SELECT 
	                                    CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) 
	                         =
	                         1
	                     ) THEN (
	                         SELECT TOP 
	                                1 
	                                ENDerecos.SiglaUF
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = 
	                                Profissionais.IdProfissional
	                                AND E_Divulgacao = 1
	                     )
	                ELSE Profissionais.SiglaUF
	           END AS SiglaUF,
	           CASE 
	                WHEN (
	                         (
	                             SELECT 
	                                    CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) 
	                         =
	                         1
	                     ) THEN (
	                         SELECT TOP 
	                                1 
	                                ENDerecos.ENDereco
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = 
	                                Profissionais.IdProfissional
	                                AND E_Divulgacao = 1
	                     )
	                ELSE Profissionais.ENDereco
	           END AS ENDereco,
	           CASE 
	                WHEN (
	                         (
	                             SELECT 
	                                    CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) 
	                         =
	                         1
	                     ) THEN (
	                         SELECT TOP 
	                                1 
	                                ENDerecos.NomeCidade
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = 
	                                Profissionais.IdProfissional
	                                AND E_Divulgacao = 1
	                     )
	                ELSE Profissionais.NomeCidade
	           END AS NomeCidade,
	           CASE 
	                WHEN (
	                         (
	                             SELECT 
	                                    CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) 
	                         =
	                         1
	                     ) THEN (
	                         SELECT TOP 
	                                1 
	                                ENDerecos.NomeBairro
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = 
	                                Profissionais.IdProfissional
	                                AND E_Divulgacao = 1
	                     )
	                ELSE Profissionais.NomeBairro
	           END AS NomeBairro,
	           CASE 
	                WHEN (
	                         (
	                             SELECT 
	                                    CadPFMostraENDerecoDivulgacao
	                             FROM   parametrosSiscafw
	                         ) 
	                         =
	                         1
	                     ) THEN (
	                         SELECT TOP 
	                                1 
	                                ENDerecos.E_Divulgacao
	                         FROM   ENDerecos
	                         WHERE  ENDerecos.IdProfissional = 
	                                Profissionais.IdProfissional
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
	           CONVERT(VARCHAR(10), DataNAScimento, 103) AS 
	           DataNAScimento,
	           TipoSanguineo,
	           Religioes.IdReligiao AS Religiao,
	           Sexo,
	           Nacionalidades.idNacionalidade AS Nacionalidade,
	           Nacionalidades.Nacionalidade AS nomeNacionalidade,
	           SiglaUFNaturalidade,
	           NomePai,
	           NomeMae,
	           Civil_Militar,
	           EstadoCivil,
	           Raca,
	           RG,
	           RGOrgaoEmissao,
	           SiglaUFRG,
	           CONVERT(VARCHAR(10), RGDataEmissao, 103) AS 
	           RGDataEmissao,
	           CPF,
	           CTPS,
	           SerieCTPS,
	           CertificadoReserv,
	           CertificadoReservCSM,
	           CONVERT(VARCHAR(10), CertificadoReservData, 103) AS 
	           CertificadoReservData,
	           TituloEleitorInscricao,
	           TituloEleitorZona,
	           TituloEleitorSecao,
	           CONVERT(VARCHAR(10), TituloEleitorDataEmissao, 103) AS 
	           TituloEleitorDataEmissao,
	           NomeCidadeTitEleitor,
	           SiglaUFTituloEleitor,
	           DetalheSituacaoAtual = ISNULL(
	               (
	                   SELECT TOP 
	                          1 
	                          ds.Detalhe
	                   FROM   Profissionais_SituacoesPF 
	                          ps
	                          JOIN DetalhesSituacao 
	                               ds
	                               ON  ds.IdDetalheSituacao = ps.IdDetalheSituacao
	                   WHERE  ps.IdProfissional = Profissionais.IdProfissional
	                   ORDER BY
	                          ps.DataInicioSituacao 
	                          DESC
	               ),
	               ''
	           ),
	           InibirVisualizacaoRegistroConselhoAtual = ISNULL(
	               (
	                   SELECT TOP 
	                          1 
	                          s.InibirRegistrosWeb
	                   FROM   Profissionais_SituacoesPF 
	                          ps
	                          JOIN SituacoesPFPJ 
	                               s
	                               ON  s.IdSituacaoPFPJ = ps.IdSituacaoPFPJ
	                   WHERE  ps.IdProfissional = Profissionais.IdProfissional
	                   ORDER BY
	                          ps.DataInicioSituacao 
	                          DESC
	               ),
	               ''
	           ),
	           DtUltimaAtualizacaoWeb,
	           UsrUltimaAtualizacaoWeb
	           ,IdentGenero
	           ,DescIdentGenero
	    FROM   Profissionais
	           LEFT JOIN Nacionalidades
	                ON  Nacionalidades.IdNacionalidade = 
	                    Profissionais.IdNacionalidade
	           LEFT JOIN Cidades
	                ON  Cidades.IdCidade = Profissionais.IdCidadeNaturalidade
	           LEFT JOIN Religioes
	                ON  Religioes.IdReligiao = Profissionais.IdReligiao
	    WHERE  IdProfissional = @IdProfissional
	END                          
	
	SET NOCOUNT OFF 

	SET ANSI_NULLS ON 
	
END
