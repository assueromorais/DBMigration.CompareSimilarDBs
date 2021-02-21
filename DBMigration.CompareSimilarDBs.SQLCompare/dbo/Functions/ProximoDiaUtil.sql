/*Bug 310 - Sérgio-Adicionado por Rafaela*/
CREATE FUNCTION [dbo].[ProximoDiaUtil](@Data DATETIME)
RETURNS DATETIME
AS
BEGIN
	WHILE (SELECT DBO.EhFeriado(@Data)) = 1 OR DATEPART(DW, @Data) IN (1,7)
		SET @Data = DATEADD(DAY, 1, @Data) 
		
	RETURN (@Data)
END




