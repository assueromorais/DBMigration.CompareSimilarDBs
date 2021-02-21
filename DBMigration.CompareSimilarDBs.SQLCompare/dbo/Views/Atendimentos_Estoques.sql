

CREATE  VIEW [dbo].[Atendimentos_Estoques]
AS
SELECT     dbo.SubItens.IdItem, ISNULL(SUM(dbo.MovimentacoesItens.Qtd), 0) AS EstoqueAtual
FROM         dbo.SubItens LEFT OUTER JOIN
                      dbo.MovimentacoesItens ON dbo.SubItens.IdSubItem = dbo.MovimentacoesItens.IdSubItem
GROUP BY dbo.SubItens.IdItem




