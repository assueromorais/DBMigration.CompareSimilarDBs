
CREATE PROCEDURE dbo.usp_GerarEmissaoByUserType (
    @ConfigEmissao     ConfigEmissao READONLY,
    @Debitos           Debitos READONLY,
    @Executar          BIT 
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
		
	BEGIN TRY
	
		DECLARE @TipoEmissao          TINYINT,
		        @GerarNossoNumero     BIT,
		        @IdBanco              INT,
		        @TipoComposicao       INT,
		        @DataVencimentoBoleto DATETIME,  
		        @DataAtualizacao      DATETIME,
		        @DataMinimaASerConsiderada DATETIME, 		        
		        @IdContaCorrente      INT,
		        @IdConvenio           INT,
		        @EmissaoComDesconto   INT,		        
		        @RAISERROR_MSG        VARCHAR(200) 
		        
		DECLARE @DebitosOK TABLE (
					IdDebito INT,
					IdTipoDebito INT,
					NumeroParcela INT,
					NumConjTpDebito INT,
					NumConjReneg INT,
					IdProfissional INT,
					IdPessoaJuridica INT,
					IdPessoa INT
				)  		        
		        
		        
		SELECT @TipoEmissao          = ce.TipoEmissao,           		
			   @GerarNossoNumero     = ce.GerarNossoNumero, 
			   @IdBanco              = ce.IdBanco,
			   @IdContaCorrente      = ce.IdContaCorrente,
			   @IdConvenio           = ce.IdConvenio,
			   @TipoComposicao       = ce.TipoComposicao,  
			   @DataVencimentoBoleto = ce.DataVencimentoBoleto,
			   @DataAtualizacao      = ce.DataAtualizacao,
			   @EmissaoComDesconto   = ce.EmissaoComDesconto
		FROM   @ConfigEmissao ce	
			
		/* Validações */	
		
		/* Só é aceito contas correntes da Caixa Econômica no layout CNAB 240 SIGCB */
		IF EXISTS(SELECT TOP 1 1
		          FROM   BancosSiscafw
		          WHERE  IdBancoSiscafw = @IdBanco
		            AND  CodigoBanco = '104')
		   AND 
		   EXISTS(SELECT TOP 1 1 
		          FROM   ContasCorrentes
		          WHERE  IdContaCorrente = @IdContaCorrente
					AND  (E_CNAB <> 1 OR LeiauteCnab <> 1))
			RAISERROR ( 'Para o banco Caixa Econômica só é aceito contas correntes no layout CNAB 240 SIGCB', 11, 0 )					
		
	
		IF NOT EXISTS (SELECT TOP 1 1 
		               FROM @ConfigEmissao ce
							JOIN ContasCorrentes cc ON cc.IdContaCorrente = ce.IdContaCorrente
							LEFT JOIN Convenios c ON c.IdConvenio = ce.IdConvenio	
							JOIN ConfigBancoParaEmissao cbpe ON  cbpe.IdConfigBancoParaEmissao = ISNULL(c.IdConfigBancoParaEmissao, cc.IdConfigBancoParaEmissao))
		BEGIN
			IF ISNULL(@IdConvenio, 0) > 0 
				 RAISERROR ( 'Não existe configuração de emissão para este convênio.', 11, 0 )
			ELSE RAISERROR ( 'Não existe configuração de emissão para esta conta corrente.', 11, 0 )								
		END			
		
		-- O IdBanco e o IdContaCorrente tem que existir
		IF NOT EXISTS(SELECT TOP 1 1 FROM BancosSiscafw WHERE IdBancoSiscafw = ISNULL(@IdBanco,0))
			RAISERROR ( 'É obrigatório informar o ID do Banco.', 11, 0 )			
		
		IF NOT EXISTS(SELECT TOP 1 1 FROM ContasCorrentes WHERE IdContaCorrente = ISNULL(@IdContaCorrente,0))
			RAISERROR ( 'É obrigatório informar o ID da conta corrente.', 11, 0 )
		
		IF ISNULL(@IdConvenio,0) > 0 	
		BEGIN
			IF NOT EXISTS(SELECT TOP 1 1
			              FROM   BancosSiscafw bs
			                     JOIN ContasCorrentes cc ON  cc.IdBancoSiscafw = bs.IdBancoSiscafw
			                     JOIN Convenios c ON c.IdContaCorrente = cc.IdContaCorrente
			              WHERE  bs.IdBancoSiscafw = @IdBanco
			                AND  cc.IdContaCorrente = @IdContaCorrente
			                AND  c.IdConvenio = @IdConvenio)
			RAISERROR ( 'As informações bancárias de Banco / Conta corrente / Convênio não conferem.', 11, 0 )			                 			
		END		
		ELSE
		BEGIN
			IF NOT EXISTS(SELECT TOP 1 1
			              FROM   BancosSiscafw bs
			                     JOIN ContasCorrentes cc ON  cc.IdBancoSiscafw = bs.IdBancoSiscafw
			              WHERE  bs.IdBancoSiscafw = @IdBanco
			                AND  cc.IdContaCorrente = @IdContaCorrente)
			RAISERROR ( 'As informações bancárias de Banco / Conta corrente não conferem.', 11, 0 )					
		END
		
		-- Para emissão unificada é obrigatório informar a data de vencimento do boleto.
        -- A não ser que seja uma emissão com desconto do tipo 2 (layout de 3 guias), porque neste caso 
        -- a data de vencimento utilizada será as datas dos descontos e do vencimento da anuidade.
		IF (@TipoComposicao = 1) AND (@DataVencimentoBoleto IS NULL) AND (@EmissaoComDesconto IN (0,1))
			RAISERROR ( 'Para emissão unificada é obrigatório informar a data de vencimento do boleto.', 11, 0 )
		
		-- Se a data de atualização foi informada é obrigatório que seja informada a data de vencimento
		IF (@DataAtualizacao IS NOT NULL) AND (@DataVencimentoBoleto IS NULL) 
			RAISERROR ( 'É necessário informar a data de vencimento quando se utiliza a atualização de valores.', 11, 0 )

		IF (@DataVencimentoBoleto IS NOT NULL) AND (@DataVencimentoBoleto < @DataMinimaASerConsiderada)
		BEGIN
			SET @RAISERROR_MSG = 'A data de vencimento do boleto não pode ser anterior a data de ' + CONVERT(VARCHAR(10), @DataMinimaASerConsiderada, 103) + '.'
			RAISERROR ( @RAISERROR_MSG, 11, 0 )				
		END		
				
		-- Os tipos de emissão 1, 5 e 6 são emissões que necessariamente precisam que o nosso número seja gerado,
		-- logo, não podem ser utilizadas junto com a opção "GerarNossoNumero" desativada (False = 0).
		-- TipoDaEmissao = 1-Impressão em boletas; 2-Arquivo para o banco; 3-Impressão de recibo; 5-Débito em Conta; 6-Envio de email;
		
		IF @TipoEmissao IN (1,5,6) AND ISNULL(@GerarNossoNumero,0) = 0 
			RAISERROR ( 'Para emissões de: "Impressão de boletos (1)", "Débito em conta (5)" e "Envio de e-mail (6)" é obrigatório gerar nosso número (parâmetro "@GerarNossoNumero")', 11, 0 )

		-- Se for emissão para débito em conta mas a conta corrente informada não possui
		IF @TipoEmissao = 5 AND 
		   EXISTS (
				   SELECT TOP 1 1
				   FROM   BancosSiscafw bs
						  JOIN ContasCorrentes cc
							   ON  cc.IdBancoSiscafw = bs.IdBancoSiscafw
				   WHERE  cc.IdBancoSiscafw = @IdBanco
						  AND cc.IdContaCorrente = @IdContaCorrente
						  AND ISNULL(cc.ConvenioDebitoEmConta, '') = ''
			   )
			RAISERROR ( 'Convênio não configurado para emissão de débito em conta.', 11, 0 )
	
		IF EXISTS(SELECT TOP 1 1 
		          FROM   EmissoesConfig ec 
		                 JOIN @ConfigEmissao ecx ON ec.Chave = ecx.Chave
		          WHERE  ecx.Chave IS NOT NULL)
			RAISERROR ( 'Chave informada já utilizada, favor utilizar outra.', 11, 0 )	
	
		DECLARE @IdEmissaoConfig INT,
				@Coletiva        BIT,
				@Chave           UNIQUEIDENTIFIER	
	
		-- Remove registro de @Debitos cujo IdDebito seja nulo (tem casos em que ocorre) e também
		-- débitos que não estejam nas situações.  1-Não pago
		--                                         3-Pago a menor
		--                                         10-Não pago em DA
		--                                         15-Pago a menor em DA
		
		INSERT INTO @DebitosOK
		  (
		    IdDebito,
		    IdTipoDebito,
		    NumeroParcela,
		    NumConjTpDebito,
		    NumConjReneg,
		    IdProfissional,
		    IdPessoaJuridica,
		    IdPessoa
		  )
		SELECT d.IdDebito,
			   d.IdTipoDebito,
			   CASE 
					WHEN d.NumeroParcela = 0 THEN 0
					ELSE 1
			   END,			   
			   ISNULL(d.NumConjTpDebito, -1),
			   ISNULL(d.NumConjReneg, -1),
			   ISNULL(d.IdProfissional, -1),
			   ISNULL(d.IdPessoaJuridica, -1),
			   ISNULL(d.IdPessoa, -1)		  
		FROM   Debitos d
		       JOIN @Debitos dx ON dx.IdDebito = d.IdDebito
		WHERE  d.IdSituacaoAtual IN (1, 3, 10, 15)	
		
		-- Agora vamos remover as parcelas quando houver cota-única e o tipo de composição for Unificada
		
		IF @TipoComposicao = 1 
			DELETE FROM @DebitosOK
			WHERE  IdDebito NOT IN (SELECT d.IdDebito
									FROM   @DebitosOK d
									WHERE  ( d.NumeroParcela = 0
												   OR ( d.NumeroParcela = 1
														AND NOT EXISTS( SELECT TOP 1 1 
																		FROM   @DebitosOK d2
																		WHERE  d2.IdTipoDebito    = d.IdTipoDebito
																		  AND d2.NumConjTpDebito  = d.NumConjTpDebito
																		  AND d2.NumConjReneg     = d.NumConjReneg
																		  AND d2.IdProfissional   = d.IdProfissional
																		  AND d2.IdPessoaJuridica = d.IdPessoaJuridica
																		  AND d2.IdPessoa         = d.IdPessoa
																		  AND d2.NumeroParcela    = 0
																	  )
													  )
										  )										 
								   )		
	
		IF NOT EXISTS (SELECT TOP 1 1 FROM @DebitosOK) 
			RAISERROR ( 'Não foram identificados débitos válidos para a emissão.', 11, 0 )	
				
		SET @Coletiva = CAST(CASE WHEN ( SELECT COUNT(*)
										 FROM   (  SELECT d.IdProfissional,
														  d.IdPessoaJuridica,
														  d.IdPessoa
												   FROM   @DebitosOK dt
														  JOIN Debitos d ON  d.IdDebito = dt.IdDebito	
												   GROUP BY
														  d.IdProfissional,
														  d.IdPessoaJuridica,
														  d.IdPessoa ) Qtd ) > 1 THEN 1 
								  ELSE 0
							 END AS BIT) 						
			
		SELECT @Chave = CASE WHEN Chave IS NULL THEN NEWID() ELSE Chave END
		FROM   @ConfigEmissao
			
		INSERT INTO EmissoesConfig
		  (
			Titulo,
			TipoPessoa,
			IdRelatorio,
			[DATA],
			Usuario,
			Coletiva,
			IdBanco,
			IdContaCorrente,
			IdConvenio,
			EmissaoComRegistro,
			TipoEmissao,
			TipoComposicao,
			TipoDivisaoDesp,
			GerarNossoNumero,
			EmissaoComDesconto,
			EmissaoWeb,
			ValorDespBanco,
			ValorDespPostal,
			ValorDespAdv,
			DataVencimentoBoleto,
			DataAtualizacao,
			NaoReceberAposVencimento,
			IdProcedimentoAtraso,
			IdentificarDebitoNoBoleto,
			ExibirComposicaoDebito,
			IndicarDebitosEmAberto,
			InserirRTF_File,
			CodProtesto,
			QtdDiasProtesto,
			CodBaixa,
			QtdDiasBaixa,
			Mensagem,
			Instrucao,
			Chave,
			AtualizacaoWeb
		  )
		SELECT ce.Titulo,
		       ce.TipoPessoa,
		       CASE WHEN ce.IdRelatorio = 0 THEN NULL ELSE ce.IdRelatorio END,
			   GETDATE(),
			   HOST_NAME(),
			   @Coletiva,
			   ce.IdBanco,
			   ce.IdContaCorrente,
			   CASE WHEN ce.IdConvenio = 0 THEN NULL ELSE ce.IdConvenio END, 
			   1,
			   ce.TipoEmissao,
			   ce.TipoComposicao,
			   ce.TipoDivisaoDesp,
			   ce.GerarNossoNumero,
			   CASE WHEN @DataVencimentoBoleto IS NULL THEN ce.EmissaoComDesconto ELSE 0 END,
			   ce.EmissaoWeb,
			   ce.ValorDespBanco,
			   ce.ValorDespPostal,
			   ce.ValorDespAdv,
			   ce.DataVencimentoBoleto,
			   ce.DataAtualizacao,
			   ce.NaoReceberAposVencimento,
			   ce.IdProcedimentoAtraso,
			   ce.IdentificarDebitoNoBoleto,
			   ce.ExibirComposicaoDebito,
			   ce.IndicarDebitosEmAberto,
			   ce.InserirRTF_File,
			   cbpe.CodProtesto,
			   cbpe.QtdDiasProtesto,
			   cbpe.CodBaixa,
			   cbpe.QtdDiasBaixa,
			   ce.Mensagem, 
			   ce.Instrucao,
			   @Chave,
			   CASE WHEN ce.EmissaoWeb = 1 THEN 'I:'
			   		ELSE NULL
			   END 			   
		FROM @ConfigEmissao ce
			   JOIN BancosSiscafw bs
					ON  bs.IdBancoSiscafw = ce.IdBanco
			   JOIN ContasCorrentes cc
					ON cc.IdBancoSiscafw = bs.IdBancoSiscafw
					AND cc.IdContaCorrente = ce.IdContaCorrente
			   LEFT JOIN Convenios c
			        ON c.IdContaCorrente = cc.IdContaCorrente
					AND c.IdConvenio = ce.IdConvenio	
			   LEFT JOIN ConfigBancoParaEmissao cbpe 
			        ON  cbpe.IdConfigBancoParaEmissao = ISNULL(c.IdConfigBancoParaEmissao, cc.IdConfigBancoParaEmissao)
		
		SELECT @IdEmissaoConfig = SCOPE_IDENTITY()
		
		SELECT @DataMinimaASerConsiderada = dbo.ufn_GetDataMinimaASerConsideradaByEmissaoConfig( @IdEmissaoConfig )
				
		IF @IdEmissaoConfig IS NULL
			RAISERROR ( 'Não foi gerado registro na tabela EmissoesConfig.', 11, 0 )				
		
		IF @TipoComposicao = 1 
		BEGIN
			/*
			* Se a emissão for unificada (@TipoComposicao = 1) vamos excluir as parcelas
			* quando na lista de débitos existir a cota-única e parcelas.			
			*/  		
			INSERT INTO TemporaryID
			  (
				Chave,
				ID,
				IDPessoa
			  )
			SELECT @Chave,
				   dx.IdDebito,
				   CASE WHEN d.IdProfissional   IS NOT NULL THEN d.IdProfissional 
				        WHEN d.IdPessoaJuridica IS NOT NULL THEN d.IdPessoaJuridica
				        WHEN d.IdPessoa         IS NOT NULL THEN d.IdPessoa
				        ELSE NULL
				   END 
			FROM   @DebitosOK dx
			       JOIN Debitos d ON d.IdDebito = dx.IdDebito			  
		END			
		ELSE
		BEGIN
			INSERT INTO TemporaryID
			  (
				Chave,
				ID,
				IDPessoa
			  )
			SELECT @Chave,
				   dx.IdDebito,
				   CASE WHEN d.IdProfissional   IS NOT NULL THEN d.IdProfissional 
				        WHEN d.IdPessoaJuridica IS NOT NULL THEN d.IdPessoaJuridica
				        WHEN d.IdPessoa         IS NOT NULL THEN d.IdPessoa
				        ELSE NULL
				   END 
			FROM   @DebitosOK dx
			       JOIN Debitos d ON d.IdDebito = dx.IdDebito					
		END
						
		-- Chamamos a SP para validar os dados, como por exemplo o CPF
		EXEC dbo.usp_ValidarTemporaryID @IdEmissaoConfig, @DataMinimaASerConsiderada
				
		-- Se não existe nenhum registro aguardando emissão é porque todos estão inválidos, neste caso aborta a emissão.
		IF NOT EXISTS (SELECT TOP 1 1 FROM TemporaryID WHERE [Status] = 0 AND Chave = @Chave) -- 0-Aguardando				
			RAISERROR ( 'Não foram identificados débitos válidos para a emissão.', 11, 0 )	
									
		IF @Executar = 1				
			EXEC usp_GerarEmissao @IdEmissaoConfig	
		ELSE
		BEGIN
			-- É necessário ter um retorno (NÃO RETIRAR ESSE SELECT)
			SELECT
				@Chave AS Chave,
				0 AS ErrorNumber,
				0 AS ErrorSeverity,
				0 AS ErrorState,
				'' AS ErrorProcedure,
				0 AS ErrorLine,
				'' AS ErrorMessage			
		END
	END TRY
	BEGIN CATCH
		SELECT
		    @Chave AS Chave,
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() + ' - Método: ' + ERROR_PROCEDURE() + ' - Linha: ' + CAST(ERROR_LINE() AS VARCHAR)AS ErrorMessage
	END CATCH
END
