CREATE VIEW dbo.vw_AgendaResumo
AS
SELECT 
IdLancamentoFinanceiro AS Id,
1 AS NumTipo,
DataPrevisao,
Nome AS sTexto,
ValorPrevisao AS Valor,
'P' AS Tipo
FROM LancamentosFinanceiros
INNER JOIN Pessoas ON Pessoas.IdPessoa = LancamentosFinanceiros.IdPessoa
WHERE IdContaFinanceira IN (SELECT IdContaFinanceira FROM PlanoContasFinanceiro WHERE TipoConta = 'D')
AND Transferencia = 0
AND DataExecucao IS NULL

UNION

SELECT
IdLancamentoFinanceiro AS Id,
2 AS NumTipo,
DataPrevisao,
NomeContaFinanceira AS sTexto,
ValorPrevisao AS Valor,
'R' AS Tipo
FROM LancamentosFinanceiros
INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
WHERE LancamentosFinanceiros.IdContaFinanceira IN (SELECT IdContaFinanceira FROM PlanoContasFinanceiro WHERE TipoConta = 'R')
AND Transferencia = 0
AND DataExecucao IS NULL

UNION

SELECT
IdLancamentoFinanceiro AS Id,
3 AS NumTipo,
DataPrevisao,
NomeContaFinanceira AS sTexto,
ValorPrevisao * -1 AS Valor,
'T' AS Tipo
FROM LancamentosFinanceiros
INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
WHERE LancamentosFinanceiros.IdContaFinanceira IN (SELECT IdContaFinanceira FROM PlanoContasFinanceiro WHERE TipoConta = 'C')
AND Transferencia = 1
AND DataExecucao IS NULL

UNION

SELECT
IdLancamentoFinanceiro AS Id,
4 AS NumTipo,
DataPrevisao,
NomeContaFinanceira AS sTexto,
ValorPrevisao AS Valor,
'T' AS Tipo
FROM LancamentosFinanceiros
INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceiraDestino
WHERE LancamentosFinanceiros.IdContaFinanceiraDestino IN (SELECT IdContaFinanceira FROM PlanoContasFinanceiro WHERE TipoConta = 'C')
AND Transferencia = 1
AND DataExecucao IS NULL

UNION

SELECT
IdLancamentoFinanceiro AS Id,
5 AS NumTipo,
DataPrevisao,
NomeContaFinanceira AS sTexto,
ValorPrevisao * -1 AS Valor,
'I' AS Tipo
FROM LancamentosFinanceiros
INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceira
WHERE LancamentosFinanceiros.IdContaFinanceira IN (SELECT IdContaFinanceira FROM PlanoContasFinanceiro WHERE TipoConta = 'I')
AND Transferencia = 1
AND DataExecucao IS NULL

UNION 

SELECT
IdLancamentoFinanceiro AS Id,
6 AS NumTipo,
DataPrevisao,
NomeContaFinanceira AS sTexto,
ValorPrevisao AS Valor,
'I' AS Tipo
FROM LancamentosFinanceiros
INNER JOIN PlanoContasFinanceiro ON PlanoContasFinanceiro.IdContaFinanceira = LancamentosFinanceiros.IdContaFinanceiraDestino
WHERE LancamentosFinanceiros.IdContaFinanceiraDestino IN (SELECT IdContaFinanceira FROM PlanoContasFinanceiro WHERE TipoConta = 'I')
AND Transferencia = 1
AND DataExecucao IS NULL