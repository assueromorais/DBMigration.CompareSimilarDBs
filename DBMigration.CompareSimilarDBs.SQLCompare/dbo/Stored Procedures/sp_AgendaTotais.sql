CREATE PROCEDURE dbo.sp_AgendaTotais @Data AS DateTime
AS BEGIN

	SELECT 
	'0' AS Tipo,
	CONVERT(VARCHAR(10), @Data, 103) AS Texto,
	(SELECT ISNULL(SUM(ABS(ValorPrevisao)),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE TipoConta = 'D'
	AND DataExecucao IS NULL
	AND DataPrevisao = @Data ) AS ValorPagar,
	(SELECT ISNULL(SUM(ValorPrevisao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE TipoConta = 'R'
	AND DataExecucao IS NULL
	AND DataPrevisao = @Data ) AS ValorReceber,
	(SELECT ISNULL(SUM(ValorExecucao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE Transferencia = 0
	AND DataExecucao <= @Data ) +
	(SELECT ISNULL(SUM(ValorPrevisao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE Transferencia = 0
	AND DataExecucao IS NULL
	AND DataPrevisao <= @Data ) AS ValorSaldo
	
	UNION
	
	SELECT
	'1' AS Tipo,
	'Na Semana' AS Texto,
	(SELECT ISNULL(SUM(ABS(ValorPrevisao)),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE TipoConta = 'D'
	AND DataExecucao IS NULL
	AND DataPrevisao >= @Data
	AND DataPrevisao <= @Data + (7 - DATEPART(dw, @Data))) AS ValorPagar,
	(SELECT ISNULL(SUM(ValorPrevisao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE TipoConta = 'R'
	AND DataExecucao IS NULL
	AND DataPrevisao >= @Data
	AND DataPrevisao <= @Data + (7 - DATEPART(dw, @Data))) AS ValorReceber,
	(SELECT ISNULL(SUM(ValorExecucao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE Transferencia = 0
	AND DataExecucao <= @Data + (7 - DATEPART(dw, @Data))) +
	(SELECT ISNULL(SUM(ValorPrevisao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE Transferencia = 0
	AND DataExecucao IS NULL
	AND DataPrevisao <= @Data + (7 - DATEPART(dw, @Data))) AS ValorSaldo
	
	UNION
	
	SELECT 
	'2' AS Tipo,
	'No Mês' AS Texto,
	(SELECT ISNULL(ABS(SUM(ValorPrevisao)),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE TipoConta = 'D'
	AND DataExecucao IS NULL
	AND DATEPART(yy, DataPrevisao) = DATEPART(yy, @Data)
	AND DATEPART(mm, DataPrevisao) = DATEPART(mm, @Data)) AS ValorPagar, 
	(SELECT ISNULL(SUM(ValorPrevisao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE TipoConta = 'R'
	AND DataExecucao IS NULL
	AND DATEPART(yy, DataPrevisao) = DATEPART(yy, @Data)
	AND DATEPART(mm, DataPrevisao) = DATEPART(mm, @Data)) AS ValorReceber,
	(SELECT ISNULL(SUM(ValorExecucao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE Transferencia = 0
	AND DATEPART(yy, DataExecucao) <= DATEPART(yy, @Data)
	AND DATEPART(mm, DataExecucao) <= DATEPART(mm, @Data)) +
	(SELECT ISNULL(SUM(ValorPrevisao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE Transferencia = 0
	AND DataExecucao IS NULL
	AND DATEPART(yy, DataPrevisao) <= DATEPART(yy, @Data)
	AND DATEPART(mm, DataPrevisao) <= DATEPART(mm, @Data)) AS ValorSaldo
	
	UNION
	
	SELECT
	'3' AS Tipo,
	'No Exercício' AS Texto,
	(SELECT ISNULL(ABS(SUM(ValorPrevisao)),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE TipoConta = 'D'
	AND DataExecucao IS NULL
	AND DATEPART(yy, DataPrevisao) = DATEPART(yy, @Data)) AS ValorPagar,
	(SELECT ISNULL(SUM(ValorPrevisao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE TipoConta = 'R'
	AND DataExecucao IS NULL
	AND DATEPART(yy, DataPrevisao) = DATEPART(yy, @Data)) AS ValorReceber,
	(SELECT ISNULL(SUM(ValorExecucao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE Transferencia = 0
	AND DATEPART(yy, DataExecucao) <= DATEPART(yy, @Data)) +
	(SELECT ISNULL(SUM(ValorPrevisao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE Transferencia = 0
	AND DataExecucao IS NULL
	AND DATEPART(yy, DataPrevisao) <= DATEPART(yy, @Data)) AS ValorSaldo
	ORDER BY Tipo
END
