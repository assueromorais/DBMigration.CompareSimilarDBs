Create FUNCTION [dbo].[VencimentoComDesconto] (@IdDebito int, @DataHj datetime)
		RETURNS DateTime
		AS
		BEGIN
		DECLARE @VencimentoDesconto Datetime, @DataPgtoDesconto datetime
		SELECT @VencimentoDesconto = Debitos.DataVencimento FROM Debitos WHERE IdDebito = @IdDebito
		
		IF EXISTS (Select TOP 1 1 From Debitos, ConfigParcelasDebito, OpcoesPgtoDesconto 
					Where ConfigParcelasDebito.IdConfigGeracaoDebito = Debitos.IdConfigGeracaoDebito 
					And OpcoesPgtoDesconto.IdConfigParcelaDebito = ConfigParcelasDebito.IdConfigParcelaDebito 
					And IdDebito = @IdDebito
					And ConfigParcelasDebito.NumeroParcela = Debitos.NumeroParcela 
					And DataPgtoDesconto <= Debitos.DataVencimento)
		BEGIN
			/*OC.43445 ITALO SELECT TOP 1  E TROQUEI O Debitos.DataVencimento POR OpcoesPgtoDesconto.DataPgtoDesconto */
			SELECT TOP 1 @VencimentoDesconto /*@DataPgtoDesconto*/ = OpcoesPgtoDesconto.DataPgtoDesconto
			From Debitos, ConfigParcelasDebito, OpcoesPgtoDesconto 
			Where ConfigParcelasDebito.IdConfigGeracaoDebito = Debitos.IdConfigGeracaoDebito 
			And OpcoesPgtoDesconto.IdConfigParcelaDebito = ConfigParcelasDebito.IdConfigParcelaDebito 
			And IdDebito = @IdDebito
			And ConfigParcelasDebito.NumeroParcela = Debitos.NumeroParcela 
			And DataPgtoDesconto >= Cast(Convert(varchar(10),@DataHj,112) as datetime)
		END
		ELSE
		BEGIN			 
			IF EXISTS( SELECT TOP 1 1
					  FROM   Debitos d 
					  JOIN   ConfigGeracaoDebito cgd  ON   cgd.IdConfigGeracaoDebito = d.IdConfigGeracaoDebito 
					  /*JOIN   ConfigParcelasDebito cpd  ON   cpd.IdConfigGeracaoDebito = cgd.IdConfigGeracaoDebito  */
					  JOIN   ConfigParcelasDebito cpd  ON   cpd.IdConfigGeracaoDebito = cgd.IdConfigGeracaoDebito AND  cpd.NumeroParcela = (CASE WHEN D.NumeroParcela = 0 THEN 0 ELSE 1 END) 				  
					  JOIN   OpcoesPgtoDesconto opd  ON   opd.IdConfigParcelaDebito = cpd.IdConfigParcelaDebito 
					  WHERE  d.IdDebito = @IdDebito AND cgd.IdTipoDebito IS NULL )
			 BEGIN
				SELECT @VencimentoDesconto = CASE 
												  WHEN opd.DiaAntecipacao IS NULL THEN d.DataVencimento
												  ELSE CASE 
															WHEN D.DataVencimento >= CAST(CONVERT(VARCHAR(10),@DataHj,112) AS DATETIME) THEN 
			                                            		CASE 
																	WHEN DATEADD(DAY, - opd.DiaAntecipacao, d.DataVencimento) > CAST(CONVERT(VARCHAR(10),@DataHj,112) AS DATETIME) THEN 
																			DATEADD(DAY, - opd.DiaAntecipacao, d.DataVencimento)
																	WHEN DATEADD(DAY, - opd.DiaAntecipacao, d.DataVencimento) <= CAST(CONVERT(VARCHAR(10),@DataHj,112) AS DATETIME) THEN 
																			CAST(CONVERT(VARCHAR(10),@DataHj,112) AS DATETIME)
																	ELSE d.DataVencimento
															   END
															ELSE d.DataVencimento
													   END
											 END
				FROM   Debitos d
				JOIN   ConfigGeracaoDebito cgd ON   cgd.IdConfigGeracaoDebito = d.IdConfigGeracaoDebito
				/*JOIN   ConfigParcelasDebito cpd ON   cpd.IdConfigGeracaoDebito = cgd.IdConfigGeracaoDebito*/
				JOIN   ConfigParcelasDebito cpd  ON   cpd.IdConfigGeracaoDebito = cgd.IdConfigGeracaoDebito AND  cpd.NumeroParcela = (CASE WHEN D.NumeroParcela = 0 THEN 0 ELSE 1 END) 
				JOIN   OpcoesPgtoDesconto opd  ON   opd.IdConfigParcelaDebito = cpd.IdConfigParcelaDebito
				WHERE  d.IdDebito = @IdDebito
				  AND  cgd.IdTipoDebito IS NULL 
			 END
		END
		RETURN(@VencimentoDesconto)
	END