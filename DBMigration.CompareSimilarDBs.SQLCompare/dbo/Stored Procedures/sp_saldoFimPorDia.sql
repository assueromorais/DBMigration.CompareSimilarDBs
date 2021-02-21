

/* Miler - OC 29234 */
CREATE PROCEDURE [dbo].[sp_saldoFimPorDia] @Data VARCHAR(10), @IdContaFinanceira INT, @IdCentroCusto INT, @IdCentroCustoReceita INT, @valor MONEY OUTPUT 
 AS
SET NOCOUNT ON

IF @IdContaFinanceira = 0
BEGIN
    SELECT @valor = ISNULL((SUM(saldoInicial)
    + SUM(ISNULL(ValorTotal,0)) - SUM(ISNULL(ValorEfetivo,0))
    +
    (SUM(ISNULL(ValorPrevisto,0)) - 
    SUM(ISNULL(ValorPrevistoNeg,0)) )),0)
    FROM   (
               SELECT (
                          SELECT SUM(saldoInicial)
                          FROM   web_contasFinanceiras wcf
                          WHERE  wcf.IdContaFinanceira > 0
                          /*AND dataSaldoInicial <= @Data*/
                          
                      ) AS saldoInicial,
                      (
                          SELECT SUM(ISNULL(wc.ValorTotal,0))
                          FROM   web_ContasFinanceiras wcf 
                          LEFT
                          JOIN   web_receitas wc
                            ON   wc.IdContaFinanceira = wcf.IdContaFinanceira
                           AND   dataReceita < = @Data
                           /*AND dataReceita >=DataSaldoInicial*/
                           
                           AND   wc.IdCentroCusto = @IdCentroCusto
                           AND   wc.IdCentroCustoReceita = @IdCentroCustoReceita
                          WHERE  wcf.IdContaFinanceira > 0
                      ) AS ValorTotal,
                      (
                          SELECT SUM(ISNULL(wp.ValorEfetivo,0))
                          FROM   web_ContasFinanceiras wcf 
                          
                          LEFT
                          JOIN   WEB_Despesas wp
                            ON   wp.IdContaFinanceira = wcf.IdContaFinanceira
                           AND   dataEfetiva < = @Data
                           /*AND wp.dataEfetiva >=DataSaldoInicial*/
                           
                           AND   wp.IdCentroCusto = @IdCentroCusto
                          WHERE  wcf.IdContaFinanceira > 0
                      ) AS ValorEfetivo,
                      (
                          SELECT SUM(ISNULL(wmNeg.ValorPrevisto,0))
                          FROM   web_ContasFinanceiras wcf 
                          LEFT
                          JOIN   WEB_movimentacoesFinanceiras wmNeg
                            ON   wmNeg.IdContaOrigem = wcf.IdContaFinanceira
                           AND   wmNeg.DataTransacao < = @Data
                           /*AND wmNeg.DataTransacao >=DataSaldoInicial*/
                           
                           AND   wmNeg.IdCentroCusto = @IdCentroCusto
                           AND   wmNeg.IdCentroCustoReceita = @IdCentroCustoReceita
                          WHERE  wcf.IdContaFinanceira > 0
                      ) AS ValorPrevistoNEg,
                      (
                          SELECT SUM(ISNULL(wmPos.ValorPrevisto,0))
                          FROM   web_ContasFinanceiras wcf 
                          LEFT
                          JOIN   WEB_movimentacoesFinanceiras wmPos
                            ON   wmPos.IdContaDestino = wcf.IdContaFinanceira
                           AND   wmPos.DataTransacao < = @Data
                           /*AND wmPos.DataTransacao >=DataSaldoInicial*/
                           
                           AND   wmPos.IdCentroCusto = @IdCentroCusto
                           AND   wmPos.IdCentroCustoReceita = @IdCentroCustoReceita
                          WHERE  wcf.IdContaFinanceira > 0
                      ) AS ValorPrevisto
           ) b
END
ELSE 
BEGIN
    SELECT @valor = ISNULL((SUM(saldoInicial)
    + SUM(ISNULL(ValorTotal,0)) - SUM(ISNULL(ValorEfetivo,0))
    +
    (SUM(ISNULL(ValorPrevisto,0)) - 
    SUM(ISNULL(ValorPrevistoNeg,0)) )),0)
    FROM   (
               SELECT (
                          SELECT SUM(saldoInicial)
                          FROM   web_contasFinanceiras wcf
                          WHERE  wcf.IdContaFinanceira = @IdContaFinanceira
                          /*AND dataSaldoInicial <= @Data*/
                          
                      ) AS saldoInicial,
                      (
                          SELECT SUM(ISNULL(wc.ValorTotal,0))
                          FROM   web_ContasFinanceiras wcf 
                          LEFT
                          JOIN   web_receitas wc
                            ON   wc.IdContaFinanceira = wcf.IdContaFinanceira
                           AND   dataReceita < = @Data
                           /*AND dataReceita >=DataSaldoInicial*/
                           
                           AND   wc.IdCentroCusto = @IdCentroCusto
                           AND   wc.IdCentroCustoReceita = @IdCentroCustoReceita
                          WHERE  wcf.IdContaFinanceira = @IdContaFinanceira
                      ) AS ValorTotal,
                      (
                          SELECT SUM(ISNULL(wp.ValorEfetivo,0))
                          FROM   web_ContasFinanceiras wcf 
                          
                          LEFT
                          JOIN   WEB_Despesas wp
                            ON   wp.IdContaFinanceira = wcf.IdContaFinanceira
                           AND   dataEfetiva < = @Data
                           /*AND wp.dataEfetiva >=DataSaldoInicial*/
                           
                           AND   wp.IdCentroCusto = @IdCentroCusto
                          WHERE  wcf.IdContaFinanceira = @IdContaFinanceira
                      ) AS ValorEfetivo,
                      (
                          SELECT SUM(ISNULL(wmNeg.ValorPrevisto,0))
                          FROM   web_ContasFinanceiras wcf 
                          LEFT
                          JOIN   WEB_movimentacoesFinanceiras wmNeg
                            ON   wmNeg.IdContaOrigem = wcf.IdContaFinanceira
                           AND   wmNeg.DataTransacao < = @Data
                           /*AND wmNeg.DataTransacao >=DataSaldoInicial*/
                           
                           AND   wmNeg.IdCentroCusto = @IdCentroCusto
                           AND   wmNeg.IdCentroCustoReceita = @IdCentroCustoReceita
                          WHERE  wcf.IdContaFinanceira = @IdContaFinanceira
                      ) AS ValorPrevistoNEg,
                      (
                          SELECT SUM(ISNULL(wmPos.ValorPrevisto,0))
                          FROM   web_ContasFinanceiras wcf 
                          LEFT
                          JOIN   WEB_movimentacoesFinanceiras wmPos
                            ON   wmPos.IdContaDestino = wcf.IdContaFinanceira
                           AND   wmPos.DataTransacao < = @Data
                           /*AND wmPos.DataTransacao >=DataSaldoInicial*/
                           
                           AND   wmPos.IdCentroCusto = @IdCentroCusto
                           AND   wmPos.IdCentroCustoReceita = @IdCentroCustoReceita
                          WHERE  wcf.IdContaFinanceira = @IdContaFinanceira
                      ) AS ValorPrevisto
           ) b
END





