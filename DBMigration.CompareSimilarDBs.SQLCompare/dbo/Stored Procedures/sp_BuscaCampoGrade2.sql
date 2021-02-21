		 		
-- ============================================================================
--	sp_BuscaCampoGrade2
-- ============================================================================
CREATE PROCEDURE [dbo].[sp_BuscaCampoGrade2]
	@IdProcessoPFPJ VARCHAR(9)
AS
BEGIN
	DECLARE @CampoGrid  VARCHAR(30),
	        @Sql        VARCHAR(2000)  
	
	
	SELECT @CampoGrid = ISNULL(tituloMonitor, '--')
	FROM   telASDefinicoes
	WHERE  nomeCampo = 'CampoGridDinamico'  
	
	SET @sql = 
	    'SELECT Processos.IdProcesso,  
							CASE   
								WHEN Processos_Prof_Pj_PessoAS1.IdProfissional IS NOT NULL THEN   
									(SELECT dbo.CapturaIniciASNome(Nome) 
									   FROM Profissionais 
									  WHERE IdProfissional = Processos_Prof_Pj_PessoAS1.IdProfissional )   
								WHEN Processos_Prof_Pj_PessoAS1.IdPessoaJuridica IS NOT NULL THEN   
									(SELECT dbo.CapturaIniciASNome(Nome) 
									   FROM PessoASJuridicAS 
									  WHERE IdPessoaJuridica = Processos_Prof_Pj_PessoAS1.IdPessoaJuridica)
								WHEN Processos_Prof_Pj_PessoAS1.IdPessoa IS NOT NULL THEN   
									(SELECT dbo.CapturaIniciASNome(Nome) 
									   FROM PessoAS 
									  WHERE IdPessoa = Processos_Prof_Pj_PessoAS1.IdPessoa )
							END AS [campoGrade2],
							TelASDefinicoes.TituloMonitor  
			  FROM Processos, Processos_Prof_Pj_PessoAS1, telASDefinicoes  
	     WHERE Processos_Prof_Pj_PessoAS1.IdProcesso = Processos.IdProcesso  
				 AND Processos_Prof_Pj_PessoAS1.IdProcesso = ' + @IdProcessoPFPJ 
	    + 
	    '  
         AND TelASDefinicoes.NomeCampo = ''campoGridDinamico''  
				 AND telASDefinicoes.idTipoProcesso = Processos.IdTipoProcesso  
				 AND visualizarWeb = 1 '  
	
	EXEC (@sql)
END
