CREATE PROCEDURE dbo.sp_AgendaAuxiliar2
AS BEGIN

	SELECT SUM(A) AS Total FROM (SELECT
	(SELECT ISNULL(SUM(ValorExecucao),0) FROM LancamentosFinanceiros
	WHERE PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceiraDestino AND Transferencia = 0)+
	(SELECT ISNULL(SUM(ValorExecucao),0) FROM LancamentosFinanceiros
	WHERE PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira AND Transferencia = 0) AS A
	FROM PlanoContasFinanceiro
	WHERE TipoConta = 'C' OR TipoConta = 'I') AS B

END
