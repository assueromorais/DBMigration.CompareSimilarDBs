CREATE FUNCTION [dbo].[Calc_Duodecimo] (@Valor Float, @DataCalculo datetime)
			 RETURNS decimal (10,2) 
			 AS 
			 BEGIN 
			 DECLARE @Result Decimal(10,2)
			 SET @Result = @Valor * (13 - MONTH(@DataCalculo)) / 12 
			 RETURN(@result)
			 END