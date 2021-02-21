/*
 * Oc 223590 
 * Criado por Robson
 */  
 
CREATE FUNCTION [dbo].[FormataTelefoneFixo_Unico]
(
	@UF        VARCHAR(2),
	@Telefone  VARCHAR(100)
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @TelefoneValido                   BIT,
	        @i                                SMALLINT,
	        @Tam                              SMALLINT,
	        @DDD                              VARCHAR(3),
	        @TelefonePuro                     VARCHAR(100),
	        @PosicaoDDDInicio                 SMALLINT,
	        @PosicaoDDDFim                    SMALLINT,
	        @DigitoTelefone                   VARCHAR(1),
	        @TelefonePuroSemCaracterEspecial  VARCHAR(100),
	        @TelefoneFormatado                VARCHAR(100),
	        @Telefone_Aux                     VARCHAR(100)
	
	DECLARE @Tab_DDD                          TABLE (UF VARCHAR(2), DDD SMALLINT)
		
	SELECT @TelefoneValido = 0,
	       @i = 0,
	       @TelefoneFormatado = ''
	
	-- Retira todas as letras do campo telefone 		
	SET @Tam = LEN(ISNULL(@Telefone, ''))
	-- Telefone não informado
	IF @Tam = 0
	    RETURN ('')
	
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
	
	
	
	SET @Tam = LEN(ISNULL(@Telefone, ''))
	
	SET @i = 1
	SET @Telefone_Aux = ''
	
	WHILE @Tam >= @i
	BEGIN
	    SET @DigitoTelefone = SUBSTRING(@Telefone, @i, 1)
	    IF @DigitoTelefone IN (' ', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', ')', '(', '/')
	    BEGIN
	        SET @Telefone_Aux = @Telefone_Aux + @DigitoTelefone
	    END
	    
	    SET @i = @i + 1
	END
	
	SET @i = 1
	
	SET @TelefonePuroSemCaracterEspecial = RTRIM(LTRIM(@Telefone_Aux))
	
	SET @TelefonePuroSemCaracterEspecial = REPLACE (@TelefonePuroSemCaracterEspecial, '//', '/')
	SET @TelefonePuroSemCaracterEspecial = REPLACE (@TelefonePuroSemCaracterEspecial, ' - ', '-')
	
	WHILE @i < 3
	BEGIN
	    -- Inicio Tratamento do DDD
	    IF SUBSTRING(@TelefonePuroSemCaracterEspecial, 3, 1) = ' '
	    BEGIN
	        SET @TelefonePuroSemCaracterEspecial = SUBSTRING(@TelefonePuroSemCaracterEspecial, 1, 2) + '-' + SUBSTRING(@TelefonePuroSemCaracterEspecial, 4, 96)
	    END
	    
	    IF SUBSTRING(@TelefonePuroSemCaracterEspecial, 4, 1) = ' '
	    BEGIN
	        SET @TelefonePuroSemCaracterEspecial = SUBSTRING(@TelefonePuroSemCaracterEspecial, 1, 3) + '-' + SUBSTRING(@TelefonePuroSemCaracterEspecial, 5, 96)
	    END
	    
	    SET @PosicaoDDDInicio = CASE 
	                                 WHEN SUBSTRING(@TelefonePuroSemCaracterEspecial, 1, 1) = '(' THEN 2
	                                 WHEN SUBSTRING(@TelefonePuroSemCaracterEspecial, 1, 1) = ')' THEN 2
	                                 WHEN CHARINDEX('-', @TelefonePuroSemCaracterEspecial, 1) BETWEEN 3 AND 5 THEN 1
	                                 ELSE 0
	                            END
	    
	    
	    SET @PosicaoDDDFim = CASE 
	                              WHEN CHARINDEX(')', @TelefonePuroSemCaracterEspecial, 1) BETWEEN 3 AND 5 THEN CHARINDEX(')', @TelefonePuroSemCaracterEspecial, 1)
	                              WHEN CHARINDEX('(', @TelefonePuroSemCaracterEspecial, 1) BETWEEN 3 AND 5 THEN CHARINDEX('(', @TelefonePuroSemCaracterEspecial, 1)
	                              WHEN CHARINDEX('-', @TelefonePuroSemCaracterEspecial, 1) BETWEEN 3 AND 5 THEN CHARINDEX('-', @TelefonePuroSemCaracterEspecial, 1)
	                              ELSE 0
	                         END
	    
	    
	    IF @PosicaoDDDInicio > 0
	       AND @PosicaoDDDFim > 0
	    BEGIN
	        SET @DDD = SUBSTRING(@TelefonePuroSemCaracterEspecial, @PosicaoDDDInicio, @PosicaoDDDFim -@PosicaoDDDInicio)
	        
	        SET @DDD = REPLACE (@DDD, '.', '')
	        
	        IF ISNUMERIC(@DDD) = 0
	        BEGIN
	            SET @DDD = (
	                    SELECT TOP 1 DDD
	                    FROM   @Tab_DDD
	                    WHERE  UF = @UF
	                           AND DDD IN (11, 21, 27, 31, 41, 47, 51, 61, 62, 63, 65, 67, 68, 69, 71, 79, 81, 82, 83, 84, 85, 86, 87, 91, 92, 95, 96, 97, 98)
	                )
	        END
	        
	        IF NOT EXISTS (
	               SELECT 1
	               FROM   @Tab_DDD
	               WHERE  DDD = @DDD
	           )
	        BEGIN
	            SET @DDD = (
	                    SELECT TOP 1 DDD
	                    FROM   @Tab_DDD
	                    WHERE  UF = @UF
	                           AND DDD IN (11, 21, 27, 31, 41, 47, 51, 61, 62, 63, 65, 67, 68, 69, 71, 79, 81, 82, 83, 84, 85, 86, 87, 91, 92, 95, 96, 97, 98)
	                )
	        END
	    END
	    ELSE
	    BEGIN
	        SET @DDD = (
	                SELECT TOP 1 DDD
	                FROM   @Tab_DDD
	                WHERE  UF = @UF
	            )
	    END
	    
	    SET @DDD = CONVERT(VARCHAR(2), CONVERT(INT, @DDD))
	    
	    SET @Tam = LEN(@TelefonePuroSemCaracterEspecial)
	    
	    -- Fim Tratamento do DDD
	    
	    SET @PosicaoDDDInicio = CASE 
	                                 WHEN @PosicaoDDDFim >= 5 THEN 1
	                                 ELSE @PosicaoDDDFim + 1
	                            END
	    
	    SET @PosicaoDDDFim = CASE 
	                              WHEN @PosicaoDDDFim >= 5 THEN 0
	                              ELSE @PosicaoDDDFim
	                         END
	    
	    SET @TelefonePuro = LTRIM(RTRIM(SUBSTRING(@TelefonePuroSemCaracterEspecial, @PosicaoDDDInicio, @Tam - @PosicaoDDDFim)))
	    
	    SET @PosicaoDDDInicio = CHARINDEX(')', @TelefonePuro, 1)
	    SET @Tam = LEN(@TelefonePuro)
	    SET @TelefonePuro = CASE 
	                             WHEN @PosicaoDDDInicio < 8 AND @PosicaoDDDInicio > 0 THEN LTRIM(RTRIM(SUBSTRING(@TelefonePuroSemCaracterEspecial, @PosicaoDDDInicio + 1, @Tam - @PosicaoDDDInicio)))
	                             ELSE @TelefonePuro
	                        END
	    
	    SET @PosicaoDDDInicio = CHARINDEX('-', @TelefonePuro, 1)
	    
	    
	    
	    IF @PosicaoDDDInicio < 4
	    BEGIN
	        SET @Tam = LEN(@TelefonePuro)
	        SET @TelefonePuro = LTRIM(RTRIM(SUBSTRING(@TelefonePuro, @PosicaoDDDInicio + 1, @Tam - @PosicaoDDDInicio)))
	    END
	    
    
	    SET @PosicaoDDDInicio = CHARINDEX('/', @TelefonePuro, 1)
	    
	    IF @PosicaoDDDInicio < 4
	    BEGIN
	        SET @Tam = LEN(@TelefonePuro)
	        SET @TelefonePuro = LTRIM(RTRIM(SUBSTRING(@TelefonePuro, @PosicaoDDDInicio + 1, @Tam - @PosicaoDDDInicio)))
	    END
	    ELSE
	    BEGIN
	        IF @PosicaoDDDInicio > 8
	            SET @Tam = LEN(@TelefonePuro)
	        
	        SET @TelefonePuro = LTRIM(RTRIM(SUBSTRING(@TelefonePuro, 1, @PosicaoDDDInicio -1)))
	    END
	    
	    SET @PosicaoDDDInicio = CHARINDEX(' ', @TelefonePuro, 1)
	    
	    IF @PosicaoDDDInicio < 8
	    BEGIN
	        SET @Tam = LEN(@TelefonePuro)
	        SET @TelefonePuro = LTRIM(RTRIM(SUBSTRING(@TelefonePuro, 1, @PosicaoDDDInicio))) + LTRIM(RTRIM(SUBSTRING(@TelefonePuro, @PosicaoDDDInicio + 1, @Tam - @PosicaoDDDInicio)))
	    END
	    
	    SET @PosicaoDDDInicio = CHARINDEX('-', @TelefonePuro, 1)
	    
	    IF @PosicaoDDDInicio = 5
	    BEGIN
	        SET @TelefonePuro = SUBSTRING(@TelefonePuro, 1, 4) + SUBSTRING(@TelefonePuro, 6, 4)
	    END
	    
	    IF @PosicaoDDDInicio = 6
	    BEGIN
	        SET @TelefonePuro = SUBSTRING(@TelefonePuro, 1, 5) + SUBSTRING(@TelefonePuro, 7, 4)
	    END
	    
	    SET @PosicaoDDDFim = CHARINDEX(' ', @TelefonePuro, 1)
	    
	    IF @PosicaoDDDFim > 8
	        SET @PosicaoDDDFim = CHARINDEX('/', @TelefonePuro, 1)
	    
	    SET @Tam = LEN(@TelefonePuro)
	    SET @PosicaoDDDFim = CASE 
	                              WHEN @PosicaoDDDFim > 0 THEN @PosicaoDDDFim
	                              ELSE @Tam
	                         END
	    
	    SET @PosicaoDDDFim = CASE 
	                              WHEN @PosicaoDDDFim > @Tam THEN @Tam
	                              ELSE @PosicaoDDDFim
	                         END
	    
	    SET @TelefonePuro = LTRIM(RTRIM(SUBSTRING(@TelefonePuro, 1, @PosicaoDDDFim)))
	    
	    SET @TelefonePuro = LTRIM(RTRIM(REPLACE (@TelefonePuro, '/', '')))
	    
	    IF CHARINDEX('(', @TelefonePuro, 1) > 0
	    BEGIN
	        SET @TelefonePuro = (LEFT(@TelefonePuro, CHARINDEX('(', @TelefonePuro, 1) -1))
	    END
	    
	    IF CHARINDEX(' ', @TelefonePuro, 1) > 0
	    BEGIN
	        SET @TelefonePuro = (LEFT(@TelefonePuro, CHARINDEX(' ', @TelefonePuro, 1) -1))
	    END
	    
	    /*IF LEN(@TelefonePuro) >= 8
	    BEGIN
	        IF SUBSTRING(@TelefonePuro, 1, 1) IN ('9', '8', '7')
	        BEGIN
	            IF @DDD = 11
	               AND LEN(@TelefonePuro) = 8
	                SET @TelefonePuro = '9' + @TelefonePuro
	            
	            IF dbo.ValidaTelefoneCelular(@DDD + '-' + @TelefonePuro) = 0
	            BEGIN*/
	                SET @TelefoneFormatado = @TelefoneFormatado + @DDD + '-' + @TelefonePuro + '|'
	   /*         END
	        END
	    END*/
	    
	    IF CHARINDEX(' ', @TelefonePuro, 1) > 0
	    BEGIN
	        SET @TelefonePuro = (LEFT(@TelefonePuro, CHARINDEX(' ', @TelefonePuro, 1) -1))
	    END
	    
	    
	    SET @PosicaoDDDFim = CHARINDEX(RIGHT(@TelefonePuro, 4), @Telefone_Aux, 1) + 4
	    SET @Tam = LEN(@Telefone_Aux) 
	    
	    IF @PosicaoDDDFim + 1 > @Tam
	    BEGIN
	        BREAK
	    END
	    ELSE
	    BEGIN
	        SET @TelefonePuroSemCaracterEspecial = RTRIM(LTRIM(SUBSTRING(@Telefone_Aux, @PosicaoDDDFim + 1, @Tam -@PosicaoDDDFim)))
	        
	        SET @PosicaoDDDInicio = CHARINDEX('/', @TelefonePuroSemCaracterEspecial, 1)
	        IF @PosicaoDDDInicio < 4
	        BEGIN
	            SET @Tam = LEN(@TelefonePuroSemCaracterEspecial)
	            SET @TelefonePuroSemCaracterEspecial = LTRIM(RTRIM(SUBSTRING(@TelefonePuroSemCaracterEspecial, @PosicaoDDDInicio + 1, @Tam - @PosicaoDDDInicio)))
	        END
	    END
	    
	    SET @i = @i + 1
	END
	
	IF (CHARINDEX('|',@TelefoneFormatado, 1) > 0)
	  SET @TelefoneFormatado = SUBSTRING(@TelefoneFormatado,1,CHARINDEX('|',@TelefoneFormatado, 1)-1)

    SET @TelefoneFormatado = REPLACE(@TelefoneFormatado,'-','')	  
	
    RETURN @TelefoneFormatado
END 
