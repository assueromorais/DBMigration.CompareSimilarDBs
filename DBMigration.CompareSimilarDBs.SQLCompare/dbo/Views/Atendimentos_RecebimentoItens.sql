

CREATE VIEW [dbo].[Atendimentos_RecebimentoItens] AS 
SELECT Enviados.IdItem, Enviados.IdUnidade, 
isnull(ABS(Enviados.QtdEnviada), 0) - isnull(ABS(Recebidos.QtdEntregue), 0) - isnull(ABS(SemReg.QtdEntregueSemRegPreco), 0) QtdFaltaReceber FROM
(SELECT * FROM AtendimentosPedidos_EnvioRegPreco) AS Enviados LEFT JOIN  
(SELECT * FROM AtendimentosPedidos_Entregas) AS Recebidos 
ON Enviados.IdItem = Recebidos.IdItem AND Enviados.IdUnidade = Recebidos.IdUnidade LEFT JOIN 
(SELECT * FROM AtendimentosPedidos_EntregasSemRegPreco) AS SemReg
ON Enviados.IdItem = SemReg.IdItem AND Enviados.IdUnidade = SemReg.IdUnidade



