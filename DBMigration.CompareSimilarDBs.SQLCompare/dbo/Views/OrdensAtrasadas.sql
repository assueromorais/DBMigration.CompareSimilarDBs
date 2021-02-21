

CREATE VIEW dbo.OrdensAtrasadas AS
SELECT 
OrdensAtrasadas_Previstas.IdOrdem, 
Ordens.NumeroOrdem,
Pessoas.Nome,
OrdensAtrasadas_Previstas.IdSubItem, 
SubItens.NomeSubItem, 
OrdensAtrasadas_Previstas.DataPrevista, 
OrdensAtrasadas_Previstas.QtdPrevista
FROM OrdensAtrasadas_Previstas 
LEFT JOIN AtendimentosOrdens_Entregas ON OrdensAtrasadas_Previstas.IdOrdem = AtendimentosOrdens_Entregas.IdOrdem
AND OrdensAtrasadas_Previstas.IdSubItem = AtendimentosOrdens_Entregas.IdItem
INNER JOIN SubItens ON SubItens.IdSubItem = OrdensAtrasadas_Previstas.IdSubItem
INNER JOIN Ordens ON Ordens.IdOrdem = OrdensAtrasadas_Previstas.IdOrdem
INNER JOIN Pessoas ON Pessoas.IdPessoa = Ordens.IdPessoa
WHERE OrdensAtrasadas_Previstas.QtdAcumulada > ISNULL(AtendimentosOrdens_Entregas.QtdEntregue, 0)
AND Ordens.Situacao = 0 




