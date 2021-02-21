

CREATE VIEW [dbo].[Atendimentos_QtdItensFaltaOrdem] AS
SELECT O.IdOrdem, IO.IdSubItem, SUM(IO.Qtd) - SUM(isnull(EO.QtdMedidaEntrega,0)) AS FaltaReceber,
MRP.IdUnidade
	FROM Ordens O INNER JOIN ItensOrdens IO ON IO.IdOrdem = O.IdOrdem 
	LEFT JOIN EntregasOrdens EO ON EO.IdOrdem = O.IdOrdem 
	INNER JOIN MovimentacoesRegPrecos MRP ON MRP.IdOrdem = O.IdOrdem
	INNER JOIN SubItens SI ON SI.IdSubItem = MRP.IdSubItem
	INNER JOIN Itens I ON I.IdItem = SI.IdItem
	WHERE I.IdPessoa = O.IdPessoa
	GROUP BY O.IdOrdem, IO.IdSubItem, MRP.IdUnidade
	HAVING SUM(IO.Qtd) > SUM(isnull(EO.QtdMedidaEntrega,0))



