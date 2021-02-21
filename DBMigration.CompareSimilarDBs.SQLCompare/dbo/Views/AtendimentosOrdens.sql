

CREATE VIEW dbo.AtendimentosOrdens AS 
SELECT 
AtendimentosOrdens_Pedidos.IdItem, 
ItensCompras.NomeItemCompra AS NomeItem, 
AtendimentosOrdens_Pedidos.IdOrdem, 
Ordens.DataOrdem, 
Ordens.NumeroOrdem, 
Ordens.Valor, 
Ordens.IdContrato, 
Ordens.Empenho, 
Ordens.IdPessoa, 
Ordens.DataPrevista, 
Ordens.NotaFiscal, 
Ordens.NumeroProcesso, 
Ordens.IdProcesso, 
Pessoas.Nome, 
NULL AS NomeMedida, 
0 AS EstoqueAtual, 
AtendimentosOrdens_Pedidos.QtdPedida, 
ISNULL(AtendimentosOrdens_Entregas.QtdEntregue, 0) AS QtdEntregue, 
AtendimentosOrdens_Pedidos.QtdPedida - ISNULL(AtendimentosOrdens_Entregas.QtdEntregue, 0) AS QtdQueFaltaEntregar, 
Ordens.GeradaSolicitacao, 
AtendimentosOrdens_Pedidos.Almoxarifado 
FROM dbo.AtendimentosOrdens_Pedidos 
LEFT OUTER JOIN dbo.AtendimentosOrdens_Entregas ON dbo.AtendimentosOrdens_Entregas.IdItem = dbo.AtendimentosOrdens_Pedidos.IdItem 
AND dbo.AtendimentosOrdens_Entregas.IdOrdem = dbo.AtendimentosOrdens_Pedidos.IdOrdem 
AND dbo.AtendimentosOrdens_Entregas.Almoxarifado = '0' 
INNER JOIN dbo.Ordens ON dbo.Ordens.IdOrdem = dbo.AtendimentosOrdens_Pedidos.IdOrdem AND dbo.Ordens.IdServico IS NULL 
INNER JOIN dbo.Pessoas ON dbo.Pessoas.IdPessoa = dbo.Ordens.IdPessoa 
INNER JOIN dbo.ItensCompras ON dbo.ItensCompras.IdItemCompra = dbo.AtendimentosOrdens_Pedidos.IdItem AND AtendimentosOrdens_Pedidos.Almoxarifado = '0' 
UNION
SELECT 
AtendimentosOrdens_Pedidos.IdItem, 
SubItens.NomeSubItem AS NomeItem, 
AtendimentosOrdens_Pedidos.IdOrdem, 
Ordens.DataOrdem, 
Ordens.NumeroOrdem, 
Ordens.Valor, 
Ordens.IdContrato, 
Ordens.Empenho, 
Ordens.IdPessoa, 
Ordens.DataPrevista, 
Ordens.NotaFiscal, 
Ordens.NumeroProcesso, 
Ordens.IdProcesso, 
Pessoas.Nome, 
Medidas.NomeMedida, 
(SELECT ISNULL(SUM(dbo.MovimentacoesItens.Qtd), 0) FROM dbo.MovimentacoesItens WHERE dbo.MovimentacoesItens.IdSubItem = dbo.SubItens.IdSubItem) AS EstoqueAtual, 
AtendimentosOrdens_Pedidos.QtdPedida, 
ISNULL(AtendimentosOrdens_Entregas.QtdEntregue, 0) AS QtdEntregue, 
AtendimentosOrdens_Pedidos.QtdPedida - ISNULL(AtendimentosOrdens_Entregas.QtdEntregue, 0) AS QtdQueFaltaEntregar, 
Ordens.GeradaSolicitacao, 
AtendimentosOrdens_Pedidos.Almoxarifado 
FROM dbo.AtendimentosOrdens_Pedidos 
LEFT OUTER JOIN dbo.AtendimentosOrdens_Entregas ON dbo.AtendimentosOrdens_Entregas.IdItem = dbo.AtendimentosOrdens_Pedidos.IdItem AND dbo.AtendimentosOrdens_Entregas.IdOrdem = dbo.AtendimentosOrdens_Pedidos.IdOrdem 
AND dbo.AtendimentosOrdens_Entregas.Almoxarifado = '1' 
INNER JOIN dbo.SubItens ON dbo.SubItens.IdSubItem = dbo.AtendimentosOrdens_Pedidos.IdItem AND AtendimentosOrdens_Pedidos.Almoxarifado = '1' 
INNER JOIN dbo.Itens ON dbo.Itens.IdItem = dbo.SubItens.IdItem
INNER JOIN dbo.Medidas ON dbo.Medidas.IdMedida = dbo.Itens.IdMedidaPadrao 
INNER JOIN dbo.Ordens ON dbo.Ordens.IdOrdem = dbo.AtendimentosOrdens_Pedidos.IdOrdem AND dbo.Ordens.IdServico IS NULL 
INNER JOIN dbo.Pessoas ON dbo.Pessoas.IdPessoa = dbo.Ordens.IdPessoa 




