

CREATE VIEW [dbo].[AtendimentosPedidos_Entregas] AS
SELECT dbo.SubItens.IdItem, dbo.MovimentacoesItens.IdUnidade, SUM(dbo.MovimentacoesItens.Qtd) AS QtdEntregue
FROM dbo.MovimentacoesItens INNER JOIN
dbo.SubItens ON dbo.MovimentacoesItens.IdSubItem = dbo.SubItens.IdSubItem
WHERE     (dbo.MovimentacoesItens.IdUnidade IS NOT NULL)
GROUP BY dbo.SubItens.IdItem, dbo.MovimentacoesItens.IdUnidade



