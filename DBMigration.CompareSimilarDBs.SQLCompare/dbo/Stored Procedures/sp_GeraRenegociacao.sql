/*Oc. 132754 Task 1630 Claudio Adicionado por Rafaela*/
CREATE PROCEDURE [dbo].[sp_GeraRenegociacao]
@IdConfiguracao varchar(8),
@TextoSql varchar(8000), 
@JurosMulta bit = 0,
@lAtualiza bit = 1,
@Profissional INT = 1,
@DataGeracao varchar(30)
AS
BEGIN

	SET NOCOUNT ON
	SET XACT_ABORT ON 
	/**************************************************************************************************************
	 VALIDAÇÃO INICIAL DOS PARAMETROS  DA PROCEDURE
	***************************************************************************************************************/
	/*Oc132475 - Garante a transação*/
	
	BEGIN TRY 
		IF RTRIM(LTRIM(ISNULL(@IdConfiguracao,''))) = '' 
		  BEGIN
			RAISERROR ('O parâmetro obrigatório @IdConfiguracao não foi preenchido',10,1)
			RETURN 5000
		  END

		IF RTRIM(LTRIM(ISNULL(@TextoSql,''))) = ''
		  BEGIN
			RAISERROR ('O parâmetro obrigatório @TextoSql não foi preenchido',10,1)
			RETURN 5000
		  END

		IF RTRIM(LTRIM(ISNULL(@DataGeracao,''))) = ''
		  BEGIN
			RAISERROR ('O parâmetro obrigatório @@DataGeracao não foi preenchido',10,1)
			RETURN 5000
		  END
	
	/**************************************************************************************************************
	 INICIO DA DECLARAÇÃO E PREENCHIMENTO DO VALORES DAS VARIÁVEIS GLOBAIS
	***************************************************************************************************************/
	--INDICADOR DE EXECUTA COMPOSIÇÃO
		DECLARE @ExecutarSPComposicao BIT -- INDICA SE SERÁ EXECUTADA A PROCEDURE DE COMPOSIÇÃO DE DÉBITOS
		SET  @ExecutarSPComposicao = 1 -- ?VERIFICAR A NECESSIDADE DESSA VARIÁVEL POIS É SEMPRE SETADA PARA 1

	--VARIÁVEIS DE ACRESCIMO DE JUROS NA PARCELA
		DECLARE @PercentAcrescimo	FLOAT
		DECLARE @UtilizarAcrescimoRecobranca	BIT
		/* Oc. 49027 - Carrega o percentual definido para acréscimo nas parcelas. Lembrando que este acréscimo é acumulativo e é a partir da segunda parcela. 
		*  e o parâmetro UtilizarAcrescimoRecobranca para verificar se deve-se calcular acréscimo na recobrança.*/
		SELECT
			@PercentAcrescimo = (ISNULL(ps.PercAcrescimoCumulativo, 0) / 100),
		    @UtilizarAcrescimoRecobranca = ps.UtilizarAcrescimoRecobranca
		FROM
			parametrossiscafw ps
		
	-- INDICADOR DE DEPARTAMENTO DO USUÁRIO	
		DECLARE @strDepartamento VARCHAR(15)
		
		SELECT
			@strDepartamento = ISNULL(d.NomeDepto, '')
		FROM
			Usuarios
			LEFT JOIN Departamentos d ON d.IdDepto = Usuarios.IdDepartamento
		WHERE 
			NomeUsuario = HOST_NAME()     

	-- VARIAVEIS QUE SERAO UTILIZADAS COMO CONSTANTES
	
	DECLARE @INDICE_SELIC      INT,
	        @INDICE_UFIR       INT,
	        @INDICE_ICV        INT,
	        @INDICE_INPC       INT,
	        @INDICE_POUPANCA   INT,
	        @INDICE_IPCA_IBGE  INT,
	        @INDICE_URH        INT,
	        @INDICE_IGPM       INT
	        
	SELECT @INDICE_SELIC = -1,
	       @INDICE_UFIR = -2,
	       @INDICE_ICV = -3,
	       @INDICE_INPC = -4,
	       @INDICE_POUPANCA = -5,
	       @INDICE_IPCA_IBGE = -6,
	       @INDICE_URH = -7,
	       @INDICE_IGPM = -13
	       
	-- PARAMETROS DA CONFIGURAÇÃO DE GERAÇÃO DE DÉBITOS

	DECLARE @IdTipoDebito					VARCHAR(8),
			@DataReferencia					VARCHAR(20),
			@IdMoedaConf					VARCHAR(8),
			@IdConfigProcedimento			INT,
			@DataReajuste					DATETIME,
			@QtdeParcelas					INT,
			@CotaUnica						BIT,
			@AutorizaDebitoConta_CotaUnica	BIT,
			@AutorizaDebitoConta_Parcelas	BIT ,
			@NPossuiCotaUnica               BIT  
			
	DECLARE @MaxProgress INT,
	        @MaxTask INT,
	        @CurrentProgress INT,
	        @UserName VARCHAR(80),
	        @ProcName VARCHAR(100)		
	        
	SET @CurrentProgress = 0       
    SET @UserName = (SELECT HOST_NAME())
	--Obtem o nome da SP
    SET @ProcName = (SELECT OBJECT_NAME(@@PROCID))
    
    SET @MaxTask = 8
    -- Progress Bar
	INSERT INTO IndexsProgress (Name,  Progress, MaxProgress, UserName, Task, MaxTask ) 
	VALUES (@ProcName, 0, @MaxProgress, @UserName, 0, @MaxTask )  



	-- Progress Bar - 1
    UPDATE IndexsProgress SET Task = Task + 1
    WHERE Name = @ProcName AND UserName = @UserName
    				     
	              
	SELECT
		@IdTipoDebito = IdTipoDebito,
	    @DataReferencia = DataReferenciaDebito,
	    @IdMoedaConf = IdMoedaConfigGeracaoDebito,
	    @IdConfigProcedimento = IdConfigProcedimentoAtraso,
	    @DataReajuste = DataReajuste,
	    @QtdeParcelas = QtdeParcelas,
	    @CotaUnica = GerarCotaUnica,
	    @AutorizaDebitoConta_CotaUnica = AutorizaDebitoConta_CotaUnica,
	    @AutorizaDebitoConta_Parcelas = AutorizaDebitoConta_Parcelas
	FROM
		ConfigGeracaoDebito
	WHERE 
		IdConfigGeracaoDebito = @IdConfiguracao
	
    SET @NPossuiCotaUnica = Case when @CotaUnica = 1 then 0 else 1 end
		   
	IF @IdTipoDebito IS NULL OR @IdMoedaConf IS NULL OR @DataReferencia  IS NULL OR @DataReajuste  IS NULL
	  BEGIN
		RAISERROR ('A configuração do procedimento de geração de débitos está incompleta. Verifique antes de prosseguir',10,1)
		RETURN 5000
	  END

	-- VERIFICA DE ESTÁ CONFIGURADAS PARCELAMENTO POR FAIXA DE VALORES
	DECLARE @Faixa BIT   
	SELECT @Faixa = ISNULL((SELECT TOP 1 1
						 FROM   ConfigFaixasValores
						 WHERE  IdConfigGeracaoDebito = @IdConfiguracao), 0)   

	IF @Faixa = 0 and @QtdeParcelas  IS NULL AND  @CotaUnica  IS NULL 
	  BEGIN
		RAISERROR ('A configuração do procedimento de geração de débitos está incompleta. Inform se será gerada parcela única ou a quantidade de parcelas. Verifique antes de prosseguir',10,1)
		RETURN 5000
	  END	
	
	  
	  
	/**************************************************************************************************************
	 INICIO DA CRIAÇÃO DAS TABELAS TEMPORÁRIAS
	***************************************************************************************************************/
	-- TABELA PARA ARMAZENAR OS DÉBITOS DE ORIGEM QUE SERÃO RENEGOCIADOS OU RECOBRADOS
	CREATE TABLE #tmp_Debitos_Origem
	(
		Id                INT IDENTITY(1, 1),
		IdProfissional    INT,
		IdDebito          INT,
		IdMoeda           INT,
		IdTpDebito        INT,
		Valor             FLOAT,
		ValorPago         FLOAT,
		DtVencimento      DATETIME,
		DtPagamento       DATETIME,
		NumParcela        INT,
		NumConjunto       INT,
		IdSituacao        INT,
		ValorAtualizado   MONEY,
		ValorJuros        MONEY,
		ValorMulta        MONEY,
		ValorAtualizacao  MONEY,
		CodErro           INT
	) 

	--TABELA PARA ARMAZENAR A RELAÇÃO DOS DEVEDORES QUE TERÃO SEUS DÉBITOS RENEGOCIADOS OU RECOBRADOS

	CREATE TABLE #tmp_Devedores
	(
		Id                        INT IDENTITY(1, 1),
		IdProfissional            INT,
		TotalProf                 MONEY,
		TotalJuros                MONEY,
		TotalMulta                MONEY,
		TotalAtualizacoes         MONEY,
		PercReducaoMulta          DECIMAL(10, 2),
		PercReducaoJuros          DECIMAL(10, 2),
		PercReducaoAtualizacao    DECIMAL(10, 2),
		ValorParcelaMinima        MONEY,
		TotalReducaoJuros         MONEY,
		TotalReducaoMulta         MONEY,
		TotalReducaoAtualizacoes  MONEY,
		TotalProfComDesconto      MONEY,
		QtdParcelas               INT,
		IdConfigFaixaValor        INT,
		Valor_Parcela             MONEY,
		Ajuste_Ultima_parc        MONEY,
		NumConjuntoRenegociacao   INT,
		NumeroReneg               VARCHAR(15) COLLATE DATABASE_DEFAULT
	)

-- CRIA TABELA PARA ARMAZENAR O DEVEDORES QUE FORAM EXCLUÍDOS LISTA POR NÃO ATENDEREM AO VALOR DA PARCELA MÍNIMA

	CREATE TABLE #tmp_Devedores_Excluidos
	(
		Id                        INT,
		IdProfissional            INT,
		Nome                      VARCHAR(200),
		TotalProf                 MONEY,
		TotalJuros                MONEY,
		TotalMulta                MONEY,
		TotalAtualizacoes         MONEY,
		PercReducaoMulta          DECIMAL(10, 2),
		PercReducaoJuros          DECIMAL(10, 2),
		PercReducaoAtualizacao    DECIMAL(10, 2),
		ValorParcelaMinima        MONEY,
		TotalReducaoJuros         MONEY,
		TotalReducaoMulta         MONEY,
		TotalReducaoAtualizacoes  MONEY,
		TotalProfComDesconto      MONEY,
		QtdParcelas               INT,
		Valor_Parcela             MONEY,
		Ajuste_Ultima_parc        MONEY
	)
	
	
	-- TABELA PARA GERAÇÃO E TRATAMENTO DOS DÉBITOS ANTES DA GERAÇÃO DEFINITIVA NA TABELA DE DÉBITOS
	CREATE TABLE #Tmp_Debitos_Gerados
	(
		Id                   INT IDENTITY(1, 1),
		IdTipoDebito         INT,
		IdMoeda              INT,
		DataReferencia       DATETIME,
		NumeroParcela        INT,
		DataVencimento       DATETIME,
		Valor                MONEY,
		IdProf               INT,
		IdConfiguracao       INT,
		DataGeracao          DATETIME,
		UsuarioRen           VARCHAR(20) COLLATE DATABASE_DEFAULT,
		DepartamentoRen      VARCHAR(50) COLLATE DATABASE_DEFAULT,
		NumConjReneg         INT,
		NumeroRenegociacao   VARCHAR(20) COLLATE DATABASE_DEFAULT,
		Emitido              BIT,
		DataAtualizacao      DATETIME,
		RegistraLog          BIT,
		AutorizaDebitoConta  BIT,
		Acrescimos           NUMERIC(10, 2),
		NPossuiCotaUnica     BIT
	)
	
	/**************************************************************************************************************
	 INICIO DO PROCESSAMENTO DAS INFORMAÇÕES
	***************************************************************************************************************/
	-- INSERIR OS DÉBITOS DE ORIGEM NA TABELA TEMPORÁRIA                              
	INSERT INTO #tmp_Debitos_Origem (IdProfissional, IdDebito, IdMoeda, IdTpDebito, Valor, ValorPago, DtVencimento, DtPagamento, NumParcela, NumConjunto, IdSituacao, ValorAtualizado)
	EXEC (@TextoSql)
	
	
	
	-- REMOVE DA LISTAGEM DE DÉBITOS OS CASOS DE INCONSISTÊNCIA, QUE SÃO DÉBITOS COM A SITUAÇÃO NÃO PAGO, PAGO A MENOR OU LANÇADO EM DÍVIDA ATIVA MAS QUE 
	-- AO SE APURAR O VALOR PAGO IDENTIFICA-SE QUE O DÉBITO JÁ ESTA QUITADO.
	DELETE
	FROM
		#tmp_Debitos_Origem
	WHERE
		IdSituacao IN (3, 15)
	    AND dbo.Calc_PagoMenor(IdDebito, @Profissional) = 0	

	--CALCULA OS VALORES DE MULTAS, JUROS E ATUALIZACOES UTILIZADOS
	UPDATE 
		#tmp_Debitos_Origem
	SET                                	
		ValorMulta       = ISNULL(dbo.AtualizaDebitos(DtVencimento,@DataReajuste,Valor,@Profissional,IdTpDebito,IdMoeda, 0, 1, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),0),
		ValorJuros       = ISNULL(dbo.AtualizaDebitos(DtVencimento,@DataReajuste,Valor,@Profissional,IdTpDebito,IdMoeda, 0, 2, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),0),
		ValorAtualizacao = ISNULL(dbo.AtualizaDebitos(DtVencimento,@DataReajuste,Valor,@Profissional,IdTpDebito,IdMoeda, 0, 3, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),0),
		CodErro          = ISNULL(dbo.AtualizaDebitos(DtVencimento,@DataReajuste,Valor,@Profissional,IdTpDebito,IdMoeda, 0, 4, IdDebito, CASE WHEN ValorPago > 0 THEN 3 ELSE 1 END),0)

	/* Identifica erros de falta de índice */	       
	IF EXISTS(SELECT TOP 1 1 FROM #tmp_Debitos_Origem WHERE CodErro = @INDICE_SELIC)
		RAISERROR(50001, 11, 1)

	IF EXISTS(SELECT TOP 1 1 FROM #tmp_Debitos_Origem WHERE CodErro = @INDICE_UFIR)
		RAISERROR(50002, 11, 1)
	
	IF EXISTS(SELECT TOP 1 1 FROM #tmp_Debitos_Origem WHERE CodErro = @INDICE_ICV)
		RAISERROR(50003, 11, 1)
	
	IF EXISTS(SELECT TOP 1 1 FROM #tmp_Debitos_Origem WHERE CodErro = @INDICE_INPC)
		RAISERROR(50004, 11, 1)
	
	IF EXISTS(SELECT TOP 1 1 FROM #tmp_Debitos_Origem WHERE CodErro = @INDICE_POUPANCA)
		RAISERROR(50005, 11, 1)
			
	IF EXISTS(SELECT TOP 1 1 FROM #tmp_Debitos_Origem WHERE CodErro = @INDICE_IPCA_IBGE)
		RAISERROR(50006, 11, 1)
	
	IF EXISTS(SELECT TOP 1 1 FROM #tmp_Debitos_Origem WHERE CodErro = @INDICE_URH)
		RAISERROR(50007, 11, 1)
	
	IF EXISTS(SELECT TOP 1 1 FROM #tmp_Debitos_Origem WHERE CodErro = @INDICE_IGPM)
		RAISERROR(50008, 11, 1)

	UPDATE #tmp_Debitos_Origem 
	   SET ValorAtualizado = CASE IdMoeda WHEN 1 THEN CASE IdSituacao WHEN 3 THEN dbo.Calc_PagoMenor(IdDebito, @Profissional)
	                                                                  ELSE Valor
	                                                  END	 
	                                      WHEN 2 THEN (SELECT dbo.Calc_Ufir(Valor, DtVencimento, GETDATE(), 2))	
						                  WHEN 3 THEN (SELECT dbo.Calc_URH (Valor, GETDATE(), 3))
		                     END + ValorMulta + ValorJuros + ValorAtualizacao
					

    -- Progress Bar
    UPDATE IndexsProgress SET Task = Task + 1
    WHERE Name = @ProcName AND UserName = @UserName

	-- INSERE OS REGISTROS NA TABELA DE DEVEDORES
	INSERT INTO #tmp_Devedores (IdProfissional, TotalProf, TotalJuros, TotalMulta, TotalAtualizacoes)
		SELECT
			IdProfissional,
			TotalProf = SUM(ValorAtualizado),
			TotalJuros = SUM(ValorJuros),
			TotalMulta = SUM(ValorMulta),
			TotalAtualizacoes = SUM(ValorAtualizacao)
		FROM
			#tmp_Debitos_Origem
		GROUP BY
			IdProfissional
		ORDER BY
			IdProfissional



	                    
	IF   @Faixa = 1
	BEGIN
	-- CALCULA A QUANTIDADE DE PARCELAS CASO DE USAR FAIXAS DE VALORES
		UPDATE
			#tmp_Devedores
		SET
			--SELECT T.IdProfissional,
			QtdParcelas = T.QtdParcelas
		FROM
			#tmp_Devedores TD
			JOIN (	SELECT
                		TDV.IdProfissional,
						TDV.TotalProf,
						QtdParcelas = MAX(CFV.QtdeParcelas)
					FROM
                		#tmp_Devedores TDV
                		LEFT JOIN ConfigFaixasValores CFV ON CFV.IdConfigGeracaoDebito = 
                			 @IdConfiguracao AND TDV.TotalProf 
                			 BETWEEN ISNULL(CFV.ValorInicialFaixa,0) AND 
                			 ISNULL(CFV.ValorFinalFaixa,999999999)
					GROUP BY
                		TDV.IdProfissional,
                		TDV.TotalProf) AS T ON T.IdProfissional = TD.IdProfissional
			
	-- REGISTRA O IdConfigFaixaValor REFERENTE A PARCELA SELECIONADA
		UPDATE
			#tmp_Devedores
		SET
			--SELECT T.IdProfissional,
			IdConfigFaixaValor = T.IdConfigFaixaValor
		FROM
			#tmp_Devedores TD JOIN (SELECT
			                        	TDV.IdProfissional,
			                            TDV.TotalProf,
			                            IdConfigFaixaValor = MAX(CFV.IdConfigFaixaValor)
			                        FROM
			                        	#tmp_Devedores TDV
			                        	LEFT JOIN ConfigFaixasValores CFV ON CFV.IdConfigGeracaoDebito = @IdConfiguracao AND TDV.QtdParcelas = CFV.QtdeParcelas
			                        GROUP BY
			                        	TDV.IdProfissional,
			                        	TDV.TotalProf) AS T ON T.IdProfissional = TD.IdProfissional
			
	END

    UPDATE IndexsProgress SET Task = Task + 1
    WHERE Name = @ProcName AND UserName = @UserName


	IF   @Faixa = 0
	BEGIN
		-- CALCULAR QUANTIDADE DE PARCELAS PARA O CASO DE PARCELAS FIXAS
		DECLARE @NumeroParcelaFixas INT 
	    
		SELECT
			@NumeroParcelaFixas = MAX(NumeroParcela)
		FROM
			ConfigParcelasDebito CPD
			JOIN ConfigGeracaoDebito CGD ON CGD.IdConfigGeracaoDebito = CPD.IdConfigGeracaoDebito
		WHERE 
			CGD.IdConfigGeracaoDebito = @IdConfiguracao
	   
		UPDATE
			#tmp_Devedores
		SET
			QtdParcelas = @NumeroParcelaFixas
	    
	END


	--VERIFICA OS PERCENTUAIS DE DESCONTOS A SEREM APLICADOS SE HOUVEREM SIDO PARAMETRIZADOS
	UPDATE
		#tmp_Devedores
	SET
		PercReducaoMulta = ISNULL(T.ReducaoMulta, 0.000),
	    PercReducaoJuros = ISNULL(T.ReducaoJuros, 0.000),
	    PercReducaoAtualizacao = ISNULL(T.ReducaoAtualizacao, 0.000)
	FROM
		#tmp_Devedores TD LEFT JOIN (SELECT
		                             	IdConfigGeracaoDebito,
		                                 NomeConfiguracao,
		                                 PR.DiasVenc1aParc,
		                                 PR.ValorParcelaMinima,
		                                 PR.QtdMaxParcelas,
		                                 QtdParcelas = PRP.Parcela,
		                                 ReducaoMulta = PRP.ReducaoMulta,
		                                 ReducaoJuros = PRP.ReducaoJuros,
		                                 ReducaoAtualizacao = PRP.ReducaoAtualizacao
		                             FROM
		                             	ConfigGeracaoDebito CD
		                             	LEFT JOIN ProcedimentosRenegociacao PR ON CD.IdProcedRenegociacao = PR.IdProcedRenegociacao
		                             	LEFT JOIN ProcRenegociacao_Parcelas PRP ON PRP.IdProcedRenegociacao = PR.IdProcedRenegociacao
		                             WHERE 
		                             	CD.IdConfigGeracaoDebito = @IdConfiguracao) 
		T ON T.QtdParcelas = TD.QtdParcelas
				
			



	--ATUALIZA O VALOR DA PARCELA MÍNIMA
	UPDATE
		#tmp_Devedores
	SET
		ValorParcelaMinima = (SELECT
		                      	PR.ValorParcelaMinima
		                      FROM
		                      	ConfigGeracaoDebito CD
		                      	JOIN ProcedimentosRenegociacao PR ON CD.IdProcedRenegociacao = 
		                      	     PR.IdProcedRenegociacao
		                      WHERE 
		                      	CD.IdConfigGeracaoDebito = @IdConfiguracao) 




	-- CALCULA A DIVIDA TOTAL DO DEVEDOR COM OS DESCONTOS DE MULTAS, JUROS E CORREÇÕES
	UPDATE
		#tmp_Devedores
	SET
		TotalReducaoJuros = ISNULL(TotalJuros, 0.000) * ISNULL(PercReducaoJuros, 0.000) / 100.000,
	    TotalReducaoMulta = ISNULL(TotalMulta, 0.000) * ISNULL(PercReducaoMulta, 0.000) / 100.000,
	    TotalReducaoAtualizacoes = ISNULL(TotalAtualizacoes, 0.000) * ISNULL(PercReducaoAtualizacao, 0.000) / 100.000

	-- CALCULA O VALOR DO DÉBITO COM DESCONTO
	UPDATE
		#tmp_Devedores
	SET
		TotalProfComDesconto = ISNULL(TotalProf, 0.000) -(ISNULL(TotalReducaoJuros, 0.000) + ISNULL(TotalReducaoMulta, 0.000) + ISNULL(TotalReducaoAtualizacoes, 0.000))

	-- CALCULA O VALOR DA PARCELA 
	UPDATE
		#tmp_Devedores
	SET
		Valor_Parcela = CASE 
		                     WHEN ISNULL(CAST(QtdParcelas AS NUMERIC(10, 2)), 0.000) > 0 THEN (ISNULL(TotalProfComDesconto, 0.000) / CAST(QtdParcelas AS NUMERIC(10, 2)))
		                     ELSE Valor_Parcela
		                END
					
	-- MANTEM NO VALOR DA PARCELA APENAS DUAS CASAS DECIMAIS SEM USAR ARREDONDAMENTO PARA FICAR IGUAL A ROTINA INDIVIDUAL NO DELPHI				
	UPDATE
		#tmp_Devedores
	SET
		Valor_Parcela = CAST(CAST(Valor_Parcela * 100.00 AS INT) AS MONEY) / 100.00
			

	-- CALCULA O VALOR DO AJUSTE DA ÚLTIMA PARCELA
	UPDATE
		#tmp_Devedores
	SET
		Ajuste_Ultima_parc = CASE 
		                          WHEN ISNULL(CAST(QtdParcelas AS NUMERIC(10, 2)), 0.000) > 0 AND ISNULL(Valor_Parcela, 0.000) > 0 THEN ROUND(ISNULL(TotalProfComDesconto, 0.000) -(CAST(QtdParcelas AS NUMERIC(10, 2)) * Valor_Parcela), 2)
		                          ELSE Ajuste_Ultima_parc
		                     END


	-- VERIFICA NO CASO DE RENEGOCIAÇOES OS DEVEDORES CUJA PARCELA FICOU ABAIXO DO MÍNIMO PREVISTO E EXCLUI DA RELAÇÃO
	-- DE DÉBITOS E INCLUI NA TABELA TEMPORÁRIA QUE SERÁ RETORNADA PELA PROCEDURE
	INSERT INTO #tmp_Devedores_Excluidos (Id, IdProfissional, Nome, TotalProf, TotalJuros, TotalMulta, TotalAtualizacoes, PercReducaoMulta, 
	       PercReducaoJuros, PercReducaoAtualizacao, ValorParcelaMinima, TotalReducaoJuros, TotalReducaoMulta, TotalReducaoAtualizacoes, 
	       TotalProfComDesconto, QtdParcelas, Valor_Parcela, Ajuste_Ultima_parc)
	SELECT
		Id,
	    IdProfissional,
	    Nome = CASE @Profissional
	                WHEN 1 THEN (SELECT Nome FROM Profissionais PF WHERE PF.IdProfissional = TD.IdProfissional)
	                WHEN 0 THEN (SELECT Nome FROM PessoasJuridicas PJ WHERE PJ.IdPessoaJuridica = TD.IdProfissional)
	                WHEN 2 THEN (SELECT Nome FROM Pessoas P WHERE P.IdPessoa = TD.IdProfissional)
	           END,
	    TotalProf,
	    TotalJuros,
	    TotalMulta,
	    TotalAtualizacoes,
	    PercReducaoMulta,
	    PercReducaoJuros,
	    PercReducaoAtualizacao,
	    ValorParcelaMinima,
	    TotalReducaoJuros,
	    TotalReducaoMulta,
	    TotalReducaoAtualizacoes,
	    TotalProfComDesconto,
	    QtdParcelas,
	    Valor_Parcela,
	    Ajuste_Ultima_parc
	FROM
		#tmp_Devedores TD
	WHERE 
		ValorParcelaMinima IS NOT NULL
	    AND ISNULL(ValorParcelaMinima, 0) > Valor_Parcela
	
	DELETE FROM #tmp_Devedores
	FROM #tmp_Devedores TD
	JOIN #tmp_Devedores_Excluidos TDE ON TDE.Id = TD.Id
	
	
	
    -- Progress Bar
    UPDATE IndexsProgress SET Task = Task + 1
    WHERE Name = @ProcName AND UserName = @UserName
	
	-- VERIFICA SE A TABELA DE DEVEDORES FICOU VAZIA DEPOIS DA EXCLUSÃO DO QUE NÃO ALCANÇARAM A PARCELA MÍNIMA 
	-- CASO ESTEJA VAZIA PULA PARA O FINAL DA PROCEDURE PARA ENCERRAR A OPERAÇÃO
	
	IF (SELECT COUNT(*) FROM #tmp_Devedores) > 0 
	  BEGIN
	
			-- CALCULA O NUMERO DO CONJUNTO DE RENEGOCIAÇÃO
			UPDATE #tmp_Devedores
			SET   NumConjuntoRenegociacao = 
				CASE @Profissional
					WHEN 1 THEN (SELECT ISNULL(MAX(d.NumConjReneg), 0) + 1 FROM   Debitos d WHERE  d.IdProfissional = #tmp_Devedores.IdProfissional)
					WHEN 0 THEN (SELECT ISNULL(MAX(d.NumConjReneg), 0) + 1 FROM   Debitos d WHERE  d.IdPessoaJuridica = #tmp_Devedores.IdProfissional)
					WHEN 2 THEN (SELECT ISNULL(MAX(d.NumConjReneg), 0) + 1 FROM   Debitos d WHERE  d.IdPessoa = #tmp_Devedores.IdProfissional)
				END

			-- GERA O NÚMERO DAS RENEGOCIAÇÃO
			IF EXISTS (SELECT 1 FROM ParametrosSiscafw WHERE bNumerarRen = 1   )
			BEGIN
			  DECLARE @idInicial INT, @idFinal INT
			  DECLARE @NumeroReneg VARCHAR(15)			  
			  DECLARE @ID INT
			  
			  IF OBJECT_ID('TEMPDB..#Proxnum') IS NOT NULL
				DROP TABLE #Proxnum
				
			  CREATE TABLE #Proxnum (Proximo VARCHAR(15) COLLATE database_default)
			  
			  SELECT @idInicial = MIN(ID), @idFinal = MAX(ID)
			  FROM #tmp_Devedores
			  
			  SET @ID = @idInicial
			  
			  WHILE @ID BETWEEN @idInicial AND @idFinal
			  BEGIN
				  INSERT INTO #Proxnum
				  EXEC spProximoNumero '', 'ANO', 10, '', 'ParametrosSiscafw', 'NumeroRenegociacao', '', ''
				  
				  SELECT @NumeroReneg = dbo.RetiraZero(Proximo) FROM #Proxnum 
			  
				  UPDATE #tmp_Devedores SET NumeroReneg = @NumeroReneg
				  WHERE Id = @ID
				  
				  UPDATE ParametrosSiscafw SET NumeroRenegociacao = @NumeroReneg 
				   
				  SET @ID = @ID + 1
			  END
			 
			END 

			-- GERAR OS DÉBITOS EM UMA TABELA TEMPORÁRIA
			IF   @Faixa <> 1 -- GERA DEBITO DE PARCELAS E COTA UNICA PARA CASOS QUE NÃO USAM FAIXAS DE VALORES
			BEGIN
			 --VERIFICA SE SERÁ GERA A COTA ÚNICA E INSERE O DÉBITO DA COTA UNICA NA TABELA TEMPORÁRIA
			 IF @CotaUnica = 1 
				BEGIN
					INSERT INTO #Tmp_Debitos_Gerados (IdTipoDebito, IdMoeda, DataReferencia, NumeroParcela, DataVencimento, Valor, 
					       IdProf, IdConfiguracao, DataGeracao, UsuarioRen,  DepartamentoRen, NumConjReneg, NumeroRenegociacao, 
					       Emitido, DataAtualizacao, RegistraLog, AutorizaDebitoConta, NPossuiCotaUnica)			 
						SELECT
							PARCELAS.IdTipoDebito,
							PARCELAS.IdMoedaConfigGeracaoDebito,
							PARCELAS.DataReferenciaDebito,
							PARCELAS.NumeroParcela,
							PARCELAS.DataVencimentoParcela,
							TD.TotalProfComDesconto,
							TD.IdProfissional,
							PARCELAS.IdConfigGeracaoDebito,
							@DataGeracao,
							HOST_NAME(),
							@strDepartamento,
							TD.NumConjuntoRenegociacao,
							CASE 
								 WHEN TD.NumeroReneg <> 'NULL' THEN TD.NumeroReneg
								 ELSE NULL
							END,
							0,
							PARCELAS.DataReajuste,
							0,
							CASE NumeroParcela
								 WHEN 0 THEN ISNULL(PARCELAS.AutorizaDebitoConta_CotaUnica, 0)
								 ELSE ISNULL(PARCELAS.AutorizaDebitoConta_Parcelas, 0)
							END,
							0
						FROM
							#tmp_Devedores TD
							CROSS JOIN (SELECT
					            			CGD.IdTipoDebito,
											CGD.IdMoedaConfigGeracaoDebito,
											CGD.DataReferenciaDebito,
											CGD.DataReajuste,
											CPD.NumeroParcela,
											CPD.DataVencimentoParcela,
											CGD.IdConfigGeracaoDebito,
											CGD.AutorizaDebitoConta_CotaUnica,
											CGD.AutorizaDebitoConta_Parcelas,
											CPD.IdConfigFaixaValor
										FROM
					            			ConfigGeracaoDebito CGD
					            			JOIN ConfigParcelasDebito CPD ON CGD.IdConfigGeracaoDebito = 
					            				 CPD.IdConfigGeracaoDebito
										WHERE 
					            			CPD.IdConfigGeracaoDebito = @IdConfiguracao
											AND NumeroParcela = 0) AS PARCELAS
						WHERE 
							ISNULL(PARCELAS.IdConfigFaixaValor, 0) = ISNULL(TD.IdConfigFaixaValor, 0)
	
				END
				
				
			 -- GERA AS DEMAIS PARCELAS DO PARCELAMENTO
 					INSERT INTO #Tmp_Debitos_Gerados (IdTipoDebito, IdMoeda, DataReferencia, NumeroParcela, DataVencimento, Valor, 
 					       IdProf, IdConfiguracao, DataGeracao, UsuarioRen, DepartamentoRen, NumConjReneg, NumeroRenegociacao, 
 					       Emitido, DataAtualizacao, RegistraLog, AutorizaDebitoConta, NPossuiCotaUnica)			 
						SELECT
							PARCELAS.IdTipoDebito,
							PARCELAS.IdMoedaConfigGeracaoDebito,
							PARCELAS.DataReferenciaDebito,
							PARCELAS.NumeroParcela,
							PARCELAS.DataVencimentoParcela,
							CASE 
								 WHEN PARCELAS.NumeroParcela = TD.QtdParcelas AND 
									  Ajuste_Ultima_parc <> 0 THEN Valor_Parcela + 
									  Ajuste_Ultima_parc
								 ELSE Valor_Parcela
							END,
							TD.IdProfissional,
							PARCELAS.IdConfigGeracaoDebito,
							@DataGeracao,
							HOST_NAME(),
							@strDepartamento,
							TD.NumConjuntoRenegociacao,
							CASE 
								 WHEN TD.NumeroReneg <> 'NULL' THEN TD.NumeroReneg
								 ELSE NULL
							END,
							0,
							PARCELAS.DataReajuste,
							0,
							CASE NumeroParcela
								 WHEN 0 THEN ISNULL(PARCELAS.AutorizaDebitoConta_CotaUnica, 0)
								 ELSE ISNULL(PARCELAS.AutorizaDebitoConta_Parcelas, 0)
							END,
							@NPossuiCotaUnica
						FROM
							#tmp_Devedores TD
							CROSS JOIN (SELECT
					            			CGD.IdTipoDebito,
											CGD.IdMoedaConfigGeracaoDebito,
											CGD.DataReferenciaDebito,
											CGD.DataReajuste,
											CPD.NumeroParcela,
											CPD.DataVencimentoParcela,
											CGD.IdConfigGeracaoDebito,
											CGD.AutorizaDebitoConta_CotaUnica,
											CGD.AutorizaDebitoConta_Parcelas,
											CPD.IdConfigFaixaValor
										FROM
					            			ConfigGeracaoDebito CGD
					            			JOIN ConfigParcelasDebito CPD ON CGD.IdConfigGeracaoDebito = 
					            				 CPD.IdConfigGeracaoDebito
										WHERE 
					            			CPD.IdConfigGeracaoDebito = @IdConfiguracao
											AND NumeroParcela > 0) AS PARCELAS
						WHERE 
							ISNULL(PARCELAS.IdConfigFaixaValor, 0) = ISNULL(TD.IdConfigFaixaValor, 0)
			 END
			 


			-- Progress Bar
			UPDATE IndexsProgress SET Task = Task + 1
			WHERE Name = @ProcName AND UserName = @UserName

			IF   @Faixa = 1 -- GERA DEBITO DE PARCELAS E COTA UNICA PARA QUE USAM FAIXAS DE VALORES
			BEGIN
			 --VERIFICA SE SERÁ GERA A COTA ÚNICA E INSERE O DÉBITO DA COTA UNICA NA TABELA TEMPORÁRIA
			 IF @CotaUnica = 1 
				BEGIN
					INSERT INTO #Tmp_Debitos_Gerados (IdTipoDebito, IdMoeda, DataReferencia, NumeroParcela, DataVencimento, Valor, 
					       IdProf, IdConfiguracao, DataGeracao, UsuarioRen, DepartamentoRen, NumConjReneg, NumeroRenegociacao, 
					       Emitido, DataAtualizacao, RegistraLog, AutorizaDebitoConta, NPossuiCotaUnica)			 
						SELECT
							PARCELAS.IdTipoDebito,
							PARCELAS.IdMoedaConfigGeracaoDebito,
							PARCELAS.DataReferenciaDebito,
							PARCELAS.NumeroParcela,
							PARCELAS.DataVencimentoParcela,
							TD.TotalProfComDesconto,
							TD.IdProfissional,
							PARCELAS.IdConfigGeracaoDebito,
							@DataGeracao,
							HOST_NAME(),
							@strDepartamento,
							TD.NumConjuntoRenegociacao,
							CASE 
								 WHEN TD.NumeroReneg <> 'NULL' THEN TD.NumeroReneg
								 ELSE NULL
							END,
							0,
							PARCELAS.DataReajuste,
							0,
							CASE NumeroParcela
								 WHEN 0 THEN ISNULL(PARCELAS.AutorizaDebitoConta_CotaUnica, 0)
								 ELSE ISNULL(PARCELAS.AutorizaDebitoConta_Parcelas, 0)
							END,
							0
						FROM
							#tmp_Devedores TD
							CROSS JOIN (SELECT
						            		CGD.IdTipoDebito,
											CGD.IdMoedaConfigGeracaoDebito,
											CGD.DataReferenciaDebito,
											CGD.DataReajuste,
											CPD.NumeroParcela,
											CPD.DataVencimentoParcela,
											CGD.IdConfigGeracaoDebito,
											CGD.AutorizaDebitoConta_CotaUnica,
											CGD.AutorizaDebitoConta_Parcelas,
											CPD.IdConfigFaixaValor
										FROM
						            		ConfigGeracaoDebito CGD
						            		JOIN ConfigParcelasDebito CPD ON CGD.IdConfigGeracaoDebito = 
						            			 CPD.IdConfigGeracaoDebito
										WHERE 
						            		CPD.IdConfigGeracaoDebito = @IdConfiguracao
											AND NumeroParcela = 0) AS PARCELAS
						WHERE 
							ISNULL(PARCELAS.IdConfigFaixaValor, 0) = ISNULL(TD.IdConfigFaixaValor, 0)

				END
			 
			 -- GERA AS DEMAIS PARCELAS DO PARCELAMENTO
 					INSERT INTO #Tmp_Debitos_Gerados (IdTipoDebito, IdMoeda, DataReferencia, NumeroParcela, DataVencimento, Valor, 
 					       IdProf, IdConfiguracao, DataGeracao, UsuarioRen, DepartamentoRen, NumConjReneg, NumeroRenegociacao, 
 					       Emitido, DataAtualizacao, RegistraLog, AutorizaDebitoConta, NPossuiCotaUnica)			 
						SELECT
							PARCELAS.IdTipoDebito,
							PARCELAS.IdMoedaConfigGeracaoDebito,
							PARCELAS.DataReferenciaDebito,
							PARCELAS.NumeroParcela,
							PARCELAS.DataVencimentoParcela,
							CASE 
								 WHEN PARCELAS.NumeroParcela = TD.QtdParcelas AND 
									  Ajuste_Ultima_parc <> 0 THEN Valor_Parcela + 
									  Ajuste_Ultima_parc
								 ELSE Valor_Parcela
							END,
							TD.IdProfissional,
							PARCELAS.IdConfigGeracaoDebito,
							@DataGeracao,
							HOST_NAME(),
							@strDepartamento,
							TD.NumConjuntoRenegociacao,
							CASE 
								 WHEN TD.NumeroReneg <> 'NULL' THEN TD.NumeroReneg
								 ELSE NULL
							END,
							0,
							PARCELAS.DataReajuste,
							0,
							CASE NumeroParcela
								 WHEN 0 THEN ISNULL(PARCELAS.AutorizaDebitoConta_CotaUnica, 0)
								 ELSE ISNULL(PARCELAS.AutorizaDebitoConta_Parcelas, 0)
							END,
							@NPossuiCotaUnica
						FROM
							#tmp_Devedores TD
							CROSS JOIN (SELECT
						            		CGD.IdTipoDebito,
											CGD.IdMoedaConfigGeracaoDebito,
											CGD.DataReferenciaDebito,
											CGD.DataReajuste,
											CPD.NumeroParcela,
											CPD.DataVencimentoParcela,
											CGD.IdConfigGeracaoDebito,
											CGD.AutorizaDebitoConta_CotaUnica,
											CGD.AutorizaDebitoConta_Parcelas,
											CPD.IdConfigFaixaValor
										FROM
						            		ConfigGeracaoDebito CGD
						            		JOIN ConfigParcelasDebito CPD ON CGD.IdConfigGeracaoDebito = 
						            			 CPD.IdConfigGeracaoDebito
										WHERE 
						            		CPD.IdConfigGeracaoDebito = @IdConfiguracao
											AND NumeroParcela > 0) AS PARCELAS
						WHERE 
							ISNULL(PARCELAS.IdConfigFaixaValor, 0) = ISNULL(TD.IdConfigFaixaValor, 0)


			 END 
			 
             -- Progress Bar
             UPDATE IndexsProgress SET Task = Task + 1
             WHERE Name = @ProcName AND UserName = @UserName
			 
		--ATUALIZA O VALOR DAS PARCELAS COM O ACRESCIMO CUMULATIVO A PARTIR DA SEGUNDA PARCELA 
			IF (@PercentAcrescimo > 0) AND (@UtilizarAcrescimoRecobranca = 1)
			BEGIN
			
				UPDATE	#Tmp_Debitos_Gerados
				SET	    Acrescimos =  d.Valor*(@PercentAcrescimo * (d.NumeroParcela-1))
									--FOI UTILIZADA AQUI A FÓRMULA DE JUROS COMPOSTOS QUE ATENDE AO ESSE CALCULO DE ACRESCIMO CUMULATIVO
				FROM	#Tmp_Debitos_Gerados  D
				WHERE	d.NumeroParcela > 1 
			END
			 
			 
		 -- INSERE OS DÉBITOS NA TABELA DE DÉBITOS
		  INSERT INTO Debitos (IdProfissional, IdPessoaJuridica, IdPessoa, IdSituacaoAtual, IdTipoDebito, IdMoeda, DataReferencia, 
		         NumeroParcela, DataVencimento, ValorDevido, IdConfigGeracaoDebito, DataGeracao, UsuarioRen, DepartamentoRen, 
		         NumConjReneg, NumeroRenegociacao, Emitido, DataAtualizacao, RegistraLog, AutorizaDebitoConta, Acrescimos, Desconto, NPossuiCotaUnica)
				SELECT
					IdProfissional = CASE 
					                      WHEN @Profissional = 1 THEN td.IdProf
					                      ELSE NULL
					                 END,
				    IdPessoaJuridica = CASE 
				                            WHEN @Profissional = 0 THEN 
				                                 td.IdProf
				                            ELSE NULL
				                       END,
				    IdPessoa = CASE 
				                    WHEN @Profissional NOT IN (0, 1) THEN 
				                         td.IdProf
				                    ELSE NULL
				               END,
				    1,
				    td.IdTipoDebito,
				    td.IdMoeda,
				    td.DataReferencia,
				    td.NumeroParcela,
				    td.DataVencimento,
				    td.Valor,
				    td.IdConfiguracao,
				    td.DataGeracao,
				    td.UsuarioRen,
				    td.DepartamentoRen,
				    td.NumConjReneg,
				    td.NumeroRenegociacao,
				    td.Emitido,
				    td.DataAtualizacao,
				    td.RegistraLog,
				    td.AutorizaDebitoConta,
				    td.Acrescimos,
				    0,
				    td.NPossuiCotaUnica
				FROM
					#Tmp_Debitos_Gerados td			 
			 
		 --ALTERA O STATUS DOS DÉBITOS DE ORIGEM PARA RENEGOCIADO, RECOBRADO, OU RENEGOCIADO EM DÍVIDA ATIVA
					 
			UPDATE
				Debitos
			SET
				IdSituacaoAtual = CASE 
				                       WHEN d.IdSituacaoAtual <> 10 THEN 6
				                       ELSE 14
				                  END,
			    UsuarioRen = HOST_NAME(),
			    DepartamentoRen = @strDepartamento,
			    NumConjReneg = TD.NumConjuntoRenegociacao,
			    NumeroRenegociacao = CASE 
			                              WHEN TD.NumeroReneg IS NOT NULL THEN 
			                                   TD.NumeroReneg
			                              ELSE NULL
			                         END,
			    RegistraLog = 0
			FROM
				Debitos d JOIN #tmp_Debitos_Origem TDO ON TDO.IdDebito = d.IdDebito JOIN 
				#tmp_Devedores TD ON TD.IdProfissional = TDO.IdProfissional
		    
		    

			-- Progress Bar
			UPDATE IndexsProgress SET Task = Task + 1
			WHERE Name = @ProcName AND UserName = @UserName
		    
		-- REGISTRANDO O HISTÓRICO DE SITUAÇÕES DO DÉBITO
		DECLARE @IdSituacao			INT,					 
				@UsuarioRen         VARCHAR(50),
			    @DepartamentoRen    VARCHAR(60),
			    @IdDebito 			INT
			        
				SET @UsuarioRen = HOST_NAME()			        
			        
				SELECT TOP 1
     				@IdSituacao	= CASE 
				                       WHEN d.IdSituacaoAtual <> 10 THEN 6
				                       ELSE 14
				                  END,
				    @IdDebito = d.IdDebito			          
				FROM
				Debitos d JOIN #tmp_Debitos_Origem TDO ON TDO.IdDebito = d.IdDebito JOIN 
				#tmp_Devedores TD ON TD.IdProfissional = TDO.IdProfissional	
					 
					 
		INSERT INTO Debitos_SituacoesDebito(IdDebito,
		                                    UsuarioUltimaAtualizacao,
		                                    IdSituacaoDebito,
		                                    DataSituacao,
		                                    DepartamentoUltimaAtualizacao) 
		             VALUES
		             (
		               @IdDebito,
		               @UsuarioRen,
		               @IdSituacao,		               
		               @DataGeracao,
		               @DepartamentoRen		               		               
		             )   
		-- ALTERADO DADOS DO TIPO DE EMISSÃO
			UPDATE
				Debitos
			SET
				--SELECT 
				TpEmissaoConjunta = 0,
			    NumConjEmissao = 0,
			    TpCompDespesas = 0,
			    NossoNumero = NULL
			FROM
				Debitos d JOIN #tmp_Debitos_Origem TDO ON TDO.IdDebito = d.IdDebito JOIN 
				#tmp_Devedores TD ON TD.IdProfissional = TDO.IdProfissional JOIN 
				ComposicoesEmissao CE ON CE.IdDebito = D.IdDebito
			WHERE
				D.TpEmissaoConjunta = 3
			    AND (ISNULL(D.NumConjEmissao, 0) = 0)

			

            -- Progress Bar
            UPDATE IndexsProgress SET Task = Task + 1
            WHERE Name = @ProcName AND UserName = @UserName
			
			UPDATE
				DEBITOS
			SET
				TpEmissaoConjunta = 0,
			    NumConjEmissao = 0,
			    TpCompDespesas = 0,
			    NossoNumero = NULL
			FROM
				DEBITOS DE JOIN (SELECT
				                 	D.IdPessoa,
				                     D.IdProfissional,
				                     D.IdPessoaJuridica,
				                     D.NumConjEmissao
				                 FROM
				                 	Debitos D
				                 	JOIN #tmp_Debitos_Origem TDO ON TDO.IdDebito = D.IdDebito
				                 	JOIN #tmp_Devedores TD ON TD.IdProfissional = TDO.IdProfissional
				                 	JOIN ComposicoesEmissao CE ON CE.IdDebito = D.IdDebito
				                 WHERE 
				                 	ISNULL(D.NumConjEmissao, 0) > 0) AS DBE ON 
				ISNULL(DBE.IdPessoa, 0) = ISNULL(DE.IdPessoa, 0) AND ISNULL(DBE.IdProfissional, 0) = ISNULL(DE.IdProfissional, 0) 
				AND ISNULL(DBE.IdPessoaJuridica, 0) = ISNULL(DE.IdPessoaJuridica, 0)
				AND DBE.NumConjEmissao = DE.NumConjEmissao
			WHERE
				ISNULL(DE.TpEmissaoConjunta, 0) > 0 
				
				

			--GERA A COMPOSIÇÃO DOS DÉBITOS
			DECLARE @IdProfissional			INT, 
					@TotalProf				MONEY, 
					@PercReducaoMulta			Decimal(10,2),
					@PercReducaoJuros			Decimal(10,2),
					@PercReducaoAtualizacao		Decimal(10,2),
					@NumConjuntoRenegociacao	INT,
					@maxIdRegistro				INT,
					@IdRegistroCorrente				INT
	
					
			SELECT
				@IdRegistroCorrente = MIN(Id),
			    @maxIdRegistro = MAX(Id)
			FROM
				#tmp_Devedores
				

            SELECT  @MaxProgress = COUNT(*) FROM #tmp_Devedores

			WHILE @IdRegistroCorrente <= @maxIdRegistro
			BEGIN
			   SET @CurrentProgress = @CurrentProgress + 1

			   UPDATE IndexsProgress SET Progress = @CurrentProgress, MaxProgress = @MaxProgress
			   WHERE Name = @ProcName AND UserName = @UserName
			   					
				SELECT
					@IdProfissional = IdProfissional,
				    @TotalProf = TotalProf,
				    @PercReducaoMulta = PercReducaoMulta,
				    @PercReducaoJuros = PercReducaoJuros,
				    @PercReducaoAtualizacao = PercReducaoAtualizacao,
				    @NumConjuntoRenegociacao = NumConjuntoRenegociacao
				FROM
					#tmp_Devedores
				WHERE 
					Id = @IdRegistroCorrente
				IF @IdProfissional IS NOT NULL
					EXEC sp_ComposicaoDebito @IdProfissional, @NumConjuntoRenegociacao, @DataReajuste, @Profissional, 1, 0, 0 ,0,@PercReducaoMulta,@PercReducaoJuros,@PercReducaoAtualizacao,0

				  SET @IdRegistroCorrente = @IdRegistroCorrente + 1
			END

			-- APAGA DEBITOS DE PARCELAS UNICAS RENEGOCIADAS
			DELETE
			FROM
				Debitos_SituacoesDebito
				FROM DEBITOS DE JOIN Debitos_SituacoesDebito SD ON SD.IdDebito = 
				DE.IdDebito JOIN (SELECT
				                  	D.IdPessoa,
				                      D.IdProfissional,
				                      D.IdPessoaJuridica,
				                      TDO.NumConjunto
				                  FROM
				                  	Debitos D
				                  	JOIN #tmp_Debitos_Origem TDO ON TDO.IdDebito = 
				                  	     D.IdDebito
				                  	JOIN #tmp_Devedores TD ON TD.IdProfissional = 
				                  	     TDO.IdProfissional
				                  WHERE 
				                  	TDO.NumParcela = 0) AS DBE ON ISNULL(DBE.IdPessoa, 0) = 
				ISNULL(DE.IdPessoa, 0) AND ISNULL(DBE.IdProfissional, 0) = 
				ISNULL(DE.IdProfissional, 0) AND ISNULL(DBE.IdPessoaJuridica, 0) = 
				ISNULL(DE.IdPessoaJuridica, 0) AND DBE.NumConjunto = DE.NumConjTpDebito
			WHERE
				DE.NumeroParcela <> 0
					
			DELETE FROM ComposicoesDebito
			--SELECT DE.*
			FROM DEBITOS DE
			JOIN ComposicoesDebito CD ON CD.IdDebito = DE.IdDebito
			JOIN (	
				SELECT D.IdPessoa, D.IdProfissional, D.IdPessoaJuridica, TDO.NumConjunto
				FROM Debitos D
				JOIN #tmp_Debitos_Origem TDO  ON   TDO.IdDebito = D.IdDebito
				JOIN #tmp_Devedores TD ON TD.IdProfissional = TDO.IdProfissional
				WHERE TDO.NumParcela = 0
				) AS DBE ON  ISNULL(DBE.IdPessoa,0) = ISNULL(DE.IdPessoa,0)
							AND ISNULL(DBE.IdProfissional,0) =  ISNULL(DE.IdProfissional,0) 
							AND ISNULL(DBE.IdPessoaJuridica,0)  =  ISNULL(DE.IdPessoaJuridica,0) 
							AND DBE.NumConjunto = DE.NumConjTpDebito
			WHERE DE.NumeroParcela <> 0
		    

			DELETE FROM DEBITOS
			--SELECT DE.*
			FROM DEBITOS DE
			JOIN (	
				SELECT D.IdPessoa, D.IdProfissional, D.IdPessoaJuridica, TDO.NumConjunto
				FROM Debitos D
				JOIN #tmp_Debitos_Origem TDO  ON   TDO.IdDebito = D.IdDebito
				JOIN #tmp_Devedores TD ON TD.IdProfissional = TDO.IdProfissional
				WHERE TDO.NumParcela = 0
				) AS DBE ON ISNULL(DBE.IdPessoa,0) = ISNULL(DE.IdPessoa,0)
							AND ISNULL(DBE.IdProfissional,0) =  ISNULL(DE.IdProfissional,0) 
							AND ISNULL(DBE.IdPessoaJuridica,0)  =  ISNULL(DE.IdPessoaJuridica,0) 
							AND DBE.NumConjunto = DE.NumConjTpDebito
			WHERE DE.NumeroParcela <> 0
		  END	 		
	/**************************************************************************************************************
	RETORNA A LISTA DE DEVEDORES QUE FORAM EXCLUIDOS DA LISTA POR NÃO ATIGIREM A PARCELA MÍNIMA
	***************************************************************************************************************/	
	
	SELECT * FROM #tmp_Devedores_Excluidos

	--/**************************************************************************************************************
	-- DESTRUIÇÃO DAS TABELAS TEMPORÁRIAS
	--***************************************************************************************************************/
	----APAGA AS TABELAS TEMPORÁRIAS		
	--IF EXISTS (SELECT * FROM TEMPDB.SYS.SYSOBJECTS WHERE XTYPE = 'U' AND NAME = '#tmp_Devedores') 
	--	DROP TABLE  #tmp_Devedores

	--IF EXISTS (SELECT * FROM TEMPDB.SYS.SYSOBJECTS WHERE XTYPE = 'U' AND NAME = '#tmp_Debitos_Origem') 
	--	DROP TABLE  #tmp_Debitos_Origem

	--IF EXISTS (SELECT * FROM TEMPDB.SYS.SYSOBJECTS WHERE XTYPE = 'U' AND NAME = '#Tmp_Debitos_Gerados') 
	--	DROP TABLE  #Tmp_Debitos_Gerados

	--IF EXISTS (SELECT * FROM TEMPDB.SYS.SYSOBJECTS WHERE XTYPE = 'U' AND NAME = '#tmp_Devedores_Excluidos') 
	--	DROP TABLE  #tmp_Devedores_Excluidos
  END TRY
  BEGIN CATCH
    RAISERROR ('Erro na geração de recobrança.',12,1)
  END CATCH
END
