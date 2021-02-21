


CREATE VIEW [dbo].[AtendimentosPedidosRegPreco]
AS
SELECT  dbo.AtendimentosPedidos_Pedidos.IdItem, dbo.Itens.NomeItem, dbo.AtendimentosPedidos_Pedidos.IdUnidade, dbo.Unidades.NomeUnidade, 
                      dbo.Medidas.NomeMedida,
                      dbo.AtendimentosPedidos_Pedidos.QtdPedida + ISNULL(dbo.AtendimentosPedidos_EnvioRegPreco.QtdEnviada, 0) + ISNULL(dbo.AtendimentosPedidos_EntregasSemRegPreco.QtdEntregueSemRegPreco, 0) AS QtdQueFaltaEnviar,
                      dbo.Itens.ItemEmModalidadeRegPreco, dbo.Itens.IdPessoa
FROM    dbo.AtendimentosPedidos_Pedidos  
    LEFT OUTER JOIN   dbo.AtendimentosPedidos_EnvioRegPreco ON dbo.AtendimentosPedidos_EnvioRegPreco.IdItem = dbo.AtendimentosPedidos_Pedidos.IdItem AND 
                      dbo.AtendimentosPedidos_EnvioRegPreco.IdUnidade = dbo.AtendimentosPedidos_Pedidos.IdUnidade
    LEFT OUTER JOIN   dbo.AtendimentosPedidos_EntregasSemRegPreco ON dbo.AtendimentosPedidos_EntregasSemRegPreco.IdItem = dbo.AtendimentosPedidos_Pedidos.IdItem AND 
                      dbo.AtendimentosPedidos_EntregasSemRegPreco.IdUnidade = dbo.AtendimentosPedidos_Pedidos.IdUnidade INNER JOIN                      
                      dbo.Itens ON dbo.Itens.IdItem = dbo.AtendimentosPedidos_Pedidos.IdItem INNER JOIN
                      dbo.Medidas ON dbo.Medidas.IdMedida = dbo.Itens.IdMedidaPadrao INNER JOIN
                      dbo.Unidades ON dbo.Unidades.IdUnidade = dbo.AtendimentosPedidos_Pedidos.IdUnidade 
WHERE   (dbo.AtendimentosPedidos_Pedidos.QtdPedida + ISNULL(dbo.AtendimentosPedidos_EnvioRegPreco.QtdEnviada, 0) + ISNULL(dbo.AtendimentosPedidos_EntregasSemRegPreco.QtdEntregueSemRegPreco, 0) > 0)




