/* OC.229066
* Criado por Robson
* 
*/ 
CREATE FUNCTION [dbo].[ValidaTelefoneCelular]
(
	@Telefone VARCHAR(100)
)
RETURNS BIT
AS
BEGIN
	DECLARE @TelefoneValido  BIT,
	        @i               SMALLINT,
	        @Tam             SMALLINT,
	        @DDD             VARCHAR(3),
	        @DigitoTelefone  VARCHAR(1)
	
	DECLARE @Tab_DDD         TABLE (UF VARCHAR(2), DDD SMALLINT)
	
	SELECT @TelefoneValido = 0,
	       @i = 0		
	
	SET @Telefone = REPLACE (@Telefone, '#', '')
	
	-- Retira todas as letras do campo telefone 		
	SET @Tam = LEN(ISNULL(@Telefone, ''))
	-- Telefone não informado
	IF @Tam = 0
	   OR @Telefone IS NULL
	    RETURN (@TelefoneValido)
	
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'SP',
	         11 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'SP',
	         12 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'SP',
	         13 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'SP',
	         14 )	
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'SP',
	         15 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'SP',
	         17 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'SP',
	         18 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'SP',
	         19 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'RJ',
	         21 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'RJ',
	         22 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'RJ',
	         24 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'ES',
	         27 )	
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'ES',
	         28 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'MG',
	         31 )	
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'MG',
	         32 )	
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'MG',
	         33 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'MG',
	         34 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'MG',
	         35 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'MG',
	         37 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'MG',
	         38 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PR',
	         41 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PR',
	         42 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PR',
	         43 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PR',
	         44 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PR',
	         45 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PR',
	         46 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'SC',
	         47 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'SC',
	         48 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'SC',
	         49 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'RS',
	         51 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'RS',
	         53 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'RS',
	         54 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'RS',
	         55 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'DF',
	         61 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'GO',
	         62 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'TO',
	         63 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'GO',
	         64 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'MT',
	         65 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'MT',
	         66 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'MS',
	         67 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'AC',
	         68 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'RO',
	         69 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'BA',
	         71 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'BA',
	         73 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'BA',
	         74 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'BA',
	         75 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'BA',
	         76 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'BA',
	         77 )	         
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'SE',
	         79 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PE',
	         81 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'AL',
	         82 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PB',
	         83 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'RN',
	         84 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'CE',
	         85 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PI',
	         86 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PE',
	         87 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'CE',
	         88 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PI',
	         89 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PA',
	         91 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'AM',
	         92 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PA',
	         93 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'PA',
	         94 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'RR',
	         95 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'AP',
	         96 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'AM',
	         97 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'MA',
	         98 )
	INSERT INTO @Tab_DDD ( UF,
	       DDD )
	VALUES ( 'MA',
	         99 )
	
	SET @i = 1
	
	WHILE @Tam >= @i
	BEGIN
	    SET @DigitoTelefone = SUBSTRING(@Telefone, @i, 1)
	    IF @DigitoTelefone NOT IN ('-', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '#')
	    BEGIN
	        SET @TelefoneValido = 1
	        RETURN (@TelefoneValido)
	    END
	    
	    SET @i = @i + 1
	END
	
	IF ISNUMERIC(SUBSTRING(@Telefone, 1, 2)) = 0
	BEGIN
	    SET @TelefoneValido = 1
	    RETURN (@TelefoneValido)
	END	
	
	IF NOT EXISTS (
	       SELECT 1
	       FROM   @Tab_DDD
	       WHERE  DDD = SUBSTRING(@Telefone, 1, 2)
	   )
	BEGIN
	    SET @TelefoneValido = 1
	    RETURN (@TelefoneValido)
	END	
	
	IF EXISTS(SELECT 1 FROM @Tab_DDD WHERE  DDD = SUBSTRING(@Telefone, 1, 2))
	   AND LEN(RTRIM(LTRIM(SUBSTRING(@Telefone, 3, 20)))) >= 8
	BEGIN
	    SET @TelefoneValido = 1
	    RETURN (@TelefoneValido)
	END
	
	
	IF LEN(RTRIM(LTRIM(SUBSTRING(@Telefone, 4, 20)))) < 8
	BEGIN
	    SET @TelefoneValido = 1
	    RETURN (@TelefoneValido)
	END 
	
	RETURN(@TelefoneValido)
END 
