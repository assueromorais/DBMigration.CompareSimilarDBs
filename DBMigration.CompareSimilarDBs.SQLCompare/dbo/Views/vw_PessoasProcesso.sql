

CREATE VIEW [dbo].[vw_PessoasProcesso]
AS
SELECT 
       Processos.IdProcesso,
       Processos.AnoProc,
       Processos.NumeroProc,
       Processos.IdTipoProcesso,
       /*************************************************/
       CASE 
            WHEN Processos_Prof_Pj.idProfissional IS NOT NULL THEN Processos_Prof_Pj.idProfissional
            WHEN Processos_Prof_Pj.IdPessoaJuridica IS NOT NULL THEN Processos_Prof_Pj.IdPessoaJuridica
       END AS [IdPessoa_Registro_conselho]  ,	
       CASE 
            WHEN Processos_Prof_Pj.idProfissional IS NOT NULL THEN 'PF'
            WHEN Processos_Prof_Pj.IdPessoaJuridica IS NOT NULL THEN 'PJ'
       END AS [TipoPessoa_Registro_conselho]  ,
       CASE 
            WHEN Processos_Prof_Pj.idProfissional IS NOT NULL THEN (ISNULL((SELECT pcp.RegistroConselho
            	                                                              FROM Profissionais_CategoriasProf pcp
            	                                                             WHERE pcp.IdProcesso = Processos.IdProcesso
            	                                                               AND pcp.IdProfissional = Processos_Prof_Pj.idProfissional), 
            	                                                           (SELECT RegistroConselhoAtual
                                                                              FROM Profissionais
                                                                             WHERE IdProfissional = Processos_Prof_Pj.IdProfissional)))
            WHEN Processos_Prof_Pj.IdPessoaJuridica IS NOT NULL THEN (ISNULL((SELECT pjcp.RegistroConselho
                                                                              FROM PessoasJuridicas_CategoriaPJ pjcp
                                                                              WHERE pjcp.IdProcesso = Processos.IdProcesso
                                                                               AND pjcp.IdPessoaJuridica = Processos_Prof_Pj.IdPessoaJuridica),
                                                                               (SELECT RegistroConselhoAtual
                                                                                  FROM PessoasJuridicas
                                                                                 WHERE IdPessoaJuridica = Processos_Prof_Pj.IdPessoaJuridica)))
       END AS [Registro_conselho]  ,
       /*************************************************/
       CASE 
            WHEN Processos_Prof_Pj.IdPessoaJuridica IS NOT NULL THEN Processos_Prof_Pj.IdPessoaJuridica
            WHEN Processos_Prof_Pj.IdPessoa IS NOT NULL THEN Processos_Prof_Pj.IdPessoa                                                            
       END AS [IdPessoa_Cnpj_cpf]  ,
       CASE 
            WHEN Processos_Prof_Pj.IdPessoaJuridica IS NOT NULL THEN 'PJ'
            WHEN Processos_Prof_Pj.IdPessoa IS NOT NULL THEN 'PE'     
       END AS [TipoPessoa_Cnpj_cpf]  ,
       CASE 
            WHEN Processos_Prof_Pj.IdPessoaJuridica IS NOT NULL THEN (SELECT CNPJ
                                                                      FROM   
                                                                      PessoasJuridicas
                                                                      WHERE  
                                                                      IdPessoaJuridica = 
                                                                      Processos_Prof_Pj.IdPessoaJuridica
                                                                      )
            WHEN Processos_Prof_Pj.IdPessoa IS NOT NULL THEN (SELECT CNPJCPF
                                                              FROM   Pessoas
                                                              WHERE  IdPessoa = 
                                                              Processos_Prof_Pj.IdPessoa
                                                              )
       END AS [Cnpj_cpf]  ,
       /*************************************************/
       CASE 
            WHEN Processos_Prof_Pj.idProfissional IS NOT NULL THEN Processos_Prof_Pj.IdProfissional                                                                   
            WHEN Processos_Prof_Pj.IdPessoa IS NOT NULL THEN Processos_Prof_Pj.IdPessoa
       END AS [IdPessoa_Cpf] ,
       CASE 
            WHEN Processos_Prof_Pj.idProfissional IS NOT NULL THEN 'PF'                                                                   
            WHEN Processos_Prof_Pj.IdPessoa IS NOT NULL THEN 'PE'
       END AS [TipoPessoa_Cpf]  ,
       CASE 
            WHEN Processos_Prof_Pj.idProfissional IS NOT NULL THEN (SELECT CPF
                                                                    FROM   
                                                                    Profissionais
                                                                    WHERE  
                                                                    IdProfissional = 
                                                                    Processos_Prof_Pj.IdProfissional
                                                                    )
            WHEN Processos_Prof_Pj.IdPessoa IS NOT NULL THEN (SELECT CNPJCPF
                                                              FROM   Pessoas
                                                              WHERE  IdPessoa = 
                                                              Processos_Prof_Pj.IdPessoa
                                                              )
       END AS [Cpf] ,
       /*************************************************/
       CASE 
            WHEN Processos_Prof_Pj.IdProfissional IS NOT NULL THEN Processos_Prof_Pj.IdProfissional
            WHEN Processos_Prof_Pj.IdPessoaJuridica IS NOT NULL THEN Processos_Prof_Pj.IdPessoaJuridica
            WHEN Processos_Prof_Pj.IdPessoa IS NOT NULL THEN Processos_Prof_Pj.IdPessoa
       END AS [IdPessoa_Representado_nome] ,
       CASE 
            WHEN Processos_Prof_Pj.IdProfissional IS NOT NULL THEN 'PF'
            WHEN Processos_Prof_Pj.IdPessoaJuridica IS NOT NULL THEN 'PJ'
            WHEN Processos_Prof_Pj.IdPessoa IS NOT NULL THEN 'PE'
       END AS [TipoPessoa_Representado_nome]  ,
       CASE 
            WHEN Processos_Prof_Pj.IdProfissional IS NOT NULL THEN (SELECT Nome
                                                                    FROM   
                                                                    Profissionais
                                                                    WHERE  
                                                                    IdProfissional = 
                                                                    Processos_Prof_Pj.IdProfissional 
                                                                    )
            WHEN Processos_Prof_Pj.IdPessoaJuridica IS NOT NULL THEN (SELECT Nome
                                                                      FROM   
                                                                      PessoasJuridicas
                                                                      WHERE  
                                                                      IdPessoaJuridica = 
                                                                      Processos_Prof_Pj.IdPessoaJuridica
                                                                      )
            WHEN Processos_Prof_Pj.IdPessoa IS NOT NULL THEN (SELECT Nome
                                                              FROM   Pessoas
                                                              WHERE  IdPessoa = 
                                                              Processos_Prof_Pj.IdPessoa 
                                                              )
       END AS [Representado_nome],       
       CASE 
            WHEN Processos_Prof_Pj.idProfissional IS NOT NULL THEN (SELECT RegistroConselhoAtual
                                                                    FROM   
                                                                    Profissionais
                                                                    WHERE  
                                                                    IdProfissional = 
                                                                    Processos_Prof_Pj.IdProfissional
                                                                    )
            WHEN Processos_Prof_Pj.IdPessoaJuridica IS NOT NULL THEN (SELECT RegistroConselhoAtual
                                                                      FROM   
                                                                      PessoasJuridicas
                                                                      WHERE  
                                                                      IdPessoaJuridica = 
                                                                      Processos_Prof_Pj.IdPessoaJuridica
                                                                      )
       END AS [Representado_Registro_conselho]  ,
       /*************************************************/
       CASE 
            WHEN Processos_Prof_Pj_Pessoas1.IdProfissional IS NOT NULL THEN 
                 Processos_Prof_Pj_Pessoas1.IdProfissional 
            WHEN Processos_Prof_Pj_Pessoas1.IdPessoaJuridica IS NOT NULL THEN 
                 Processos_Prof_Pj_Pessoas1.IdPessoaJuridica
            WHEN Processos_Prof_Pj_Pessoas1.IdPessoa IS NOT NULL THEN 
                 Processos_Prof_Pj_Pessoas1.IdPessoa 
       END AS [IdPessoa_Representante_nome],
       CASE 
            WHEN Processos_Prof_Pj_Pessoas1.IdProfissional IS NOT NULL THEN 'PF'
            WHEN Processos_Prof_Pj_Pessoas1.IdPessoaJuridica IS NOT NULL THEN 'PJ'
            WHEN Processos_Prof_Pj_Pessoas1.IdPessoa IS NOT NULL THEN 'PE'
       END AS [TipoPessoa_Representante_nome]  ,
       CASE 
            WHEN Processos_Prof_Pj_Pessoas1.IdProfissional IS NOT NULL THEN (SELECT 
            Nome
                                                                             FROM   
                                                                             Profissionais
                                                                             WHERE  
                                                                             IdProfissional = 
                                                                             Processos_Prof_Pj_Pessoas1.IdProfissional 
                                                                             )
            WHEN Processos_Prof_Pj_Pessoas1.IdPessoaJuridica IS NOT NULL THEN (SELECT 
            Nome
                                                                               FROM   
                                                                               PessoasJuridicas
                                                                               WHERE  
                                                                               IdPessoaJuridica = 
                                                                               Processos_Prof_Pj_Pessoas1.IdPessoaJuridica
                                                                               )
            WHEN Processos_Prof_Pj_Pessoas1.IdPessoa IS NOT NULL THEN (SELECT 
            Nome
                                                                       FROM   
                                                                       Pessoas
                                                                       WHERE  
                                                                       IdPessoa = 
                                                                       Processos_Prof_Pj_Pessoas1.IdPessoa 
                                                                       )
       END AS [Representante_nome] ,
       
       CASE 
            WHEN Processos_Prof_Pj_Pessoas1.idProfissional IS NOT NULL THEN (SELECT RegistroConselhoAtual
                                                                    FROM   
                                                                    Profissionais
                                                                    WHERE  
                                                                    IdProfissional = 
                                                                    Processos_Prof_Pj.IdProfissional
                                                                    )
            WHEN Processos_Prof_Pj_Pessoas1.IdPessoaJuridica IS NOT NULL THEN (SELECT RegistroConselhoAtual
                                                                      FROM   
                                                                      PessoasJuridicas
                                                                      WHERE  
                                                                      IdPessoaJuridica = 
                                                                      Processos_Prof_Pj.IdPessoaJuridica
                                                                      )
       END AS [Representante_Registro_conselho]  
	   /*************************************************/
FROM  Processos

	LEFT JOIN Processos_Prof_PJ
	ON   Processos_Prof_PJ.IdProcesso = Processos.IdProcesso

	LEFT JOIN Processos_Prof_PJ_Pessoas1
	ON   Processos_Prof_PJ_Pessoas1.IdProcesso = Processos.IdProcesso

WHERE 1 = 1 
