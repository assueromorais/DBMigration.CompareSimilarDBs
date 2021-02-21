

CREATE VIEW dbo.AtendimentosOrdens_Pedidos AS
SELECT IdOrdem, IdSubItem AS IdItem, SUM(Qtd) AS QtdPedida, '1' AS Almoxarifado 
FROM dbo.ItensOrdens 
GROUP BY IdOrdem, IdSubItem 
UNION 
SELECT IdOrdem, IdItemCompra AS IdItem, SUM(Qtd) AS QtdPedida, '0' AS Almoxarifado 
FROM dbo.ItensComprasOrdens 
GROUP BY IdOrdem, IdItemCompra




