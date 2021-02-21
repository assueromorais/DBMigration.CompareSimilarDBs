CREATE PROCEDURE dbo.sp_AgendaTotalConta @Data AS DateTime
AS BEGIN

	SELECT * FROM (
	SELECT 
	IdContaFinanceira,
	NomeContaFinanceira, 
	/* Receita/Despesa executada */
	(SELECT ISNULL(SUM(ValorExecucao),0) FROM LancamentosFinanceiros
	WHERE PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceiraDestino
	AND Transferencia = 0)+
	/* Movimentação avulsa */
	(SELECT ISNULL(SUM(ValorExecucao),0) FROM LancamentosFinanceiros
	WHERE PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	AND Transferencia = 0) AS SaldoDisponivel,
	/* Receita/Despesa executada */
	(SELECT ISNULL(SUM(ValorExecucao),0) FROM LancamentosFinanceiros
	WHERE PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceiraDestino
	AND Transferencia = 0 AND DataExecucao <= @Data)+
	/* Receita/Despesa prevista */
	(SELECT ISNULL(SUM(ValorPrevisao),0) FROM LancamentosFinanceiros
	WHERE PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceiraDestino
	AND DataExecucao IS NULL AND DataPrevisao <= @Data AND Transferencia = 0)+
	/* Movimentação avulsa */
	(SELECT ISNULL(SUM(ValorExecucao),0) FROM LancamentosFinanceiros
	WHERE PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	AND Transferencia = 0 AND DataExecucao <= @Data)+
	/* Transferencia destino */
	(SELECT ISNULL(SUM(ValorPrevisao),0) FROM LancamentosFinanceiros
	WHERE PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceiraDestino
	AND DataExecucao IS NULL AND Transferencia = 1 AND DataPrevisao <= @Data)+
	/* Transferencia origem */
	(SELECT ISNULL(SUM(ValorPrevisao),0)*-1 FROM LancamentosFinanceiros
	WHERE PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
	AND DataExecucao IS NULL AND Transferencia = 1 AND DataPrevisao <= @Data)
	 AS SaldoPrevisto
	FROM PlanoContasFinanceiro
	WHERE TipoConta = 'C' OR TipoConta = 'I'
	) AS A
	WHERE SaldoPrevisto <> 0 OR SaldoDisponivel <> 0
	ORDER BY NomeContaFinanceira
END
