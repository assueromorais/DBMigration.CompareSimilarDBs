/*Kleber - 23/07/2010 - OC 64030*/

CREATE VIEW dbo.SubItensSemValorRef AS
SELECT SubItens.* 
FROM SubItens INNER JOIN Itens ON Itens.IdItem = SubItens.IdItem
WHERE Itens.SemValorReferencia = 1
