﻿CREATE FUNCTION dbo.udf_Day_Of_Week(@p_Date CHAR)
RETURNS VARCHAR(10)
AS
BEGIN
DECLARE @return_DayofWeek VARCHAR(15)
SELECT @return_DayofWeek = CASE @p_Date
WHEN 7 THEN 'DOMINGO'
WHEN 1 THEN 'SEGUNDA'
WHEN 2 THEN 'TERÇA'
WHEN 3 THEN 'QUARTA'
WHEN 4 THEN 'QUINTA'
WHEN 5 THEN 'SEXTA'
WHEN 6 THEN 'SÁBADO'
END
RETURN (@return_DayofWeek)
END