


CREATE VIEW [dbo].[AtendimentosPedidos_EnvioRegPreco]
AS
SELECT  dbo.SubItens.IdItem, dbo.MovimentacoesRegPrecos.IdUnidade, SUM(dbo.MovimentacoesRegPrecos.Qtd) AS QtdEnviada
FROM    dbo.MovimentacoesRegPrecos 
INNER JOIN dbo.SubItens ON dbo.MovimentacoesRegPrecos.IdSubItem = dbo.SubItens.IdSubItem
WHERE  (dbo.MovimentacoesRegPrecos.IdUnidade IS NOT NULL)
GROUP BY dbo.SubItens.IdItem, dbo.MovimentacoesRegPrecos.IdUnidade




