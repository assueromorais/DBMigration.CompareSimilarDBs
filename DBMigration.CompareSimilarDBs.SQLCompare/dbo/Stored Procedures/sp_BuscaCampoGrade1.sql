	 
-- ============================================================================
--	SP_AtualizaRefTranBB_WEB
-- ============================================================================
CREATE PROCEDURE [dbo].[sp_BuscaCampoGrade1]
	@IdProcessoPFPJ VARCHAR(9)
AS
BEGIN
	DECLARE @CampoGrid  VARCHAR(30),
	        @Sql        VARCHAR(4500)    
	
	SET @sql = 
	    'SELECT Processos.IdProcesso,    
						  CASE WHEN Processos_Prof_Pj.IdProfissional IS NOT NULL THEN     
                     (SELECT dbo.CapturaIniciASNome(Nome)  FROM Profissionais WHERE IdProfissional = Processos_Prof_Pj.IdProfissional )     
                   WHEN Processos_Prof_Pj.IdPessoaJuridica IS NOT NULL THEN     
                     (SELECT dbo.CapturaIniciASNome(Nome)  FROM PessoASJuridicAS WHERE IdPessoaJuridica = Processos_Prof_Pj.IdPessoaJuridica)     
                   WHEN Processos_Prof_Pj.IdPessoa IS NOT NULL THEN     
                     (SELECT dbo.CapturaIniciASNome(Nome)  FROM PessoAS WHERE IdPessoa = Processos_Prof_Pj.IdPessoa )     
                   END AS [CampoGrade1], 
                   TelASDefinicoes.TituloMonitor,                     
                   [MatÃ©ria] = (SELECT CASE     
										WHEN Processos_Prof_Pj.IdProfissional IS NOT NULL THEN     
												(SELECT dbo.PRO_MateriASProcesso(' 
	    + @IdProcessoPFPJ + 
	    ',Processos_Prof_Pj.IdProfissional, NULL, NULL)
													 FROM Profissionais WHERE IdProfissional = Processos_Prof_Pj.IdProfissional)     
										WHEN Processos_Prof_Pj.IdPessoaJuridica IS NOT NULL THEN     
					(SELECT dbo.PRO_MateriASProcesso(' + @IdProcessoPFPJ + 
	    ', NULL, Processos_Prof_Pj.IdPessoaJuridica, null)
													 FROM PessoASJuridicAS WHERE IdPessoaJuridica = Processos_Prof_Pj.IdPessoaJuridica)                                   
										WHEN Processos_Prof_Pj.IdPessoa IS NOT NULL THEN     
					(SELECT dbo.PRO_MateriASProcesso(' + @IdProcessoPFPJ + 
	    ', NULL, NULL, Processos_Prof_Pj.IdPessoa)
													 FROM PessoAS WHERE IdPessoa = Processos_Prof_Pj.IdPessoa)
								 END)
				FROM Processos, Processos_Prof_Pj, telASDefinicoes        
	     WHERE Processos_Prof_Pj.IdProcesso = Processos.IdProcesso    
				 AND Processos_Prof_Pj.IdProcesso = ' + @IdProcessoPFPJ + 
	    '    
				 AND TelASDefinicoes.NomeCampo = ''campoGrid''    
				 AND telASDefinicoes.idTipoProcesso = Processos.IdTipoProcesso  
         AND visualizarWeb = 1 '
	
	EXEC (@sql)
END
