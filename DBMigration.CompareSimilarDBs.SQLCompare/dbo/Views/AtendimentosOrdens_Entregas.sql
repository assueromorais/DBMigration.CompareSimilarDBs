

CREATE VIEW dbo.AtendimentosOrdens_Entregas AS 
SELECT 
EntregasOrdens.IdOrdem, 
MovimentacoesItens.IdSubItem AS IdItem, 
SUM(MovimentacoesItens.Qtd) AS QtdEntregue, 
'1' AS Almoxarifado 
FROM dbo.EntregasOrdens 
INNER JOIN dbo.MovimentacoesItens ON dbo.MovimentacoesItens.IdMovimentacaoItem = dbo.EntregasOrdens.IdMovimentacaoItem 
GROUP BY dbo.EntregasOrdens.IdOrdem, dbo.MovimentacoesItens.IdSubItem 
UNION 
SELECT 
IdOrdem, 
IdItemCompra AS IdItem, 
SUM(QtdEntrega) AS QtdEntregue, 
'0' AS Almoxarifado 
FROM dbo.EntregasItensCompras 
GROUP BY IdOrdem, IdItemCompra 




