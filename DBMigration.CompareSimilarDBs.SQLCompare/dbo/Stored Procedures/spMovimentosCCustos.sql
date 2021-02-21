/*Oc. 106685 - Carol*/

CREATE PROCEDURE [dbo].[spMovimentosCCustos]
	@DataInicial DATETIME,
	@DataFinal DATETIME,
	@IdCCusto INT,
	@MovimentacaoRP1 BIT,
	@MovimentacaoRP2 BIT
AS
BEGIN
	SET NOCOUNT ON     
	
	CREATE TABLE #Referencia
	(
		IdItem           INT,
		DataReferencia   DATETIME,
		ValorReferencia  MONEY
	)     
	
	INSERT #Referencia
	SELECT Itens.IdItem,
	       ItemReferencia.DataValorReferencia,
	       ISNULL(ItemReferencia.ValorReferencia, 0)
	FROM   Itens
	       LEFT JOIN (
	                SELECT IdItem,
	                       DataValorReferencia,
	                       ValorReferencia
	                FROM   Itens
	                WHERE  DataValorReferencia <= @datafinal
	                       AND DataValorReferencia IS NOT NULL
	                       AND ValorReferencia IS NOT NULL
	            ) ItemReferencia
	            ON  ItemReferencia.IdItem = Itens.IdItem     
	
	UPDATE #Referencia
	SET    ValorReferencia = UltimaEntrega.ValorReferencia
	FROM   #Referencia,
	       (
	           SELECT IdItem,
	                  MAX(DataReferencia) AS DataReferencia,
	                  MAX(ValorReferencia) AS ValorReferencia
	           FROM   EntregasOrdens
	                  INNER JOIN SubItens
	                       ON  SubItens.IdSubItem = EntregasOrdens.IdSubItem
	           WHERE  DataReferencia <= @datafinal
	           GROUP BY
	                  IdItem
	       ) UltimaEntrega
	WHERE  #Referencia.IdItem = UltimaEntrega.IdItem
	       AND (
	               UltimaEntrega.DataReferencia > #Referencia.DataReferencia
	               OR #Referencia.DataReferencia IS NULL
	           )     
	
	
	IF @IdCCusto = 0
	BEGIN
	    SELECT SubItens.IdSubItem,
	           Itens.CodigoItem,
	           SubItens.NomeSubItem,
	           ISNULL(
	               CentroCustos.CodigoCentroCusto,
	               CASE 
	                    WHEN MovimentacoesItens.IdInventario IS NULL THEN 9999
	                    ELSE 99991
	               END
	           ) AS CodigoCentroCusto,
	           ISNULL(
	               CentroCustos.NomeCentroCusto,
	               CASE 
	                    WHEN MovimentacoesItens.IdInventario IS NULL THEN 
	                         'Itens Devolvidos ao Fornecedor'
	                    ELSE 'Itens Ajustados via Inventário'
	               END
	           ) AS NomeCentroCusto,
	           SUM(-MovimentacoesItens.Qtd) AS Qtd,
	           -- SUM(-MovimentacoesItens.Qtd * #Referencia.ValorReferencia) AS Valor     
	           SUM(ValorMovimento) AS Valor,
	           (
	               SELECT ISNULL(SUM(Qtd), 0)
	               FROM   MovimentacoesItens
	               WHERE  DataMovimentacao <= @DataFinal
	                      AND MovimentacoesItens.IdSubItem = SubItens.IdSubItem
	                      AND MovimentacoesItens.IdMovimentacaoItem <= (
	                              SELECT TOP 1 IdMovimentacaoItem
	                              FROM   MovimentacoesItens
	                              WHERE  DataMovimentacao <= @DataFinal
	                                     AND MovimentacoesItens.IdSubItem = 
	                                         SubItens.IdSubItem
	                              ORDER BY
	                                     IdMovimentacaoItem DESC
	                          )
	           ) AS SaldoMovimento
	    FROM   MovimentacoesItens
	           LEFT JOIN Unidades
	                ON  MovimentacoesItens.IdUnidade = Unidades.IdUnidade
	           LEFT JOIN UnidadesCentroCustosAno
	                ON  UnidadesCentroCustosAno.IdUnidade = Unidades.IdUnidade -- PluriAnual     
	                    
	           LEFT JOIN CentroCustos
	                ON  UnidadesCentroCustosAno.IdCentroCusto = CentroCustos.IdCentroCusto -- PluriAnual     
	                    
	           INNER JOIN SubItens
	                ON  MovimentacoesItens.IdSubItem = SubItens.IdSubItem
	           INNER JOIN Itens
	                ON  Itens.IdItem = SubItens.IdItem
	           INNER JOIN #Referencia
	                ON  SubItens.IdItem = #Referencia.IdItem
	    WHERE  DataMovimentacao >= @DataInicial
	           AND DataMovimentacao <= @DataFinal
	           AND ISNULL(UnidadesCentroCustosAno.Exercicio, 0) = CASE WHEN EXISTS (SELECT TOP 1 1 FROM PlanoContas WHERE  Exercicio = YEAR(@DataFinal)) THEN YEAR(GETDATE()) ELSE 0 END
	           AND MovimentacoesItens.Qtd < 0
	           AND (
	                   (MovimentacaoDeRegistroPreco = @MovimentacaoRP1)
	                   OR (MovimentacaoDeRegistroPreco = @MovimentacaoRP2)
	               )
	    GROUP BY
	           SubItens.IdSubItem,
	           Itens.CodigoItem,
	           SubItens.NomeSubItem,
	           CodigoCentroCusto,
	           NomeCentroCusto,
	           IdInventario
	    ORDER BY
	           CentroCustos.CodigoCentroCusto
	END
	ELSE
	BEGIN
	    SELECT SubItens.IdSubItem,
	           Itens.CodigoItem,
	           SubItens.NomeSubItem,
	           CentroCustos.CodigoCentroCusto,
	           CentroCustos.NomeCentroCusto,
	           SUM(-MovimentacoesItens.Qtd) AS Qtd,
	           --  SUM(-MovimentacoesItens.Qtd * #Referencia.ValorReferencia) AS Valor     
	           SUM(ValorMovimento) AS Valor,
	           (
	               SELECT ISNULL(SUM(Qtd), 0)
	               FROM   MovimentacoesItens
	               WHERE  DataMovimentacao <= @DataFinal
	                      AND MovimentacoesItens.IdSubItem = SubItens.IdSubItem
	                      AND MovimentacoesItens.IdMovimentacaoItem <= (
	                              SELECT TOP 1 IdMovimentacaoItem
	                              FROM   MovimentacoesItens
	                              WHERE  DataMovimentacao <= @DataFinal
	                                     AND MovimentacoesItens.IdSubItem = 
	                                         SubItens.IdSubItem
	                              ORDER BY
	                                     IdMovimentacaoItem DESC
	                          )
	           ) AS SaldoMovimento
	    FROM   MovimentacoesItens
	           INNER JOIN Unidades
	                ON  MovimentacoesItens.IdUnidade = Unidades.IdUnidade
	           LEFT JOIN UnidadesCentroCustosAno
	                ON  UnidadesCentroCustosAno.IdUnidade = Unidades.IdUnidade -- PluriAnual     
	                    
	           LEFT JOIN CentroCustos
	                ON  UnidadesCentroCustosAno.IdCentroCusto = CentroCustos.IdCentroCusto -- PluriAnual     
	                    
	           INNER JOIN SubItens
	                ON  MovimentacoesItens.IdSubItem = SubItens.IdSubItem
	           INNER JOIN Itens
	                ON  Itens.IdItem = SubItens.IdItem
	           INNER JOIN #Referencia
	                ON  SubItens.IdItem = #Referencia.IdItem
	    WHERE  DataMovimentacao >= @DataInicial
	           AND DataMovimentacao <= @DataFinal
	           AND ISNULL(UnidadesCentroCustosAno.Exercicio, 0) = CASE WHEN EXISTS (SELECT TOP 1 1 FROM PlanoContas WHERE  Exercicio = YEAR(@DataFinal)) THEN YEAR(GETDATE()) ELSE 0 END
	           AND (
	                   (MovimentacaoDeRegistroPreco = @MovimentacaoRP1)
	                   OR (MovimentacaoDeRegistroPreco = @MovimentacaoRP2)
	               )
	           AND CentroCustos.IdCentroCusto = @IdCCusto
	    GROUP BY
	           SubItens.IdSubItem,
	           Itens.CodigoItem,
	           SubItens.NomeSubItem,
	           CentroCustos.CodigoCentroCusto,
	           CentroCustos.NomeCentroCusto
	    ORDER BY
	           CentroCustos.CodigoCentroCusto
	END 
	
	DROP TABLE #Referencia  
	SET NOCOUNT OFF
END


