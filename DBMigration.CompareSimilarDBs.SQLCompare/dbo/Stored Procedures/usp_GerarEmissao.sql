
CREATE PROCEDURE dbo.usp_GerarEmissao (@IdEmissaoConfig INT)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @Result TABLE (
		                    Chave           UNIQUEIDENTIFIER,
			                ErrorNumber     INT,
			                ErrorSeverity   INT,
			                ErrorState      INT,
			                ErrorProcedure  VARCHAR(255),
			                ErrorLine       INT,
			                ErrorMessage    VARCHAR(5000)
			              )
	
	
	BEGIN TRY
	
		IF EXISTS(SELECT TOP 1 1 FROM EmissoesConfig WHERE IdEmissaoConfig = @IdEmissaoConfig AND [Status] = 5) -- Situação de cancelado da tabela EmissoesConfig
			RAISERROR ( 'Não é possível gerar uma emissão cancelada.', 11, 0 )
		
		/*****************************************************
		* INICIO - Definições de variáveis e tabelas temporarias
		* *****************************************************/		
	
		DECLARE @IdEmissao                     INT = NULL,  
				@IdDetalheEmissao              INT = NULL, 
				@SeuNumero                     VARCHAR(11) = NULL,
				@NossoNumero                   VARCHAR(20) = NULL,	
				@TipoPessoa                    INT = NULL, /* 0-PJ; 1-PF; 2-PE */
				@IdPessoa                      INT = NULL,
				@IdDebito                      INT = NULL,
				@IdBanco                       INT = NULL,
				@CodigoBanco                   CHAR(3) = NULL,
				@CodigoAgencia                 INT = NULL,
				@IdContaCorrente               INT = NULL,
				@IdConvenio                    INT = NULL,
				@EmissaoComDesconto            INT = 0,
				@EmissaoWeb                    BIT = NULL,
				@DebitoEmConta                 BIT = NULL,
				@TipoEmissao                   INT = NULL,
				@TipoComposicao                INT = NULL,
				@CodCC_Conv_Ced                VARCHAR(16) = NULL,
				@CodOperacao                   VARCHAR(3)  = NULL,
				@DataVencimentoBoleto          DATETIME = NULL,
				@DataAtualizacao               DATETIME = NULL,
				@DataEmissao                   DATETIME = NULL,
				@UsuarioEmissao 			   VARCHAR(35) = NULL,
				@DepartamentoEmissao           VARCHAR(60) = NULL,	
				@NaoReceberAposVencimento      BIT = NULL,
				@IdProcedimentoAtraso          INT = NULL,
				@ValorDespBanco                MONEY = NULL,
				@ValorDespPostal               MONEY = NULL,
				@ValorDespAdv 	               MONEY = NULL,
				@TipoDivisaoDesp	           TINYINT = NULL,
				@GerarNossoNumero              BIT = NULL,
				@Chave                         UNIQUEIDENTIFIER = NULL,
				@DebitosSelecao                Debitos,
				@AgrupadorEmissao              INT,      
				@DataMinimaASerConsiderada     DATETIME
	
		DECLARE @Debitos TABLE (
					ID INT IDENTITY(1, 1),
					IdDebito INT,
					DataVencimento DATETIME,
					TipoPessoa INT,
					IdPessoa INT
				)       
	        
		DECLARE @Valores TABLE (
			        Agrupador INT,
					IdDebito INT,
					IdProfissional INT,
					IdPessoaJuridica INT,
					IdPessoa INT,
					IdTipoDebito INT,
					NumConjReneg INT,
					NumConjTpDebito INT,
					SiglaDebito VARCHAR(10),
					NumeroParcela INT,
					DataReferencia DATETIME,
					DataVencimento DATETIME,
					ValorDevido NUMERIC(10, 2),
					ValorPrincipal NUMERIC(10, 2),
					ValorAtualizacao NUMERIC(10, 2),
					ValorMulta NUMERIC(10, 2),
					ValorJuros NUMERIC(10, 2),
					ValorDesconto NUMERIC(10, 2),
					IdProcedimento INT,
					IsentoDeEncargosParaEmissao BIT,
					CodErro INT
				)  
        	
		/*****************************************************
		* FIM - Definições de variáveis e tabelas temporarias
		* ****************************************************/	        		
		
			
		SELECT @IdBanco              = IdBanco,
			   @IdContaCorrente      = IdContaCorrente,
			   @IdConvenio           = IdConvenio,
			   @TipoComposicao       = TipoComposicao,
			   @TipoEmissao          = TipoEmissao,
			   @DebitoEmConta        = CASE WHEN TipoEmissao = 5 THEN 1 ELSE 0 END,
			   @DataVencimentoBoleto = CAST(DataVencimentoBoleto AS DATE),
			   @DataAtualizacao      = CAST(DataAtualizacao AS DATE),
			   @NaoReceberAposVencimento = NaoReceberAposVencimento,
			   @IdProcedimentoAtraso = IdProcedimentoAtraso,
			   @EmissaoComDesconto   = EmissaoComDesconto,
			   @EmissaoWeb           = EmissaoWeb,
			   @ValorDespBanco       = ValorDespBanco,   
			   @ValorDespPostal      = ValorDespPostal,
			   @ValorDespAdv 	     = ValorDespAdv, 
			   @TipoDivisaoDesp	     = TipoDivisaoDesp,
			   @GerarNossoNumero     = GerarNossoNumero,
			   @Chave                = Chave,
			   @DataEmissao          = GETDATE(),
			   @UsuarioEmissao       = HOST_NAME(),
			   @DepartamentoEmissao  = ( SELECT d.NomeDepto 
                                         FROM   Departamentos d
                                                JOIN Usuarios u ON d.IdDepto = u.IdDepartamento
			                	         WHERE  u.NomeUsuario = HOST_NAME() )    
		FROM   EmissoesConfig
		WHERE  IdEmissaoConfig  = @IdEmissaoConfig
	
		SELECT @CodigoBanco = CodigoBanco
		FROM   BancosSiscafw 
		WHERE  IdBancoSiscafw = @IdBanco

		SELECT @CodigoAgencia = CodigoAgencia 
		FROM   ContasCorrentes 
		WHERE  IdContaCorrente = @IdContaCorrente		
		
		SELECT @DataMinimaASerConsiderada = dbo.ufn_GetDataMinimaASerConsideradaByEmissaoConfig( @IdEmissaoConfig )

		/*
		* 
		* Prinmeiras validações AQUI
		* 
		* */

		EXEC dbo.usp_Get_CodCC_Conv_Ced @IdContaCorrente, 
										@IdConvenio, 
										@CodCC_Conv_Ced OUTPUT, 
										@CodOperacao OUTPUT	        
	
		/* Recuperamos todos os débitos que devem ser emitidos. */
		
		INSERT INTO @Debitos
		  (
			IdDebito,
			DataVencimento,
			TipoPessoa,
			IdPessoa
		  )
		SELECT d.IdDebito,
			   d.DataVencimento,
			   CASE 
					WHEN d.IdPessoaJuridica IS NOT NULL THEN 0
					WHEN d.IdProfissional IS NOT NULL THEN 1
					ELSE 2
			   END,
			   CASE 
					WHEN d.IdPessoaJuridica IS NOT NULL THEN d.IdPessoaJuridica
					WHEN d.IdProfissional IS NOT NULL THEN d.IdProfissional
					ELSE d.IdPessoa
			   END
		FROM   Debitos d
			   JOIN TemporaryID ti
					ON  ti.ID = d.IdDebito
		WHERE  ti.Chave = @Chave	  
		  AND  ti.[Status] = 0 -- 0 - Aguardando          		
				
		/* Marca a emissão como iniciada (2) */				
		UPDATE EmissoesConfig 
		SET    [Status] = 2 -- Situação de iniciado da tabela EmissoesConfig
		WHERE  IdEmissaoConfig = @IdEmissaoConfig
				
		DECLARE Emissao_Cursor CURSOR FAST_FORWARD 
		FOR
			/* Caso o TipoComposicao seja 0 (emissão normal) deixamos o campo IdDebito para que 
			*  a consulta retorne cada débito individualmente.
			*  Já se o TipoComposicao for 1 (emissão unificada) definimos o IdDebito como Nulo 
			*  para que possamos agrupar pelo Id da pessoa (IdPessoa, IdProfissional e IdPessoaJuridica),
			*  porque neste tipo de emissão devemos agrupar todos os débito em um único boleto. */
			SELECT DISTINCT 
				   CASE 
						WHEN @TipoComposicao = 0 THEN IdDebito
						ELSE NULL
				   END AS IdDebito,
				   TipoPessoa,
				   IdPessoa				   
			FROM   @Debitos
			GROUP BY
				   CASE 
						WHEN @TipoComposicao = 0 THEN IdDebito
						ELSE NULL
				   END,
				   TipoPessoa,
				   IdPessoa
				 
		
		OPEN Emissao_Cursor
	
		FETCH NEXT FROM Emissao_Cursor INTO @IdDebito, @TipoPessoa, @IdPessoa
	
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (SELECT [Status] FROM EmissoesConfig WHERE IdEmissaoConfig = @IdEmissaoConfig) = 3 -- Situação de parado da tabela EmissoesConfig
				BREAK
				
			IF (SELECT [Status] FROM EmissoesConfig WHERE IdEmissaoConfig = @IdEmissaoConfig) = 5 -- Situação de cancelado da tabela EmissoesConfig
			BEGIN
				UPDATE TemporaryID
				SET    [Status] = 3 -- 3 Situação de cancelado da tabela TemporaryID
				WHERE  Chave = @Chave
				  AND  [Status] = 0
				  
				BREAK	
			END	
			
			BEGIN TRY
				BEGIN TRANSACTION
						
				/* *************************************************
				* INICIO DO PROCESSAMENTO DA EMISSÃO
				* ***************************************************/
			
				DELETE FROM @Valores
			
				/*
				* 
				*  @Valores -> inserimos os débitos que compõem o boleto.
				*  
				*  Já inserimos consultando os encargos até a data de atualização (@DataAtualizacao)
				* 
				* */
			
				DELETE FROM @DebitosSelecao
			
				INSERT INTO @DebitosSelecao ( IdDebito ) 
				SELECT IdDebito
				FROM   Debitos d
				WHERE d.IdDebito IN (SELECT dt.IdDebito 
									 FROM   @Debitos dt
									 WHERE  dt.IdDebito = @IdDebito
									   AND  @TipoComposicao = 0)			                       
				   OR d.IdDebito IN (SELECT dt.IdDebito 
									 FROM   @Debitos dt
									 WHERE  dt.TipoPessoa = @TipoPessoa
									   AND  dt.IdPessoa = @IdPessoa
									   AND  @TipoComposicao = 1 ) 
												        
				/*
				* 
				* Se for débito em conta deve-se verificar se o débito já foi emitido e não houve estorno.
				* 
				* */
				IF @DebitoEmConta = 1 
				BEGIN
					IF @TipoPessoa <> 1 
						RAISERROR ( 'Débito em conta só está disponível para profissionais.', 11, 0)
				
					IF EXISTS(
							SELECT TOP 1 1
							FROM   @DebitosSelecao ds
									JOIN Debitos d
										ON  d.IdDebito = ds.IdDebito
									JOIN Profissionais p
										ON  p.IdProfissional = d.IdProfissional
							WHERE ISNULL(p.AgenciaDebitoConta,'') = '' OR
									ISNULL(p.ContaDebitoConta,'') = '' OR
									ISNULL(p.IdBancoDebitoConta,'') = '' ) 
						RAISERROR ( 'Configure os dados de banco, conta-corrente e agência.', 11, 0)
				
					IF EXISTS(
							SELECT TOP 1 1
							FROM   @DebitosSelecao ds
									JOIN Debitos d
										ON  d.IdDebito = ds.IdDebito
									JOIN Profissionais p
										ON  p.IdProfissional = d.IdProfissional
							WHERE ISNULL(d.AutorizaDebitoConta,0) = 0 )
						RAISERROR ( 'Débito não configurado para débito em conta.', 11, 0)
									
					IF EXISTS(
							SELECT TOP 1 1
							FROM  @DebitosSelecao ds
									JOIN Debitos d
										ON  d.IdDebito = ds.IdDebito
									JOIN ComposicoesEmissao ce
										ON  d.IdDebito = ce.IdDebito
									JOIN DetalhesEmissao de
										ON  de.IdDetalheEmissao = ce.IdDetalheEmissao
									JOIN DetalhesArquivoRemessa dar
										ON  dar.NossoNumero = de.NossoNumero
									JOIN ArquivosRemessa ar
										ON  ar.IdArquivoRemessa = dar.IdArquivoRemessa
							WHERE  ISNULL(dar.Estornado, 0) = 0
									AND ar.Estornado = 0
					)
					RAISERROR ( 'Débito já emitido para débito em conta e não consta estorno.', 11, 0)					
				END
			
			
				/*
				* 
				* Vamos desfazer os conjuntos das emissões referentes aos débitos selecionados.
				* (pra que gravar essas informações na tabela de débitos? - vai saber... ) 
				* 
				* */
						
				EXEC dbo.usp_DesfazerConjuntoEmissaoByUserType @DebitosSelecao 
						
				/*
				* 
				* Agora já temos os débitos preparados, podemos dar continuidade
				* 
				* */			

				EXEC @IdEmissao = dbo.usp_GetIdEmisao @TipoPessoa, @IdPessoa, @EmissaoWeb
				
				IF @IdEmissao IS NULL
					RAISERROR ( 'Não foi possível gerar/identificar os dados da pessoa.', 11, 0)
		
				INSERT INTO @Valores
				  (
					Agrupador, 		 
					IdDebito,      
					IdProfissional,
					IdPessoaJuridica,      
					IdPessoa,      
					IdTipoDebito,      
					NumConjReneg,      
					NumConjTpDebito,      
					SiglaDebito,  
					NumeroParcela,      
					DataReferencia, 
					DataVencimento, 
					ValorDevido,    
					ValorPrincipal,    
					ValorAtualizacao,    
					ValorMulta,    
					ValorJuros,    
					ValorDesconto,    
					IdProcedimento,       
					IsentoDeEncargosParaEmissao,                     
					CodErro
				  )
				EXEC usp_GetDebitosAtualizadosParaEmissaoByUserType @EmissaoComDesconto,   
																	@TipoPessoa,          
																	@DataVencimentoBoleto,
																	@DataAtualizacao,     
																	@IdProcedimentoAtraso,
																	@TipoComposicao,
																	@DataMinimaASerConsiderada,
																	@DebitosSelecao             																			
					
				SELECT @AgrupadorEmissao = MIN(Agrupador) 
				FROM   @Valores
																											
				WHILE @AgrupadorEmissao IS NOT NULL
				BEGIN				
					IF @GerarNossoNumero = 1
						EXEC dbo.usp_GetProximoNossoNumero @IdBanco, 
															@IdContaCorrente, 
															@IdConvenio, 
															@DebitoEmConta,
															@EmissaoWeb,
															@NossoNumero OUTPUT

					IF @DebitoEmConta = 0
						EXEC dbo.usp_GetProximoSeuNumero @EmissaoWeb,
														 @SeuNumero OUTPUT
					
					INSERT INTO DetalhesEmissao
					(
						IdEmissao,
						NossoNumero,
						SeuNumero,
						IdMoedaDevida,
						DataEmissao,
						DataVencimento,
						DataAtualizacaoEncargos,
						ValorEmissao,
						ValorDespBco,
						ValorDespAdv,
						ValorDespPostais,
						TipoEmissao,
						TipoComposicao,
						CodBanco,
						CodAgencia,
						CodOperacao,
						CodCC_Conv_Ced,
						RegistraLog,
						IdEmissaoConfig,
						SituacaoRegistro,
						AtualizacaoWeb,
						UsuarioEmissao,
						DepartamentoEmissao	
					)
			
					SELECT 
						@IdEmissao,
						@NossoNumero,
						@SeuNumero,
						1, -- Moeda Real
						@DataEmissao,	
						MAX(vl.DataVencimento),
						@DataAtualizacao,
						SUM(vl.ValorDevido),						
						@ValorDespBanco,
						@ValorDespAdv,
						@ValorDespPostal,
						@TipoEmissao,
						CASE WHEN COUNT(vl.IdDebito) = 1 THEN 0 ELSE @TipoComposicao END,
						@CodigoBanco,
						@CodigoAgencia,
						@CodOperacao,	
						@CodCC_Conv_Ced,
						1,
						@IdEmissaoConfig,
						/* Se o tipo de emissão for "2-Arquivo para o banco" a situação da emissão será "2-Remessa Gerada",
						*  se for "6-Envio por email" a situação da emissão será "9-Emissão Cancelada ", já para os demais tipos
						*  a situação será "1-Aguardando Remessa".
						*  Sobre a situação quando o tipo for envio por e-mail o motivo é para evitar que uma emissão feita para
						*  ser enviado por e-mail fique na fila para ser enviado ao banco para registro caso o envio do e-mail não
						*  seja realizado. Desta forma, apenas se o e-mail for enviado com sucesso é que a situação desta emissão
						*  será alterada para "1-Aguardando Remessa".
						*  Obs.: Ao atualizar a situação da emissão, deve-se verificar se a situação dela é de fato 9 (Cancelada), 
						*        porque se estiver sendo utilizada o registro online, após a geração da emissão o boleto já será
						*        registrado e sua situação será  */
						CASE WHEN @TipoEmissao = 2 THEN 2
						     WHEN @TipoEmissao = 6 THEN 6    
						     ELSE 1    
						END,
						CASE WHEN @EmissaoWeb  = 1 THEN 'I:' ELSE NULL END,
						@UsuarioEmissao,     
						@DepartamentoEmissao					    
					FROM  @Valores vl
					WHERE Agrupador = @AgrupadorEmissao
						
					SELECT @IdDetalheEmissao = SCOPE_IDENTITY()			

					INSERT INTO ComposicoesEmissao
					(
						IdDetalheEmissao,
						IdDebito,
						IdMoedaDevida,
						Sigladebito,
						NumeroParcela,
						DataReferenciaDebito,
						DataVencimentoDebito,
						ValorDevido,
						ValorPrincipal,
						ValorAtualizacao,
						ValorMulta,
						ValorJuros,
						ValorDesconto,
						IdProcedimento,
						RegistraLog,
						AtualizacaoWeb					
					)
					SELECT @IdDetalheEmissao,
							vl.IdDebito,
							1, -- Moeda Real
							vl.SiglaDebito,
							vl.NumeroParcela,			        
							CONVERT(VARCHAR(8), vl.DataReferencia, 112),
							vl.DataVencimento,
							vl.ValorDevido,
							vl.ValorPrincipal, -- Valor Principal é cheio
							vl.ValorAtualizacao,
							vl.ValorMulta,
							vl.ValorJuros,
							vl.ValorDesconto,
							vl.IdProcedimento,
							1, -- RegistraLog
							CASE WHEN @EmissaoWeb = 1 THEN 'I:' ELSE NULL END
					FROM   @Valores vl
					WHERE  Agrupador = @AgrupadorEmissao
				
					/* Se o débito (ou todos os débitos no caso de emissão unificada) forem isentos financeiro
					 * então o boleto não pode ser recebido após o vencimento. */
					IF NOT EXISTS(SELECT TOP 1 1 
								  FROM   @Valores 
								  WHERE  IsentoDeEncargosParaEmissao = 0)
						SET @NaoReceberAposVencimento = 1  
			
					/* ATENÇÃO! A chamada da usp_SetDetalhesEmissaoConfig deve ser depois do insert na tabela ComposicoesEmissao */
					IF @NaoReceberAposVencimento = 0  
						EXEC dbo.usp_SetDetalhesEmissaoConfig @IdDetalheEmissao,
															  @IdContaCorrente, 
															  @IdConvenio	

					/* Somente emissões do tipo normal, onde o valor da emissão é feito no valor cheio e não há
					*  emissões para cada opção de desconto é que vamos configurar os descontos na tabela
					*  ComposicoesEmissaoConfig. */				
					IF @EmissaoComDesconto = 0
						EXEC dbo.usp_SetComposicoesEmissaoConfig @IdDetalheEmissao, @DataMinimaASerConsiderada
						
					/* Verifica se a emissão está correta */
					IF dbo.ufn_ValidarEmissao( @IdDetalheEmissao ) = 0
						RAISERROR ( 'Emissão inconsistente - Valor da emissão diferente da composição', 11, 0)

					SELECT @AgrupadorEmissao = MIN(Agrupador) 
					FROM   @Valores
					WHERE  Agrupador > @AgrupadorEmissao											
				END
											
				UPDATE Debitos
				SET    NossoNumero         = @NossoNumero,
					   SeuNumero           = @SeuNumero,
					   TpEmissaoConjunta   = CASE WHEN (SELECT COUNT(*) FROM @Valores) = 1 THEN 0 ELSE @TipoComposicao END,
					   NumConjEmissao      = dbo.ufn_GetProximoNumConjEmissao(@TipoPessoa, @IdPessoa),
					   TpCompDespesas      = @TipoDivisaoDesp,
					   Emitido             = 1,
					   AutorizaDebitoConta = CASE WHEN @TipoEmissao = 5 THEN 1 ELSE 0 END
				WHERE  IdDebito IN (SELECT IdDebito
									FROM   @Valores)
																			
				/* ---------- FIM ---------*/
						
				UPDATE TemporaryID
				SET    [Status] = 4 -- 4 - Gerado  
				WHERE  Chave = @Chave
				  AND  ID IN (SELECT IdDebito FROM @Valores)
						
				COMMIT TRANSACTION		

			END TRY
			BEGIN CATCH
		
				ROLLBACK TRANSACTION
						
				UPDATE EmissoesConfig 
				SET    ErroMsg = ERROR_MESSAGE() + ' - Método: ' + ERROR_PROCEDURE() + ' - Linha: ' + CAST(ERROR_LINE() AS VARCHAR)
				WHERE  Chave = @Chave
						
				UPDATE TemporaryID
				SET    [Status] = 2, -- 2 - Erro 
					   [Error]  = ERROR_NUMBER()    
				WHERE  Chave = @Chave
				  AND  ID IN (SELECT IdDebito FROM @Valores)		  
			      
			END CATCH;
		
			FETCH NEXT FROM Emissao_Cursor INTO @IdDebito, @TipoPessoa, @IdPessoa			
		END
		
		UPDATE EmissoesConfig 
		SET    [Status] = 4 -- Situação de concluído da tabela EmissoesConfig
		WHERE  IdEmissaoConfig = @IdEmissaoConfig
			AND  [Status] <> 5 -- Somente se ela não tiver sido cancelada
	
		CLOSE Emissao_Cursor
		DEALLOCATE Emissao_Cursor
	
		-- É necessário ter um retorno (NÃO RETIRAR ESSE SELECT)
		INSERT INTO @Result ( Chave, ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage )
		SELECT @Chave, 0, 0, 0, '', 0, ''			
	END TRY
	BEGIN CATCH
		INSERT INTO @Result ( Chave, ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage )
		SELECT
		    @Chave AS Chave,
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() + ' - Método: ' + ERROR_PROCEDURE() + ' - Linha: ' + CAST(ERROR_LINE() AS VARCHAR) AS ErrorMessage
	END CATCH
	
	SELECT * FROM @Result
END
