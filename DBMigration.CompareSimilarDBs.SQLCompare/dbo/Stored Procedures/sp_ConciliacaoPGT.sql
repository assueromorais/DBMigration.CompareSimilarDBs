/*Oc. 112519 - Carol*/

CREATE PROCEDURE [dbo].[sp_ConciliacaoPGT]
@DataDe DATETIME,
@DataAte DATETIME,
@Valor MONEY = 0,
@ValorMenor BIT = 0,
@Ids VARCHAR(8000) = ''
AS

CREATE TABLE #DetalheArquivoTEMP (
	IdArquivo INT,
	SeuNumero VARCHAR(20),
	Lote INT,
	Valor MONEY,
	Operacao VARCHAR(50),
	Total MONEY,
	IdFormaPagamento INT,
	DataPagamento DATETIME)

INSERT INTO #DetalheArquivoTEMP
	SELECT DA.IdArquivo, DA.SeuNumero, DA.Lote, DA.Valor, 
	CASE 
	WHEN DA.FormaLancamento = 1 THEN 'Transf. C/C'
	WHEN DA.FormaLancamento = 3 THEN 'DOC/TED'
	WHEN DA.FormaLancamento = 5 THEN 'Transf. C/P'
	WHEN DA.FormaLancamento = 7 THEN 'Pag. Títulos'
	END, 0, 0,
	DA.DataPagamento
	FROM DetalheArquivos DA
	INNER JOIN ControleArquivos CA ON CA.IdArquivo = DA.IdArquivo
	WHERE DA.DataPagamento BETWEEN @DataDe AND @DataAte
	AND DA.Cancelado = 0
	AND CA.TipoArquivo = 'RM'
	AND DA.Valor <= @Valor

UPDATE #DetalheArquivoTEMP
SET #DetalheArquivoTEMP.IdFormaPagamento = FP.IdFormaPagamento
FROM #DetalheArquivoTEMP, FormasPagamento FP, Pagamentos PG
WHERE SUBSTRING(#DetalheArquivoTEMP.SeuNumero, 1, 1) = 'P'
AND PG.NumeroPagamento = SUBSTRING(SeuNumero, 2, CHARINDEX('/', SeuNumero) - 2)
AND PG.AnoExercicio = SUBSTRING(SeuNumero, CHARINDEX('/', SeuNumero) + 1, 4)
AND FP.IdFormaPagamento = PG.IdFormaPagamento

UPDATE #DetalheArquivoTEMP
SET #DetalheArquivoTEMP.IdFormaPagamento = FP.IdFormaPagamento
FROM #DetalheArquivoTEMP, FormasPagamento FP, MovimentoFinanceiro MF
WHERE SUBSTRING(#DetalheArquivoTEMP.SeuNumero, 1, 1) = 'M'
AND MF.NumeroMovimentoFinanceiro = SUBSTRING(SeuNumero, 2, CHARINDEX('/', SeuNumero) - 2)
AND MF.AnoExercicio = SUBSTRING(SeuNumero, CHARINDEX('/', SeuNumero) + 1, 4)
AND FP.IdFormaPagamento = MF.IdFormaPagamento

UPDATE #DetalheArquivoTEMP
SET #DetalheArquivoTEMP.IdFormaPagamento = FP.IdFormaPagamento
FROM #DetalheArquivoTEMP, FormasPagamento FP, RestosPagamento RP
WHERE SUBSTRING(#DetalheArquivoTEMP.SeuNumero, 1, 1) = 'R'
AND RP.NumeroPagamento = SUBSTRING(SeuNumero, 2, CHARINDEX('/', SeuNumero) - 2)
AND RP.AnoExercicio = SUBSTRING(SeuNumero, CHARINDEX('/', SeuNumero) + 1, 4)
AND FP.IdFormaPagamento = RP.IdFormaPagamento

/*Caroline Crisóstomo - OC.112519 - SIPRO*/
UPDATE #DetalheArquivoTEMP
SET #DetalheArquivoTEMP.IdFormaPagamento = FP.IdFormaPagamento
FROM #DetalheArquivoTEMP, FormasPagamento FP, Receitas RE
WHERE SUBSTRING(#DetalheArquivoTEMP.SeuNumero, 1, 1) = 'E'
AND RE.NumeroReceita = SUBSTRING(SeuNumero, 2, CHARINDEX('/', SeuNumero) - 2)
AND RE.AnoExercicio = SUBSTRING(SeuNumero, CHARINDEX('/', SeuNumero) + 1, 4)
AND FP.IdFormaPagamento = RE.IdFormaPagamento
/**/

UPDATE #DetalheArquivoTEMP
SET Total = (SELECT SUM(DA.Valor) FROM #DetalheArquivoTEMP DA WHERE DA.IdArquivo = #DetalheArquivoTEMP.IdArquivo AND DA.Lote = #DetalheArquivoTEMP.Lote)

IF @ValorMenor = 1 
	SELECT * 
	FROM #DetalheArquivoTEMP
	WHERE Valor <= @Valor
	ORDER BY Operacao, IdArquivo, Lote, Valor
ELSE
	SELECT * 
	FROM #DetalheArquivoTEMP
	WHERE (Total = @Valor
	OR Valor = @Valor)
	AND IdArquivo = (SELECT MIN(DET2.IdArquivo) FROM #DetalheArquivoTEMP DET2 WHERE (Total = @Valor OR Valor = @Valor) AND CHARINDEX('(' + CAST(IdFormaPagamento AS VARCHAR(20)) + ')', @Ids) = 0)
	ORDER BY Operacao, IdArquivo, Lote, Valor

DROP TABLE #DetalheArquivoTEMP
