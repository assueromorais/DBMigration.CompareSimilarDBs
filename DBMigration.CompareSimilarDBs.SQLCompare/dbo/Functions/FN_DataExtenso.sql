


CREATE  FUNCTION [dbo].[FN_DataExtenso]

(

@Data VARCHAR(50)

)

RETURNS VARCHAR(8000)

AS

BEGIN

--SET LANGUAGE BRAZILIAN

DECLARE @Str_Extenso VARCHAR(8000) 

IF (SELECT ISDATE(@Data)) = 0

BEGIN

SET @Str_Extenso = 'Data Inválida'
--SET  @Data =  CONVERT(char(10), @Data,112)
RETURN @Str_Extenso

END


SET @Str_Extenso = (SELECT CONVERT(VARCHAR(02), DATEPART(DAY, @Data)) + ' de ' + DATENAME(MONTH, @Data) + ' de ' + CONVERT(VARCHAR(04), DATEPART(YEAR, @Data)))

-- January

SET @Str_Extenso = REPLACE(@Str_Extenso, 'January', 'Janeiro')

-- February

SET @Str_Extenso = REPLACE(@Str_Extenso, 'February', 'Fevereiro')

-- March

SET @Str_Extenso = REPLACE(@Str_Extenso, 'March', 'Março')

-- April

SET @Str_Extenso = REPLACE(@Str_Extenso, 'April', 'Abril')

-- May

SET @Str_Extenso = REPLACE(@Str_Extenso, 'May', 'Maio')

-- June

SET @Str_Extenso = REPLACE(@Str_Extenso, 'June', 'Junho')

-- July

SET @Str_Extenso = REPLACE(@Str_Extenso, 'July', 'Julho')

-- August

SET @Str_Extenso = REPLACE(@Str_Extenso, 'August', 'Agosto')

-- September

SET @Str_Extenso = REPLACE(@Str_Extenso, 'September', 'Setembro')

-- October

SET @Str_Extenso = REPLACE(@Str_Extenso, 'October', 'Outubro')

-- November

SET @Str_Extenso = REPLACE(@Str_Extenso, 'November', 'Novembro')

-- December

SET @Str_Extenso = REPLACE(@Str_Extenso, 'December', 'Dezembro')

RETURN @Str_Extenso

END



