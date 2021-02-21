

/*Kleber 18/12/2007 - OC 28104 */
/*Alteração da VIEW para calcular o valor unitário com base na média dos valores*/

CREATE  VIEW dbo.Estoques_UltimasCompras AS  
SELECT   
dbo.EntregasOrdens.IdSubItem,   
dbo.MovimentacoesItens.DataMovimentacao AS DataUltimaCompra,   
SUM(dbo.MovimentacoesItens.Qtd) AS QtdUltimaCompra,   
CASE WHEN SUM(dbo.MovimentacoesItens.Qtd) = 0 THEN 0 
ELSE
AVG(dbo.EntregasOrdens.ValorUnitario) * SUM(dbo.MovimentacoesItens.Qtd) / SUM(dbo.MovimentacoesItens.Qtd)    
END ValorUltimaCompra
FROM   
dbo.EntregasOrdens   
INNER JOIN dbo.Estoques_DataUltimasCompras ON dbo.EntregasOrdens.IdSubItem = dbo.Estoques_DataUltimasCompras.IdSubItem   
AND dbo.EntregasOrdens.DataReferencia = dbo.Estoques_DataUltimasCompras.DataUltimaCompra   
INNER JOIN dbo.MovimentacoesItens ON dbo.EntregasOrdens.IdMovimentacaoItem = dbo.MovimentacoesItens.IdMovimentacaoItem  
GROUP BY   
dbo.EntregasOrdens.IdSubItem,   
dbo.MovimentacoesItens.DataMovimentacao  




