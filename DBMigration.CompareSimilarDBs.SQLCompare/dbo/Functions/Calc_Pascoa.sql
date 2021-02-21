CREATE FUNCTION dbo.Calc_Pascoa (@ano varchar(4))
	RETURNS varchar(8)
	as 
	BEGIN
	DECLARE @ehFeriado bit
	DECLARE @Seculo int
	DECLARE @G int
	DECLARE @K int
	DECLARE @I int
	DECLARE @J int
	DECLARE @L int
	DECLARE @mes varchar(2)
	DECLARE @dia varchar(2)
	
	
	SET @Seculo = @ano / 100
	SET @G = @ano % 19
	SET @K = (@Seculo - 17) / 25
	SET @I = (@Seculo - @Seculo / 4 - (@Seculo - @K) / 3 + 19*@G + 15) % 30
	SET @I = @I - (@I / 28)*(1 - (@I / 28)*(29 / (@I + 1))*((21 - @G) / 11))
	SET @J = (@ano + @ano / 4 + @I + 2 - @Seculo + @Seculo / 4) % 7
	SET @L = @I - @J
	SET @mes = 3 + (@L + 40) / 44
	SET @dia = @L + 28 - 31 * (@mes / 4)
	
	RETURN(CONVERT( varchar, CONVERT(datetime, @ano + '/' + @mes + '/' + @dia, 111), 112))
	END