


CREATE VIEW [dbo].[AtendimentosPedidos_EntregasSemRegPreco]
AS
SELECT     dbo.SubItens.IdItem, dbo.MovimentacoesItens.IdUnidade, SUM(dbo.MovimentacoesItens.Qtd) AS QtdEntregueSemRegPreco
FROM       dbo.MovimentacoesItens INNER JOIN
           dbo.SubItens ON dbo.MovimentacoesItens.IdSubItem = dbo.SubItens.IdSubItem
WHERE     (dbo.MovimentacoesItens.IdUnidade IS NOT NULL) AND (dbo.MovimentacoesItens.MovimentacaoDeRegistroPreco = 0)
GROUP BY dbo.SubItens.IdItem, dbo.MovimentacoesItens.IdUnidade




