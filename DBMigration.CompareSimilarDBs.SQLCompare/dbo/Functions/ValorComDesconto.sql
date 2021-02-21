CREATE FUNCTION [dbo].[ValorComDesconto] (@IdDebito int, @Retorno int, @DataHj datetime )
	RETURNS money
	AS
	BEGIN	
		/* @Retorno ( 0 = Valor já com Desconto, 1 = Valor do Desconto ) */
						
		DECLARE @Desconto money, @E_Percentual bit, @ValorDevido money, @ValorPgtoDesconto money, @IdSituacao int, @IdMoeda int, @PessoaFisica bit
		DECLARE @DataVcto datetime, @DataCalculo datetime
		SELECT @ValorDevido = ValorDevido FROM Debitos WHERE IdDebito = @IdDebito

		SELECT @IdSituacao = Debitos.IdSituacaoAtual, @IdMoeda = Debitos.IdMoeda, @PessoaFisica = CASE WHEN IdProfissional IS NOT NULL THEN 1 ELSE 0 END   ,
		@DataVcto = Debitos.DataVencimento, @DataCalculo = Debitos.DataVencimento 
		FROM Debitos WHERE Debitos.IdDebito = @IdDebito

		SELECT @Desconto = 0
		
		IF @IdSituacao = 3
		BEGIN
			SELECT @ValorDevido = dbo.Calc_PagoMenor(@IdDebito, @PessoaFisica)		
			SET @IdMoeda = 1             
		END
		ELSE
		IF @IdMoeda <> 1 
		BEGIN
			IF @IdMoeda = 2
				SET @ValorDevido = (SELECT dbo.Calc_Ufir(@ValorDevido, @DataVcto, @DataCalculo, 2))	
			IF @IdMoeda = 3
				SET @ValorDevido = (SELECT dbo.Calc_URH(@ValorDevido, @DataCalculo, 3))
			SET @IdMoeda = 1
		END
			/*Oc 44694 Joao Marcelo - Trocando o Debitos.DataVencimento por OpcoesPgtoDesconto.DataPgtoDesconto*/
		IF EXISTS (Select TOP 1 1 From Debitos, ConfigParcelasDebito, OpcoesPgtoDesconto 
					Where ConfigParcelasDebito.IdConfigGeracaoDebito = Debitos.IdConfigGeracaoDebito 
					And OpcoesPgtoDesconto.IdConfigParcelaDebito = ConfigParcelasDebito.IdConfigParcelaDebito 
					And Debitos.IdDebito = @IdDebito AND OpcoesPgtoDesconto.DataPgtoDesconto >= Cast(Convert(varchar(10),@DataHj,112) as datetime)
					And ConfigParcelasDebito.NumeroParcela = Debitos.NumeroParcela 
					And DataPgtoDesconto <= Debitos.DataVencimento)
		BEGIN
			/*OC.43445 ITALO SELECT TOP 1  E TROQUEI O Debitos.DataVencimento POR OpcoesPgtoDesconto.DataPgtoDesconto */
			SELECT TOP 1  @E_Percentual = OpcoesPgtoDesconto.E_Percentual, @ValorPgtoDesconto  = OpcoesPgtoDesconto.ValorPgtoDesconto
			From Debitos, ConfigParcelasDebito, OpcoesPgtoDesconto 
			Where ConfigParcelasDebito.IdConfigGeracaoDebito = Debitos.IdConfigGeracaoDebito 
			And OpcoesPgtoDesconto.IdConfigParcelaDebito = ConfigParcelasDebito.IdConfigParcelaDebito 
			And Debitos.IdDebito = @IdDebito AND OpcoesPgtoDesconto.DataPgtoDesconto >= Cast(Convert(varchar(10),@DataHj,112) as datetime)
			And ConfigParcelasDebito.NumeroParcela = Debitos.NumeroParcela 
			And DataPgtoDesconto <= Debitos.DataVencimento		
			IF @E_Percentual = 1
			BEGIN 
				IF @Retorno = 0		
					SELECT @Desconto = isnull(cast(@ValorDevido - (@ValorDevido * @ValorPgtoDesconto / 100) AS Decimal(18,2)),0)
				ELSE
					SELECT @Desconto = isnull(cast((@ValorDevido * @ValorPgtoDesconto / 100) AS Decimal(18,2)),0)
			END 
			ELSE
			BEGIN 
				IF @Retorno = 0					
					SELECT @Desconto = isnull(@ValorDevido - @ValorPgtoDesconto,0)
				ELSE
					SELECT @Desconto = isnull(@ValorPgtoDesconto,0)
			END 
		END
		ELSE
		BEGIN
			  /*Oc 44694 Joao Marcelo - Trocando o Debitos.DataVencimento por OpcoesPgtoDesconto.DataPgtoDesconto*/
			IF EXISTS( SELECT TOP 1 1 
							 FROM ConfigGeracaoDebito, ConfigParcelasDebito, OpcoesPgtoDesconto, Debitos 
							 WHERE ConfigGeracaoDebito.IdConfigGeracaoDebito = ConfigParcelasDebito.IdConfigGeracaoDebito 
							 AND ConfigParcelasDebito.IdConfigParcelaDebito = OpcoesPgtoDesconto.IdConfigParcelaDebito 
							 AND ConfigGeracaoDebito.IdTipoDebito IS NULL 
							 AND ConfigParcelasDebito.IdConfigGeracaoDebito = Debitos.IdConfigGeracaoDebito 
							 And IdDebito = @IdDebito AND OpcoesPgtoDesconto.DataPgtoDesconto >= Cast(Convert(varchar(10),@DataHj,112) as datetime)
							 And ConfigParcelasDebito.NumeroParcela = (CASE WHEN Debitos.NumeroParcela = 0 THEN 0 ELSE 1 END) 
							 AND Debitos.DataVencimento >= 
															CASE 
																 WHEN OpcoesPgtoDesconto.DiaAntecipacao IS NULL THEN Debitos.DataVencimento 
																 ELSE
																	CASE WHEN Debitos.DataVencimento >= CAST(CONVERT(VARCHAR(10),@DataHj,112) AS DATETIME) THEN
																		CASE WHEN DATEADD(DAY, - OpcoesPgtoDesconto.DiaAntecipacao, Debitos.DataVencimento) > CAST(CONVERT(VARCHAR(10),@DataHj,112) AS DATETIME) then
																			DATEADD(DAY, - OpcoesPgtoDesconto.DiaAntecipacao, Debitos.DataVencimento) 
																		ELSE
																			Debitos.DataVencimento 
																		END
																	ELSE
																		Debitos.DataVencimento 
																	END
															END)

			 BEGIN
			 	/*OC.43445 ITALO SELECT TOP 1  E TROQUEI O Debitos.DataVencimento POR OpcoesPgtoDesconto.DataPgtoDesconto */
				SELECT TOP 1  @E_Percentual = OpcoesPgtoDesconto.E_Percentual, @ValorPgtoDesconto  = OpcoesPgtoDesconto.ValorPgtoDesconto         	
				FROM ConfigGeracaoDebito, ConfigParcelasDebito, OpcoesPgtoDesconto, Debitos 
				WHERE ConfigGeracaoDebito.IdConfigGeracaoDebito = ConfigParcelasDebito.IdConfigGeracaoDebito 
				AND ConfigParcelasDebito.IdConfigParcelaDebito = OpcoesPgtoDesconto.IdConfigParcelaDebito 
				AND ConfigGeracaoDebito.IdTipoDebito IS NULL 
				AND ConfigParcelasDebito.IdConfigGeracaoDebito = Debitos.IdConfigGeracaoDebito 
				And IdDebito = @IdDebito  AND OpcoesPgtoDesconto.DataPgtoDesconto >= Cast(Convert(varchar(10),@DataHj,112) as datetime)
				And ConfigParcelasDebito.NumeroParcela = (CASE WHEN Debitos.NumeroParcela = 0 THEN 0 ELSE 1 END) 
				AND Debitos.DataVencimento >= 
											CASE 
												 WHEN OpcoesPgtoDesconto.DiaAntecipacao IS NULL THEN Debitos.DataVencimento 
												 ELSE
													CASE WHEN Debitos.DataVencimento >= CAST(CONVERT(VARCHAR(10),@DataHj,112) AS DATETIME) THEN
														CASE WHEN DATEADD(DAY, - OpcoesPgtoDesconto.DiaAntecipacao, Debitos.DataVencimento) > CAST(CONVERT(VARCHAR(10),@DataHj,112) AS DATETIME) then
															DATEADD(DAY, - OpcoesPgtoDesconto.DiaAntecipacao, Debitos.DataVencimento) 
														ELSE
															Debitos.DataVencimento 
														END
													ELSE
														Debitos.DataVencimento 
													END
											END
				IF @E_Percentual = 1
				BEGIN 
					IF @Retorno = 0
						SELECT @Desconto = isnull(cast(@ValorDevido-(@ValorDevido * @ValorPgtoDesconto / 100) AS Decimal(18,2)),0)
					ELSE
						SELECT @Desconto = isnull(cast((@ValorDevido * @ValorPgtoDesconto / 100) AS Decimal(18,2)),0)
				END 
				ELSE
				BEGIN 
					IF @Retorno = 0
						SELECT @Desconto = isnull(@ValorDevido-@ValorPgtoDesconto,0)
					ELSE
						SELECT @Desconto = isnull(@ValorPgtoDesconto,0)
				END 
			 END
			 ELSE
			 BEGIN
				IF @Retorno = 0         	
					SELECT @Desconto = @ValorDevido				
			 END
		END
		RETURN(@Desconto)
	END