
CREATE VIEW [dbo].[AtendimentosPedidosLE_Entregas]
AS
SELECT   dbo.SubItens.IdItem, dbo.MovimentacoesItens.IdUnidade, dbo.MovimentacoesItens.IdLocalEntrega, SUM(dbo.MovimentacoesItens.Qtd) AS QtdEntregue
FROM     dbo.MovimentacoesItens INNER JOIN
         dbo.SubItens ON dbo.MovimentacoesItens.IdSubItem = dbo.SubItens.IdSubItem
WHERE   (dbo.MovimentacoesItens.IdUnidade IS NOT NULL) AND (dbo.MovimentacoesItens.IdLocalEntrega IS NOT NULL)
GROUP BY dbo.SubItens.IdItem, dbo.MovimentacoesItens.IdUnidade, dbo.MovimentacoesItens.IdLocalEntrega