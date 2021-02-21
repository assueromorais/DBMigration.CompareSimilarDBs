/* OC 17219 - Rodrigo Souza */ 
/* Kleber em 301209 */
/* André em 080110 */

CREATE PROCEDURE [dbo].[sp_CodigosCCustoEvento]
@Analitico varchar(1) = NULL,
@Exercicio VARCHAR(4) = ''  

AS 
SET NOCOUNT ON
CREATE TABLE #CodigosFormatados
(
	IdCentroCusto int,
	CodigoFormatado varchar(15) COLLATE database_default,
	Analitico int
)
DECLARE @IdCentroCusto int, @CodigoCentroCusto varchar(15), @MascaraEvento varchar(15), @MascaraCCusto varchar(15), @CodigoFormatado varchar(15), @iMascara int, @iCodigoFormatado int, @Evento bit
SELECT @MascaraEvento = ISNULL(MascaraEvento,'S_MASC'), @MascaraCCusto = ISNULL(MascaraCCusto,'S_MASC') FROM ConfiguracoesAnuaisSipro WHERE Exercicio = @Exercicio
IF @@ROWCOUNT = 0
BEGIN
	SET @MascaraEvento = 'S_MASC'
	SET @MascaraCCusto = 'S_MASC'
	SET @Exercicio = NULL
END
DECLARE codigos_eventos_cursor CURSOR FAST_FORWARD FOR
SELECT IdCentroCusto, CodigoCentroCusto, Evento
FROM CentroCustos
OPEN codigos_eventos_cursor
FETCH NEXT FROM codigos_eventos_cursor
INTO @IdCentroCusto, @CodigoCentroCusto, @Evento
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @iMascara = 1
	SET @iCodigoFormatado = 1
	SET @CodigoFormatado = ''
	IF @Evento = 1
	BEGIN
		IF @MascaraEvento = 'S_MASC'
		BEGIN
			SET @CodigoFormatado = @CodigoCentroCusto
			INSERT INTO #CodigosFormatados VALUES(@IdCentroCusto,@CodigoFormatado,1)
		END
		ELSE
		BEGIN
			WHILE LEN(@CodigoCentroCusto) >= @iCodigoFormatado
			BEGIN
				SET @CodigoFormatado = @CodigoFormatado +
				(
				SELECT CODIGO =
					CASE
					WHEN SUBSTRING(@MascaraEvento,@iMascara,1) = '1' THEN SUBSTRING(@CodigoCentroCusto,@iCodigoFormatado,1)
					ELSE '.'
					END
				)
				IF SUBSTRING(@MascaraEvento,@iMascara,1) = '1'
					SET @iCodigoFormatado = @iCodigoFormatado+1
				SET @iMascara = @iMascara+1
				IF @iMascara > LEN(@MascaraEvento)
					SET @iCodigoFormatado = LEN(@CodigoCentroCusto)+1
			END
			INSERT INTO #CodigosFormatados VALUES(@IdCentroCusto,@CodigoFormatado,1)
		END
	END
	ELSE
	BEGIN
		IF @MascaraCCusto = 'S_MASC'
		BEGIN
			SET @CodigoFormatado = @CodigoCentroCusto
			INSERT INTO #CodigosFormatados VALUES(@IdCentroCusto,@CodigoFormatado,1)
		END
		ELSE
		BEGIN
			WHILE LEN(@CodigoCentroCusto) >= @iCodigoFormatado
			BEGIN
				SET @CodigoFormatado = @CodigoFormatado +
				(
				SELECT CODIGO =
					CASE
					WHEN SUBSTRING(@MascaraCCusto,@iMascara,1) = '1' THEN SUBSTRING(@CodigoCentroCusto,@iCodigoFormatado,1)
					ELSE '.'
					END
				)
				IF SUBSTRING(@MascaraCCusto,@iMascara,1) = '1'
					SET @iCodigoFormatado = @iCodigoFormatado+1
				SET @iMascara = @iMascara+1
				IF @iMascara > LEN(@MascaraCCusto)
					SET @iCodigoFormatado = LEN(@CodigoCentroCusto)+1
			END
			INSERT INTO #CodigosFormatados VALUES(@IdCentroCusto,@CodigoFormatado,1)
		END
	END
	FETCH NEXT FROM codigos_eventos_cursor
	INTO @IdCentroCusto, @CodigoCentroCusto, @Evento
END
CLOSE codigos_eventos_cursor
DEALLOCATE codigos_eventos_cursor

UPDATE #CodigosFormatados SET Analitico = 0
WHERE IdCentroCusto IN
(
SELECT A.IdCentroCusto FROM CentroCustos A
INNER JOIN CentroCustos B ON B.CodigoCentroCusto like A.CodigoCentroCusto+'%'
AND B.Evento = A.Evento
AND ISNULL(B.Exercicio,0) = ISNULL(A.Exercicio,0)  -- Plurianual
GROUP BY A.IdCentroCusto
HAVING COUNT(A.CodigoCentroCusto) > 1
)

IF @Analitico = '0' OR @Analitico = '1'
	SELECT * FROM #CodigosFormatados WHERE Analitico = @Analitico
ELSE
	SELECT * FROM #CodigosFormatados

DROP TABLE #CodigosFormatados
