

CREATE VIEW [dbo].[EstoquesSubItensporAlmoxarifado]
AS
SELECT  dbo.SubItens.IdSubItem, dbo.SubItens.NomeSubItem, dbo.Almoxarifados.IdAlmoxarifado, dbo.Almoxarifados.NomeAlmoxarifado, SUM(dbo.MovimentacoesItens.Qtd) AS EstoqueAtualAlmoxarifado
FROM    dbo.SubItens 
INNER JOIN dbo.MovimentacoesItens ON dbo.MovimentacoesItens.IdSubItem = dbo.SubItens.IdSubItem
INNER JOIN dbo.Almoxarifados ON dbo.Almoxarifados.IdAlmoxarifado = dbo.MovimentacoesItens.IdAlmoxarifado
GROUP BY  dbo.SubItens.IdSubItem, dbo.SubItens.NomeSubItem, dbo.Almoxarifados.IdAlmoxarifado, dbo.Almoxarifados.NomeAlmoxarifado



