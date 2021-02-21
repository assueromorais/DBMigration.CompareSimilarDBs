
/*Alteração Nelson / Lucimara - Ocorr. 88150 - 14/03/2012*/
/* Miler - OC 29234 */

CREATE PROCEDURE [dbo].[sp_saldoInicio]
	@Data VARCHAR(10), -- Data de Referência do movimento financeiro
	@IdContaFinanceira INT, -- Identificador da Conta Financeira
	@IF CHAR(1), -- Flag identificadora do tipo de saldo retornado (I - Saldo Inicial, F - Saldo Final)
	@IdCentroCusto INT, -- Identificador do Centro de Custo
	@IdCentroCustoReceita INT, -- Identificador do Centro de Custo Receita
	@Valor MONEY OUTPUT -- Valor do Saldo que será retornado
AS
	SET NOCOUNT ON
	
	PRINT @data
	
	/* Configura data para cada tipo de saldo */
	IF @IF = 'I'
	    /* Configura data para o primeiro dia do mês da data informada */
	    SET @Data = SUBSTRING(@Data, 1, 4) + '' + SUBSTRING(@Data, 6, 2) + '01'
	ELSE 
	/* Saldo Final */
	IF @IF = 'F'
	BEGIN
	    /* Configura data para o primeiro dia do mês subsequente ao da data informada */
	    SELECT @Data = CONVERT(
	               VARCHAR,
	               CONVERT(VARCHAR, DATEADD(MONTH, 1, CAST(@Data AS DATETIME)), 120)
	           )
	    
	    SET @Data = SUBSTRING(@Data, 1, 4) + '' + SUBSTRING(@Data, 6, 2) + '01'
	END
	
	PRINT @Data
	
	/* Se "Conta Financeira" não for informada */
	IF @IdContaFinanceira = 0
	BEGIN
	    SELECT @valor = ISNULL(
	               (
	                   SUM(saldoInicial)
	                   + SUM(ISNULL(ValorTotal, 0)) - SUM(ISNULL(ValorEfetivo, 0))
	                   + (
	                       SUM(ISNULL(ValorPrevisto, 0)) - 
	                       SUM(ISNULL(ValorPrevistoNeg, 0))
	                   )
	               ),
	               0
	           )
	      FROM (
	               SELECT (
	                          SELECT SUM(saldoInicial)
	                            FROM web_contasFinanceiras wcf
	                           WHERE wcf.IdContaFinanceira > 0
	                                 /*and dataSaldoInicial <= @Data*/
	                      ) AS saldoInicial,
	                      (
	                          SELECT SUM(ISNULL(wc.ValorTotal, 0))
	                            FROM web_ContasFinanceiras wcf
	                                 LEFT
	                          JOIN web_receitas wc
	                                      ON  wc.IdContaFinanceira = wcf.IdContaFinanceira
	                                      AND dataReceita < @Data
	                                          /*and dataReceita >=DataSaldoInicial*/
	                                      AND wc.IdCentroCusto IN (SELECT A.IdCentroCusto
	                                                                 FROM CentroCustos A
	                                                                WHERE A.CodigoCentroCusto IN (SELECT B.CodigoCentroCusto
	                                                                                                FROM CentroCustos B
	                                                                                               WHERE B.IdCentroCusto = @IdCentroCusto
	                                                                                                 AND B.NomeCentroCusto = A.NomeCentroCusto))
	                                      AND wc.IdCentroCustoReceita = @idCentrocustoReceita
	                           WHERE wcf.IdContaFinanceira > 0
	                      ) AS ValorTotal,
	                      (
	                          SELECT SUM(ISNULL(wp.ValorEfetivo, 0))
	                            FROM web_ContasFinanceiras wcf
	                                 LEFT
	                          JOIN WEB_Despesas wp
	                                      ON  wp.IdContaFinanceira = wcf.IdContaFinanceira
	                                      AND dataEfetiva < @Data
	                                          /*and wp.dataEfetiva >=DataSaldoInicial*/
	                                      AND wp.IdCentroCusto IN (SELECT A.IdCentroCusto
	                                                                 FROM CentroCustos A
	                                                                WHERE A.CodigoCentroCusto IN (SELECT B.CodigoCentroCusto
	                                                                                                FROM CentroCustos B
	                                                                                               WHERE B.IdCentroCusto = @IdCentroCusto
	                                                                                                 AND B.NomeCentroCusto = A.NomeCentroCusto))
	                           WHERE wcf.IdContaFinanceira > 0
	                      ) AS ValorEfetivo,
	                      (
	                          SELECT SUM(ISNULL(wmNeg.ValorPrevisto, 0))
	                            FROM web_ContasFinanceiras wcf
	                                 LEFT
	                          JOIN WEB_movimentacoesFinanceiras wmNeg
	                                      ON  wmNeg.IdContaOrigem = wcf.IdContaFinanceira
	                                      AND wmNeg.DataTransacao < @Data
	                                          /*and wmNeg.DataTransacao >=DataSaldoInicial*/
	                                      AND wmNeg.IdCentroCusto IN (SELECT A.IdCentroCusto
	                                                                 FROM CentroCustos A
	                                                                WHERE A.CodigoCentroCusto IN (SELECT B.CodigoCentroCusto
	                                                                                                FROM CentroCustos B
	                                                                                               WHERE B.IdCentroCusto = @IdCentroCusto
	                                                                                                 AND B.NomeCentroCusto = A.NomeCentroCusto))
	                                      AND wmNeg.IdCentroCustoReceita = @idCentrocustoReceita
	                           WHERE wcf.IdContaFinanceira > 0
	                      ) AS ValorPrevistoNEg,
	                      (
	                          SELECT SUM(ISNULL(wmPos.ValorPrevisto, 0))
	                            FROM web_ContasFinanceiras wcf
	                                 LEFT
	                          JOIN WEB_movimentacoesFinanceiras wmPos
	                                      ON  wmPos.IdContaDestino = wcf.IdContaFinanceira
	                                      AND wmPos.DataTransacao < @Data
	                                          /*and wmPos.DataTransacao >=DataSaldoInicial*/
	                                      AND wmPos.IdCentroCusto IN (SELECT A.IdCentroCusto
	                                                                 FROM CentroCustos A
	                                                                WHERE A.CodigoCentroCusto IN (SELECT B.CodigoCentroCusto
	                                                                                                FROM CentroCustos B
	                                                                                               WHERE B.IdCentroCusto = @IdCentroCusto
	                                                                                                 AND B.NomeCentroCusto = A.NomeCentroCusto))
	                                      AND wmPos.IdCentroCustoReceita = @idCentrocustoReceita
	                           WHERE wcf.IdContaFinanceira > 0
	                      ) AS ValorPrevisto
	           )b
	END
	ELSE
	BEGIN
	    /* Conta Financeira informada */
	    SELECT @valor = ISNULL(
	               (
	                   SUM(saldoInicial)
	                   + SUM(ISNULL(ValorTotal, 0)) - SUM(ISNULL(ValorEfetivo, 0))
	                   + (
	                       SUM(ISNULL(ValorPrevisto, 0)) - 
	                       SUM(ISNULL(ValorPrevistoNeg, 0))
	                   )
	               ),
	               0
	           )
	      FROM (
	               SELECT (
	                          SELECT SUM(saldoInicial)
	                            FROM web_contasFinanceiras wcf
	                           WHERE wcf.IdContaFinanceira = @IdContaFinanceira
	                                 /*and dataSaldoInicial < @data*/
	                      ) AS saldoInicial,
	                      (
	                          SELECT SUM(ISNULL(wc.ValorTotal, 0))
	                            FROM web_ContasFinanceiras wcf
	                                 LEFT
	                          JOIN web_receitas wc
	                                      ON  wc.IdContaFinanceira = wcf.IdContaFinanceira
	                                      AND dataReceita < @Data
	                                          /*and dataReceita >=DataSaldoInicial*/
	                                      AND wc.IdCentroCusto IN (SELECT A.IdCentroCusto
	                                                                 FROM CentroCustos A
	                                                                WHERE A.CodigoCentroCusto IN (SELECT B.CodigoCentroCusto
	                                                                                                FROM CentroCustos B
	                                                                                               WHERE B.IdCentroCusto = @IdCentroCusto
	                                                                                                 AND B.NomeCentroCusto = A.NomeCentroCusto))
	                                      AND wc.IdCentroCustoReceita = @idCentrocustoReceita
	                           WHERE wcf.IdContaFinanceira = @IdContaFinanceira
	                      ) AS ValorTotal,
	                      (
	                          SELECT SUM(ISNULL(wp.ValorEfetivo, 0))
	                            FROM web_ContasFinanceiras wcf
	                                 LEFT
	                          JOIN WEB_Despesas wp
	                                      ON  wp.IdContaFinanceira = wcf.IdContaFinanceira
	                                      AND dataEfetiva < @Data
	                                          /*and wp.dataEfetiva >=DataSaldoInicial*/
	                                      AND wp.IdCentroCusto IN (SELECT A.IdCentroCusto
	                                                                 FROM CentroCustos A
	                                                                WHERE A.CodigoCentroCusto IN (SELECT B.CodigoCentroCusto
	                                                                                                FROM CentroCustos B
	                                                                                               WHERE B.IdCentroCusto = @IdCentroCusto
	                                                                                                 AND B.NomeCentroCusto = A.NomeCentroCusto))
	                           WHERE wcf.IdContaFinanceira = @IdContaFinanceira
	                      ) AS ValorEfetivo,
	                      (
	                          SELECT SUM(ISNULL(wmNeg.ValorPrevisto, 0))
	                            FROM web_ContasFinanceiras wcf
	                                 LEFT
	                          JOIN WEB_movimentacoesFinanceiras wmNeg
	                                      ON  wmNeg.IdContaOrigem = wcf.IdContaFinanceira
	                                      AND wmNeg.DataTransacao < @Data
	                                          /*and wmNeg.DataTransacao >=DataSaldoInicial*/
	                                      AND wmNeg.IdCentroCusto IN (SELECT A.IdCentroCusto
	                                                                 FROM CentroCustos A
	                                                                WHERE A.CodigoCentroCusto IN (SELECT B.CodigoCentroCusto
	                                                                                                FROM CentroCustos B
	                                                                                               WHERE B.IdCentroCusto = @IdCentroCusto
	                                                                                                 AND B.NomeCentroCusto = A.NomeCentroCusto))
	                                      AND wmNeg.IdCentroCustoReceita = @idCentrocustoReceita
	                           WHERE wcf.IdContaFinanceira = @IdContaFinanceira
	                      ) AS ValorPrevistoNEg,
	                      (
	                          SELECT SUM(ISNULL(wmPos.ValorPrevisto, 0))
	                            FROM web_ContasFinanceiras wcf
	                                 LEFT
	                          JOIN WEB_movimentacoesFinanceiras wmPos
	                                      ON  wmPos.IdContaDestino = wcf.IdContaFinanceira
	                                      AND wmPos.DataTransacao < @Data
	                                          /*and wmPos.DataTransacao >=DataSaldoInicial*/
	                                      AND wmPos.IdCentroCusto IN (SELECT A.IdCentroCusto
	                                                                 FROM CentroCustos A
	                                                                WHERE A.CodigoCentroCusto IN (SELECT B.CodigoCentroCusto
	                                                                                                FROM CentroCustos B
	                                                                                               WHERE B.IdCentroCusto = @IdCentroCusto
	                                                                                                 AND B.NomeCentroCusto = A.NomeCentroCusto))
	                                      AND wmPos.IdCentroCustoReceita = @idCentrocustoReceita
	                           WHERE wcf.IdContaFinanceira = @IdContaFinanceira
	                      ) AS ValorPrevisto
	           )b
	END
