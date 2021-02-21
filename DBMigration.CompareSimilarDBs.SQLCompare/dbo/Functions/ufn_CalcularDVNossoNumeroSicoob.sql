/*
 * Oc 238676
 * Criado por Michel
 */
 
CREATE FUNCTION dbo.ufn_CalcularDVNossoNumeroSicoob
(
@Agencia VARCHAR(4),
@codigoCedente VARCHAR(10),
@nossoNumero VARCHAR(7)
)
RETURNS INT
AS
BEGIN
DECLARE @Constante VARCHAR(21),
@Numero
VARCHAR(21),
@DigitoNumero INT,
@DigitoConstante INT,
@Soma INT,
@Digito INT

SELECT @Constante = '319731973197319731973',
@Numero = RIGHT(REPLICATE('0', 4) + LTRIM(RTRIM(@Agencia)), 4) + RIGHT (REPLICATE('0', 10) + LTRIM(RTRIM(@codigoCedente)), 10)
+ RIGHT (REPLICATE('0', 7) + LTRIM(RTRIM(@nossoNumero)), 7);
SET @Soma = 0
SET @Digito = 0
WHILE LEN(@Numero) > 0
BEGIN
SELECT @DigitoNumero = CAST(LEFT(@Numero, 1) AS INT),
@DigitoConstante = CAST(LEFT(@Constante, 1) AS INT)

SELECT @Soma = @Soma + @DigitoNumero * @DigitoConstante

SELECT @Numero = RIGHT(@Numero, LEN(@Numero) - 1)
SELECT @Constante = RIGHT(@Constante, LEN(@Constante) - 1)
END
SELECT @Digito = 11 -((@Soma) -(FLOOR(@Soma / 11) * 11)); SELECT @Digito =
CASE
WHEN @Digito > 9 THEN 0
ELSE @Digito
END
RETURN @Digito
END
