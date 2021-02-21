/*Oc.131908 - Sergio - 02/07/2014*/
/*Oc.118804 - Lucimara - 13/12/2013*/	
/*Oc.131908 - Sergio -Inserido por Rafaela Task 1099 02/07/2014*/

	CREATE PROCEDURE  [dbo].[sp_ApuracaoValorLiquidoBI] 
		@DataDe DATETIME,
		@DataAte DATETIME = 0,
		@intIdTipo integer = 0,
		@lItensAcimaDaVidaUtil BIT = 0
	AS
		
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
		PRINT @EstadoConservDepreciacao
		PRINT @IniciaDepreciacaoPorEstadoConserv
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
						  AND IM.ValorAcumuladoDepreciacao > 0
						  AND IM.DataUltimaDepreciacao BETWEEN @DataDe AND @DataAte
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
	              WHEN ItensImoveis.VidaUtilBI > 0 THEN ItensImoveis.VidaUtilBI
	              ELSE TiposBens.VidaUtil
	           END VidaUtil,
	           CASE 
	              WHEN ItensImoveis.PercentValResidualBI >= 0 THEN ItensImoveis.PercentValResidualBI
	              ELSE TiposBens.PercentValResidual
	           END PercentValResidual           			   
			   INTO #TempItem
		FROM   ItensImoveis
			   INNER JOIN TiposBens
					ON  TiposBens.IdTipo = ItensImoveis.IdTipo
		WHERE  IdItem IN (SELECT IdItem
						  FROM   #TempReavaliacao)
		
		
		--Finalizando o cálculo.
		SELECT #TempReavaliacao.IdItem,
			   CodigoItem,
			   NomeItem,
			   IdTipo,
			   Tipo,
			   DataUltimaDepreciacao,
			   Valor,
			   DataUltimaDepreciacao AS DataContabilizacao,	--DataContabilizacao,
			   ValorAcumuladoDepreciacao ValorAAjustar,
			   (Valor - ValorAcumuladoDepreciacao) AS ValorAjustado,
               QtdMesesDepreciacaoAcumulada,			   
			   VidaUtil,
			   PercentValResidual
		FROM   #TempItem,
			   #TempReavaliacao
		WHERE  #TempItem.IdItem = #TempReavaliacao.IdItem
		
		DROP TABLE #TempItem
		DROP TABLE #TempReavaliacao
		



