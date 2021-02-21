

CREATE VIEW dbo.EstoqueAtualcomUltimasCompras AS
SELECT 
dbo.SubItens.IdSubItem, 
dbo.SubItens.NomeSubItem, 
dbo.Medidas.NomeMedida, 
dbo.Itens.EstoqueMinimo, 
(SELECT ISNULL(SUM(dbo.MovimentacoesItens.Qtd), 0) FROM dbo.MovimentacoesItens WHERE dbo.MovimentacoesItens.IdSubItem = dbo.SubItens.IdSubItem) AS EstoqueAtual, 
dbo.Estoques_UltimasCompras.DataUltimaCompra, 
dbo.Estoques_UltimasCompras.QtdUltimaCompra, 
dbo.Estoques_UltimasCompras.ValorUltimaCompra
FROM dbo.SubItens 
INNER JOIN dbo.Itens ON dbo.Itens.IdItem = dbo.SubItens.IdItem 
INNER JOIN dbo.Medidas ON dbo.Itens.IdMedidaPadrao = dbo.Medidas.IdMedida 
LEFT OUTER JOIN dbo.Estoques_UltimasCompras ON dbo.Estoques_UltimasCompras.IdSubItem = dbo.SubItens.IdSubItem




