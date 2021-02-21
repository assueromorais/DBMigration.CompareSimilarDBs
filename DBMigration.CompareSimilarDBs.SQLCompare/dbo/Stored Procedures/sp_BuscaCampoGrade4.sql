 				
-- ============================================================================
--	sp_BuscaCampoGrade4
-- ============================================================================
CREATE PROCEDURE [dbo].[sp_BuscaCampoGrade4]
	@IdProcessoPFPJ VARCHAR(9)
AS
BEGIN
	SELECT DISTINCT Processos_Prof_PJ_PessoAS1.IdProcesso,
	       campoGrade4 = (
	           CASE 
	                WHEN DetalhesGrade1.IdProfissional IS NOT 
	                     NULL THEN Profissionais.Nome
	                WHEN DetalhesGrade1.IdPessoaJuridica IS NOT 
	                     NULL THEN PessoASJuridicAS.Nome
	                WHEN DetalhesGrade1.IdPessoa IS NOT NULL THEN PessoAS.Nome
	           END
	       ),
	       TelASDefinicoes.TituloMonitor
	FROM   DetalhesGrade1
	       LEFT JOIN Profissionais
	            ON  ISNULL(DetalhesGrade1.IdProfissional, -1) = ISNULL(Profissionais.IdProfissional, -1)
	       LEFT JOIN PessoASJuridicAS
	            ON  ISNULL(DetalhesGrade1.IdPessoaJuridica, -2) = ISNULL(PessoASJuridicAS.IdPessoaJuridica, -2)
	       LEFT JOIN PessoAS
	            ON  ISNULL(DetalhesGrade1.IdPessoa, -3) = ISNULL(PessoAS.IdPessoa, -3)
	       JOIN Processos_Prof_PJ_PessoAS1
	            ON  DetalhesGrade1.IdProcesso_Prof_PJ_Pessoa1 = 
	                Processos_Prof_PJ_PessoAS1.IdProcessos_Prof_PJ_Pessoa1
	       JOIN Processos
	            ON  Processos.IdProcesso = Processos_Prof_PJ_PessoAS1.IdProcesso
	       JOIN TelASDefinicoes
	            ON  TelASDefinicoes.NomeCampo = 'DetalhesGrade1'
	            AND telASDefinicoes.idTipoProcesso = Processos.IdTipoProcesso
	WHERE  visualizarWeb = 1
	       AND Processos_Prof_PJ_PessoAS1.IdProcesso = @IdProcessoPFPJ
END
