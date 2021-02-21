/*Oc. 62311 - Seila 25/06/2010*/   
/*CarlosR Oc44034*/
/* JoaoM Oc 41432 */
/*RodrigoT Oc 52079*/
/*Seila DM62311*/
/*Nivaldo OC 66268*/
/*Seila OC 123255 Task804 Adicionado por Rafaela*/
CREATE PROCEDURE [dbo].[sp_ProcessosOUFiscAtuais] @Processos   Bit,   
                                          @TipoPessoa varchar( 02 ),  
                                          @IdPessoa   INT,
                                          @EModeloDA BIT = 0,/*Oc.123255*/ 
                                          @IdTipoProcesso INT = 0
AS  

IF @Processos = 1  
BEGIN 
  IF @TipoPessoa = 'PF'  
  BEGIN  
    /* SELEÇÃO PARA PROCESSOS RELACIONADOS A PESSOAS FISICAS (PROFISSIONAIS) */  
    SELECT p.IdProcesso,
		   NumeroProcesso = CASE 
								 WHEN NumeroProc IS NULL THEN p.NumeroProcesso
								 ELSE CASE 
										   WHEN p.AnoProc IS NOT NULL THEN CAST(NumeroProc AS VARCHAR(20)) 
												+ '/' + CAST(AnoProc AS VARCHAR(4))
										   ELSE CAST(p.NumeroProc AS VARCHAR)
									  END
							END,
		   p.NumProcExterno,/*DM62311*/
		   DataSituacao = CONVERT(VARCHAR(10), MAX(psp.DataSituacao), 103),
		   Situacao = (
			   SELECT TOP 1 spf.SituacaoProcFis
			   FROM   Processos_SituacoesProcesso psp
					  LEFT JOIN SituacoesProcFis spf
						   ON  spf.IdSituacaoProcFis = psp.IdSituacaoProcFis
			   WHERE  psp.IdProcesso = ppp.IdProcesso
			   ORDER BY
					  psp.DataSituacao DESC
		   ),
		   ProcessoExterno = (
			   SELECT TOP 1 t.NumeProcExterno
			   FROM   Tramitacoes t
			   WHERE  t.IdProcesso = p.IdProcesso
			   ORDER BY
					  t.DataEntrada ASC,
					  t.DataEnvio ASC
		   ), tp.VincularDA   /*OC 66268*/
		   ,tp.ProcessoTipo /*Oc.123255*/ 
	FROM   Processos_Prof_PJ ppp
		   INNER JOIN Processos p
				ON  p.IdProcesso = ppp.IdProcesso
		   INNER JOIN TipoProcesso tp
		        ON p.IDTIPOPROCESSO = tp.IdTipoProcesso	   /*OC 66268*/			
		   LEFT JOIN Processos_SituacoesProcesso psp
				ON  psp.IdProcesso = p.IdProcesso
	WHERE  tp.VincularDA = '1' AND 	/*Oc.123255*/ 
	       CASE @EModeloDA WHEN 1 THEN p.EModeloDA ELSE ppp.IdProfissional END  = 
	       CASE @EModeloDA WHEN 1 THEN 1 ELSE @IdPessoa END AND 
	       CASE @IdTipoProcesso WHEN 0 THEN 0 ELSE tp.IdTipoProcesso END = 
	       CASE @IdTipoProcesso WHEN 0 THEN 0 ELSE @IdTipoProcesso END
	GROUP BY
		   p.IdProcesso,
		   ppp.IdProcesso,
		   CASE 
				WHEN NumeroProc IS NULL THEN p.NumeroProcesso
				ELSE CASE 
						  WHEN p.AnoProc IS NOT NULL THEN CAST(NumeroProc AS VARCHAR(20)) 
							   + '/' + CAST(AnoProc AS VARCHAR(4))
						  ELSE CAST(p.NumeroProc AS VARCHAR)
					 END
		   END
		   ,p.NumProcExterno/*DM62311*/
		   ,tp.VincularDA   /*OC 66268*/
		   ,tp.ProcessoTipo /*Oc.123255*/ 
  END  
    
  IF @TipoPessoa = 'PJ'  
  BEGIN  
    /* SELEÇÃO PARA PROCESSOS RELACIONADOS A PESSOAS JURIDICAS */  
    SELECT Processos.IdProcesso,
		   CASE 
				WHEN NumeroProc IS NULL THEN Processos.NumeroProcesso
				ELSE
            		CASE 
            			WHEN AnoProc IS NOT NULL THEN CAST(NumeroProc AS VARCHAR(20)) + '/' + CAST(AnoProc AS VARCHAR(4))
            			ELSE CAST(NumeroProc AS VARCHAR)
            		END
		   END NumeroProcesso,
		   Processos.NumProcExterno,/*DM62311*/
		   CONVERT(
			   VARCHAR(10),
			   MAX(Processos_SituacoesProcesso.DataSituacao),
			   103
		   ) AS DataSituacao,
		   Situacao = (
			   SELECT TOP 1 SituacoesProcFis.SituacaoProcFis
			   FROM   Processos_SituacoesProcesso
					  LEFT JOIN SituacoesProcFis
						   ON  SituacoesProcFis.IdSituacaoProcFis = 
							   Processos_SituacoesProcesso.IdSituacaoProcFis
			   WHERE  Processos_SituacoesProcesso.IdProcesso = A.IdProcesso
			   ORDER BY
					  Processos_SituacoesProcesso.DataSituacao DESC
		   )
		   ,tp.ProcessoTipo /*Oc.123255*/
	FROM   Processos_Prof_PJ A
		   INNER JOIN Processos
				ON  Processos.IdProcesso = A.IdProcesso 
		   INNER JOIN TipoProcesso tp 	/*Oc.123255*/ 
		        ON  Processos.IDTIPOPROCESSO = tp.IdTipoProcesso	
		   LEFT JOIN Processos_SituacoesProcesso
				ON  Processos_SituacoesProcesso.IdProcesso = Processos.IdProcesso
	WHERE  tp.VincularDA = '1' AND 	/*Oc.123255*/ 
	       CASE @EModeloDA WHEN 1 THEN Processos.EModeloDA ELSE A.IdPessoaJuridica END  = 
	       CASE @EModeloDA WHEN 1 THEN 1 ELSE @IdPessoa END AND 
	       CASE @IdTipoProcesso WHEN 0 THEN 0 ELSE tp.IdTipoProcesso END = 
	       CASE @IdTipoProcesso WHEN 0 THEN 0 ELSE @IdTipoProcesso END
	GROUP BY
		   Processos.IdProcesso,
		   A.IdProcesso,
		   CASE 
				WHEN NumeroProc IS NULL THEN Processos.NumeroProcesso
				ELSE
            		CASE 
            			WHEN AnoProc IS NOT NULL THEN CAST(NumeroProc AS VARCHAR(20)) + '/' + CAST(AnoProc AS VARCHAR(4))
            			ELSE CAST(NumeroProc AS VARCHAR)
            		END
		   END 
		   ,Processos.NumProcExterno/*DM62311*/  
		   ,tp.ProcessoTipo /*Oc.123255*/
  END  

  IF @TipoPessoa = 'PE'  
  BEGIN  
    /* SELEÇÃO PARA PROCESSOS RELACIONADOS A PESSOAS JURIDICAS */  
    SELECT Processos.IdProcesso,
		   CASE 
				WHEN NumeroProc IS NULL THEN Processos.NumeroProcesso
				ELSE CASE 
						  WHEN AnoProc IS NOT NULL THEN CAST(NumeroProc AS VARCHAR(20)) 
							   + '/' + CAST(AnoProc AS VARCHAR(4))
						  ELSE CAST(NumeroProc AS VARCHAR)
					 END
		   END NumeroProcesso,
		   Processos.NumProcExterno,/*DM62311*/ 
		   CONVERT(
			   VARCHAR(10),
			   MAX(Processos_SituacoesProcesso.DataSituacao),
			   103
		   ) AS DataSituacao,
		   Situacao = (
			   SELECT TOP 1 SituacoesProcFis.SituacaoProcFis
			   FROM   Processos_SituacoesProcesso
					  LEFT JOIN SituacoesProcFis
						   ON  SituacoesProcFis.IdSituacaoProcFis = 
							   Processos_SituacoesProcesso.IdSituacaoProcFis
			   WHERE  Processos_SituacoesProcesso.IdProcesso = A.IdProcesso
			   ORDER BY
					  Processos_SituacoesProcesso.DataSituacao DESC
		   )
		   ,tp.ProcessoTipo /*Oc.123255*/
	FROM   Processos_Prof_PJ A
		   INNER JOIN Processos
				ON  Processos.IdProcesso = A.IdProcesso
		   INNER JOIN TipoProcesso tp 	/*Oc.123255*/ 
		        ON  Processos.IDTIPOPROCESSO = tp.IdTipoProcesso
		   LEFT JOIN Processos_SituacoesProcesso
				ON  Processos_SituacoesProcesso.IdProcesso = Processos.IdProcesso
	WHERE  tp.VincularDA = '1' AND 	/*Oc.123255*/ 
	       CASE @EModeloDA WHEN 1 THEN Processos.EModeloDA ELSE A.IdPessoa END  = 
	       CASE @EModeloDA WHEN 1 THEN 1 ELSE @IdPessoa END AND 
	       CASE @IdTipoProcesso WHEN 0 THEN 0 ELSE tp.IdTipoProcesso END = 
	       CASE @IdTipoProcesso WHEN 0 THEN 0 ELSE @IdTipoProcesso END
	GROUP BY
		   Processos.IdProcesso,
		   A.IdProcesso,
		   CASE 
				WHEN NumeroProc IS NULL THEN Processos.NumeroProcesso
				ELSE CASE 
						  WHEN AnoProc IS NOT NULL THEN CAST(NumeroProc AS VARCHAR(20)) 
							   + '/' + CAST(AnoProc AS VARCHAR(4))
						  ELSE CAST(NumeroProc AS VARCHAR)
					 END
		   END
		   ,Processos.NumProcExterno/*DM62311*/   
		   ,tp.ProcessoTipo /*Oc.123255*/
  END  
END  
  
IF @Processos = 0  
BEGIN  
  IF @TipoPessoa = 'PF'  
  BEGIN  
    /* SELEÇÃO PARA FISCALIZAÇÃO RELACIONADOS A PESSOAS FISICAS (PROFISSIONAIS) */  
    SELECT  
      Fiscalizacoes.IdFiscalizacao,  
      Fiscalizacoes.NumeroFiscalizacao,  
      CONVERT(varchar(10), MAX( Fiscalizacoes_SituacoesFiscalizacao.DataSituacaoFisc), 103 ) As DataSituacao,  
      Situacao = (   SELECT TOP 1 SituacoesProcFis.SituacaoProcFis FROM Fiscalizacoes_SituacoesFiscalizacao  
                     LEFT JOIN SituacoesProcFis ON SituacoesProcFis.IdSituacaoProcFis = Fiscalizacoes_SituacoesFiscalizacao.IdSituacaoProcFis  
                     WHERE Fiscalizacoes_SituacoesFiscalizacao.IdFiscalizacao = A.IdFiscalizacao  
                     ORDER BY Fiscalizacoes_SituacoesFiscalizacao.DataSituacaoFisc Desc  
                  )  
    FROM Fiscalizacoes_Prof_PJ A  
       INNER JOIN Fiscalizacoes ON Fiscalizacoes.IdFiscalizacao = A.IdFiscalizacao  
       LEFT JOIN Fiscalizacoes_SituacoesFiscalizacao ON Fiscalizacoes_SituacoesFiscalizacao.IdFiscalizacao = Fiscalizacoes.IdFiscalizacao  
    WHERE A.IdProfissional = @IdPessoa  
    GROUP BY Fiscalizacoes.IdFiscalizacao, A.IdFiscalizacao, Fiscalizacoes.NumeroFiscalizacao  
  END  
  
  IF @TipoPessoa = 'PJ'  
  BEGIN  
    /* SELEÇÃO PARA FISCALIZACAO RELACIONADOS A PESSOAS JURIDICAS */  
    SELECT  
      Fiscalizacoes.IdFiscalizacao,  
      Fiscalizacoes.NumeroFiscalizacao,  
      CONVERT(varchar(10), MAX( Fiscalizacoes_SituacoesFiscalizacao.DataSituacaoFisc), 103 ) As DataSituacao,  
      Situacao = (   SELECT TOP 1 SituacoesProcFis.SituacaoProcFis FROM Fiscalizacoes_SituacoesFiscalizacao  
                     LEFT JOIN SituacoesProcFis ON SituacoesProcFis.IdSituacaoProcFis = Fiscalizacoes_SituacoesFiscalizacao.IdSituacaoProcFis  
                     WHERE Fiscalizacoes_SituacoesFiscalizacao.IdFiscalizacao = A.IdFiscalizacao  
                     ORDER BY Fiscalizacoes_SituacoesFiscalizacao.DataSituacaoFisc Desc  
                  )  
    FROM Fiscalizacoes_Prof_PJ A  
       INNER JOIN Fiscalizacoes ON Fiscalizacoes.IdFiscalizacao = A.IdFiscalizacao  
       LEFT JOIN Fiscalizacoes_SituacoesFiscalizacao ON Fiscalizacoes_SituacoesFiscalizacao.IdFiscalizacao = Fiscalizacoes.IdFiscalizacao  
    WHERE A.IdPessoaJuridica = @IdPessoa  
    GROUP BY Fiscalizacoes.IdFiscalizacao, A.IdFiscalizacao, Fiscalizacoes.NumeroFiscalizacao  
  END  
	
  IF @TipoPessoa = 'PE'  
  BEGIN  
    /* SELEÇÃO PARA FISCALIZAÇÃO RELACIONADOS A PESSOAS */  
    SELECT  
      Fiscalizacoes.IdFiscalizacao,  
      Fiscalizacoes.NumeroFiscalizacao,  
      CONVERT(varchar(10), MAX( Fiscalizacoes_SituacoesFiscalizacao.DataSituacaoFisc), 103 ) As DataSituacao,  
      Situacao = (   SELECT TOP 1 SituacoesProcFis.SituacaoProcFis FROM Fiscalizacoes_SituacoesFiscalizacao  
                     LEFT JOIN SituacoesProcFis ON SituacoesProcFis.IdSituacaoProcFis = Fiscalizacoes_SituacoesFiscalizacao.IdSituacaoProcFis  
                     WHERE Fiscalizacoes_SituacoesFiscalizacao.IdFiscalizacao = A.IdFiscalizacao  
                     ORDER BY Fiscalizacoes_SituacoesFiscalizacao.DataSituacaoFisc Desc  
                  )  
    FROM Fiscalizacoes_Prof_PJ A  
       INNER JOIN Fiscalizacoes ON Fiscalizacoes.IdFiscalizacao = A.IdFiscalizacao  
       LEFT JOIN Fiscalizacoes_SituacoesFiscalizacao ON Fiscalizacoes_SituacoesFiscalizacao.IdFiscalizacao = Fiscalizacoes.IdFiscalizacao  
    WHERE A.IdPessoa = @IdPessoa  
    GROUP BY Fiscalizacoes.IdFiscalizacao, A.IdFiscalizacao, Fiscalizacoes.NumeroFiscalizacao  
  END   

END
