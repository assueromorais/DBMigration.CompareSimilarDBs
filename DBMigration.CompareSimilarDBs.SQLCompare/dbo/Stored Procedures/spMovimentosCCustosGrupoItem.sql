/*Oc. 106685 - Carol*/  
/*Oc. 120606 - BUG 266 - Sergio*/     

CREATE PROCEDURE [dbo].[spMovimentosCCustosGrupoItem]  
 @DataInicial DATETIME,  
 @DataFinal DATETIME,  
 @IdCCusto INT,  
 @IdGrupoItem INT,  
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
        grupositens.NomeGrupoItem,  
        -MovimentacoesItens.Qtd Quantidade,  
        --#Referencia.ValorReferencia ValorUnitario,
        MovimentacoesItens.ValorMovimento/MovimentacoesItens.Qtd ValorUnitario,  
        -- SUM(-MovimentacoesItens.Qtd * #Referencia.ValorReferencia) AS Valor  
        --SUM(ValorMovimento) AS Valor    /*Kleber - 30/06/2010 - OC 64721*/  
        ValorMovimento AS Valor /*Kleber - 30/06/2010 - OC 64721*/  
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
        INNER JOIN grupositens  
             ON  Itens.IdGrupoItem = grupositens.IdGrupoItem  
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
        AND (  
                (@IdCCusto = 0)  
                OR (CentroCustos.IdCentroCusto = @IdCCusto)  
            )  
        AND (  
                (@IdGrupoItem = 0)  
                OR (grupositens.IdGrupoItem = @IdGrupoItem)  
            )   
            --GROUP BY SubItens.IdSubItem, Itens.CodigoItem, SubItens.NomeSubItem, CentroCustos.CodigoCentroCusto, CentroCustos.NomeCentroCusto,grupositens.NomeGrupoItem, MovimentacoesItens.Qtd, #Referencia.ValorReferencia    /*Kleber - 30/06/2010 - OC 64721*/  
 ORDER BY  
        CodigoCentroCusto,  
        grupositens.NomeGrupoItem,  
        Itens.CodigoItem   
   
 DROP TABLE #Referencia   
 SET NOCOUNT OFF  
END  
  
  
