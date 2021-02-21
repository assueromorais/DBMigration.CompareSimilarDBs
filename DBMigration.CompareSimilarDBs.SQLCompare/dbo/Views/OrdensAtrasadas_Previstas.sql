

CREATE VIEW dbo.OrdensAtrasadas_Previstas AS
SELECT 
ItensOrdens.IdOrdem, 
ItensOrdens.IdSubItem, 
CronogramasOrdens.QtdPrevista, 
CronogramasOrdens.DataPrevista,
(SELECT SUM(QtdPrevista)
FROM CronogramasOrdens Aux 
WHERE Aux.IdItensOrdem = CronogramasOrdens.IdItensOrdem
AND Aux.DataPrevista <= CronogramasOrdens.DataPrevista) AS QtdAcumulada
FROM CronogramasOrdens 
INNER JOIN ItensOrdens ON  CronogramasOrdens.IdItensOrdem = ItensOrdens.IdItensOrdem
WHERE (CronogramasOrdens.DataPrevista < GETDATE())




