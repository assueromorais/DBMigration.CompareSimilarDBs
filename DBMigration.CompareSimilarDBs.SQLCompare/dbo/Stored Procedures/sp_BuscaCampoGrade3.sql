			
-- ============================================================================
--	sp_BuscaCampoGrade3
-- ============================================================================
CREATE PROCEDURE [dbo].[sp_BuscaCampoGrade3]
	@IdProcessoPFPJ VARCHAR(9)
AS
BEGIN
	SELECT Processos_Prof_PJ.IdProcesso,
	       campoGrade3 = (
	           CASE 
	                WHEN DetalhesGrade.IdProfissional IS NOT NULL THEN 
	                     Profissionais.Nome
	                WHEN DetalhesGrade.IdPessoaJuridica IS NOT NULL THEN 
	                     PessoASJuridicAS.Nome
	                WHEN DetalhesGrade.IdPessoa IS NOT NULL THEN PessoAS.Nome
	           END
	       ),
	       TelASDefinicoes.TituloMonitor
	FROM   DetalhesGrade
	       LEFT JOIN Profissionais
	            ON  ISNULL(DetalhesGrade.IdProfissional, -1) = ISNULL(Profissionais.IdProfissional, -1)
	       LEFT JOIN PessoASJuridicAS
	            ON  ISNULL(DetalhesGrade.IdPessoaJuridica, -2) = ISNULL(PessoASJuridicAS.IdPessoaJuridica, -2)
	       LEFT JOIN PessoAS
	            ON  ISNULL(DetalhesGrade.IdPessoa, -3) = ISNULL(PessoAS.IdPessoa, -3)
	       JOIN Processos_Prof_PJ
	            ON  DetalhesGrade.IdProcesso_Prof_PJ = Processos_Prof_PJ.IdProcessos_Prof_PJ
	       JOIN Processos
	            ON  Processos.IdProcesso = Processos_Prof_PJ.IdProcesso
	       JOIN TelASDefinicoes
	            ON  TelASDefinicoes.NomeCampo = 'DetalhesGrade'
	            AND telASDefinicoes.idTipoProcesso = Processos.IdTipoProcesso
	WHERE  Processos_Prof_PJ.IdProcesso = @IdProcessoPFPJ
	       AND visualizarWeb = 1
END
