/*Oc. 69079 - Gustavo*/

CREATE FUNCTION [dbo].[Calc_DataUtil](@Data DATETIME)
RETURNS DATETIME
AS
BEGIN
  DECLARE @DataUtil DATETIME
  
  SET @DataUtil = @Data  
  
  IF DATEPART(DW,@DataUtil) = 7 /*Sábado*/
	SET  @DataUtil = @DataUtil + 2

  IF DATEPART(DW,@DataUtil) = 1 /*Domingo*/
	SET  @DataUtil = @DataUtil + 1
	
  WHILE dbo.EhFeriado(CONVERT(VARCHAR(8), @DataUtil, 112)) = 1 /*Feriados*/
    SET @DataUtil = @DataUtil + 1  
  
  RETURN(@DataUtil)
END  
