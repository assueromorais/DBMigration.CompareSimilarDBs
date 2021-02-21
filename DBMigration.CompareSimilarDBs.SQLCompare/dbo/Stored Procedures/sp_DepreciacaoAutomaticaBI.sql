/*Oc.122652 - Lucimara - 20/01/2014*/
/*Oc.122652 - Lucimara - 20/02/2014 BUG 125022*/
CREATE PROCEDURE  [dbo].[sp_DepreciacaoAutomaticaBI] 

	@DataDe DATETIME,
	@DataAte DATETIME = 0,
	@intIdTipo integer = 0,
	@lItensAcimaDaVidaUtil BIT = 0
AS
	/*
	DECLARE @DataDe         DATETIME = '20121115',
	@DataAte                DATETIME = '20131213',
	@intIdTipo              integer = 0,
	@lItensAcimaDaVidaUtil  BIT = 0
	*/

	IF @DataAte = 0
	    SET @DataAte = GETDATE()
		
	DECLARE @EstadoConservDepreciacao           INT,
	        @PeridiocidadeDepreciacao           INT,
	        @IniciaDepreciacaoPorEstadoConserv  BIT
	
	--Verificando Configurações
	SELECT @EstadoConservDepreciacao = ISNULL(IdEstadoConservDepreciacao, 0),
	       @IniciaDepreciacaoPorEstadoConserv = ISNULL(IniciaDepreciacaoPorEstadoConserv, 0),
	       @PeridiocidadeDepreciacao = ISNULL(PeridiocidadeDepreciacaoBI, 0)
	FROM   ConfiguracoesSG
	
	--Trazendo os itens, a data da última reavaliação com seu respectivo valor, e que pelo menos já possuam uma
	--reavaliação com o Estado de conservação inicial da Depreciação
	SELECT *,
	       (
	           SELECT R2.Valor
	           FROM   Reavaliacoes R2
	           WHERE  R2.IdItem = A.IdItem
	                  AND R2.DataReavaliacao = A.DataReavaliacao
                          AND R2.TipoBem = 'I'
	       ) Valor
	       INTO #TempReavaliacao
	FROM   (
	           SELECT R.IdItem,
	                  MAX(DataReavaliacao) DataReavaliacao
	           FROM   Reavaliacoes AS R
	                  INNER JOIN ItensImoveis IM
	                       ON  IM.IdItem = R.IdItem
	                  INNER JOIN TiposBens
	                       ON  TiposBens.IdTipo = IM.IdTipo
	           WHERE  R.TipoBem = 'I'
	                  AND (
	                          (@IniciaDepreciacaoPorEstadoConserv = 0)
	                          OR (
	                                 1 = (
	                                     SELECT TOP 1 1
	                                     FROM   Reavaliacoes R3
	                                     WHERE  R3.IdItem = R.IdItem
	                                            AND R3.IdEstadoConservacao = @EstadoConservDepreciacao
	                                 )
	                             )
	                      )
	                  AND TiposBens.SofreDepreciacao = 1
	                  AND ((@intIdTipo = 0) OR (IM.IdTipo = @intIdTipo))
	           GROUP BY
	                  R.IdItem
	       ) A
	
	
	--Trazendo os valores necessários para o cálculo
	SELECT IdItem,
	   CodigoItem,
	   NomeItem,
	   TiposBens.IdTipo,
	   Tipo,
	   ValorAquisicao,
	   DataUltimaDepreciacao,
	   ValorAcumuladoDepreciacao,
	   QtdMesesDepreciacaoAcumulada, 
       CASE 
			WHEN hcd.VResidualPercent IS NOT NULL THEN
				 hcd.VResidualPercent
			ELSE	 
				 CASE 
					WHEN ItensImoveis.PercentValResidualBI > 0 THEN ItensImoveis.PercentValResidualBI
					ELSE TiposBens.PercentValResidual
				 END	
	   END PercentValResidual,
       CASE 
			WHEN hcd.VidaUtilAnos IS NOT NULL THEN
				 hcd.VidaUtilAnos
			ELSE	 
				 CASE 
					WHEN ItensImoveis.VidaUtilBI > 0 THEN ItensImoveis.VidaUtilBI
					ELSE TiposBens.VidaUtil
				 END	
       END VidaUtil,
       hcd.IdHistoricoConfigDepreciacaoBI,
	   /*hcd.IdReavaliacao,
	   hcd.ConfigAlteradaPorItem,
		   hcd.Data,*/
	   hcd.QtdMesesRestantes,
	   hcd.TaxaDepreciacaoMensal       
	INTO #TempItem
	FROM   ItensImoveis
	       INNER JOIN TiposBens
	            ON  TiposBens.IdTipo = ItensImoveis.IdTipo
           LEFT JOIN HistoricoConfigDepreciacaoBI hcd
                ON  hcd.IdItemImovel = ItensImoveis.IdItem
                    AND hcd.IdHistoricoConfigDepreciacaoBI = (
                    SELECT MAX(hcd2.IdHistoricoConfigDepreciacaoBI)
                    FROM   HistoricoConfigDepreciacaoBI hcd2
                    WHERE  hcd2.IdItemImovel = hcd.IdItemImovel
                )	            
	WHERE  IdItem IN (SELECT IdItem
	                  FROM   #TempReavaliacao)
	
	--Verificando a taxa de cálculo
	SELECT #TempReavaliacao.IdItem,
	       CASE 
				WHEN TaxaDepreciacaoMensal IS NULL THEN 
	       	       ( CAST(100 AS MONEY) / CAST(VidaUtil AS MONEY) / CAST(12 AS MONEY))
	       	    ELSE
	       			TaxaDepreciacaoMensal
	       END TaxaMensal,	
	       CASE 
	            WHEN DAY(
	                     CASE 
	                          WHEN DataUltimaDepreciacao IS NULL THEN 
	                               DataReavaliacao
	                          ELSE DataUltimaDepreciacao
	                     END
	                 ) <= DAY(@DataAte) THEN (
	                     DATEDIFF(
	                         MONTH,
	                         CASE 
	                              WHEN DataUltimaDepreciacao IS NULL THEN 
	                                   DataReavaliacao
	                              ELSE DataUltimaDepreciacao
	                         END,
	                         @DataAte
	                     )
	                 )
	            ELSE (
	                     DATEDIFF(
	                         MONTH,
	                         CASE 
	                              WHEN DataUltimaDepreciacao IS NULL THEN 
	                                   DataReavaliacao
	                              ELSE DataUltimaDepreciacao
	                         END,
	                         @DataAte
	                     ) - 1
	                 )
	       END QtdMesesSemDepreciacao,
           (DATEDIFF(DAY,
                     CASE 
	                     WHEN DataUltimaDepreciacao IS NULL THEN 
	                          DataReavaliacao
	                     ELSE DataUltimaDepreciacao
	                 END,
	                 @DataAte
	                 )	       
	       )AS QtdDiasSemDepreciacao,
	       CASE 
				WHEN QtdMesesRestantes IS NULL THEN 
	       	       99999
	       	    ELSE
	       		   (QtdMesesRestantes - QtdMesesDepreciacaoAcumulada) 
	       END QtdMesesRestantesAtualizado           	       	       	       
	       INTO #TempTaxa
	FROM   #TempItem,
	       #TempReavaliacao
	WHERE  #TempItem.IdItem = #TempReavaliacao.IdItem
	      AND ((CASE 
	               WHEN DataUltimaDepreciacao IS NULL THEN 
	                  (DataReavaliacao + (@PeridiocidadeDepreciacao * 30))
	               ELSE 
	               	  (DataUltimaDepreciacao + (@PeridiocidadeDepreciacao * 30))               		                    
	            END >= @DataDe ) AND
               (CASE 
				   WHEN QtdMesesRestantes IS NULL THEN 
	       	          99999
	       	       ELSE
	       		      (QtdMesesRestantes - QtdMesesDepreciacaoAcumulada) 
                END > 0))  /*  ??????????????????  */ 

				
	--Verificando a Taxa Real do período de cálculo  e o Fator indicador de quantos períodos ficaram sem depreciação
	SELECT #TempTaxa.IdItem,
	       CASE 
	            WHEN ((QtdMesesSemDepreciacao >= @PeridiocidadeDepreciacao) AND (QtdDiasSemDepreciacao >= @PeridiocidadeDepreciacao * 30)) 
                     OR (QtdMesesRestantesAtualizado > 0) THEN	                 
	                  TaxaMensal * @PeridiocidadeDepreciacao
	            ELSE 0
	       END TaxaReal,
	       CASE 
	            WHEN ((QtdMesesSemDepreciacao >= @PeridiocidadeDepreciacao) AND (QtdDiasSemDepreciacao >= @PeridiocidadeDepreciacao * 30)) 
                     OR (QtdMesesRestantesAtualizado > 0) THEN	                 
	                  FLOOR(QtdMesesSemDepreciacao / @PeridiocidadeDepreciacao)
	            ELSE 0
	       END FatorMultiplicador,
	       QtdMesesRestantesAtualizado
	       INTO #TempTaxaReal
	FROM   #TempTaxa
	
	--Calculando o valor a depreciar
	SELECT #TempReavaliacao.IdItem,
	       CASE		
	            WHEN @lItensAcimaDaVidaUtil = 0 THEN (
	                     (Valor -(ValorAquisicao * PercentValResidual / 100)) 
	                      * (TaxaReal * FatorMultiplicador) / 100
	                 )
	            ELSE CASE 
	                      WHEN (TaxaReal * FatorMultiplicador) > 100 THEN (Valor -(ValorAquisicao * PercentValResidual / 100))
	                      ELSE (
	                               (Valor -(ValorAquisicao * PercentValResidual / 100)) 
	                               * (TaxaReal * FatorMultiplicador) / 100
	                           )
	                 END
	       END ValorADepreciar,
	       (
	           DATEADD(
	               MONTH,
	               (FatorMultiplicador * @PeridiocidadeDepreciacao),
	               CASE 
	                    WHEN DataUltimaDepreciacao IS NULL THEN DataReavaliacao
	                    ELSE DataUltimaDepreciacao
	               END
	           )
	       ) AS DataContabilizacao,
	       (ValorAquisicao * PercentValResidual / 100) AS ValorResidual
	       INTO #TempValoraDepreciar
	FROM   #TempItem,
	       #TempReavaliacao,
	       #TempTaxaReal
	WHERE  #TempItem.IdItem = #TempReavaliacao.IdItem
	       AND #TempItem.IdItem = #TempTaxaReal.IdItem
	       AND FatorMultiplicador >= 1
	       AND #TempReavaliacao.Valor > 0.01 
	
	--Finalizando o cálculo.
	SELECT #TempReavaliacao.IdItem,
	       CodigoItem,
	       NomeItem,
	       IdTipo,
	       Tipo,
	       DataReavaliacao,
	       Valor,
	       DataContabilizacao,
	       ValorADepreciar,
	       (Valor - ValorADepreciar) AS ValorDepreciado,
	       VidaUtil,
	       PercentValResidual,
	       TaxaReal,
	       FatorMultiplicador,
	       ValorResidual,
	       (Valor - ValorResidual) AS TotalADepreciar,
	       CASE 
	            WHEN @lItensAcimaDaVidaUtil = 0 THEN (TaxaReal * FatorMultiplicador)
	            ELSE CASE 
	                      WHEN (TaxaReal * FatorMultiplicador) <= 100 THEN (TaxaReal * FatorMultiplicador)
	                      ELSE 100
	                 END
	       END TaxaAcumulada,
	       QtdMesesRestantesAtualizado,
	       (@PeridiocidadeDepreciacao * FatorMultiplicador) QtdMesesADepreciar,	       
	       DataUltimaDepreciacao,
	       #TempItem.ValorAcumuladoDepreciacao,
           #TempItem.QtdMesesDepreciacaoAcumulada	       
	FROM   #TempItem,
	       #TempReavaliacao,
	       #TempTaxaReal,
	       #TempValoraDepreciar
	WHERE  #TempItem.IdItem = #TempReavaliacao.IdItem
	       AND #TempItem.IdItem = #TempTaxaReal.IdItem
	       AND #TempItem.IdItem = #TempValoraDepreciar.IdItem 
	           --AND Valor - ValorADepreciar >= ValorResidual
	       AND CAST(Valor AS MONEY) - CAST(ValorADepreciar AS MONEY) >= CAST(ValorResidual AS MONEY)
	       AND DataContabilizacao BETWEEN @DataDe AND @DataAte
	ORDER BY
	       CodigoItem
	
	DROP TABLE #TempItem
	DROP TABLE #TempReavaliacao
	DROP TABLE #TempTaxa
	DROP TABLE #TempTaxaReal
	DROP TABLE #TempValoraDepreciar






