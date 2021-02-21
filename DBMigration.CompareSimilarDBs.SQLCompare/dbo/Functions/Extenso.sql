/* Adicionado por Diego */
/* OC 142218 - Seila*/

CREATE FUNCTION [dbo].[Extenso]
(
@valor DECIMAL(18,2)
)
RETURNS VARCHAR(8000)
AS
BEGIN

DECLARE @valorCentavos	TINYINT	 --Valor dos Centavos
DECLARE @valorInt	 BIGINT	 --Remove os centavos
DECLARE @valorStr	 VARCHAR(20)	 --Valor como string
DECLARE @pedacoStr1	 VARCHAR(20)	 --Pedaco da str
DECLARE @pedacoStr2	 VARCHAR(20)	 --Pedaco da str
DECLARE @pedacoStr3	 VARCHAR(20)	 --Pedaco da str
DECLARE @pedacoInt1	 INT	 --Pedaco da INT
DECLARE @pedacoInt2	 INT	 --Pedaco da INT
DECLARE @pedacoInt3	 INT	 --Pedaco da INT
DECLARE @menorN	 INT
DECLARE @retorno VARCHAR(8000)

SET @retorno = ''
SET @valorInt = Convert(bigint, @valor)
SET @valorStr = Convert(VARCHAR(20), @valorInt)
SET @valorCentavos = Convert(int, (@valor - convert(bigint, @valor)) * 100)


--Retorna Zero
IF (@valor = 0)
BEGIN
SET @retorno = 'zero reais'
RETURN @retorno
END

DECLARE @numeros TABLE (descricao varchar(50), menor int, maior int)
DECLARE @milhar TABLE (descricaoUm varchar(50), descricaoPl Varchar(50), menor int, maior int)

INSERT INTO @numeros VALUES('um', 1, 1)
INSERT INTO @numeros VALUES('dois', 2, 2)
INSERT INTO @numeros VALUES('três', 3, 3)
INSERT INTO @numeros VALUES('quatro', 4, 4)
INSERT INTO @numeros VALUES('cinco', 5, 5)
INSERT INTO @numeros VALUES('seis', 6, 6)
INSERT INTO @numeros VALUES('sete', 7, 7)
INSERT INTO @numeros VALUES('oito', 8, 8)
INSERT INTO @numeros VALUES('nove', 9, 9)
INSERT INTO @numeros VALUES('dez', 10, 10)
INSERT INTO @numeros VALUES('onze', 11, 11)
INSERT INTO @numeros VALUES('doze', 12, 12)
INSERT INTO @numeros VALUES('treze', 13, 13)
INSERT INTO @numeros VALUES('quatorze', 14, 14)
INSERT INTO @numeros VALUES('quinze', 15, 15)
INSERT INTO @numeros VALUES('dezesseis', 16, 16)
INSERT INTO @numeros VALUES('dezessete', 17, 17)
INSERT INTO @numeros VALUES('dezoito', 18, 18)
INSERT INTO @numeros VALUES('dezenove', 19, 19)
INSERT INTO @numeros VALUES('vinte', 20, 20)
INSERT INTO @numeros VALUES('vinte e', 21, 29)
INSERT INTO @numeros VALUES('trinta', 30, 30)
INSERT INTO @numeros VALUES('trinta e', 31, 39)
INSERT INTO @numeros VALUES('quarenta', 40, 40)
INSERT INTO @numeros VALUES('quarenta e', 41, 49)
INSERT INTO @numeros VALUES('cinquenta', 50, 50)
INSERT INTO @numeros VALUES('cinquenta e', 51, 59)
INSERT INTO @numeros VALUES('sessenta', 60, 60)
INSERT INTO @numeros VALUES('sessenta e', 61, 69)
INSERT INTO @numeros VALUES('setenta', 70, 70)
INSERT INTO @numeros VALUES('setenta e', 71, 79)
INSERT INTO @numeros VALUES('oitenta', 80, 80)
INSERT INTO @numeros VALUES('oitenta e', 81, 89)
INSERT INTO @numeros VALUES('noventa', 90, 90)
INSERT INTO @numeros VALUES('noventa e', 91, 99)
INSERT INTO @numeros VALUES('cem', 100, 100)
INSERT INTO @numeros VALUES('cento e', 101, 199)
INSERT INTO @numeros VALUES('duzentos', 200, 200)
INSERT INTO @numeros VALUES('duzentos e', 201, 299)
INSERT INTO @numeros VALUES('trezentos', 300, 300)
INSERT INTO @numeros VALUES('trezentos e', 301, 399)
INSERT INTO @numeros VALUES('quatrocentos', 400, 400)
INSERT INTO @numeros VALUES('quatrocentos e', 401, 499)
INSERT INTO @numeros VALUES('quinhentos', 500, 500)
INSERT INTO @numeros VALUES('quinhentos e', 501, 599)
INSERT INTO @numeros VALUES('seiscentos', 600, 600)
INSERT INTO @numeros VALUES('seiscentos e', 601, 699)
INSERT INTO @numeros VALUES('setecentos', 700, 700)
INSERT INTO @numeros VALUES('setecentos e', 701, 799)
INSERT INTO @numeros VALUES('oitocentos', 800, 800)
INSERT INTO @numeros VALUES('oitocentos e', 801, 899)
INSERT INTO @numeros VALUES('novecentos', 900, 900)
INSERT INTO @numeros VALUES('novecentos e', 901, 999)

INSERT INTO @milhar VALUES('mil', 'mil', 4, 6)
INSERT INTO @milhar VALUES('milhão', 'milhões', 7, 9)
INSERT INTO @milhar VALUES('bilhão', 'bilhões', 10, 12)
INSERT INTO @milhar VALUES('trilhão', 'trilhões', 13, 15)
INSERT INTO @milhar VALUES('quadrilhão', 'quadrilhões', 16, 18)

--Busca o número de casas (sempre em 3)
SELECT TOP 1 @menorN = menor - 1 FROM @milhar WHERE menor > len(@valorStr)

--Adiciona casas a esquerda (tratando sempre de 3 em 3 casas)
SET @valorStr = replicate('0', @menorN - len(@valorStr)) + @valorStr

--Varre Convertendo os valores para valores por extenso
WHILE (len(@valorStr) > 0)
BEGIN
--Busca os 3 primeiros carac.
SET @pedacoStr1 = left(@valorStr, 3)
SET @pedacoStr2 = right(@pedacoStr1, 2)
SET @pedacoStr3 = right(@pedacoStr2, 1)
SET @pedacoInt1 = Convert(int, @pedacoStr1)
SET @pedacoInt2 = Convert(int, @pedacoStr2)
SET @pedacoInt3 = Convert(int, @pedacoStr3)

--Busca a centena
SELECT 
@retorno = @retorno + descricao + ' ' 
FROM 
@numeros 
WHERE 
((len(@pedacoInt1) = 3) AND @pedacoStr1 BETWEEN menor AND maior) 
OR ((@pedacoInt2 <> 0 AND len(@pedacoInt2) = 2) AND @pedacoInt2 BETWEEN menor AND maior)
OR ((@pedacoInt3 <> 0 AND(@pedacoInt2 < 10 OR @pedacoInt2 > 20)) AND @pedacoInt3 BETWEEN menor AND maior) --Remove de 11 a 19
ORDER BY 
maior DESC

--Define o milhar (se foi escrito algum valor para ele)
IF (@pedacoInt1 > 0)
SELECT @retorno = @retorno + CASE WHEN @pedacoInt1 > 1 THEN descricaoPL ELSE descricaoUm END + ' ' FROM @milhar WHERE (len(@valorStr) BETWEEN menor and maior)

--Remove os pedaços efetuados
SET @valorStr = right(@valorStr, len(@valorStr) - 3)

IF (convert(int, left(@valorStr, 3)) > 0)
SET @retorno = @retorno + 'e '
ELSE
IF (convert(int, @valorStr) = 0 AND len(@valorStr) = 6) /*Somente coloca na dezena*/
SET @retorno = @retorno + 'de '	
END

--Somente coloca se tiver algum valor.
IF (len(@retorno) > 0)
SET @retorno = @retorno + CASE WHEN @valorInt > 1 THEN 'reais ' ELSE 'real ' END


--Busca os centavos
SET @valorStr = Convert(varchar(2), @valorCentavos)

--Adiciona casas a esquerda
SET @valorStr = replicate('0', 2 - len(@valorStr)) + @valorStr

--Define os centavos
--Busca os 2 caracteres
SET @pedacoStr1 = @valorStr
SET @pedacoStr2 = right(@valorStr, 1)
SET @pedacoInt1 = Convert(int, @pedacoStr1)
SET @pedacoInt2 = Convert(int, @pedacoStr2)

--Define a descrição (Não coloca se não tiver reais)
IF (@pedacoInt1 > 0 AND (len(@retorno) > 0))
SET @retorno = @retorno + 'e '

--Busca a centena
SELECT 
@retorno = @retorno + descricao + ' ' 
FROM 
@numeros 
WHERE 
((@pedacoInt1 <> 0 AND len(@pedacoInt1) = 2) AND @pedacoInt1 BETWEEN menor AND maior)
OR ((@pedacoInt2 <> 0 AND (@pedacoInt1 < 10 OR @pedacoInt1 > 20)) AND @pedacoInt2 BETWEEN menor AND maior)
ORDER BY 
maior DESC

--Define a descrição
IF (@pedacoInt1 > 0)
SELECT @retorno = @retorno + 'centavo' + CASE WHEN @pedacoInt1 > 1 THEN 's' ELSE '' END


RETURN @retorno
END
