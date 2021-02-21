


























CREATE PROCEDURE dbo.Sp_SaldosPlanoContasFinanceiro  AS 
SET NOCOUNT ON

DECLARE @idconta int, @saldo money, @codcontafin varchar(50)
CREATE TABLE #PlContasFin
 (IdContaFinanceira int, 
  NomeContaFinanceira varchar(60), 
  CodigoContaFinanceira varchar(50),
  Analitico bit)
INSERT INTO #PlContasFin EXEC('Sp_PlanoContasFinanceiro')

CREATE TABLE #SaldosPlContasFin
 (IdContaFinanceira int, 
  NomeContaFinanceira varchar(60), 
  CodigoContaFinanceira varchar(50),
  Analitico bit,
  Saldo money)
INSERT INTO #SaldosPlContasFin SELECT *, 0 FROM #PlContasFin

DECLARE planocontasfin_cursor CURSOR FAST_FORWARD FOR 
SELECT IdContaFinanceira, ISNULL(SUM(ValorExecucao),0)
FROM LancamentosFinanceiros
GROUP BY IdContaFinanceira
OPEN planocontasfin_cursor
FETCH NEXT FROM planocontasfin_cursor
INTO @idconta, @saldo
WHILE @@FETCH_STATUS = 0
BEGIN
   UPDATE #SaldosPlContasFin SET Saldo = @saldo
   WHERE IdContaFinanceira = @idconta
   FETCH NEXT FROM planocontasfin_cursor
   INTO @idconta, @saldo
END
CLOSE planocontasfin_cursor
DEALLOCATE planocontasfin_cursor

DECLARE planocontasfin_cursor CURSOR FAST_FORWARD FOR 
SELECT IdContaFinanceira, CodigoContaFinanceira, Saldo 
FROM #SaldosPlContasFin
OPEN planocontasfin_cursor
FETCH NEXT FROM planocontasfin_cursor
INTO @idconta, @codcontafin, @saldo
WHILE @@FETCH_STATUS = 0
BEGIN
   UPDATE #SaldosPlContasFin SET Saldo = (SELECT SUM(Saldo) FROM #SaldosPlContasFin WHERE CodigoContaFinanceira LIKE @codcontafin+'%')
   WHERE IdContaFinanceira = @idconta
   FETCH NEXT FROM planocontasfin_cursor
   INTO @idconta, @codcontafin, @saldo
END
CLOSE planocontasfin_cursor
DEALLOCATE planocontasfin_cursor


SELECT * FROM #SaldosPlContasFin






















































