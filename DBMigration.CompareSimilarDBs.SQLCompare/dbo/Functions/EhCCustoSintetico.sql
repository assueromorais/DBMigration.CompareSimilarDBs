/* OC 17219 - Rodrigo Souza */ 
CREATE FUNCTION [dbo].[EhCCustoSintetico] (@IdCentroCusto int)  
RETURNS bit  
AS  
BEGIN  
 DECLARE @EhEvento bit, @CodigoCentroCusto varchar(50), @EhCCustoSintetico BIT, @Exercicio VARCHAR(4)  -- Plurianual  
 SELECT @EhEvento = Evento, @CodigoCentroCusto = CodigoCentroCusto, @Exercicio = Exercicio   -- Plurianual
 FROM CentroCustos WHERE IdCentroCusto = @IdCentroCusto  
  
 SELECT @EhCCustoSintetico = CASE WHEN QtdCod > 1 THEN 1 ELSE 0 END FROM (  
 SELECT (  
 SELECT COUNT(*) FROM CentroCustos  
 WHERE Evento = @EhEvento 
 AND ISNULL(Exercicio,0) = @Exercicio   -- Plurianual
 AND CodigoCentroCusto LIKE @CodigoCentroCusto + '%') QtdCod) A  
   
 RETURN(@EhCCustoSintetico)  
END  
