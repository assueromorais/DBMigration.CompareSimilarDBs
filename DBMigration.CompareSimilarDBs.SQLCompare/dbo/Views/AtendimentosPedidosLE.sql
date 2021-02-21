CREATE VIEW [dbo].[AtendimentosPedidosLE]
AS
SELECT  dbo.AtendimentosPedidosLE_Pedidos.IdItem, dbo.Itens.NomeItem, dbo.AtendimentosPedidosLE_Pedidos.IdUnidade, dbo.Unidades.NomeUnidade, 
            dbo.AtendimentosPedidosLE_Pedidos.IdLocalEntrega, dbo.LocaisEntrega.TituloLocal, 
            dbo.Medidas.NomeMedida, dbo.Atendimentos_Estoques.EstoqueAtual, 
            dbo.AtendimentosPedidosLE_Pedidos.QtdPedida + ISNULL(dbo.AtendimentosPedidosLE_Entregas.QtdEntregue, 0) AS QtdQueFaltaEntregar,
            dbo.Itens.ItemEmModalidadeRegPreco
FROM    dbo.AtendimentosPedidosLE_Pedidos LEFT OUTER JOIN
            dbo.AtendimentosPedidosLE_Entregas ON dbo.AtendimentosPedidosLE_Entregas.IdItem = dbo.AtendimentosPedidosLE_Pedidos.IdItem AND 
            dbo.AtendimentosPedidosLE_Entregas.IdUnidade = dbo.AtendimentosPedidosLE_Pedidos.IdUnidade AND dbo.AtendimentosPedidosLE_Entregas.IdLocalEntrega = dbo.AtendimentosPedidosLE_Pedidos.IdLocalEntrega INNER JOIN
            dbo.Itens ON dbo.Itens.IdItem = dbo.AtendimentosPedidosLE_Pedidos.IdItem INNER JOIN
            dbo.Medidas ON dbo.Medidas.IdMedida = dbo.Itens.IdMedidaPadrao INNER JOIN
            dbo.Unidades ON dbo.Unidades.IdUnidade = dbo.AtendimentosPedidosLE_Pedidos.IdUnidade INNER JOIN
            dbo.LocaisEntrega ON dbo.LocaisEntrega.IdLocalEntrega = dbo.AtendimentosPedidosLE_Pedidos.IdLocalEntrega INNER JOIN
            dbo.Atendimentos_Estoques ON dbo.Atendimentos_Estoques.IdItem = dbo.AtendimentosPedidosLE_Pedidos.IdItem
WHERE  (dbo.AtendimentosPedidosLE_Pedidos.QtdPedida + ISNULL(dbo.AtendimentosPedidosLE_Entregas.QtdEntregue, 0) > 0)