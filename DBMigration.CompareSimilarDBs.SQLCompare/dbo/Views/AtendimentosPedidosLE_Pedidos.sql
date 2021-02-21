
CREATE  VIEW [dbo].[AtendimentosPedidosLE_Pedidos]
AS
SELECT   dbo.ItensPedidos.IdItem, dbo.Pedidos.IdUnidade, dbo.Pedidos.IdLocalEntrega, SUM(dbo.ItensPedidos.Qtd) AS QtdPedida
FROM     dbo.ItensPedidos INNER JOIN
         dbo.Pedidos ON dbo.Pedidos.IdPedido = dbo.ItensPedidos.IdPedido
WHERE   (dbo.Pedidos.IdUnidade IS NOT NULL) AND (dbo.Pedidos.IdLocalEntrega IS NOT NULL)
GROUP BY dbo.ItensPedidos.IdItem, dbo.Pedidos.IdUnidade, dbo.Pedidos.IdLocalEntrega