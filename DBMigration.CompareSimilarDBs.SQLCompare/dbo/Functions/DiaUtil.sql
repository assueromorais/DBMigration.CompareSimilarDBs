/* oc. 124422 Selvino / Adicionado por Diego */
CREATE FUNCTION [dbo].[DiaUtil] 
(@Data datetime)  
RETURNS BIT AS  
BEGIN
DECLARE @DiaUtil BIT
SELECT @DiaUtil = ISNULL(
(SELECT 0
  WHERE DATEPART(dw, @Data) IN (1, 7)
 UNION 
 SELECT 0
   FROM Feriados f
  WHERE f.Dia = DATEPART(DAY, @Data)
   AND f.Mes = DATEPART(MONTH, @Data)),1)
RETURN @DiaUtil   
END
