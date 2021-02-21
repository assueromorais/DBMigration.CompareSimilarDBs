/*Bug 388 - Sérgio-Adicionado por Rafaela*/
CREATE FUNCTION [dbo].[NumEmpenhoContrato] (@IdDonoEmpenho VARCHAR(100))  
RETURNS VARCHAR(100)
AS
BEGIN
DECLARE @resultado VARCHAR(100)
SELECT @resultado = ISNULL(@resultado + ', ','') + CAST(CASE
                  WHEN EmpenhosSG.IdEmpenhoMCASP IS NOT NULL THEN EmpenhosMCASP.NumeroEmpenho
                  ELSE Empenhos.NumeroEmpenho
             END AS VARCHAR(100))
FROM   EmpenhosSG
       LEFT JOIN Empenhos
            ON  Empenhos.IdEmpenho = EmpenhosSG.IdEmpenho
       LEFT JOIN EmpenhosMCASP
            ON  EmpenhosMCASP.IdEmpenhoMCASP = EmpenhosSG.IdEmpenhoMCASP
WHERE  TipoDonoEmpenho = 'C'
       AND IdDonoEmpenho = @IdDonoEmpenho
ORDER BY
       Empenhos.AnoExercicio,
       Empenhos.NumeroEmpenho,
       EmpenhosMCASP.AnoExercicio,
       EmpenhosMCASP.NumeroEmpenho
RETURN @resultado
END
       
