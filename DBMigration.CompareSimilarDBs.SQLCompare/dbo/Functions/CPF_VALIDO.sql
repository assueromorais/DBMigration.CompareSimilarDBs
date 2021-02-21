/* OC.229066
* Criado por Robson
* 
*/

CREATE FUNCTION [dbo].[CPF_VALIDO](@CPF VARCHAR(11))
RETURNS BIT
AS
BEGIN
  DECLARE @INDICE INT,
          @SOMA INT,
          @DIG1 INT,
          @DIG2 INT,
          @CPF_TEMP VARCHAR(11),
          @DIGITOS_IGUAIS CHAR(1),
          @RESULTADO CHAR(1),
          @CPF_NUMERICO BIT 
          
  SET @RESULTADO = 0
  SET @CPF_NUMERICO = ISNUMERIC(@CPF)

  IF (@CPF_NUMERICO = 1) AND (LEN(@CPF) = 11) 
  BEGIN
  	

  SET @CPF_TEMP = SUBSTRING(@CPF,1,1)

  SET @INDICE = 1
  SET @DIGITOS_IGUAIS = 'S'

  WHILE (@INDICE <= 11)
  BEGIN
    IF SUBSTRING(@CPF,@INDICE,1) <> @CPF_TEMP
      SET @DIGITOS_IGUAIS = 'N'
    SET @INDICE = @INDICE + 1
   
  END;

  --Caso os digitos não sejão todos iguais Começo o calculo do digitos e não contenha caracteres diferentes de números
  IF @DIGITOS_IGUAIS = 'N' 
  BEGIN
    --Cálculo do 1º dígito
    SET @SOMA = 0
    SET @INDICE = 1
    WHILE (@INDICE <= 9)
    BEGIN
      SET @Soma = @Soma + CONVERT(INT,SUBSTRING(@CPF,@INDICE,1)) * (11 - @INDICE);
      SET @INDICE = @INDICE + 1
    END

    SET @DIG1 = 11 - (@SOMA % 11)

    IF @DIG1 > 9
      SET @DIG1 = 0;

    -- Cálculo do 2º dígito }
    SET @SOMA = 0
    SET @INDICE = 1
    WHILE (@INDICE <= 10)
    BEGIN
      SET @Soma = @Soma + CONVERT(INT,SUBSTRING(@CPF,@INDICE,1)) * (12 - @INDICE);
      SET @INDICE = @INDICE + 1
    END

    SET @DIG2 = 11 - (@SOMA % 11)

    IF @DIG2 > 9
      SET @DIG2 = 0;

    -- Validando
    IF (@DIG1 = SUBSTRING(@CPF,LEN(@CPF)-1,1)) AND (@DIG2 = SUBSTRING(@CPF,LEN(@CPF),1))
      SET @RESULTADO = 1
    ELSE
      SET @RESULTADO = 0
  END
END ELSE SET @RESULTADO = 0
  RETURN @RESULTADO
END
