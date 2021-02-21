/*Oc.107494 - Seila*/ 

CREATE FUNCTION [dbo].[InsereZero] (@Campo VARCHAR(200), @Tamanho INT)
RETURNS VARCHAR(200)
AS
BEGIN
  DECLARE  @result VARCHAR(200)
  SET @Result =  (REPLICATE('0',(@Tamanho-LEN(ISNULL(@Campo,0))))) + ISNULL(CAST(@Campo AS VARCHAR),0)    
  RETURN(@result)
END
