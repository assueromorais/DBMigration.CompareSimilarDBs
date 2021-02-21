CREATE PROCEDURE [dbo].[sp_GeraRenegociacao_Avulsa] (@IdRenegociacao INT)
AS
-- Revisada em 10/11/2016 - 17.19 por Sergio
-- Revisada em 29/11/2016 - por  Wanderson

SET NOCOUNT ON

DECLARE @Mensagem VARCHAR(200), @Erro BIT

/*
*************************************************************

	VALIDAÇÃO DAS INFORMAÇÕES DA RENEGOCIAÇÃO AVULSA
**************************************************************
*/
SET @Erro=0

SET @Mensagem='Transação realizada com sucesso'

IF NOT EXISTS (SELECT 1
			   FROM dbo.Renegociacao_Avulsa_Origem T1 
			   WHERE IdRenegociacao=@IdRenegociacao)
BEGIN
	SET @Erro=1
	SET @Mensagem='Número Renegociação inexistente'
	GOTO FIM 
END

IF EXISTS (SELECT 1
			   FROM dbo.Renegociacao_Avulsa_Origem T1 
			   LEFT JOIN dbo.Renegociacao_Avulsa_Parcela_Renegociacao T2 ON T1.IdRenegociacao=T2.IdRenegociacao
			   WHERE T1.IdRenegociacao=@IdRenegociacao AND T2.IdRenegociacao IS NULL)
BEGIN
	SET @Erro=1
	SET @Mensagem='Renegociação sem parcelas geradas'
	GOTO FIM 
END

IF EXISTS (SELECT 1
			FROM dbo.Renegociacao_Avulsa_Origem T1 
				 LEFT JOIN dbo.Debitos T2 ON T1.IdDebitoOrigem=T2.IdDebito
			WHERE IdRenegociacao=@IdRenegociacao AND T2.IdDebito IS NULL)
BEGIN
	SET @Erro=1
	SET @Mensagem='Débito de origem não existe'
	GOTO FIM 
END
 
IF EXISTS (SELECT 1
			FROM dbo.Renegociacao_Avulsa_Origem T1 
				 INNER JOIN dbo.Debitos T2 ON T1.IdDebitoOrigem=T2.IdDebito
			WHERE IdRenegociacao=@IdRenegociacao AND IdSituacaoAtual IN (6,14))
BEGIN
	SET @Erro=1
	SET @Mensagem='Débito já renegociado'
	GOTO FIM 
END

DECLARE @TotalRenegociado Money, @TotalParcelas_CotaUnica Money, @TotaParcelas Money

SELECT @TotalRenegociado=SUM(ValorDevido+ValorAtualizacao+ValorMulta+ValorJuros)
FROM dbo.Renegociacao_Avulsa_Origem 
WHERE IdRenegociacao=@IdRenegociacao

SELECT 
@TotalParcelas_CotaUnica = SUM(Case When NumeroParcela=0 
                     then ROUND(ValorParcela+ValorDescontoParcela-DespAdvocaticias-CustasJudiciais-CustasPrevias,2)
                     else 0 end),
@TotaParcelas = SUM(Case When NumeroParcela > 0 
                     then ROUND(ValorParcela-ValorAcrescimoParcela+ValorDescontoParcela-DespAdvocaticias-CustasJudiciais-CustasPrevias,2)
                     else 0 end)    
FROM dbo.Renegociacao_Avulsa_Parcela_Renegociacao
WHERE IdRenegociacao=@IdRenegociacao


IF @TotalRenegociado <> @TotalParcelas_CotaUnica AND @TotalParcelas_CotaUnica > 0
BEGIN
	SET @Erro=1
	SET @Mensagem='Valor da parcela de cota única é menor que os débitos.'
	GOTO FIM 
END


IF @TotalRenegociado <> @TotaParcelas AND @TotaParcelas > 0
BEGIN
	SET @Erro=1
	SET @Mensagem='Valores das parcelas é diferente dos débitos.'
	GOTO FIM 
END

/*
*************************************************************
			INICIO DA ROTINA DE RENEGOCIAÇÃO AVULSA
**************************************************************
*/
BEGIN TRY  
	
-- DROP TABLE #Debitos_Renegociados_Origem
	CREATE TABLE #Debitos_Renegociados_Origem (
	IdDebito INT,
	IdTipoDebito INT,
	DataVencimento DATETIME,
	ValorTotalPrincipal MONEY,
	ValorTotalAtualizacao MONEY,		
	ValorTotalJuros MONEY,
	ValorTotalMulta MONEY,
	ValorTotalAcrescimo MONEY,
	QuotaUnica BIT,
	ValorTotalPrincipalDA MONEY,
	ValorTotalAtualizacaoDA MONEY,		
	ValorTotalJurosDA MONEY,
	ValorTotalMultaDA MONEY
	)

-- INICIO DA TRANSACAO DE 
   BEGIN TRAN RENEGOCIACAO
   
-- VERIFICA O DEBITO DE ORIGEM É A PARCELA = 0. EM CASO POSITIVO SERÁ EXCLUÍDA TODAS AS OUTRAS PARCELAS DO
-- CONJUNTO DE DÉBITOS

	IF EXISTS (SELECT 1
				FROM (SELECT T1.IdProfissional,T1.IdPessoaJuridica,T1.IdPessoa,IdTipoDebito,DataReferencia,NumConjTpDebito
					  FROM dbo.Renegociacao_Avulsa_Origem T1 INNER JOIN dbo.Debitos T2 ON T1.IdDebitoOrigem=T2.IdDebito
					  WHERE IdRenegociacao=@IdRenegociacao AND NumeroParcela=0) T3
					  INNER JOIN dbo.Debitos T4 ON ISNULL(T3.IdProfissional,0)=ISNULL(T4.IdProfissional,0) AND ISNULL(T3.IdPessoaJuridica,0)=ISNULL(T4.IdPessoaJuridica,0) AND ISNULL(T3.IdPessoa,0)=ISNULL(T4.IdPessoa,0) AND T3.DataReferencia=T4.DataReferencia
					  WHERE T3.IdTipoDebito=T4.IdTipoDebito AND NumeroParcela > 0 and T3.NumConjTpDebito=T4.NumConjTpDebito and IdSituacaoAtual IN (1,9))
	BEGIN
		SELECT DISTINCT T4.IdDebito
		INTO #Debito_a_excluir
		FROM (SELECT T1.IdProfissional,T1.IdPessoaJuridica,T1.IdPessoa,IdTipoDebito,DataReferencia,NumConjTpDebito
			  FROM dbo.Renegociacao_Avulsa_Origem T1 INNER JOIN dbo.Debitos T2 ON T1.IdDebitoOrigem=T2.IdDebito
			  WHERE IdRenegociacao=@IdRenegociacao AND NumeroParcela=0) T3
			  INNER JOIN dbo.Debitos T4 ON ISNULL(T3.IdProfissional,0)=ISNULL(T4.IdProfissional,0) AND ISNULL(T3.IdPessoaJuridica,0)=ISNULL(T4.IdPessoaJuridica,0) AND ISNULL(T3.IdPessoa,0)=ISNULL(T4.IdPessoa,0) AND T3.DataReferencia=T4.DataReferencia
			  WHERE T3.IdTipoDebito=T4.IdTipoDebito AND NumeroParcela > 0 and T3.NumConjTpDebito=T4.NumConjTpDebito and IdSituacaoAtual IN (1,9)

		DELETE T1
		FROM #Debito_a_excluir T1 INNER JOIN dbo.ComposicoesDebito T2 ON T1.IdDebito=T2.IdDebito
		
	
		DELETE T2
		FROM #Debito_a_excluir T1 INNER JOIN dbo.Debitos_SituacoesDebito T2 ON T1.IdDebito=T2.IdDebito
	
		DELETE T2
		FROM #Debito_a_excluir T1 INNER JOIN dbo.Debitos T2 ON T1.IdDebito=T2.IdDebito
		
	END		
		
	DECLARE @NumConjReneg INT
	
	SET @NumConjReneg=RIGHT(CONVERT (VARCHAR(4),YEAR(GETDATE())),2) + RIGHT('0' + CONVERT (VARCHAR(2),MONTH(GETDATE())),2) + RIGHT('0' + CONVERT (VARCHAR(2),DAY(GETDATE())),2)+
	                    RIGHT('0' + CONVERT (VARCHAR(4),DATEPART(HH,GETDATE())),2) + RIGHT('0' + CONVERT (VARCHAR(4),DATEPART(MI,GETDATE())),2)  
	
	
-- ATUALIZA DOS DEBITOS DE ORIGEM
	UPDATE T2 SET
	IdSituacaoAtual=CASE WHEN IdSituacaoAtual >=10 THEN 14 ELSE 6 END,
	NumConjReneg=@NumConjReneg,
	TpEmissaoConjunta = 0, 
	NumConjEmissao = 0, 
	TpCompDespesas = 0, 
	NossoNumero = NULL
	FROM dbo.Renegociacao_Avulsa_Origem T1 
		 INNER JOIN dbo.Debitos T2 ON T1.IdDebitoOrigem=T2.IdDebito
	WHERE IdRenegociacao=@IdRenegociacao

	INSERT INTO Debitos_SituacoesDebito ( IdDebito, IdSituacaoDebito, DataSituacao, UsuarioUltimaAtualizacao, DepartamentoUltimaAtualizacao )
    SELECT T2.IdDebito, T2.IdSituacaoAtual, GETDATE(), T1.UsuarioRen, T1.DepartamentoRen 
	FROM dbo.Renegociacao_Avulsa_Origem T1 
		 INNER JOIN dbo.Debitos T2 ON T1.IdDebitoOrigem=T2.IdDebito
	WHERE IdRenegociacao=@IdRenegociacao
    
-- CRIAÇÃO DOS DEBITOS DE RENEGOCIAÇÃO
	INSERT INTO dbo.Debitos(IdProfissional,IdPessoaJuridica,IdPessoa,IdTipoDebito,IdSituacaoAtual,IdMoeda,
	DataGeracao,DataVencimento,DataReferencia,ValorDevido,NumeroParcela,NumConjReneg,Emitido,
	DataAtualizacao,Desconto,NPossuiCotaUnica,
	ExecTriggerNPossuiCotaUnica,RegistraLog,UsuarioRen,DepartamentoRen,Acrescimos,AutorizaDebitoConta,
	DataPgto,ValorPago,IdTipoPagamento,DocumentoPgto,DataDeposito,DataCredito,/*NumeroAutorizacao,*/
	CodBanco,CodAgencia,CodOperacao,CodCC_Conv_Ced,Recred)
	SELECT DISTINCT 
	T1.IdProfissional,
	T1.IdPessoaJuridica,
	T1.IdPessoa,
	IdTipoDebito=2,
	IdSituacaoAtual=CASE WHEN IdTipoPagamento IS NULL THEN 1 ELSE 2 END,
	IdMoeda=1,
	DataGeracao=GETDATE(),
	DataVencimento=T2.DataVencimento,
	DataReferencia= CONVERT(DATETIME,CONVERT(VARCHAR(8), GETDATE(), 112)),-- CONVERT(DATETIME,CONVERT(CHAR(10),GETDATE(),101)),
	ValorDevido=T2.ValorParcela, 
	NumeroParcela=NumeroParcela,
	NumConjReneg=@NumConjReneg,
	Emitido=0,
	DataAtualizacao=DataRenegociacao,
	Desconto=ValorDescontoParcela,
	NPossuiCotaUnica=CASE WHEN EXISTS (SELECT 1 FROM dbo.Renegociacao_Avulsa_Parcela_Renegociacao WHERE IdRenegociacao=T1.IdRenegociacao AND NumeroParcela=0) THEN 0 ELSE 1 END,
	ExecTriggerNPossuiCotaUnica=1,
	RegistraLog=1,
	UsuarioRen=T1.UsuarioRen,
	DepartamentoRen=T1.DepartamentoRen,
	Acrescimos=ValorAcrescimoParcela,
	AutorizaDebitoConta=0,
	DataPgto = CASE WHEN IdTipoPagamento IS NULL THEN NULL ELSE CONVERT(DATETIME,CONVERT(VARCHAR(8), GETDATE(), 112)) END,  
	ValorPago = CASE WHEN IdTipoPagamento IS NULL THEN NULL ELSE T2.ValorParcela END,                                        
	IdTipoPagamento = IdTipoPagamento,                         
	DocumentoPgto = DocumentoPgto,                                                     
	DataDeposito = DataDeposito,                                                    
	DataCredito = DataCredito,                                                    
	/*NumeroAutorizacao = NumeroAutorizacao,*/
	CodBanco = CodBanco,                                                     
	CodAgencia = CodAgencia,                                                   
	CodOperacao = CodOperacao,                                                   
	CodCC_Conv_Ced = CodCC_Conv_Ced,Recred 
	FROM dbo.Renegociacao_Avulsa_Origem T1 
		 INNER JOIN dbo.Renegociacao_Avulsa_Parcela_Renegociacao T2 ON T1.IdRenegociacao=T2.IdRenegociacao
	WHERE T1.IdRenegociacao=@IdRenegociacao
	ORDER BY NumeroParcela

-- TRATAMENTO DAS DESPESAS ADVOCATICIAS, CUSTAS JUDICIAIS E CUSTAS PREVIAS
	DECLARE @DespAdvocaticias MONEY, @CustasJudiciais MONEY, @CustasPrevias MONEY,
			@IdTipoDebitoDespAdv SMALLINT, @IdTipoDebitoCustJud SMALLINT,@IdTipoDebitoCustPre SMALLINT,
			@IdProfissional INT, @IdPessoaJuridica INT, @IdPessoa INT, @DataRenegociacao DATETIME,
			@UsuarioRen VARCHAR(30), @DepartamentoRen VARCHAR(30), 	@IdTipoPagamento SMALLINT,
			@DataVencimento DATETIME, @DocumentoPgto VARCHAR(20), @DataDeposito  DATETIME,
			@DataCredito DATETIME, @NumeroAutorizacao VARCHAR(20), @CodBanco VARCHAR(3),
			@CodAgencia VARCHAR(3), @CodOperacao VARCHAR(3), @CodCC_Conv_Ced   VARCHAR(16),
			@IdDebitoOrigem INT, @IdDebitoOrigemDespAdvocaticias INT,@IdDebitoOrigemCustasJudiciais INT,
			@IdDebitoOrigemCustasPrevias INT, @IdDebitoOrigemAcrescimos INT
			 
	IF EXISTS (SELECT 1 FROM dbo.Renegociacao_Avulsa_Parcela_Renegociacao 
				WHERE IdRenegociacao=@IdRenegociacao AND NumeroParcela = 0)	  
	BEGIN
		SELECT @DespAdvocaticias=SUM(ISNULL(DespAdvocaticias,0)),  
			   @CustasJudiciais=SUM(ISNULL(CustasJudiciais,0)),
			   @CustasPrevias=SUM(ISNULL(CustasPrevias,0)) 
		FROM dbo.Renegociacao_Avulsa_Parcela_Renegociacao 
		WHERE IdRenegociacao=@IdRenegociacao AND NumeroParcela = 0
	END
	ELSE
	BEGIN
		SELECT @DespAdvocaticias=SUM(ISNULL(DespAdvocaticias,0)),  
			   @CustasJudiciais=SUM(ISNULL(CustasJudiciais,0)),
			   @CustasPrevias=SUM(ISNULL(CustasPrevias,0)) 
		FROM dbo.Renegociacao_Avulsa_Parcela_Renegociacao 
		WHERE IdRenegociacao=@IdRenegociacao AND NumeroParcela > 0
	END	

	IF @DespAdvocaticias > 0 OR @CustasJudiciais > 0 OR @CustasPrevias > 0
	BEGIN
		/* Vilson 30/06/2017 - Versão do projeto Darkside\Development não possui esses parâmetros  
		SELECT  @IdTipoDebitoDespAdv=IdTipoDebitoDespAdv ,
				@IdTipoDebitoCustJud=IdTipoDebitoCustJud, 
				@IdTipoDebitoCustPre=IdTipoDebitoCustPre
		FROM ParametrosSiscafw

		IF @IdTipoDebitoDespAdv IS NULL AND @DespAdvocaticias > 0 
		BEGIN
			SET @Erro=2
			SET @Mensagem='Parâmetro tipo débito despesas advocaticias não configurado'
			GOTO FIM 
		END

		IF @IdTipoDebitoCustJud IS NULL AND @CustasJudiciais > 0 
		BEGIN
			SET @Erro=2
			SET @Mensagem='Parâmetro tipo débito custas judiciais não configurado'
			GOTO FIM 
		END

		IF @IdTipoDebitoCustPre IS NULL AND @CustasPrevias > 0 
		BEGIN
			SET @Erro=2
			SET @Mensagem='Parâmetro tipo débito custas previas não configurado'
			GOTO FIM 
		END
		*/
						
		SELECT TOP 1
		@IdProfissional=IdProfissional,
		@IdPessoaJuridica=IdPessoaJuridica,
		@IdPessoa=IdPessoa, 
		@DataRenegociacao=DataRenegociacao,
		@UsuarioRen=UsuarioRen,
		@DepartamentoRen=DepartamentoRen 
		FROM  dbo.Renegociacao_Avulsa_Origem 
		WHERE IdRenegociacao=@IdRenegociacao 	
		
		SELECT TOP 1
			@DataVencimento=(SELECT MIN(DataVencimento) FROM  dbo.Renegociacao_Avulsa_Parcela_Renegociacao WHERE IdRenegociacao=@IdRenegociacao),
			@IdTipoPagamento=IdTipoPagamento,
			@DocumentoPgto = DocumentoPgto,                                                     
			@DataDeposito = DataDeposito,                                                    
			@DataCredito = DataCredito,                                                    
			@NumeroAutorizacao = NumeroAutorizacao,                                                    
			@CodBanco = CodBanco,                                                     
			@CodAgencia = CodAgencia,                                                   
			@CodOperacao = CodOperacao,                                               
			@CodCC_Conv_Ced = CodCC_Conv_Ced 
		FROM dbo.Renegociacao_Avulsa_Parcela_Renegociacao  
		WHERE IdRenegociacao=@IdRenegociacao 

	-- CRIAÇÃO DO DEBITO DE DESPESAS ADVOCATICIAS
		IF @DespAdvocaticias > 0 
		BEGIN
			INSERT INTO dbo.Debitos(IdProfissional,IdPessoaJuridica,IdPessoa,IdTipoDebito,IdSituacaoAtual,IdMoeda,
			DataGeracao,DataVencimento,DataReferencia,ValorDevido,NumeroParcela,NumConjReneg,Emitido,
			DataAtualizacao,Desconto,NPossuiCotaUnica,
			ExecTriggerNPossuiCotaUnica,RegistraLog,UsuarioRen,DepartamentoRen,Acrescimos,AutorizaDebitoConta,
			DataPgto,ValorPago,IdTipoPagamento,DocumentoPgto,DataDeposito,DataCredito,/*NumeroAutorizacao,*/
			CodBanco,CodAgencia,CodOperacao,CodCC_Conv_Ced)
			SELECT  
			@IdProfissional,
			@IdPessoaJuridica,
			@IdPessoa,
			IdTipoDebito=@IdTipoDebitoDespAdv,
			IdSituacaoAtual=6,
			IdMoeda=1,
			DataGeracao=GETDATE(),
			DataVencimento=@DataVencimento,
			DataReferencia= CONVERT(DATETIME,CONVERT(VARCHAR(8), GETDATE(), 112)),
			ValorDevido=@DespAdvocaticias,
			NumeroParcela=0,
			NumConjReneg=@NumConjReneg,
			Emitido=0,
			DataAtualizacao=@DataRenegociacao,
			Desconto=0,
			NPossuiCotaUnica=0,
			ExecTriggerNPossuiCotaUnica=1,
			RegistraLog=1,
			UsuarioRen=@UsuarioRen,
			DepartamentoRen=@DepartamentoRen,
			Acrescimos=0,
			AutorizaDebitoConta=0,
			DataPgto = NULL,  
			ValorPago = NULL,                                        
			IdTipoPagamento = NULL,                         
			DocumentoPgto = NULL,                                                     
			DataDeposito = NULL,                                                    
			DataCredito = NULL,                                                    
			/*NumeroAutorizacao = NULL, */
			CodBanco = NULL,                                                     
			CodAgencia = NULL,                                                   
			CodOperacao = NULL,                                                   
			CodCC_Conv_Ced = NULL 
		
			SET @IdDebitoOrigemDespAdvocaticias=SCOPE_IDENTITY() 
			
		END 
	
	-- CRIAÇÃO DO DEBITO DE CUSTAS JUDICIAIS 
		IF @CustasJudiciais > 0 
		BEGIN
			INSERT INTO dbo.Debitos(IdProfissional,IdPessoaJuridica,IdPessoa,IdTipoDebito,IdSituacaoAtual,IdMoeda,
			DataGeracao,DataVencimento,DataReferencia,ValorDevido,NumeroParcela,NumConjReneg,Emitido,
			DataAtualizacao,Desconto,NPossuiCotaUnica,
			ExecTriggerNPossuiCotaUnica,RegistraLog,UsuarioRen,DepartamentoRen,Acrescimos,AutorizaDebitoConta,
			DataPgto,ValorPago,IdTipoPagamento,DocumentoPgto,DataDeposito,DataCredito,/*NumeroAutorizacao,*/
			CodBanco,CodAgencia,CodOperacao,CodCC_Conv_Ced)
			SELECT  
			@IdProfissional,
			@IdPessoaJuridica,
			@IdPessoa,
			IdTipoDebito=@IdTipoDebitoCustJud,
			IdSituacaoAtual=6,
			IdMoeda=1,
			DataGeracao=GETDATE(),
			DataVencimento=@DataVencimento,
			DataReferencia=CONVERT(DATETIME,CONVERT(VARCHAR(8), GETDATE(), 112)) ,--CONVERT(DATETIME,CONVERT(CHAR(10),GETDATE(),101)),
			ValorDevido=@CustasJudiciais,
			NumeroParcela=0,
			NumConjReneg=@NumConjReneg,
			Emitido=0,
			DataAtualizacao=@DataRenegociacao,
			Desconto=0,
			NPossuiCotaUnica=0,
			ExecTriggerNPossuiCotaUnica=1,
			RegistraLog=1,
			UsuarioRen=@UsuarioRen,
			DepartamentoRen=@DepartamentoRen,
			Acrescimos=0,
			AutorizaDebitoConta=0,
			DataPgto = NULL,  
			ValorPago = NULL,                                        
			IdTipoPagamento = NULL,                         
			DocumentoPgto = NULL,                                                     
			DataDeposito = NULL,                                                    
			DataCredito = NULL,                                                    
			/*NumeroAutorizacao = NULL, */
			CodBanco = NULL,                                                     
			CodAgencia = NULL,                                                   
			CodOperacao = NULL,                                                   
			CodCC_Conv_Ced = NULL 
			
			SET @IdDebitoOrigemCustasJudiciais=SCOPE_IDENTITY() 
			
		END 
	
	-- CRIAÇÃO DO DEBITO DE CUSTAS PREVIAS
		IF @CustasPrevias > 0 
		BEGIN
			INSERT INTO dbo.Debitos(IdProfissional,IdPessoaJuridica,IdPessoa,IdTipoDebito,IdSituacaoAtual,IdMoeda,
			DataGeracao,DataVencimento,DataReferencia,ValorDevido,NumeroParcela,NumConjReneg,Emitido,
			DataAtualizacao,Desconto,NPossuiCotaUnica,
			ExecTriggerNPossuiCotaUnica,RegistraLog,UsuarioRen,DepartamentoRen,Acrescimos,AutorizaDebitoConta,
			DataPgto,ValorPago,IdTipoPagamento,DocumentoPgto,DataDeposito,DataCredito,/*NumeroAutorizacao,*/
			CodBanco,CodAgencia,CodOperacao,CodCC_Conv_Ced)
			SELECT  
			@IdProfissional,
			@IdPessoaJuridica,
			@IdPessoa,
			IdTipoDebito=@IdTipoDebitoCustPre,
			IdSituacaoAtual=6,
			IdMoeda=1,
			DataGeracao=GETDATE(),
			DataVencimento=@DataVencimento,
			DataReferencia=CONVERT(DATETIME,CONVERT(VARCHAR(8), GETDATE(), 112)),
			ValorDevido=@CustasPrevias,
			NumeroParcela=0,
			NumConjReneg=@NumConjReneg,
			Emitido=0,
			DataAtualizacao=@DataRenegociacao,
			Desconto=0,
			NPossuiCotaUnica=0,
			ExecTriggerNPossuiCotaUnica=1,
			RegistraLog=1,
			UsuarioRen=@UsuarioRen,
			DepartamentoRen=@DepartamentoRen,
			Acrescimos=0,
			AutorizaDebitoConta=0,
			DataPgto = NULL,  
			ValorPago = NULL,                                        
			IdTipoPagamento = NULL,                         
			DocumentoPgto = NULL,                                                     
			DataDeposito = NULL,                                                    
			DataCredito = NULL,                                                    
			/*NumeroAutorizacao = NULL, */
			CodBanco = NULL,                                                     
			CodAgencia = NULL,                                                   
			CodOperacao = NULL,                                                   
			CodCC_Conv_Ced = NULL  
		
			SET @IdDebitoOrigemCustasPrevias=SCOPE_IDENTITY() 
			
		END 
	END


-- INICIO DOS CALCULOS PARA INCLUSÃO DAS COMPOSIÇÕES DE RENEGOCIAÇÃO
	DECLARE @ValorTotalDesconto MONEY, @ValorTotalAcrescimo MONEY, @TotalDebitosRenegociados Money
	
-- INCLUSÃO DOS REGISTROS DOS DEBITOS DE ORIGEM DA PARCELA UNICA
	IF EXISTS (SELECT 1 FROM dbo.Renegociacao_Avulsa_Parcela_Renegociacao WHERE IdRenegociacao=@IdRenegociacao AND NumeroParcela=0)
	BEGIN
		SELECT @ValorTotalAcrescimo=SUM(ISNULL(ValorAcrescimoParcela,0))
		FROM dbo.Renegociacao_Avulsa_Parcela_Renegociacao
		WHERE IdRenegociacao=@IdRenegociacao AND NumeroParcela=0
	
		INSERT INTO #Debitos_Renegociados_Origem (IdDebito,IdTipoDebito,DataVencimento,ValorTotalPrincipal,
		ValorTotalAtualizacao,ValorTotalJuros,ValorTotalMulta,ValorTotalAcrescimo,QuotaUnica)
		SELECT  T1.IdDebitoOrigem,IdTipoDebito,DataVencimento,T1.ValorDevido,T1.ValorAtualizacao,
		T1.ValorJuros,T1.ValorMulta,@ValorTotalAcrescimo,1
		FROM dbo.Renegociacao_Avulsa_Origem T1 INNER JOIN  dbo.Debitos T2 ON T1.IdDebitoOrigem=T2.IdDebito
		WHERE IdRenegociacao=@IdRenegociacao
		ORDER BY IdTipoDebito,DataVencimento
	END

-- INCLUSÃO DOS REGISTROS DOS DEBITOS DE ORIGEM DAS DEMAIS PARCELAS
	IF EXISTS (SELECT 1 FROM dbo.Renegociacao_Avulsa_Parcela_Renegociacao WHERE IdRenegociacao=@IdRenegociacao AND NumeroParcela>0)
	BEGIN
		SELECT @ValorTotalAcrescimo=SUM(ISNULL(ValorAcrescimoParcela,0))
		FROM dbo.Renegociacao_Avulsa_Parcela_Renegociacao
		WHERE IdRenegociacao=@IdRenegociacao AND NumeroParcela > 0

		INSERT INTO #Debitos_Renegociados_Origem (IdDebito,IdTipoDebito,DataVencimento,ValorTotalPrincipal,
		ValorTotalAtualizacao,ValorTotalJuros,ValorTotalMulta,ValorTotalAcrescimo,QuotaUnica)
		SELECT  T1.IdDebitoOrigem,IdTipoDebito,DataVencimento,T1.ValorDevido,T1.ValorAtualizacao,
		T1.ValorJuros,T1.ValorMulta,@ValorTotalAcrescimo,0
		FROM dbo.Renegociacao_Avulsa_Origem T1 INNER JOIN  dbo.Debitos T2 ON T1.IdDebitoOrigem=T2.IdDebito
		WHERE IdRenegociacao=@IdRenegociacao
		ORDER BY IdTipoDebito,DataVencimento
	
	END

    UPDATE #Debitos_Renegociados_Origem SET
	ValorTotalPrincipalDA=ISNULL(T2.ValorPrincipal,0),
	ValorTotalAtualizacaoDA=ISNULL(T2.ValorAtualizacao,0),		
	ValorTotalJurosDA=ISNULL(T2.ValorJuros,0),
	ValorTotalMultaDA=ISNULL(T2.ValorMulta,0)
	FROM #Debitos_Renegociados_Origem T1 INNER JOIN dbo.DebitosDividaAtiva T2 ON T1.IdDebito=T2.IdDebito
	WHERE SituacaoDebito IN (1,3)
		
    UPDATE T4 SET
	ValorTotalPrincipalDA=ISNULL(ValorTotalPrincipalDA,0) - ISNULL(T3.ValorPagoDAPrincipal,0),
	ValorTotalAtualizacaoDA=ISNULL(ValorTotalAtualizacaoDA,0) - ISNULL(T3.ValorPagoDAAtualizacao,0),
	ValorTotalJurosDA=ISNULL(ValorTotalJurosDA,0) - ISNULL(ValorPagoDAJuros,0),
	ValorTotalMultaDA=ISNULL(ValorTotalMultaDA,0)- ISNULL(ValorPagoDAMulta,0)
	FROM (
		SELECT T1.IdDebito,QuotaUnica, 
		ValorPagoDAPrincipal=SUM(ISNULL(ValorPagoDAPrincipal,0)),
		ValorPagoDAAtualizacao=SUM(ISNULL(ValorPagoDAAtualizacao,0)),
		ValorPagoDAMulta=SUM(ISNULL(ValorPagoDAMulta,0)),
		ValorPagoDAJuros=SUM(ISNULL(ValorPagoDAJuros,0))
		FROM #Debitos_Renegociados_Origem T1 INNER JOIN dbo.ComposicoesDebito T2 ON T1.IdDebito=T2.IdDebito
		WHERE ISNULL(ValorTotalPrincipalDA,0) > 0 OR 	ISNULL(ValorTotalAtualizacaoDA,0) > 0 OR 
			  ISNULL(ValorTotalJurosDA,0) > 0 OR 	ISNULL(ValorTotalMultaDA,0) > 0
		GROUP BY T1.IdDebito,QuotaUnica) T3
		INNER JOIN #Debitos_Renegociados_Origem T4 ON T3.IdDebito=T4.IdDebito
	WHERE T3.QuotaUnica=T4.QuotaUnica
	
	
	DECLARE @IdDebito INT,@IdSituacaoAtual INT, @ValorDevidoRen MONEY,@NumeroParcelaRen SMALLINT, 
			@ValorDevidoParcela MONEY,@SaldoParcela MONEY,@ValorTotalOrigem MONEY,
			@ValorDevidoOrigem MONEY,@ValorAtualizacaoOrigem MONEY, @ValorMultaOrigem MONEY,
			@ValorJurosOrigem MONEY, @IdProcedimentoAtraso INT, @ValorEsperadoPrincipal MONEY,
			@ValorEsperadoAtualizacao MONEY,@ValorEsperadoMulta MONEY,@ValorEsperadoJuros MONEY,
			@ValorDescontoPrincipal  MONEY,@ValorEsperadoDAPrincipal  MONEY,@ValorEsperadoDAAtualizacao  MONEY,
			@ValorEsperadoDAJuros  MONEY, @ValorEsperadoDAMulta MONEY, @DescontoParcela MONEY, @AcrescimosParcela MONEY, @Saldo_Desconto Money ,
			@ValorDescontoJuros MONEY, @ValorDescontoMulta MONEY, @ValorDescontoAtualizacao MONEY,
			@QuotaUnica BIT,@ValorTotalPrincipalDA MONEY,@ValorTotalAtualizacaoDA MONEY,@ValorTotalJurosDA MONEY,
			@ValorTotalMultaDA MONEY,@UsuarioPagamento VARCHAR(30), @DepartamentoPagamento VARCHAR(60),
			@ValorPagoPrincipal MONEY,@ValorPagoAtualizacao MONEY,@ValorPagoMulta MONEY,@ValorPagoJuros MONEY,
			@ValorPagoDAPrincipal MONEY,@ValorPagoDAMulta MONEY,
			@ValorPagoDAAtualizacao MONEY,@ValorPagoDAJuros MONEY,@DataPgto DATETIME, 
			@ValorPago MONEY,@IdSituacaoDebito INT 

-- CRIAÇÃO DA TABELA TEMPORARIA COM OS DEBITOS DE RENEGOCIAÇÃO CRIADOS NO INICIO DA ROTINA
	SELECT DISTINCT IdDebito,NumeroParcela,T2.ValorDevido,T1.UsuarioRen,T1.DepartamentoRen
	INTO #Parcelas_Renegociacao
	FROM dbo.Renegociacao_Avulsa_Origem T1 INNER JOIN dbo.Debitos T2 ON ISNULL(T1.IdProfissional,0)=ISNULL(T2.IdProfissional,0) AND ISNULL(T1.IdPessoaJuridica,0)=ISNULL(T2.IdPessoaJuridica,0) AND ISNULL(T1.IdPessoa,0)=ISNULL(T2.IdPessoa,0) 
	WHERE IdRenegociacao=@IdRenegociacao AND IdTipoDebito=2 AND T2.NumConjReneg=@NumConjReneg   
-- CURSOR DE CRIAÇÃO DAS COMPOSIÇÕES DOS DEBITOS DE RENEGOCIAÇÃO        
	DECLARE Cursor_Renegociacao    
	CURSOR FAST_FORWARD FOR    
			SELECT IdDebito,NumeroParcela,ValorDevido,UsuarioRen,DepartamentoRen 
			FROM #Parcelas_Renegociacao
			ORDER BY NumeroParcela
			
	OPEN   Cursor_Renegociacao

	FETCH NEXT FROM Cursor_Renegociacao 
	INTO @IdDebito,@NumeroParcelaRen,@ValorDevidoParcela,@UsuarioRen,@DepartamentoRen 		

	WHILE @@FETCH_STATUS = 0    
	BEGIN  

		SET @QuotaUnica=CASE WHEN @NumeroParcelaRen=0 THEN 1 ELSE 0 END
		
		SELECT @AcrescimosParcela=ISNULL(ValorAcrescimoParcela,0),
		 @DescontoParcela=ISNULL(ValorDescontoParcela,0),
		       @IdProcedimentoAtraso=IdProcedimentoAtraso,
			   @IdTipoPagamento=IdTipoPagamento,
			   @DocumentoPgto=DocumentoPgto,
			   @DataDeposito=DataDeposito,
			   @DataCredito=DataCredito,
			   @NumeroAutorizacao=NumeroAutorizacao,
			   @CodBanco=CodBanco,
			   @CodAgencia=CodAgencia,
			   @CodOperacao=CodOperacao,
			   @CodCC_Conv_Ced=CodCC_Conv_Ced,
			   @DespAdvocaticias=ISNULL(DespAdvocaticias,0),
			   @CustasJudiciais=ISNULL(CustasJudiciais,0),
			   @CustasPrevias=ISNULL(CustasPrevias,0)
		FROM dbo.Renegociacao_Avulsa_Parcela_Renegociacao
		WHERE IdRenegociacao=@IdRenegociacao 
		      AND NumeroParcela=@NumeroParcelaRen
			
		SET @SaldoParcela=@ValorDevidoParcela-@AcrescimosParcela+@DescontoParcela-
		                  @DespAdvocaticias-@CustasJudiciais-@CustasPrevias

		WHILE @SaldoParcela > 0
		BEGIN
		
			 SELECT TOP 1 
			 @IdDebitoOrigem=IdDebito,
			 @ValorDevidoOrigem=ValorTotalPrincipal,
			 @ValorAtualizacaoOrigem=ValorTotalAtualizacao, 
			 @ValorMultaOrigem=ValorTotalMulta,
			 @ValorJurosOrigem=ValorTotalJuros, 
			 @ValorTotalDesconto=0,
			 @ValorTotalAcrescimo=ValorTotalAcrescimo,
			 @ValorTotalPrincipalDA=ISNULL(ValorTotalPrincipalDA,0),
			 @ValorTotalAtualizacaoDA=ISNULL(ValorTotalAtualizacaoDA,0),
			 @ValorTotalJurosDA=ISNULL(ValorTotalJurosDA,0),
			 @ValorTotalMultaDA=ISNULL(ValorTotalMultaDA,0)
		     FROM #Debitos_Renegociados_Origem
		     WHERE (ValorTotalPrincipal + ValorTotalAtualizacao + ValorTotalJuros + ValorTotalMulta) > 0 AND
		           QuotaUnica=@QuotaUnica
		     ORDER BY DataVencimento, IdTipoDebito

			SET @ValorTotalOrigem= @ValorDevidoOrigem+@ValorAtualizacaoOrigem+@ValorMultaOrigem+
			                       @ValorJurosOrigem
			
			--SELECT @NumeroParcelaRen, @ValorTotalOrigem, @SaldoParcela  
			--SELECT @IdDebitoOrigem,@ValorDevidoOrigem, @ValorAtualizacaoOrigem,@ValorMultaOrigem, @ValorJurosOrigem,@ValorTotalDesconto,@ValorTotalAcrescimo
			
			IF @SaldoParcela >=  @ValorTotalOrigem
			BEGIN
				SET @ValorEsperadoPrincipal=@ValorDevidoOrigem
				SET @ValorEsperadoAtualizacao=@ValorAtualizacaoOrigem
				SET @ValorEsperadoMulta=@ValorMultaOrigem
				SET @ValorEsperadoJuros=@ValorJurosOrigem
				SET @ValorEsperadoDAPrincipal=@ValorTotalPrincipalDA 
				SET @ValorEsperadoDAAtualizacao=@ValorTotalAtualizacaoDA   
				SET @ValorEsperadoDAJuros= @ValorTotalJurosDA  
				SET @ValorEsperadoDAMulta=@ValorTotalMultaDA 
				SET @SaldoParcela=@SaldoParcela - @ValorTotalOrigem
			END		
			ELSE
			BEGIN

				SET @ValorEsperadoPrincipal=ROUND(cast(@ValorDevidoOrigem as decimal(18,2)) * ( cast(@SaldoParcela as decimal(18,2)) /  cast(@ValorTotalOrigem as decimal(18,2)) ),2)
				SET @ValorEsperadoAtualizacao=ROUND (@ValorAtualizacaoOrigem * (@SaldoParcela/@ValorTotalOrigem),2)
				SET @ValorEsperadoMulta=ROUND (@ValorMultaOrigem * (@SaldoParcela/@ValorTotalOrigem),2)
				SET @ValorEsperadoJuros=ROUND (@ValorJurosOrigem * (@SaldoParcela/@ValorTotalOrigem),2)
				SET @ValorEsperadoDAPrincipal=ROUND (@ValorTotalPrincipalDA * (@SaldoParcela/@ValorTotalOrigem),2)
				SET @ValorEsperadoDAAtualizacao=ROUND (@ValorTotalAtualizacaoDA * (@SaldoParcela/@ValorTotalOrigem),2)  
				SET @ValorEsperadoDAJuros= ROUND (@ValorTotalJurosDA * (@SaldoParcela/@ValorTotalOrigem),2)  
				SET @ValorEsperadoDAMulta=ROUND (@ValorTotalMultaDA * (@SaldoParcela/@ValorTotalOrigem),2)
				
				IF (@ValorEsperadoPrincipal+@ValorEsperadoAtualizacao+@ValorEsperadoMulta+@ValorEsperadoJuros) <>
				    @SaldoParcela
				BEGIN
					SET @ValorEsperadoJuros=@ValorEsperadoJuros + (@SaldoParcela-(@ValorEsperadoPrincipal+@ValorEsperadoAtualizacao+@ValorEsperadoMulta+@ValorEsperadoJuros))
				END
				SET @SaldoParcela=0				 
			END	 


			UPDATE #Debitos_Renegociados_Origem SET
				ValorTotalPrincipal=ValorTotalPrincipal-@ValorEsperadoPrincipal,
				ValorTotalAtualizacao=ValorTotalAtualizacao-@ValorEsperadoAtualizacao, 
				ValorTotalMulta=ValorTotalMulta-@ValorEsperadoMulta,
				ValorTotalJuros=ValorTotalJuros-@ValorEsperadoJuros,
				--ValorTotalDesconto=ValorTotalDesconto-@ValorTotalDesconto,
				ValorTotalAcrescimo=ValorTotalAcrescimo-@ValorTotalAcrescimo,
				ValorTotalPrincipalDA=ValorTotalPrincipalDA-@ValorEsperadoDAPrincipal,
				ValorTotalAtualizacaoDA= ValorTotalAtualizacaoDA-@ValorEsperadoDAAtualizacao,
				ValorTotalJurosDA=ValorTotalJurosDA-@ValorEsperadoDAJuros,
				ValorTotalMultaDA=ValorTotalMultaDA-@ValorEsperadoDAMulta				
			FROM #Debitos_Renegociados_Origem  
			WHERE IdDebito=@IdDebitoOrigem AND
		           QuotaUnica=@QuotaUnica	
		           
			-- REALIZA OS PAGAMENTOS
			IF @IdTipoPagamento IS NOT NULL
			BEGIN
				SET @ValorPagoPrincipal=@ValorEsperadoPrincipal 
				SET @ValorPagoAtualizacao=@ValorEsperadoAtualizacao 
				SET @ValorPagoMulta=@ValorEsperadoMulta  
				SET @ValorPagoJuros=@ValorEsperadoJuros
				SET @ValorPagoDAPrincipal=@ValorEsperadoDAPrincipal 
				SET @ValorPagoDAMulta=@ValorEsperadoDAMulta 
				SET @ValorPagoDAAtualizacao=@ValorEsperadoDAAtualizacao 
				SET @ValorPagoDAJuros=@ValorEsperadoDAJuros 
				SET @DataPgto= CASE WHEN @IdTipoPagamento IS NULL THEN NULL ELSE CONVERT(DATETIME,CONVERT(VARCHAR(8), GETDATE(), 112)) END  
				SET @ValorPago= @ValorEsperadoPrincipal+@ValorEsperadoAtualizacao+@ValorEsperadoMulta+@ValorEsperadoJuros
				SET @IdSituacaoDebito=1
				SET @UsuarioPagamento=@UsuarioRen  
				SET @DepartamentoPagamento=@DepartamentoRen
			END
			
			--SELECT @IdDebitoOrigem,ValorEsperadoPrincipal=@ValorEsperadoPrincipal, ValorEsperadoMulta=@ValorEsperadoMulta,ValorEsperadoJuros=@ValorEsperadoJuros
			
			INSERT INTO dbo.ComposicoesDebito (IdDebito,IdProcedimentoAtraso,ValorEsperadoPrincipal,IdMoedaValorEsperado,
			ValorEsperadoAtualizacao,ValorEsperadoMulta,ValorEsperadoJuros,IdDebitoOrigemRen,RegistraLog,
			/*NumConjComposicao,*/ValorDescontoPrincipal,/*IdComposicaoEmissao,ValorDescontoJuros,*/
			/*ValorDescontoMulta,ValorDescontoConcedido,*/
			ValorEsperadoDAPrincipal,ValorEsperadoDAAtualizacao,ValorEsperadoDAJuros, ValorEsperadoDAMulta,
			 ValorPagoPrincipal,ValorPagoAtualizacao,ValorPagoMulta,ValorPagoJuros,ValorPagoDAPrincipal,ValorPagoDAMulta,
			 ValorPagoDAAtualizacao,ValorPagoDAJuros/*,DataPgto,DataCredito,ValorPago,CodCC_Conv_Ced,CodBanco,CodAgencia,*/
			 /*CodOperacao,IdSituacaoDebito,IdTipoPagamento,DataDeposito,NumeroAutorizacao,*/
			 /*UsuarioPagamento,DepartamentoPagamento,DocumentoPgto*/)
			VALUES (@IdDebito,@IdProcedimentoAtraso,@ValorEsperadoPrincipal,1,
			@ValorEsperadoAtualizacao,@ValorEsperadoMulta,@ValorEsperadoJuros,@IdDebitoOrigem,1,
			/*1,*/@ValorDescontoPrincipal,/*0,@ValorDescontoJuros,@ValorDescontoMulta,@ValorTotalDesconto,*/
			@ValorEsperadoDAPrincipal,@ValorEsperadoDAAtualizacao,@ValorEsperadoDAJuros, @ValorEsperadoDAMulta,
			@ValorPagoPrincipal,@ValorPagoAtualizacao,@ValorPagoMulta,@ValorPagoJuros,@ValorPagoDAPrincipal,@ValorPagoDAMulta,
			@ValorPagoDAAtualizacao,@ValorPagoDAJuros/*,@DataPgto,@DataCredito,@ValorPago,@CodCC_Conv_Ced,@CodBanco,@CodAgencia,*/
			/*@CodOperacao,@IdSituacaoDebito,@IdTipoPagamento,@DataDeposito,@NumeroAutorizacao,*/
			/*@UsuarioPagamento,@DepartamentoPagamento,@DocumentoPgto*/)


		--- TRATAMENTO DOS JUROS DE ACRESCIMOS DA PARCELA
			IF @AcrescimosParcela > 0
			BEGIN
				SET @ValorEsperadoPrincipal=0
				SET @ValorEsperadoAtualizacao=0
				SET @ValorEsperadoMulta=0
				SET @ValorEsperadoJuros=@AcrescimosParcela
				SET @IdDebitoOrigemAcrescimos=@IdDebito
				SET @ValorDescontoPrincipal=0
				SET @DescontoParcela=0 
				SET @ValorDescontoJuros=0 
				SET @ValorDescontoMulta=0
				SET @IdDebitoOrigemAcrescimos=NULL
				
				INSERT INTO dbo.ComposicoesDebito (IdDebito,IdProcedimentoAtraso,ValorEsperadoPrincipal,IdMoedaValorEsperado,
				ValorEsperadoAtualizacao,ValorEsperadoMulta,ValorEsperadoJuros,IdDebitoOrigemRen,RegistraLog/*,NumConjComposicao*/)
				VALUES (@IdDebito,@IdProcedimentoAtraso,@ValorEsperadoPrincipal,1,@ValorEsperadoAtualizacao,
				@ValorEsperadoMulta,@ValorEsperadoJuros,@IdDebitoOrigemAcrescimos,1/*,1*/)
				
				SET @AcrescimosParcela=0
			END
 
		--- TRATAMENTO DAS DESPESAS ADVOCATICIAS
			IF @DespAdvocaticias > 0
			BEGIN
				SET @ValorEsperadoPrincipal=@DespAdvocaticias
				SET @ValorEsperadoAtualizacao=0
				SET @ValorEsperadoMulta=0
				SET @ValorEsperadoJuros=0
				SET @ValorDescontoPrincipal=0
				SET @DescontoParcela=0 
				SET @ValorDescontoJuros=0 
				SET @ValorDescontoMulta=0

				-- REALIZA OS PAGAMENTOS
				IF @IdTipoPagamento IS NOT NULL
				BEGIN
					SET @ValorPagoPrincipal=@DespAdvocaticias 
					SET @ValorPagoAtualizacao=0 
					SET @ValorPagoMulta=0  
					SET @ValorPagoJuros=0
					SET @ValorPagoDAPrincipal=0 
					SET @ValorPagoDAMulta=0 
					SET @ValorPagoDAAtualizacao=0 
					SET @ValorPagoDAJuros=0 
					SET @DataPgto= CASE WHEN @IdTipoPagamento IS NULL THEN NULL ELSE CONVERT(DATETIME,CONVERT(VARCHAR(8), GETDATE(), 112)) END  
					SET @ValorPago= @ValorEsperadoPrincipal+@ValorEsperadoAtualizacao+@ValorEsperadoMulta+@ValorEsperadoJuros
					SET @IdSituacaoDebito=1
					SET @UsuarioPagamento=@UsuarioRen  
					SET @DepartamentoPagamento=@DepartamentoRen
				END
				ELSE
				BEGIN
					SET @ValorPagoPrincipal=0 
					SET @ValorPagoAtualizacao=0 
					SET @ValorPagoMulta=0  
					SET @ValorPagoJuros=0
					SET @ValorPagoDAPrincipal=0 
					SET @ValorPagoDAMulta=0 
					SET @ValorPagoDAAtualizacao=0 
					SET @ValorPagoDAJuros=0 
					SET @DataPgto= NULL
					SET @ValorPago= 0
					SET @IdSituacaoDebito=NULL
					SET @UsuarioPagamento=NULL  
					SET @DepartamentoPagamento=NULL				
				END
				
				INSERT INTO dbo.ComposicoesDebito (IdDebito,IdProcedimentoAtraso,ValorEsperadoPrincipal,IdMoedaValorEsperado,
				ValorEsperadoAtualizacao,ValorEsperadoMulta,ValorEsperadoJuros,IdDebitoOrigemRen,RegistraLog,
				/*NumConjComposicao,*/ValorDescontoPrincipal,/*IdComposicaoEmissao,ValorDescontoJuros,*/
				/*ValorDescontoMulta,ValorDescontoConcedido,*/
				 ValorPagoPrincipal,ValorPagoAtualizacao,ValorPagoMulta,ValorPagoJuros,ValorPagoDAPrincipal,ValorPagoDAMulta,
				 ValorPagoDAAtualizacao,ValorPagoDAJuros/*,DataPgto,DataCredito,ValorPago,CodCC_Conv_Ced,CodBanco,CodAgencia,*/
				 /*CodOperacao,IdSituacaoDebito,IdTipoPagamento,DataDeposito,NumeroAutorizacao,*/
				 /*UsuarioPagamento,DepartamentoPagamento,DocumentoPgto*/)
				VALUES (@IdDebito,@IdProcedimentoAtraso,@ValorEsperadoPrincipal,1,
				@ValorEsperadoAtualizacao,@ValorEsperadoMulta,@ValorEsperadoJuros,@IdDebitoOrigemDespAdvocaticias,1,
				/*1,*/@ValorDescontoPrincipal,/*0,@ValorDescontoJuros,@ValorDescontoMulta,@ValorTotalDesconto,*/
				@ValorPagoPrincipal,@ValorPagoAtualizacao,@ValorPagoMulta,@ValorPagoJuros,@ValorPagoDAPrincipal,@ValorPagoDAMulta,
				@ValorPagoDAAtualizacao,@ValorPagoDAJuros/*,@DataPgto,@DataCredito,@ValorPago,@CodCC_Conv_Ced,@CodBanco,@CodAgencia,*/
				/*@CodOperacao,@IdSituacaoDebito,@IdTipoPagamento,@DataDeposito,@NumeroAutorizacao,*/
				/*@UsuarioPagamento,@DepartamentoPagamento,@DocumentoPgto*/)
				
				SET @DespAdvocaticias=0
			END	
			--- TRATAMENTO DAS CUSTAS JUDICIAIS
			IF @CustasJudiciais > 0
			BEGIN
				SET @ValorEsperadoPrincipal=@CustasJudiciais
				SET @ValorEsperadoAtualizacao=0
				SET @ValorEsperadoMulta=0
				SET @ValorEsperadoJuros=0
				SET @ValorDescontoPrincipal=0
				SET @DescontoParcela=0 
				SET @ValorDescontoJuros=0 
				SET @ValorDescontoMulta=0

				-- REALIZA OS PAGAMENTOS
				IF @IdTipoPagamento IS NOT NULL
				BEGIN
					SET @ValorPagoPrincipal=@CustasJudiciais 
					SET @ValorPagoAtualizacao=0 
					SET @ValorPagoMulta=0  
					SET @ValorPagoJuros=0
					SET @ValorPagoDAPrincipal=0 
					SET @ValorPagoDAMulta=0 
					SET @ValorPagoDAAtualizacao=0 
					SET @ValorPagoDAJuros=0 
					SET @DataPgto= CASE WHEN @IdTipoPagamento IS NULL THEN NULL ELSE CONVERT(DATETIME,CONVERT(VARCHAR(8), GETDATE(), 112)) END  
					SET @ValorPago= @ValorEsperadoPrincipal+@ValorEsperadoAtualizacao+@ValorEsperadoMulta+@ValorEsperadoJuros
					SET @IdSituacaoDebito=1
					SET @UsuarioPagamento=@UsuarioRen  
					SET @DepartamentoPagamento=@DepartamentoRen
				END
				ELSE
				BEGIN
					SET @ValorPagoPrincipal=0 
					SET @ValorPagoAtualizacao=0 
					SET @ValorPagoMulta=0  
					SET @ValorPagoJuros=0
					SET @ValorPagoDAPrincipal=0 
					SET @ValorPagoDAMulta=0 
					SET @ValorPagoDAAtualizacao=0 
					SET @ValorPagoDAJuros=0 
					SET @DataPgto= NULL
					SET @ValorPago= 0
					SET @IdSituacaoDebito=NULL
					SET @UsuarioPagamento=NULL  
					SET @DepartamentoPagamento=NULL				
				END
				
				INSERT INTO dbo.ComposicoesDebito (IdDebito,IdProcedimentoAtraso,ValorEsperadoPrincipal,IdMoedaValorEsperado,
				ValorEsperadoAtualizacao,ValorEsperadoMulta,ValorEsperadoJuros,IdDebitoOrigemRen,RegistraLog,
				/*NumConjComposicao,*/ValorDescontoPrincipal,/*IdComposicaoEmissao,ValorDescontoJuros,*/
				/*ValorDescontoMulta,ValorDescontoConcedido,*/
				 ValorPagoPrincipal,ValorPagoAtualizacao,ValorPagoMulta,ValorPagoJuros,ValorPagoDAPrincipal,ValorPagoDAMulta,
				 ValorPagoDAAtualizacao,ValorPagoDAJuros/*,DataPgto,DataCredito,ValorPago,CodCC_Conv_Ced,CodBanco,CodAgencia,*/
				 /*CodOperacao,IdSituacaoDebito,IdTipoPagamento,DataDeposito,NumeroAutorizacao,*/
				 /*UsuarioPagamento,DepartamentoPagamento,DocumentoPgto*/)
				VALUES (@IdDebito,@IdProcedimentoAtraso,@ValorEsperadoPrincipal,1,
				@ValorEsperadoAtualizacao,@ValorEsperadoMulta,@ValorEsperadoJuros,@IdDebitoOrigemCustasJudiciais,1,
				/*1,*/@ValorDescontoPrincipal,/*0,@ValorDescontoJuros,@ValorDescontoMulta,@ValorTotalDesconto,*/
				@ValorPagoPrincipal,@ValorPagoAtualizacao,@ValorPagoMulta,@ValorPagoJuros,@ValorPagoDAPrincipal,@ValorPagoDAMulta,
				@ValorPagoDAAtualizacao,@ValorPagoDAJuros/*,@DataPgto,@DataCredito,@ValorPago,@CodCC_Conv_Ced,@CodBanco,@CodAgencia,*/
				/*@CodOperacao,@IdSituacaoDebito,@IdTipoPagamento,@DataDeposito,@NumeroAutorizacao,*/
				/*@UsuarioPagamento,@DepartamentoPagamento,@DocumentoPgto*/)
				
				SET @CustasJudiciais=0
			 
			END					
			--- TRATAMENTO DAS CUSTAS PREVIAS
			
			IF @CustasPrevias > 0
			BEGIN
				SET @ValorEsperadoPrincipal=@CustasPrevias
				SET @ValorEsperadoAtualizacao=0
				SET @ValorEsperadoMulta=0
				SET @ValorEsperadoJuros=0
				SET @ValorDescontoPrincipal=0
				SET @DescontoParcela=0 
				SET @ValorDescontoJuros=0 
				SET @ValorDescontoMulta=0

				-- REALIZA OS PAGAMENTOS
				IF @IdTipoPagamento IS NOT NULL
				BEGIN
					SET @ValorPagoPrincipal=@CustasPrevias 
					SET @ValorPagoAtualizacao=0 
					SET @ValorPagoMulta=0  
					SET @ValorPagoJuros=0
					SET @ValorPagoDAPrincipal=0 
					SET @ValorPagoDAMulta=0 
					SET @ValorPagoDAAtualizacao=0 
					SET @ValorPagoDAJuros=0 
					SET @DataPgto= CASE WHEN @IdTipoPagamento IS NULL THEN NULL ELSE CONVERT(DATETIME,CONVERT(VARCHAR(8), GETDATE(), 112)) END  
					SET @ValorPago= @ValorEsperadoPrincipal+@ValorEsperadoAtualizacao+@ValorEsperadoMulta+@ValorEsperadoJuros
					SET @IdSituacaoDebito=1
					SET @UsuarioPagamento=@UsuarioRen  
					SET @DepartamentoPagamento=@DepartamentoRen
				END
				ELSE
				BEGIN
					SET @ValorPagoPrincipal=0 
					SET @ValorPagoAtualizacao=0 
					SET @ValorPagoMulta=0  
					SET @ValorPagoJuros=0
					SET @ValorPagoDAPrincipal=0 
					SET @ValorPagoDAMulta=0 
					SET @ValorPagoDAAtualizacao=0 
					SET @ValorPagoDAJuros=0 
					SET @DataPgto= NULL
					SET @ValorPago= 0
					SET @IdSituacaoDebito=NULL
					SET @UsuarioPagamento=NULL  
					SET @DepartamentoPagamento=NULL				
				END
				
				INSERT INTO dbo.ComposicoesDebito (IdDebito,IdProcedimentoAtraso,ValorEsperadoPrincipal,IdMoedaValorEsperado,
				ValorEsperadoAtualizacao,ValorEsperadoMulta,ValorEsperadoJuros,IdDebitoOrigemRen,RegistraLog,
				/*NumConjComposicao,*/ValorDescontoPrincipal,/*IdComposicaoEmissao,ValorDescontoJuros,*/
				/*ValorDescontoMulta,ValorDescontoConcedido,*/
				 ValorPagoPrincipal,ValorPagoAtualizacao,ValorPagoMulta,ValorPagoJuros,ValorPagoDAPrincipal,ValorPagoDAMulta,
				 ValorPagoDAAtualizacao,ValorPagoDAJuros/*,DataPgto,DataCredito,ValorPago,CodCC_Conv_Ced,CodBanco,CodAgencia,*/
				 /*CodOperacao,IdSituacaoDebito,IdTipoPagamento,DataDeposito,NumeroAutorizacao,*/
				 /*UsuarioPagamento,DepartamentoPagamento,DocumentoPgto*/)
				VALUES (@IdDebito,@IdProcedimentoAtraso,@ValorEsperadoPrincipal,1,
				@ValorEsperadoAtualizacao,@ValorEsperadoMulta,@ValorEsperadoJuros,@IdDebitoOrigemCustasPrevias,1,
				/*1,*/@ValorDescontoPrincipal,/*0,@ValorDescontoJuros,@ValorDescontoMulta,@ValorTotalDesconto,*/
				@ValorPagoPrincipal,@ValorPagoAtualizacao,@ValorPagoMulta,@ValorPagoJuros,@ValorPagoDAPrincipal,@ValorPagoDAMulta,
				@ValorPagoDAAtualizacao,@ValorPagoDAJuros/*,@DataPgto,@DataCredito,@ValorPago,@CodCC_Conv_Ced,@CodBanco,@CodAgencia,*/
				/*@CodOperacao,@IdSituacaoDebito,@IdTipoPagamento,@DataDeposito,@NumeroAutorizacao,*/
				/*@DepartamentoPagamento,@DepartamentoPagamento,@DocumentoPgto*/)
				
			   SET @CustasPrevias=0
			END					
		END	
			
		FETCH NEXT FROM Cursor_Renegociacao 
		INTO @IdDebito,@NumeroParcelaRen,@ValorDevidoParcela,@UsuarioRen,@DepartamentoRen 					
	END
	   
	CLOSE   Cursor_Renegociacao    
	DEALLOCATE   Cursor_Renegociacao  

-- FIM DO CURSOR DE CRIAÇÃO DAS COMPOSIÇÕES DOS DEBITOS DE RENEGOCIAÇÃO    

-- CRIAÇÃO DA TABELA TEMPORARIA COM OS DESCONTOS PARA CADA COMPOSIÇÃO
 	
	CREATE TABLE #Valor_Desconto (
	IdComposicaoDebito INT,
	ValorDesconto Money,
	ValorEsperadoPrincipal Money,
	ValorEsperadoAtualizacao Money,
	ValorEsperadoMulta Money,
	ValorEsperadoJuros Money,
	ValorEsperadoTotal Money
	)
	

	SET @IdTipoDebitoDespAdv=ISNULL(@IdTipoDebitoDespAdv,0)
	SET @IdTipoDebitoCustJud=ISNULL(@IdTipoDebitoCustJud,0)
	SET @IdTipoDebitoCustPre=ISNULL(@IdTipoDebitoCustPre,0)
	
	SELECT T1.IdDebito, ValorEsperadoTotal=SUM(isnull(t3.ValorEsperadoPrincipal,0)+isnull(ValorEsperadoAtualizacao,0)+isnull(ValorEsperadoMulta,0)+isnull(ValorEsperadoJuros,0))
	INTO #Somatorio_valores_esperados
	FROM #Parcelas_Renegociacao T1 
		 INNER JOIN Debitos T2 ON T1.IdDebito=T2.IdDebito
		 INNER JOIN  dbo.ComposicoesDebito T3 ON T1.IdDebito=T3.IdDebito 
		 INNER JOIN Debitos T4 ON T3.IdDebitoOrigemRen=T4.IdDebito 
	WHERE T2.Desconto > 0 and T4.IdTipoDebito NOT IN (@IdTipoDebitoDespAdv,@IdTipoDebitoCustJud,@IdTipoDebitoCustPre)
    GROUP BY T1.IdDebito
	
	INSERT INTO #Valor_Desconto (IdComposicaoDebito,ValorDesconto,ValorEsperadoPrincipal,ValorEsperadoAtualizacao,ValorEsperadoMulta,ValorEsperadoJuros,ValorEsperadoTotal)
	SELECT IdComposicaoDebito, 
	ValorDesconto=ROUND(T2.Desconto *
	              ((t3.ValorEsperadoPrincipal+ValorEsperadoAtualizacao+ValorEsperadoMulta+ValorEsperadoJuros)/
	               ValorEsperadoTotal),2),
	ValorEsperadoPrincipal,ValorEsperadoAtualizacao,ValorEsperadoMulta,ValorEsperadoJuros,ValorEsperadoTotal
	FROM #Parcelas_Renegociacao T1 
		 INNER JOIN Debitos T2 ON T1.IdDebito=T2.IdDebito
		 INNER JOIN  dbo.ComposicoesDebito T3 ON T1.IdDebito=T3.IdDebito 
		 INNER JOIN Debitos T4 ON T3.IdDebitoOrigemRen=T4.IdDebito 
		 INNER JOIN #Somatorio_valores_esperados T5 ON T1.IdDebito=T5.IdDebito 
	WHERE T2.Desconto > 0 AND T4.IdTipoDebito NOT IN (@IdTipoDebitoDespAdv,@IdTipoDebitoCustJud,@IdTipoDebitoCustPre)
 
	DECLARE @IdComposicaoDebito INT, @ValorDesconto MONEY

-- CURSOR PARA APLICAÇÃO DOS DESCONTOS NAS COMPOSIÇÕES   
			
	DECLARE Cursor_Descontos    
	CURSOR FAST_FORWARD FOR    
			SELECT IdComposicaoDebito,ValorDesconto,ValorEsperadoPrincipal,ValorEsperadoAtualizacao,
			       ValorEsperadoMulta,ValorEsperadoJuros
			FROM #Valor_Desconto
			ORDER BY IdComposicaoDebito  
			
	OPEN   Cursor_Descontos

	FETCH NEXT FROM Cursor_Descontos INTO @IdComposicaoDebito, @ValorDesconto,
	@ValorEsperadoPrincipal,@ValorEsperadoAtualizacao,@ValorEsperadoMulta,@ValorEsperadoJuros		

	WHILE @@FETCH_STATUS = 0    
	BEGIN  
		 
		SET @Saldo_Desconto= @ValorDesconto
		SET @ValorDescontoJuros=0
		SET @ValorDescontoPrincipal=0
		SET @ValorDescontoMulta=0
		SET @ValorDescontoAtualizacao=0
		
		IF @Saldo_Desconto <= @ValorEsperadoJuros  
		BEGIN
			SET @ValorEsperadoJuros=@ValorEsperadoJuros - @Saldo_Desconto
			SET @ValorDescontoJuros = @Saldo_Desconto
			SET @Saldo_Desconto=0
		END
		ELSE
		BEGIN
			SET @ValorDescontoJuros = @ValorEsperadoJuros
			SET @Saldo_Desconto = @Saldo_Desconto - @ValorEsperadoJuros
			SET @ValorEsperadoJuros=0
		END
		
		IF @Saldo_Desconto > 0 AND @ValorEsperadoMulta > 0 
		BEGIN
			IF @Saldo_Desconto <= @ValorEsperadoMulta
			BEGIN
				SET @ValorEsperadoMulta= @ValorEsperadoMulta - @Saldo_Desconto
				SET @ValorDescontoMulta=@Saldo_Desconto
				SET @Saldo_Desconto=0			
			END
			ELSE
			BEGIN
				SET @ValorDescontoMulta=@ValorEsperadoMulta
				SET @Saldo_Desconto = @Saldo_Desconto - @ValorEsperadoMulta
				SET @ValorEsperadoMulta=0
			END			
		END

		IF @Saldo_Desconto > 0 AND @ValorEsperadoAtualizacao > 0 
		BEGIN
			IF @Saldo_Desconto <= @ValorEsperadoAtualizacao
			BEGIN
				SET @ValorEsperadoAtualizacao= @ValorEsperadoAtualizacao - @Saldo_Desconto
				SET @ValorDescontoAtualizacao=@Saldo_Desconto
				SET @Saldo_Desconto=0			
			END
			ELSE
			BEGIN
				SET @ValorDescontoAtualizacao=@ValorEsperadoAtualizacao
				SET @Saldo_Desconto = @Saldo_Desconto - @ValorEsperadoAtualizacao
				SET @ValorEsperadoAtualizacao=0
			END			
		END				
		
		IF @Saldo_Desconto > 0 AND @ValorEsperadoPrincipal > 0 AND 
		   @Saldo_Desconto <= @ValorEsperadoPrincipal
		BEGIN
			SET @ValorDescontoPrincipal = @Saldo_Desconto
			SET @ValorEsperadoPrincipal= @ValorEsperadoPrincipal - @Saldo_Desconto
			SET @Saldo_Desconto=0			
		END

		UPDATE dbo.ComposicoesDebito SET
		ValorEsperadoPrincipal=@ValorEsperadoPrincipal,
		ValorEsperadoAtualizacao=@ValorEsperadoAtualizacao,
		ValorEsperadoMulta=@ValorEsperadoMulta,
		ValorEsperadoJuros=@ValorEsperadoJuros,
		/*ValorDescontoJuros=@ValorDescontoJuros,*/
		ValorDescontoPrincipal=@ValorDescontoPrincipal
		/*,ValorDescontoMulta=@ValorDescontoMulta*/
		/*,ValorDescontoConcedido=ISNULL(@ValorDescontoJuros,0)+ISNULL(@ValorDescontoPrincipal,0)+ISNULL(@ValorDescontoMulta,0)+ISNULL(@ValorDescontoAtualizacao,0)*/
		FROM dbo.ComposicoesDebito
		WHERE IdComposicaoDebito=@IdComposicaoDebito
		
		FETCH NEXT FROM Cursor_Descontos INTO @IdComposicaoDebito, @ValorDesconto,
		@ValorEsperadoPrincipal,@ValorEsperadoAtualizacao,@ValorEsperadoMulta,@ValorEsperadoJuros			
			
	END
	   
	CLOSE   Cursor_Descontos    
	DEALLOCATE   Cursor_Descontos
-- FIM DO CURSOR PARA APLICAÇÃO DOS DESCONTOS NAS COMPOSIÇÕES        	

-- AJUSTA OS VALORES ESPERADO DE PRINCIPAL COM O VALOR DO DÉBITO DEVIDO NA ORIGEM
 
	SELECT T3.IdDebitoOrigemRen, ValorEsperadoPrincipal_Ajuste=ValorDevido - TotalEsperadoPrincipal
	INTO #Tab_Ajuste_Principal
	FROM (	      
			SELECT IdDebitoOrigemRen, TotalEsperadoPrincipal=SUM(ISNULL(ValorEsperadoPrincipal,0)+ISNULL(ValorDescontoPrincipal,0))
			FROM #Parcelas_Renegociacao T1 
			     INNER JOIN  dbo.ComposicoesDebito T2 ON T1.IdDebito=T2.IdDebito
			WHERE T1.NumeroParcela > 0  
			GROUP BY IdDebitoOrigemRen) T3
		 INNER JOIN dbo.Renegociacao_Avulsa_Origem  T4 ON T3.IdDebitoOrigemRen=T4.IdDebitoOrigem
	WHERE IdRenegociacao=@IdRenegociacao 
	     AND ValorDevido - TotalEsperadoPrincipal <> 0  

    --SELECT * FROM #Tab_Ajuste_Principal

	UPDATE T5 SET
	ValorEsperadoPrincipal=ValorEsperadoPrincipal + ValorEsperadoPrincipal_Ajuste
	FROM (
			SELECT IdComposicaoDebito=MAX(IdComposicaoDebito)
			FROM #Parcelas_Renegociacao T1 INNER JOIN  dbo.ComposicoesDebito T2 ON T1.IdDebito=T2.IdDebito
				 INNER JOIN #Tab_Ajuste_Principal T3 ON T2.IdDebitoOrigemRen=T3.IdDebitoOrigemRen) T4
		 INNER JOIN dbo.ComposicoesDebito T5 ON T4.IdComposicaoDebito=T5.IdComposicaoDebito
		 INNER JOIN #Tab_Ajuste_Principal T6 ON T5.IdDebitoOrigemRen=T6.IdDebitoOrigemRen 

 
-- AJUSTA OS VALORES ESPERADO COM O VALOR DO DÉBITO DEVIDO  

		SELECT T3.IdDebito, ValorDevido_Ajuste=T4.ValorDevido - TotalDevidoCalculado
		INTO #Tab_Ajuste_Valor_Devido
		FROM (
			SELECT T1.IdDebito, TotalDevidoCalculado=SUM(ValorEsperadoPrincipal + ValorEsperadoAtualizacao + ValorEsperadoMulta + ValorEsperadoJuros)
			FROM #Parcelas_Renegociacao T1 
				 INNER JOIN  dbo.ComposicoesDebito T2 ON T1.IdDebito=T2.IdDebito
			GROUP BY T1.IdDebito) T3
			INNER JOIN Debitos T4 ON T3.IdDebito=T4.IdDebito	
		WHERE T4.ValorDevido <> TotalDevidoCalculado
 		
	UPDATE T5 SET
	ValorEsperadoJuros=CASE 
	                        WHEN ValorEsperadoJuros >= ValorDevido_Ajuste AND ValorEsperadoJuros > 0 AND ValorDevido_Ajuste > 0 THEN ValorEsperadoJuros - ValorDevido_Ajuste 
	                        WHEN ValorEsperadoJuros >= ValorDevido_Ajuste AND ValorEsperadoJuros > 0 AND ValorDevido_Ajuste < 0 THEN ValorEsperadoJuros + ValorDevido_Ajuste 
	                        ELSE ValorEsperadoJuros END,
	ValorEsperadoPrincipal=CASE 
							WHEN ValorEsperadoJuros < ValorDevido_Ajuste AND ValorDevido_Ajuste > 0 THEN ValorEsperadoPrincipal - ValorDevido_Ajuste 
							WHEN ValorEsperadoJuros < ValorDevido_Ajuste AND ValorDevido_Ajuste < 0 THEN ValorEsperadoPrincipal + ValorDevido_Ajuste 
							WHEN ValorEsperadoJuros < ValorDevido_Ajuste THEN ValorEsperadoPrincipal - ValorDevido_Ajuste 
	                        ELSE ValorEsperadoPrincipal END 	
	FROM (
			SELECT IdComposicaoDebito=MAX(IdComposicaoDebito)
			FROM #Tab_Ajuste_Valor_Devido T1 INNER JOIN  dbo.ComposicoesDebito T2 ON T1.IdDebito=T2.IdDebito) T4
		 INNER JOIN dbo.ComposicoesDebito T5 ON T4.IdComposicaoDebito=T5.IdComposicaoDebito
		 INNER JOIN #Tab_Ajuste_Valor_Devido T6 ON T5.IdDebito=T6.IdDebito 

	-- VERIFICA SE EXISTE ALGUM VALOR NEGATIVO APÓS OS CALCULOS. ESSE CASO TODO O PROCESSO SERÁ DESFEITO.
			         
	IF EXISTS (SELECT 1
			   FROM #Parcelas_Renegociacao T1 
				     INNER JOIN  dbo.ComposicoesDebito T2 ON T1.IdDebito=T2.IdDebito
			   WHERE ValorEsperadoPrincipal < 0 OR 
			         ValorEsperadoAtualizacao < 0 OR 
			         ValorEsperadoMulta < 0 OR 
			         ValorEsperadoJuros < 0)
	BEGIN
		ROLLBACK TRAN RENEGOCIACAO
		SET @Erro=1
		SET @Mensagem='Transação desfeita. Existem valores negativo.'
		GOTO FIM		
	END		     
 
	COMMIT TRAN RENEGOCIACAO

END TRY 
-- ROTINA QUE CAPTURA OS ERROS DE SQL NA EXECUÇÃO DA PROCEDURE. ESTÁ ASSOCIADO AO PARAGRAFO BEGIN TRY .. END TRY
BEGIN CATCH  
	ROLLBACK TRAN RENEGOCIACAO
	SET @Erro=1
  	SET @Mensagem='Erro na execução da rotina. Entre em contato com a Implanta.' + CHAR(10) + 
  					ERROR_MESSAGE ( ) 
  	GOTO FIM
END CATCH;

-- EXCLUI OS REGISTROS DE RENEGOCIAÇÕES JÁ REALIZADAS
DELETE T2
FROM dbo.Renegociacao_Avulsa_Origem T1 
	 INNER JOIN dbo.Renegociacao_Avulsa_Parcela_Renegociacao T2 ON T1.IdRenegociacao=T2.IdRenegociacao
WHERE DATEDIFF (D,DataRenegociacao,GETDATE()) > 3

DELETE T2
FROM dbo.Renegociacao_Avulsa_Origem T1 
	 RIGHT JOIN dbo.Renegociacao_Avulsa_Parcela_Renegociacao T2 ON T1.IdRenegociacao=T2.IdRenegociacao
WHERE T1.IdRenegociacao IS NULL

DELETE 
FROM dbo.Renegociacao_Avulsa_Origem
WHERE DATEDIFF (D,DataRenegociacao,GETDATE()) > 3
 
--Finalização da rotina
FIM:

IF @Erro=2
BEGIN
	ROLLBACK TRAN RENEGOCIACAO
END
SELECT CodErro=@Erro, Mensagem=@Mensagem, NumConjReneg=@NumConjReneg