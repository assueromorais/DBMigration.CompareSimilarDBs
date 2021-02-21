CREATE PROCEDURE dbo.sp_AgendaAuxiliar @Data AS DateTime
AS BEGIN

	SELECT
	(SELECT ISNULL(SUM(ABS(ValorExecucao)),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE TipoConta = 'D' AND Transferencia = 0
	AND DataExecucao = @Data) AS TotalPago,
	(SELECT ISNULL(SUM(ValorExecucao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE TipoConta = 'R' AND Transferencia = 0
	AND DataExecucao = @Data) AS TotalRecebido,
	(SELECT ISNULL(SUM(ValorExecucao),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE ValorExecucao > 0 AND Transferencia = 0
	AND (TipoConta = 'C' OR TipoConta = 'I')
	AND DataExecucao = @Data) AS TotalCredito,
	(SELECT ISNULL(SUM(ABS(ValorExecucao)),0) FROM LancamentosFinanceiros
	INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	WHERE ValorExecucao < 0 AND Transferencia = 0
	AND (TipoConta = 'C' OR TipoConta = 'I')
	AND DataExecucao = @Data) AS TotalDebito
END
