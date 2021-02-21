/*Oc. 123255 - Seila 06/08/2014*/
CREATE PROCEDURE [dbo].[sp_VinculaProcessoDivAtiva] @TipoPessoa INT,@IdProcessoModelo INT,@IdDividaAtiva INT,@IdTipoProcesso INT   
AS   
DECLARE @IdProcessoNew INT,
     @IdProcessoProfPJPE1 INT,
     @IdProcessoProfPJPE2 INT,
     @IdProfissional INT,
     @IdPessoaJuridica INT,
     @IdAutoInfracao INT,
     @NewNumeroProc BIGINT 
  
/*@TipoPessoa 0-Pessoa Física
*             1-Pessoa Jurídica(não foi solicitada a implementação)
*             2-Outras pessoas(não foi solicitada a implementação)
*/

/*===================================================================================================================================================
 01-Alimenta as variáveis @IdProfissional e @IdPessoaJuridica
===================================================================================================================================================*/
SELECT @IdProfissional = IdProfissional, @IdPessoaJuridica = IdPessoaJuridica
FROM DividaAtiva 
WHERE IdDividaAtiva = @IdDividaAtiva
		
/*01.1-Processos ==================================================================================================================================*/ 
/*Define o próximo número do processo*/
IF (SELECT NumeracaoUnicaProcesso = ISNULL(NumeracaoUnicaProcesso,0) FROM ParametrosSiscafw ) = 1 /*Se numeração unica para todos os tipos de processo*/
BEGIN
	SELECT @NewNumeroProc = MAX(ISNULL(NumeroProc,0)) + 1 
	FROM Processos	
END
ELSE
BEGIN /*Se numeração unica por tipo de processo*/
	IF (SELECT ISNULL(FiscAutoIncProc,0) FROM TipoProcesso WHERE IdTipoProcesso = @IdTipoProcesso) = 1 /*Se auto incremento*/
	BEGIN  
		SELECT @NewNumeroProc = ISNULL(SequencialProcesso,0) + 1
		FROM TipoProcesso  
		WHERE IdTipoProcesso = @IdTipoProcesso
		
		UPDATE TipoProcesso
		SET SequencialProcesso = ISNULL(SequencialProcesso,0) + 1
		WHERE IdTipoProcesso = @IdTipoProcesso
	END	
	ELSE 
	BEGIN /*Se não é auto-incremento*/
		SELECT @NewNumeroProc = MAX(ISNULL(NumeroProc,0)) + 1 
	    FROM Processos
		WHERE IdTipoProcesso = @IdTipoProcesso			
	END
END    

/*Insere o processo*/
INSERT INTO Processos (NumeroProcesso,Data1Proc,Data2Proc,Data3Proc,Data4Proc,Num1Proc,Num2Proc,Num3Proc,Num4Proc,Num5Proc,IdTabela1Proc,
					   IdTabela2Proc,IdTabela3Proc,IdTabela4Proc,IdTabela5Proc,Alfa1Proc,Alfa2Proc,Alfa3Proc,Alfa4Proc,Alfa5Proc,Valor1Proc,
					   Valor2Proc,Valor3Proc,IdCidade1,IdCidade2,IdUF1,IdUF2,Observacao,IdTabela1Prof,IdTabela1PJ,IdTabela1Pessoa,IdTabela2Prof,
					   IdTabela2PJ,IdTabela2Pessoa,IdTabela3Prof,IdTabela3PJ,IdTabela3Pessoa,IdTabela4Prof,IdTabela4PJ,IdTabela4Pessoa,Chk1,Chk2,
					   Chk3,IdTabela5Prof,IdTabela5PJ,IdTabela5Pessoa,IdProcessoPrincipal,NumeroProc,AnoProc,NumProt,IDTIPOPROCESSO,IdEtapa,Data5Proc,
					   IdSecao,IdTurma,IdDepartamentoCriacao,IdUsuarioCriacao,DataSolucao,DataAutuacao,DataCadastro,Volumes,Prescricao,NumProcExterno,
					   Alfa6Proc,Alfa7Proc,Alfa8Proc,Alfa9Proc,Alfa10Proc,NumeroPasta,ProcessoSituacao,ProcessoDataAbertura,ProcessoDataConclusao,
					   EModeloDA)    
 
	SELECT NumeroProcesso,Data1Proc,Data2Proc,Data3Proc,Data4Proc,Num1Proc,Num2Proc,Num3Proc,Num4Proc,Num5Proc,IdTabela1Proc,
						   IdTabela2Proc,IdTabela3Proc,IdTabela4Proc,IdTabela5Proc,Alfa1Proc,Alfa2Proc,Alfa3Proc,Alfa4Proc,Alfa5Proc,Valor1Proc,
						   Valor2Proc,Valor3Proc,IdCidade1,IdCidade2,IdUF1,IdUF2,Observacao,IdTabela1Prof,IdTabela1PJ,IdTabela1Pessoa,IdTabela2Prof,
						   IdTabela2PJ,IdTabela2Pessoa,IdTabela3Prof,IdTabela3PJ,IdTabela3Pessoa,IdTabela4Prof,IdTabela4PJ,IdTabela4Pessoa,Chk1,Chk2,
						   Chk3,IdTabela5Prof,IdTabela5PJ,IdTabela5Pessoa,IdProcessoPrincipal,
						   NumeroProc = @NewNumeroProc,
						   AnoProc,NumProt,IDTIPOPROCESSO,IdEtapa,Data5Proc,
						   IdSecao,IdTurma,IdDepartamentoCriacao,IdUsuarioCriacao,DataSolucao,DataAutuacao,DataCadastro,Volumes,Prescricao,NumProcExterno,
						   Alfa6Proc,Alfa7Proc,Alfa8Proc,Alfa9Proc,Alfa10Proc,NumeroPasta,ProcessoSituacao,ProcessoDataAbertura,ProcessoDataConclusao,
						   EModeloDA = 0
	FROM Processos
	WHERE IdProcesso = @IdProcessoModelo
 	
SELECT @IdProcessoNew = SCOPE_IDENTITY()
 
/*01.2-CamposDinâmicos de processo=================================================================================================================*/
/* 
* Estes campos dinâmicos não precisam de tratamento pois estão fisicamente na tabela de processos
* Data1Proc,Data2Proc,Data3Proc,Data4Proc,Data5Proc
* Num1Proc,Num2Proc,Num3Proc,Num5Proc
* Alfa1Proc,Alfa2Proc,Alfa3Proc,Alfa4Proc,Alfa5Proc,Alfa6Proc,Alfa7Proc,Alfa8Proc,Alfa9Proc,Alfa10Proc
* Valor1Proc,Valor2Proc,Valor3Proc
* Chk1,Chk2,Chk3
* 
* Campos Id que não precisam de tratamento, pois o Id está na tabela de Processos
* **IdProcessoPrincipal,IdTipoProcesso,IdEtapa,IdSecao,IdTurma,IdDepartamentoCriacao,IdUsuarioCriacao(Não são dinâmicos)
* **IdTabela1Proc,IdTabela2Proc,IdTabela3Proc,IdTAbela4Proc,IdTabela5Proc (Pesquisam nas tabelas ProcessosTabela1,2,3,4,5)
* **IdCidade1,IdCidade2 (Pesquisam na tabela de Cidades)
* **IdUF1,IdUF2 (Pesquisam na tabela de Estados)
* **IdTabela1Prof,IdTabela2Prof,IdTabela3Prof,IdTabela4Prof,IdTabela5Prof (Pesquisam nas tabelas de PF/PJ/PE)
* **IdTabela1PJ,IdTabela2PJ,IdTabela3PJ,IdTabela4PJ,IdTabela5PJ (Pesquisam nas tabelas de PF/PJ/PE)
* **IdTabela1Pessoa,IdTabela2Pessoa,IdTabela3Pessoa,IdTabela4Pessoa,IdTabela5Pessoa (Pesquisam nas tabelas de PF/PJ/PE) 
* 
* Estes precisam de tratamento, pois utilizam uma terceira tabela para relacionamento
* Processos_ProcessosLista1,ProcessosLista1(Campo do tipo ListaProcesso)
* Grade =>Processos_Prof_PJ
* Grade1=>Processos_Prof_PJ_Pessoas1
* DetalhesGrade
* DetalhesGrade1
* */

/*ListaProcesso*/
IF EXISTS (SELECT TOP 1 1 FROM Processos_ProcessosLista1 WHERE IdProcesso = @IdProcessoModelo)/*Se existe no processo Modelo*/
	INSERT INTO Processos_ProcessosLista1 (IdProcesso,IdProcessoLista1)
		SELECT @IdProcessoNew,IdProcessoLista1
		FROM Processos_ProcessosLista1
		WHERE IdProcesso = @IdProcessoModelo   	

/*Grade01-Processos_Prof_PJ*/	
IF EXISTS (SELECT TOP 1 1  FROM TelasDefinicoes WHERE VinculaDA = 1 AND TipoCampo = 'G' AND NomeCampo = 'CampoGrid' AND IdTipoProcesso = @IdTipoProcesso)
BEGIN		
	INSERT INTO Processos_Prof_PJ (IdProfissional,IdPessoaJuridica,IdProcesso) 
		SELECT @IdProfissional,@IdPessoaJuridica,@IdProcessoNew			
END	
ELSE
BEGIN		
	INSERT INTO Processos_Prof_PJ (IdProfissional,IdPessoaJuridica,IdProcesso) 
		SELECT IdProfissional,IdPessoaJuridica,@IdProcessoNew
		FROM Processos_Prof_PJ 
		WHERE IdProcesso = @IdProcessoModelo		
END		

/*DetalhesGrade01-DetalhesGrade*/
SELECT @IdProcessoProfPJPE1 = SCOPE_IDENTITY()		
INSERT INTO DetalhesGrade(IdProcesso_Prof_PJ,IdProfissional,IdPessoaJuridica,IdPessoa)
	SELECT @IdProcessoProfPJPE1,DG.IdProfissional,DG.IdPessoaJuridica,DG.IdPessoa /* ou SELECT @IdProcessoProfPJPE1,@IdProfissional*/	
	FROM Processos_Prof_PJ PP INNER JOIN 
	     DetalhesGrade DG ON DG.IdProcesso_Prof_PJ = PP.IdProcessos_Prof_PJ 
	WHERE PP.IdProcesso = @IdProcessoModelo

/*Grade02-Processos_Prof_PJ_Pessoas1*/
IF EXISTS (SELECT TOP 1 1  FROM TelasDefinicoes WHERE VinculaDA = 1 AND TipoCampo = 'G' AND NomeCampo = 'CampoGridDinamico' AND IdTipoProcesso = @IdTipoProcesso)
BEGIN
	INSERT INTO Processos_Prof_PJ_Pessoas1 (IdProfissional,IdPessoaJuridica,IdProcesso) 
		SELECT @IdProfissional,@IdPessoaJuridica,@IdProcessoNew		
END	
ELSE
BEGIN
	INSERT INTO Processos_Prof_PJ_Pessoas1 (IdProfissional,IdPessoaJuridica,IdProcesso) 
		SELECT IdProfissional,IdPessoaJuridica,@IdProcessoNew
		FROM Processos_Prof_PJ_Pessoas1 
		WHERE IdProcesso = @IdProcessoModelo			
END		
/*DetalhesGrade02-DetalhesGrade1*/	
SELECT @IdProcessoProfPJPE2 = SCOPE_IDENTITY()	
INSERT INTO DetalhesGrade1(IdProcesso_Prof_PJ_Pessoa1,IdProfissional,IdPessoaJuridica,IdPessoa)
	SELECT @IdProcessoProfPJPE2,DG.IdProfissional,DG.IdPessoaJuridica,DG.IdPessoa /* ou SELECT @IdProcessoProfPJPE2,@IdProfissional*/
	FROM Processos_Prof_PJ_Pessoas1 PP INNER JOIN 
	     DetalhesGrade1 DG ON DG.IdProcesso_Prof_PJ_Pessoa1 = PP.IdProcessos_Prof_PJ_Pessoa1 
	WHERE PP.IdProcesso = @IdProcessoModelo	
		
/*01.3-Situações do processo======================================================================================================================*/	
INSERT INTO Processos_SituacoesProcesso (IdProcesso,IdSituacaoProcFis,DataSituacao)
	SELECT @IdProcessoNew,IdSituacaoProcFis,DataSituacao
	FROM Processos_SituacoesProcesso
	WHERE IdProcesso = @IdProcessoModelo	

/*01.4-Tramitações do processo=====================================================================================================================*/	
INSERT INTO Tramitacoes (IdProcesso,IdFiscalizacao,IdDocumento,IdSituacaoTramitacao,IdLocalTramitacao,NumeProcExterno,DataPrevisao,DataEntrada,
	DataSaida,Andamento,Pendencias,ProtocoloDoc,IdUsuario,PessoaTramitacao,Recebido,IndLocal,IdUsuarioCriacao,DataEnvio,Prioridade,IdUsuarioRecebeu,
	IdDepartamento,IdDepartamentoRecebeu,IdDepartamentoCriacao,IdUnidade,IdLoteTramitacao,TramitacaoLote,IdLocalizador,MensagemLida,DataLeitura,
	DataUltimaAtualizacao,UsuarioUltimaAtualizacao,DepartamentoUltimaAtualizacao,DtLeituraMsgUsrCriacao,DtLeituraMsgUsrResponsavel)	
	SELECT IdProcesso = @IdProcessoNew,IdFiscalizacao,IdDocumento,IdSituacaoTramitacao,IdLocalTramitacao,NumeProcExterno,DataPrevisao,DataEntrada,
	       DataSaida,Andamento,Pendencias,ProtocoloDoc,IdUsuario,PessoaTramitacao,Recebido,IndLocal,IdUsuarioCriacao,DataEnvio,Prioridade,IdUsuarioRecebeu,
	       IdDepartamento,IdDepartamentoRecebeu,IdDepartamentoCriacao,IdUnidade,IdLoteTramitacao,TramitacaoLote,IdLocalizador,MensagemLida,DataLeitura,
	       DataUltimaAtualizacao,UsuarioUltimaAtualizacao,DepartamentoUltimaAtualizacao,DtLeituraMsgUsrCriacao,DtLeituraMsgUsrResponsavel
	FROM Tramitacoes 
	WHERE IdProcesso = @IdProcessoModelo		
		
/*01.5-Ocorências do processo======================================================================================================================*/	
INSERT INTO Ocorrencias (IndPaiOcorrencia,IdPaiOcorrencia,DataOcorrencia,TextoOcorrencia,IdUsuarioCriacao,IdDepartamentoCriacao,
					 IdSituacaoOcorrencia,IdTramitacao)
	SELECT  IndPaiOcorrencia,IdPaiOcorrencia = @IdProcessoNew,DataOcorrencia,TextoOcorrencia,IdUsuarioCriacao,IdDepartamentoCriacao,
	        IdSituacaoOcorrencia,IdTramitacao
	FROM Ocorrencias
	WHERE IndPaiOcorrencia = 1 AND 
	      IdPaiOcorrencia = @IdProcessoModelo      

/*01.6-Fiscalização================================================================================================================================*/
/*ÚNICA ABA A NÃO SER GERADA POIS O TRABALHO SERIA O MESMO PARA GERAR UM NOVO PROCESSO - CAMPOS DINÂMICOS E NOVA FISCALIZAÇÃO POR PESSOA
* O ANDRÉ(REQUISITOS) ESTÁ CIENTE, POIS INFORMEI O MESMO DO TRABALHO. - SEILA EM 18/06/2014*/				
/*01.7-Vínculos====================================================================================================================================*/
INSERT INTO Processos_Documentos (IdProcesso,IdDocumento,IdProcessoFases,IdTramitacao)
	SELECT @IdProcessoNew,IdDocumento,IdProcessoFases,IdTramitacao
	FROM Processos_Documentos 
	WHERE IdProcesso = @IdProcessoModelo
	
		
INSERT INTO DigitalizacoesProcessos (IdProcesso,IdControleDigitalizacoes)
	SELECT @IdProcessoNew,IdControleDigitalizacoes
	FROM DigitalizacoesProcessos 
	WHERE IdProcesso = @IdProcessoModelo
	
/*A parte de PROCESSOS RELACIONADOS não é possível ser coletivo pois é atualizado o campo IdProcessoPrincipal 
  da tabela de processos sendo que o mesmo só pode estar vinculado a um único processo*/
  	  
/*01.8-Andamentos==================================================================================================================================*/
INSERT INTO Processo_Fases (IdFase,IdProfissional,IdProcesso,DataRef,DataFase,Nota,IdPena,DataInicio,DataFim,Deferido,IdUsuarioCriacao,
						    IdDepartamentoCriacao,IdFiscalizacao,IdPessoaJuridica,IdPessoa,NumeroPlenaria,VisualizarWeb,VisualizarNotaWeb,
						    IdAutoInfracao,MotivoAndamento,IdRespCorrespPessoa,IdRespCorrespPF,IdRespCorrespPJ,IdTramitacao,Numero_Plenaria,
						    DataPlenaria)
	SELECT IdFase,IdProfissional,IdProcesso = @IdProcessoNew,DataRef,DataFase,Nota,IdPena,DataInicio,DataFim,Deferido,IdUsuarioCriacao,
		   IdDepartamentoCriacao,IdFiscalizacao,IdPessoaJuridica,IdPessoa,NumeroPlenaria,VisualizarWeb,VisualizarNotaWeb,IdAutoInfracao,
		   MotivoAndamento,IdRespCorrespPessoa,IdRespCorrespPF,IdRespCorrespPJ,IdTramitacao,Numero_Plenaria,DataPlenaria 
	FROM Processo_Fases
	WHERE IdProcesso = @IdProcessoModelo 
		
/*01.9-AutosInfração===============================================================================================================================*/
INSERT INTO AutosInfracao (IdProcesso,IdDebitoInfracao,NumeroInfracao,DataInfracao,RelatoInfracao,IdFiscalizacao,IdProfissional,IdPessoaJuridica,
					       IdPessoa,HORA,DataUltimaAtualizacao,UsuarioUltimaAtualizacao,DepartamentoUltimaAtualizacao,Cancelado)
	SELECT @IdProcessoNew,IdDebitoInfracao,NumeroInfracao,DataInfracao,RelatoInfracao,IdFiscalizacao,@IdProfissional,@IdPessoaJuridica,
		   IdPessoa,HORA,DataUltimaAtualizacao,UsuarioUltimaAtualizacao,DepartamentoUltimaAtualizacao,Cancelado
	FROM AutosInfracao 
	WHERE IdProcesso = @IdProcessoModelo	

SELECT @IdAutoInfracao = SCOPE_IDENTITY()/*@IdAutoInfração para alimentar as 3 tabelas abaixo*/	                       

INSERT INTO AutosInfracao_Infringencias(IdAutoInfracao,IdInfringencia,Numero,data)
	SELECT @IdAutoInfracao,AU.IdInfringencia,AU.Numero,AU.data
	FROM AutosInfracao_Infringencias AU INNER JOIN 
		 AutosInfracao AI ON AI.IdAutoInfracao = AU.IdAutoInfracao  
	WHERE IdProcesso = @IdProcessoModelo		

INSERT INTO AutosInfracao_InstrucoesAutoInf (IdAutoInfracao,IdInstrucaoAutoInf,Numero,data)
	SELECT @IdAutoInfracao,AU.IdInstrucaoAutoInf,AU.Numero,AU.data
	FROM AutosInfracao_InstrucoesAutoInf AU INNER JOIN 
		 AutosInfracao AI ON AI.IdAutoInfracao = AU.IdAutoInfracao  
	WHERE IdProcesso = @IdProcessoModelo

INSERT INTO AutosInfracao_Sansoes(IdAutoInfracao,IdSansao,Numero,data)
	SELECT @IdAutoInfracao,AU.IdSansao,AU.Numero,AU.data
	FROM AutosInfracao_Sansoes AU INNER JOIN 
		 AutosInfracao AI ON AI.IdAutoInfracao = AU.IdAutoInfracao  
	WHERE IdProcesso = @IdProcessoModelo
	
INSERT INTO Ocorrencias	(IndPaiOcorrencia,IdPaiOcorrencia,DataOcorrencia,TextoOcorrencia,IdUsuarioCriacao,IdDepartamentoCriacao,
                         IdSituacaoOcorrencia,IdTramitacao)
	SELECT OC.IndPaiOcorrencia,@IdAutoInfracao,OC.DataOcorrencia,OC.TextoOcorrencia,OC.IdUsuarioCriacao,OC.IdDepartamentoCriacao,
		   OC.IdSituacaoOcorrencia,OC.IdTramitacao 
	FROM Ocorrencias OC INNER JOIN 
		 AutosInfracao AI ON AI.IdAutoInfracao = OC.IdPaiOcorrencia
	WHERE OC.IndPaiOcorrencia = 6 AND 
		  IdProcesso = @IdProcessoModelo  			  
			  
INSERT INTO Debitos(IdProfissional,IdPessoaJuridica,IdTipoDebito,IdSituacaoAtual,IdArquivoPagamento,IdAutoInfracao,IdMoeda,IdConfigGeracaoDebito,
                    NossoNumero,DataGeracao,DataVencimento,DataReferencia,DataRepasse,DataPgto,ValorDevido,ValorPago,NumeroParcela,PercentualRepasse,
                    DocumentoPgto,ContaCorrente,TpEmissaoConjunta,TpCompDespesas,NumConjReneg,NumConjTpDebito,NumConjEmissao,ObsDebito,CodBanco,
                    CodAgencia,CodOperacao,CodCC_Conv_Ced,Emitido,NumeroDocumento,IdTipoPagamento,DataAtualizacao,Desconto,IdFiscalizacao,IdPessoa,
                    IdMotivoCancelamento,DataDeposito,TipoDividaAtiva,RegistraLog,DataCredito,IdProcedimentoOperacional,DataUltimaAtualizacao,
                    UsuarioUltimaAtualizacao,DepartamentoUltimaAtualizacao,NPossuiCotaUnica,ExecTriggerNPossuiCotaUnica,IdDividaAtiva,GeracaoColetiva,
                    Bacalhau,UsuarioRen,DepartamentoRen,NumeroRenegociacao,AutorizaDebitoConta,SeuNumero,Acrescimos,E_Estagiario,
                    AtualizacaoWeb,PagoPorBaixaDebCancelado,IdDebitoOrigem,NumConjRenegHistorico,NumConjParcelasRen,CategoriaCriacao,InscricaoCriacao,
                    DataUltimoPgto,DataUltimoCredito,Recred)

	SELECT @IdProfissional,@IdPessoaJuridica,DB.IdTipoDebito,IdSituacaoAtual = 1,IdArquivoPagamento = NULL,@IdAutoInfracao,DB.IdMoeda,DB.IdConfigGeracaoDebito,
		   NossoNumero = NULL ,DB.DataGeracao,DB.DataVencimento,DB.DataReferencia,DataRepasse = NULL,DataPgto = NULL,DB.ValorDevido,ValorPago = NULL,
		   DB.NumeroParcela,DB.PercentualRepasse,DocumentoPgto = NULL,ContaCorrente = NULL,TpEmissaoConjunta = NULL,TpCompDespesas =NULL,NumConjReneg = NULL,
		   DB.NumConjTpDebito,NumConjEmissao = NULL,DB.ObsDebito,CodBanco = NULL,CodAgencia = NULL,CodOperacao = NULL,CodCC_Conv_Ced = NULL,Emitido = 0,
		   NumeroDocumento = NULL,IdTipoPagamento = NULL,DataAtualizacao = NULL,Desconto = NULL,DB.IdFiscalizacao,DB.IdPessoa,IdMotivoCancelamento = NULL,
		   DataDeposito = NULL,TipoDividaAtiva = NULL,DB.RegistraLog,DataCredito = NULL,IdProcedimentoOperacional = NULL,DB.DataUltimaAtualizacao,
		   DB.UsuarioUltimaAtualizacao,DB.DepartamentoUltimaAtualizacao,DB.NPossuiCotaUnica,DB.ExecTriggerNPossuiCotaUnica,IdDividaAtiva = NULL,
		   DB.GeracaoColetiva,DB.Bacalhau,UsuarioRen = NULL,DepartamentoRen = NULL,NumeroRenegociacao = NULL,DB.AutorizaDebitoConta,
		   SeuNumero = NULL,DB.Acrescimos,DB.E_Estagiario,DB.AtualizacaoWeb,PagoPorBaixaDebCancelado = NULL,IdDebitoOrigem = NULL,
		   NumConjRenegHistorico = NULL,NumConjParcelasRen = NULL,DB.CategoriaCriacao,DB.InscricaoCriacao,
		   DataUltimoPgto = NULL,DataUltimoCredito = NULL,DB.Recred 
	FROM Debitos DB INNER JOIN 
	     AutosInfracao AI ON AI.IdAutoInfracao = DB.IdAutoInfracao INNER JOIN 
	     TiposDebito TD ON TD.IdTipoDebito = DB.IdTipoDebito
	WHERE AI.IdProcesso = @IdProcessoModelo
    AND DB.IdSituacaoAtual NOT IN(6,14) /*Somente débitos NãoPago*/
    AND TD.ExclusivoProcesso = 1
	    
/*01.10-DébitosVinculados==========================================================================================================================*/
INSERT INTO Processo_Debitos (IdProcesso,IdDebito)
	SELECT @IdProcessoNew ,IdDebito 
	FROM DebitosDividaAtiva 
	WHERE IdDividaAtiva = @IdDividaAtiva
/*01.11-CustasProcessuais==========================================================================================================================*/
INSERT INTO CustasProcessuais (IdProcesso,IdTipoCusta,DataCadastro,Descricao,Valor,UsuarioCriacao)
	SELECT  IdProcesso = @IdProcessoNew,IdTipoCusta,DataCadastro,Descricao,Valor,UsuarioCriacao
	FROM CustasProcessuais
	WHERE IdProcesso = @IdProcessoModelo
			
/*01.12-Atualiza a Divida Ativa com o IdProcesso===================================================================================================*/
UPDATE DividaAtiva
SET IdProcesso = @IdProcessoNew
WHERE IdDividaAtiva = @IdDividaAtiva
/*=================================================================================================================================================*/
