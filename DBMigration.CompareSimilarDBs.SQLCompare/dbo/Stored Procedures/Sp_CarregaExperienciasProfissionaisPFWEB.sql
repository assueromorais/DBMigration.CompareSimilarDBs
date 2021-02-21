									
-- ============================================================================
--	sp_CarregaExperienciasProfissionaisPFWEB
-- ============================================================================
CREATE PROCEDURE Sp_CarregaExperienciasProfissionaisPFWEB
	@IdProfissional INT = -1
AS
BEGIN
	SET NOCOUNT ON      
	IF @IdProfissional > 0
	BEGIN
	    SELECT IdExperienciaProfissional,
	           'NomePessoa' = CASE 
	                               WHEN TblExperienciAS.IdPessoa 
	                                    IS NOT 
	                                    NULL THEN (
	                                        SELECT LTRIM(RTRIM(PessoAS.Nome)) AS 
	                                               Nome
	                                        FROM   PessoAS
	                                        WHERE  IdPessoa = TblExperienciAS.IdPessoa
	                                    )
	                               WHEN TblExperienciAS.IdPessoaJuridica 
	                                    IS NOT 
	                                    NULL THEN (
	                                        SELECT LTRIM(RTRIM(PessoASJuridicAS.Nome)) AS 
	                                               Nome
	                                        FROM   PessoASJuridicAS
	                                        WHERE  IdPessoaJuridica = 
	                                               TblExperienciAS.IdPessoaJuridica
	                                    )
	                          END,
	           'TpPessoaEntidade' = CASE 
	                                     WHEN TblExperienciAS.IdPessoa 
	                                          IS 
	                                          NOT 
	                                          NULL THEN 'P'
	                                     WHEN TblExperienciAS.IdPessoaJuridica 
	                                          IS 
	                                          NOT 
	                                          NULL THEN 'J'
	                                END,
	           Atividades.NomeAtividade,
	           Funcao,
	           IdVinculo,
	           LTRIM(RTRIM((PessoAS.Nome))) AS EntidadeClASse,
	           Periodo,
	           CONVERT(VARCHAR(10), TblExperienciAS.DataAdmissao, 103) AS 
	           DataAdmissao,
	           CONVERT(VARCHAR(10), TblExperienciAS.DataDemissao, 103) AS 
	           DataDemissao,
	           ISNULL(ExerceAtividade, 0) AS ExerceAtividade,
	           TblExperienciAS.IdNatureza,
	           IdAreaAtuacao,
	           IdSetorAtuacao,
	           IdTipoPessoa,
	           Cidades.NomeCidade,
	           HorarioTrabalho,
	           CargaHorariASemanal,
	           Remuneracao,
	           UFAreaAtuacao,
	           (
	               SELECT NaturezaPJ
	               FROM   NaturezASPJ npj
	               WHERE  npj.IdNaturezaPJ = TblExperienciAS.idNatureza
	           ) AS nomeNatureza,
	           (
	               SELECT AreaAtuacao
	               FROM   AreASAtuacao aa
	               WHERE  aa.IdAreaAtuacao = TblExperienciAS.IdAreaAtuacao
	           ) AS nomeArea,
	           (
	               SELECT SetorAtuacao
	               FROM   SetoresAtuacao sa
	               WHERE  sa.idSetorAtuacao = TblExperienciAS.idSetorAtuacao
	           ) AS nomeSetor,
	           (
	               SELECT VinculoEmpregaticio
	               FROM   VinculosEmpregaticio 
	                      ve
	               WHERE  ve.IdVinculoEmpregaticio = TblExperienciAS.IdVinculo
	           ) AS nomeVinculo,
	           (
	               SELECT TipoPessoa
	               FROM   TiposPessoa tp
	               WHERE  tp.IdTipoPessoa = TblExperienciAS.IdTipoPessoa
	           ) AS nomeTipo,
	           AreaAtuacaoDivulgacao,
	           SetorAtuacaoDivulgacao
	    FROM   ExperienciASProfissionais 
	           TblExperienciAS
	           LEFT JOIN Atividades
	                ON  Atividades.IdAtividade = TblExperienciAS.IdAtividade
	           LEFT JOIN Cidades
	                ON  Cidades.IdCidade = TblExperienciAS.IdCidadeAtuacao
	           LEFT JOIN PessoAS
	                ON  PessoAS.IdPessoa = TblExperienciAS.IdEntidadeClASse
	    WHERE  TblExperienciAS.IdProfissional = @IdProfissional
	           AND ISNULL(AtualizacaoWeb, '') <>
	               'E:'
	END
	
	SET NOCOUNT OFF
END
