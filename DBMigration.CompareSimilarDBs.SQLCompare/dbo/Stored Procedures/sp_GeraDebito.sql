/* OC 140286 Claudio */

CREATE PROCEDURE [dbo].[sp_GeraDebito]
	@IdConfiguracao VARCHAR(8),
	@TextoSql TEXT,
	@Profissional INT = 1,
	@DataGeracao VARCHAR(20),
	@Atualiza BIT = 0
AS
	/*
	Esta SP tem por objetivo gerar os débitos de um grupo de profissionais, pessoa jurídica ou
	outras pessoas, a partir uma configuração pré-definida.
	*/
	
	SET NOCOUNT ON  
	
	DECLARE @IdProfissional                 INT,
	        @Usuario                        VARCHAR(30),
	        @Departamento                   VARCHAR(30),
	        @ProfPJ                         VARCHAR(20),
	        @Teste                          VARCHAR(20),
	        @IdTipoDebito                   VARCHAR(8),
	        @DataReferencia                 VARCHAR(20),
	        @NumConjTpDebito                VARCHAR(8000),
	        @Desconto                       FLOAT,
	        @TpDesconto                     FLOAT,
	        @StDesconto                     FLOAT,
	        @GerarCotaUnica                 BIT,
	        @NPossuiCotaUnica               BIT,
	        @AutorizaDebitoConta_CotaUnica  BIT,
	        @AutorizaDebitoConta_Parcelas   BIT,
	        @Venc1aParcela                  DATETIME,
	        @TextoSql2                      VARCHAR(8000)
	        
			
	DECLARE @MaxProgress INT,
	        @MaxTask INT,
	        @CurrentProgress INT,
	        @UserName VARCHAR(80),
	        @ProcName VARCHAR(100)	

    SET @CurrentProgress  = 0
    SET @UserName = (SELECT HOST_NAME())
	--Obtem o nome da SP
    SET @ProcName = (SELECT OBJECT_NAME(@@PROCID))		        		
		        
	
	CREATE TABLE #tmpProfissionais
	(
		IdProfissional  INT,
		TpDesconto      FLOAT,
		StDesconto      FLOAT
	)
	CREATE INDEX IX_#tmpProfissionais
	ON #tmpProfissionais(IdProfissional)    
	
	CREATE TABLE #Debitos
	(
		IdTipoDebito                 INT,
		IdMoeda                      INT,
		DataReferencia               DATETIME,
		NumeroParcela                INT,
		DataVencimento               DATETIME,
		ValorDevido                  MONEY,
		IdProfissional               INT,
		IdPessoaJuridica             INT,
		IdPessoa                     INT,
		IdConfigGeracaoDebito        INT,
		IdSituacaoAtual              INT,
		DataGeracao                  DATETIME,
		NumConjTpDebito              INT,
		Emitido                      BIT,
		RegistraLog                  BIT,
		NPossuiCotaUnica             BIT,
		ExecTriggerNPossuiCotaUnica  BIT,
		AutorizaDebitoConta          BIT
	)  
	
	CREATE TABLE #tmp_ConfigGeracaoDebito
	(
		IdTipoDebito                 INT,
		IdMoedaConfigGeracaoDebito   INT,
		DataReferenciaDebito         DATETIME,
		NumeroParcela                INT,
		DataVencimentoParcela        DATETIME,
		ValorParcela                 MONEY,
		IdSituacaoAtual              INT,
		Emitido                      BIT,
		RegistraLog                  BIT,
		ExecTriggerNPossuiCotaUnica  BIT,
		AutorizaDebitoConta          BIT
	)
	
	CREATE TABLE #tmpdebito_a_excluir
	(
		IdDebito INT
	)  
	
	CREATE TABLE #tmpdebito_NumConjTpDebito
	(
		IdProfissional   INT,
		NumConjTpDebito  INT
	)
	CREATE INDEX IX_#tmpdebito_NumConjTpDebito
	ON #tmpdebito_NumConjTpDebito(IdProfissional) 
	
	
    SET @MaxTask = 6
    -- Progress Bar
	INSERT INTO IndexsProgress (Name,  Progress, MaxProgress, UserName, Task, MaxTask ) 
	VALUES (@ProcName, 0, @MaxProgress, @UserName, 0, @MaxTask )  


	-- Progress Bar - 1
    UPDATE IndexsProgress SET Task = Task + 1
    WHERE Name = @ProcName AND UserName = @UserName
	
	
	
	-- Carrega os profissionais que terão os debitos gerados na tabela temporária
	INSERT INTO #tmpProfissionais
	EXEC (@TextoSql) 
	
	
	
	
	--SELECT TOP 1 @Usuario = ISNULL(Usuario, ' ') FROM #tmpProfissionais
	SET @Usuario = HOST_NAME();
	SET @Departamento = (
	        SELECT ISNULL(d.NomeDepto, ' ')
	        FROM   Departamentos d
	        WHERE  d.IdDepto = (
	                   SELECT TOP 1 u.IdDepartamento
	                   FROM   Usuarios u
	                   WHERE  u.NomeUsuario = @usuario
	               )
	    )
	-- Obtem os parâmetros de configuração
	SELECT @IdTipoDebito = IdTipoDebito,
	       @DataReferencia = DataReferenciaDebito,
	       @GerarCotaUnica = GerarCotaUnica,
	       @AutorizaDebitoConta_CotaUnica = AutorizaDebitoConta_CotaUnica,
	       @AutorizaDebitoConta_Parcelas = AutorizaDebitoConta_Parcelas
	FROM   ConfigGeracaoDebito
	WHERE  IdConfigGeracaoDebito = @IdConfiguracao 
	
	
	DECLARE @IsGeraDebitoRespTec BIT,
	        @IdDebitoPJPorRespTec INT,
	        @ValorPadraoDebito MONEY
	        
	SELECT TOP 1 @IsGeraDebitoRespTec = ISNULL(GeraDebitoPJPorRespTec, 0),
	@IdDebitoPJPorRespTec = IdDebitoPJPorRespTec
	FROM ParametrosSiscafw fw
	
	SELECT @ValorPadraoDebito = ValorPadrao FROM TiposDebito
	WHERE IdTipoDebito = @IdDebitoPJPorRespTec
	  
	
	IF @Profissional = 1
	    SET @ProfPJ = 'IdProfissional'
	
	IF @Profissional = 0
	    SET @ProfPJ = 'IdPessoaJuridica'
	
	IF @Profissional = 2
	    SET @ProfPJ = 'IdPessoa' 
	
	-- Rotina de exclusão dos débitos gerados anteriormente para a configuração     
	IF (
	       SELECT UPPER(NomeDebito)
	       FROM   TiposDebito
	       WHERE  IdTipoDebito = @IdTipoDebito
	   ) = 'ANUIDADE'
	BEGIN
	    SET @TextoSql2 = 
	        'INSERT INTO #tmpdebito_a_excluir (IdDebito)  
	        SELECT IdDebito FROM  #tmpProfissionais t1, Debitos t2
			WHERE t1.IdProfissional= ' + 't2.' + @ProfPJ +
	        '  
			AND IdTipoDebito = ' + @IdTipoDebito +
	        '   
			AND DataReferencia = ''' + @DataReferencia +
	        '''  
			AND IdSituacaoAtual  = 1 
			
			UNION ALL 
			  
     	    --Caso exista debito gerado pela configuracao GerarDebitosPorRespTec

			SELECT IdDebito FROM  #tmpProfissionais t1, Debitos t2
			WHERE t1.IdProfissional= t2.IdPessoaJuridica  
			AND IdTipoDebito <> ' + @IdTipoDebito + '   
			AND DataReferencia = ''' + @DataReferencia + '''  
			AND IdSituacaoAtual  = 1
			AND EXISTS (SELECT 1 FROM debitos d
	            WHERE d.IdPessoaJuridica = t2.IdPessoaJuridica
	            AND d.IdTipoDebito = ' + @IdTipoDebito + '
	            AND d.DataReferencia = t2.DataReferencia
	            AND d.IdConfigGeracaoDebito IS NOT NULL 
	            AND d.IdConfigGeracaoDebito = t2.IdConfigGeracaoDebito) '			
			
	    
	    EXEC (@TextoSql2)	    
	    
    
	    
	    SET @TextoSql2 = 
	        'DELETE  FROM ComposicoesDebito 
			           WHERE IdDebito in (Select IdDebito from #tmpdebito_a_excluir)'
	    
	    EXEC (@TextoSql2)    
	    
	    SET @TextoSql2 = 
	        'DELETE FROM Debitos_SituacoesDebito 
			           WHERE IdDebito in (Select IdDebito from #tmpdebito_a_excluir) '
	    
	    EXEC (@TextoSql2)    
	    
	    
	    --Caso exista debito gerado pela configuracao GerarDebitosPorRespTec
	    SET @TextoSql2 = 
	        'DELETE FROM DEBITOS 
	        WHERE IdTipoDebito <> ' + @IdTipoDebito + '   
			AND DataReferencia = ''' + @DataReferencia + '''  
			AND IdSituacaoAtual  = 1
			AND EXISTS (SELECT 1 FROM debitos d
	            WHERE d.IdPessoaJuridica = debitos.IdPessoaJuridica
	            AND d.IdTipoDebito = ' + @IdTipoDebito + '
	            AND d.DataReferencia = debitos.DataReferencia
	            AND d.IdConfigGeracaoDebito IS NOT NULL 
	            AND d.IdConfigGeracaoDebito = debitos.IdConfigGeracaoDebito) '			
	    EXEC (@TextoSql2)		    
	    
	    SET @TextoSql2 = 'DELETE FROM DEBITOS   
						WHERE IdTipoDebito = ' + @IdTipoDebito +
	        '   
						AND DataReferencia = ''' + @DataReferencia +
	        '''  
						AND IdSituacaoAtual  = 1  
						AND ' + @ProfPJ +
	        ' IN (SELECT IdProfissional  FROM #tmpProfissionais)'   
	    
	    EXEC (@TextoSql2)
	    
	    
	    
	    
	END  
	-- Progress Bar - 1
    UPDATE IndexsProgress SET Task = Task + 1
    WHERE Name = @ProcName AND UserName = @UserName
	
	
	
	INSERT INTO #tmp_ConfigGeracaoDebito
	  (
	    IdTipoDebito,
	    IdMoedaConfigGeracaoDebito,
	    DataReferenciaDebito,
	    NumeroParcela,
	    DataVencimentoParcela,
	    ValorParcela,
	    IdSituacaoAtual,
	    Emitido,
	    RegistraLog,
	    ExecTriggerNPossuiCotaUnica,
	    AutorizaDebitoConta
	  )
	SELECT IdTipoDebito,
	       IdMoedaConfigGeracaoDebito,
	       DataReferenciaDebito,
	       NumeroParcela = NumeroParcela,
	       DataVencimento = DataVencimentoParcela,
	       ValorParcela,
	       IdSituacaoAtual = 1,
	       Emitido = 0,
	       RegistraLog = 0,
	       ExecTriggerNPossuiCotaUnica = 0,
	       AutorizaDebitoConta = CASE 
	                                  WHEN NumeroParcela = 0 AND 
	                                       AutorizaDebitoConta_CotaUnica = 1 THEN 
	                                       1
	                                  WHEN NumeroParcela > 0 AND 
	                                       AutorizaDebitoConta_Parcelas = 1 THEN 
	                                       1
	                                  ELSE 0
	                             END
	FROM   ConfigGeracaoDebito t1
	       LEFT JOIN ConfigParcelasDebito t2
	            ON  t1.IdConfigGeracaoDebito = t2.IdConfigGeracaoDebito
	WHERE  t1.IdConfigGeracaoDebito = @IdConfiguracao
	ORDER BY
	       NumeroParcela 
	       
	-- Progress Bar - 1
    UPDATE IndexsProgress SET Task = Task + 1
    WHERE Name = @ProcName AND UserName = @UserName
	       
	
	/*
	SET @Venc1aParcela = Case when @Atualiza = 1 
	
	THEN 
	ISNULL((SELECT TOP 1 DataVencimentoParcela   
	FROM ConfigParcelasDebito   
	WHERE IdConfigGeracaoDebito = @IdConfiguracao  
	ORDER BY DataVencimentoParcela),GETDATE())  
	ELSE GETDATE() END 
	*/
	
	SET @TextoSql2 = 
	    'INSERT INTO #tmpdebito_NumConjTpDebito (IdProfissional,NumConjTpDebito)
	        SELECT t1.IdProfissional,NumConjTpDebito=ISNULL(MAX(NumConjTpDebito), 0) + 1 
	        FROM #tmpProfissionais t1 LEFT JOIN Debitos t2 ON
			t1.IdProfissional = t2.' + @ProfPJ + ' GROUP BY t1.IdProfissional '
	
	EXEC (@TextoSql2)  
	
	-- Progress Bar - 1
    UPDATE IndexsProgress SET Task = Task + 1
    WHERE Name = @ProcName AND UserName = @UserName
	
	
	DECLARE Profissional_Cursor            CURSOR FAST_FORWARD 
	FOR
	    SELECT t1.IdProfissional,
	           TpDesconto,
	           StDesconto,
	           NumConjTpDebito             
	    FROM   #tmpProfissionais t1,
	           #tmpdebito_NumConjTpDebito  t2
	    WHERE  t1.IdProfissional = t2.IdProfissional 
	
	-- Progress Bar - 1
    UPDATE IndexsProgress SET Task = Task + 1
    WHERE Name = @ProcName AND UserName = @UserName
	
	OPEN Profissional_Cursor 

	FETCH NEXT FROM Profissional_Cursor INTO @IdProfissional, @TpDesconto, @StDesconto,
	@NumConjTpDebito
	                                                                                        
	
	SET @NPossuiCotaUnica = CASE 
	                             WHEN @GerarCotaUnica = 1 THEN 0
	                             ELSE 1
	                        END
	                        
	SET @MaxProgress = (SELECT COUNT(*)           
	                    FROM   #tmpProfissionais t1,
	                           #tmpdebito_NumConjTpDebito  t2
                        WHERE  t1.IdProfissional = t2.IdProfissional)

	-- Progress Bar - 1
    UPDATE IndexsProgress SET Task = Task + 1
    WHERE Name = @ProcName AND UserName = @UserName
             	                        
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
       SET @CurrentProgress = @CurrentProgress + 1

       --IF @CurrentProgress = 1
       --BEGIN
       --  INSERT INTO IndexsProgress (Name, Progress, MaxProgress, UserName ) 
       --  VALUES (@ProcName, 0, @MaxProgress, @UserName )  
       --END       
          
      
       UPDATE IndexsProgress SET Progress = @CurrentProgress, MaxProgress = @MaxProgress
       WHERE Name = @ProcName AND UserName = @UserName
		
		
				
	    IF @TpDesconto >= @StDesconto
	        SET @Desconto = @TpDesconto
	    ELSE
	        SET @Desconto = @StDesconto   
	    
	    
	    INSERT INTO Debitos
	      (
	        IdTipoDebito,
	        IdMoeda,
	        DataReferencia,
	        NumeroParcela,
	        DataVencimento,
	        ValorDevido, 
	        IdProfissional,
	        IdPessoaJuridica,
	        IdPessoa,
	        IdConfigGeracaoDebito,
	        IdSituacaoAtual,
	        DataGeracao,
	        NumConjTpDebito,
	        Emitido,
	        RegistraLog,
	        NPossuiCotaUnica,
	        ExecTriggerNPossuiCotaUnica,
	        AutorizaDebitoConta,
	        UsuarioUltimaAtualizacao,
	        DepartamentoUltimaAtualizacao,
	        DataUltimaAtualizacao
	      )
	    SELECT IdTipoDebito,
	           IdMoedaConfigGeracaoDebito,
	           DataReferenciaDebito,
	           NumeroParcela,
	           DataVencimentoParcela,
	           ValorDevido = ValorParcela -(ValorParcela / 100 * @Desconto),
	           --+ Case when @Atualiza = 1
	           --                                then dbo.AtualizaDebitoAvulso (DataVencimento,@Venc1aParcela,ValorDevido,0,0)
	           --                                else 0 end,
	           
	           IdProfissional = CASE 
	                                 WHEN @Profissional = 1 THEN @IdProfissional
	                            END,
	           IdPessoaJuridica = CASE 
	                                   WHEN @Profissional = 0 THEN @IdProfissional
	                              END,
	           IdPessoa = CASE 
	                           WHEN @Profissional = 2 THEN @IdProfissional
	                      END,
	           IdConfigGeracaoDebito = @IdConfiguracao,
	           IdSituacaoAtual,
	           DataGeracao = @DataGeracao,
	           NumConjTpDebito = @NumConjTpDebito,
	           Emitido,
	           RegistraLog,
	           NPossuiCotaUnica = @NPossuiCotaUnica,
	           ExecTriggerNPossuiCotaUnica,
	           AutorizaDebitoConta,
	           @Usuario,
	           @Departamento,
	           GETDATE()
	    FROM   #tmp_ConfigGeracaoDebito
	   
		    
	    --Se profissional for PJ e Parametrosfw é para gerar debito por RespTec
	    IF (@Profissional = 0) AND (@IsGeraDebitoRespTec = 1) 
	    BEGIN
	    	----------------------------
			INSERT INTO Debitos
			  (
				IdTipoDebito,
				IdMoeda,
				DataReferencia,
				NumeroParcela,
				DataVencimento,
				ValorDevido, 
				IdProfissional,
				IdPessoaJuridica,
				IdPessoa,
				IdConfigGeracaoDebito,
				IdSituacaoAtual,
				DataGeracao,
				NumConjTpDebito,
				Emitido,
				RegistraLog,
				NPossuiCotaUnica,
				ExecTriggerNPossuiCotaUnica,
				AutorizaDebitoConta,
				UsuarioUltimaAtualizacao,
				DepartamentoUltimaAtualizacao,
				DataUltimaAtualizacao
			  )
			SELECT @IdDebitoPJPorRespTec,
				   IdMoedaConfigGeracaoDebito,
				   DataReferenciaDebito,
				   NumeroParcela,
				   DataVencimentoParcela,
				   ------------- Valor parcelar por Qtd RespTec ----------------
				   ValorDevido = @ValorPadraoDebito *
				   (
						SELECT COUNT(*)
						FROM   Profissionais p
							   INNER JOIN ExperienciasProfissionais ep ON (ep.IdProfissional = p.IdProfissional)
							   INNER JOIN ResponsaveisTecnicosPJ rtp   ON (rtp.IdExperienciaProfissional = ep.IdExperienciaProfissional)
						WHERE  ep.IdPessoaJuridica = @IdProfissional
							   AND (ISNULL(rtp.DataFim, 0) = 0 OR rtp.DATAFIM >= GETDATE())
						GROUP BY
							   ep.IdPessoaJuridica	           	
		           
				   ),
		           
				   -------------------------------------------------------------
		           
				   IdProfissional = CASE 
										 WHEN @Profissional = 1 THEN @IdProfissional
									END,
				   IdPessoaJuridica = CASE 
										   WHEN @Profissional = 0 THEN @IdProfissional
									  END,
				   IdPessoa = CASE 
								   WHEN @Profissional = 2 THEN @IdProfissional
							  END,
				   IdConfigGeracaoDebito = @IdConfiguracao,
				   IdSituacaoAtual,
				   DataGeracao = @DataGeracao,
				   NumConjTpDebito = @NumConjTpDebito + 1,
				   Emitido,
				   RegistraLog,
				   NPossuiCotaUnica = @NPossuiCotaUnica,
				   ExecTriggerNPossuiCotaUnica,
				   AutorizaDebitoConta,
				   @Usuario,
				   @Departamento,
				   GETDATE()
			FROM   #tmp_ConfigGeracaoDebito
			WHERE NumeroParcela = 0 AND (
						SELECT COUNT(*)
						FROM   Profissionais p
							   INNER JOIN ExperienciasProfissionais ep ON (ep.IdProfissional = p.IdProfissional)
							   INNER JOIN ResponsaveisTecnicosPJ rtp   ON (rtp.IdExperienciaProfissional = ep.IdExperienciaProfissional)
						WHERE  ep.IdPessoaJuridica = @IdProfissional
							   AND (ISNULL(rtp.DataFim, 0) = 0 OR rtp.DATAFIM >= GETDATE())
						GROUP BY
							   ep.IdPessoaJuridica	           	
		           
			) > 0
			
/*			INNER JOIN ExperienciasProfissionais ep ON (ep.IdPessoaJuridica = @IdProfissional)
			INNER JOIN ResponsaveisTecnicosPJ rtp   ON (rtp.IdExperienciaProfissional = ep.IdExperienciaProfissional)
			WHERE  ep.IdProfissional = @IdProfissional
			AND (ISNULL(rtp.DataFim, 0) = 0 OR rtp.DATAFIM >= GETDATE())
			AND NumeroParcela = 0
*/			

			----------------------------
	    	
		    	
		    	
	    END  
	      
	    FETCH NEXT FROM Profissional_Cursor INTO @IdProfissional, @TpDesconto, @StDesconto,
	    @NumConjTpDebito
	    
	    
	END 
	
	
	
	CLOSE Profissional_Cursor 
	DEALLOCATE Profissional_Cursor  
	
	
	SET @TextoSql2 = 
	    'UPDATE Debitos SET RegistraLog = 1, ExecTriggerNPossuiCotaUnica = 1 
  WHERE RegistraLog = 0 AND IdConfigGeracaoDebito = ' + @IdConfiguracao +
	    ' AND DataGeracao = ''' + @DataGeracao + ''''
	
	EXEC (@TextoSql2)  
