CREATE FUNCTION [EhFeriado] (@data datetime)
RETURNS bit
as
BEGIN
  DECLARE @dia int, @mes int
  DECLARE @pascoa varchar(8)
  DECLARE @carnaval varchar(8)
  DECLARE @paixao varchar(8)
  DECLARE @corpus varchar(8)
  DECLARE @retorno bit

  SET @dia = DAY(@data)
  SET @mes = MONTH(@data)

  SET @pascoa = dbo.Calc_Pascoa(YEAR(@data))
  SET @paixao = CONVERT(varchar, CAST(@pascoa as datetime) - 2, 112) 
  SET @carnaval = CONVERT(varchar, CAST(@pascoa as datetime) - 47, 112)
  SET @corpus = CONVERT(varchar, CAST(@pascoa as datetime) + 60, 112) 

  IF (@dia = 1 AND @mes = 1) 
    SET @retorno = 1

  ELSE IF (@dia = 21 AND @mes = 4) 
    SET @retorno = 1

  ELSE IF (@dia = 1 AND @mes = 5) 
    SET @retorno = 1

  ELSE IF (@dia = 7 AND @mes = 9) 
    SET @retorno = 1

  ELSE IF (@dia = 12 AND @mes = 10) 
    SET @retorno = 1

  ELSE IF (@dia = 2 AND @mes = 11) 
    SET @retorno = 1

  ELSE IF (@dia = 15 AND @mes = 11) 
    SET @retorno = 1

  ELSE IF (@dia = 25 AND @mes = 12) 
    SET @retorno = 1

  ELSE IF (@dia = DAY(@carnaval) AND @mes = MONTH(@carnaval)) 
    SET @retorno = 1

  ELSE IF (@dia = DAY(@paixao) AND @mes = MONTH(@paixao)) 
    SET @retorno = 1

  ELSE IF (@dia = DAY(@corpus) AND @mes = MONTH(@corpus)) 
    SET @retorno = 1

  ELSE IF exists (SELECT IdFeriado FROM Feriados WHERE Dia=@dia AND Mes=@mes) 
    SET @retorno = 1

  ELSE
    SET @retorno = 0

  RETURN (@retorno)

END 
