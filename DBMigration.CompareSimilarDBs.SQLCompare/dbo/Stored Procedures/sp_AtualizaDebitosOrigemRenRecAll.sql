/*Oc. 91994 - Gustavo - 30-06-12 */

CREATE PROCEDURE [dbo].[sp_AtualizaDebitosOrigemRenRecAll]
	@IdDebito INT,
	@DataCalculo DATETIME,
	@Procedimento INT
AS
BEGIN
	IF OBJECT_ID('tempdb..#tmpParcelas') IS NOT NULL
	    DROP TABLE #tmpParcelas
	
	IF OBJECT_ID('tempdb..#tmpOrigens') IS NOT NULL
	    DROP TABLE #tmpOrigens	
	
	IF OBJECT_ID('tempdb..#tmpParcelasValorPagoOrigem') IS NOT NULL
	    DROP TABLE #tmpParcelasValorPagoOrigem
	
	IF OBJECT_ID('tempdb..#tmpTotalPagoOrigens') IS NOT NULL
	    DROP TABLE #tmpTotalPagoOrigens
	
	IF OBJECT_ID('tempdb..#tmpTotalPagoOrigensSomenteADever') IS NOT NULL
	    DROP TABLE #tmpTotalPagoOrigensSomenteADever	
	
	IF OBJECT_ID('tempdb..#tmpTotalAtualizado') IS NOT NULL
	    DROP TABLE #tmpTotalAtualizado	
	
	DECLARE @PessoaFisica INT
	
	--- IDENTIFICA O TIPO DE PESSOA
	IF EXISTS(
	       SELECT TOP 1 1
	       FROM   Debitos d
	       WHERE  d.IdDebito = @IdDebito
	              AND d.IdProfissional IS NOT NULL
	   )
	    SET @PessoaFisica = 1
	ELSE 
	IF EXISTS(
	       SELECT TOP 1 1
	       FROM   Debitos d
	       WHERE  d.IdDebito = @IdDebito
	              AND d.IdPessoa IS NOT NULL
	   )
	    SET @PessoaFisica = 2
	ELSE
		SET @PessoaFisica = 0	
	
	IF @DataCalculo = 0
	    SET @DataCalculo = GETDATE()
	
	--- LISTA DAS PARCELAS DA RENEGOCIAÇÃO/RECOBRANÇA A SER ANALISADA
	SELECT d.IdDebito INTO #tmpParcelas
	FROM   Debitos d
	       JOIN debitos dp
	            ON  ISNULL(d.IdProfissional, 0) = ISNULL(dp.IdProfissional, 0)
	            AND ISNULL(d.IdPessoaJuridica, 0) = ISNULL(dp.IdPessoaJuridica, 0)
	            AND ISNULL(d.IdPessoa, 0) = ISNULL(dp.IdPessoa, 0)
	            AND d.IdTipoDebito = dp.IdTipoDebito
	            AND d.NumConjReneg = dp.NumConjReneg
	WHERE  dp.IdDebito = @IdDebito
	
	--- LISTA DAS ORIGENS DA RENEGOCIAÇÃO/RECOBRANÇA A SER ANALISADA
	SELECT DISTINCT origem.IdDebito INTO #tmpOrigens
	FROM   Debitos origem
	       JOIN ComposicoesDebito cd
	            ON  cd.IdDebitoOrigemRen = origem.IdDebito
	       JOIN #tmpParcelas tp
	            ON  tp.IdDebito = cd.IdDebito
	WHERE  origem.IdTipoDebito NOT IN (2, 10)
	       AND origem.IdSituacaoAtual IN (6, 14) 
	
	--- RECUPERA O VALOR PAGO NAS PARCELAS PARA CADA DÉBITO DE ORIGEM (SOMENTE O PRINCIPAL)
	SELECT cd.IdDebitoOrigemRen AS IdDebito,
	       SUM(ISNULL(cd.ValorPagoPrincipal, 0)) AS ValorPago
	       INTO #tmpParcelasValorPagoOrigem
	FROM   ComposicoesDebito cd
	       JOIN Debitos origem
	            ON  origem.IdDebito = cd.IdDebitoOrigemRen
	       JOIN #tmpParcelas tp
	            ON  tp.IdDebito = cd.IdDebito
	       JOIN #tmpOrigens tor
	            ON  tor.IdDebito = cd.IdDebitoOrigemRen
	GROUP BY
	       cd.IdDebitoOrigemRen 
	
	--- RECUPERA O VALOR PAGO NOS DÉBITOS DE ORIGEM E SOMA COM O QUE FOI PAGO PARA ESTES DÉBITOS NAS PARCELAS
	SELECT x.IdDebito,
	       SUM(x.ValorPago) AS ValorPago INTO #tmpTotalPagoOrigens
	FROM   (
	           SELECT d.IdDebito,
	                  ISNULL(d.ValorPago, 0) AS ValorPago
	           FROM   Debitos d
	                  JOIN #tmpOrigens tor
	                       ON  tor.IdDebito = d.IdDebito 
	           UNION ALL            
	           SELECT tp.IdDebito,
	                  ISNULL(tp.ValorPago, 0) AS ValorPago
	           FROM   #tmpParcelasValorPagoOrigem tp
	       ) x
	GROUP BY
	       x.IdDebito 
	
	--- RECUPERA OS DADOS DO DÉBITO DE ORIGEM CALCULANDO TAMBÉM O SALDO DEVEDOR
	--- OBS. O CAST ABAIXO SERVE PARA FAZER ARREDONDAMENTO, EXISTEM CASOS EM QUE O
	---      VALOR DEVIDO OU PAGO ESTÁ COM TRÊS DÍGITOS APÓS A VÍRGULA
	SELECT d.IdDebito,
	       d.IdTipoDebito,
	       d.IdMoeda,
	       d.DataVencimento,
	       (CAST(d.ValorDevido AS NUMERIC(10, 2)) - CAST(ttp.ValorPago AS NUMERIC(10, 2))) AS SaldoDevedor,
	       d.ValorDevido,
	       ttp.ValorPago
	       INTO #tmpTotalPagoOrigensSomenteADever
	FROM   Debitos d
	       JOIN #tmpTotalPagoOrigens ttp
	            ON  ttp.IdDebito = d.IdDebito
	
	
	--- REMOVE TODOS OS DÉBITOS QUE JÁ FORAM QUITADOS           
	DELETE 
	FROM   #tmpTotalPagoOrigensSomenteADever
	WHERE  SaldoDevedor <= 0
	
	
	--- ATUALIZA OS VALORES
	SELECT ttp.IdDebito,
	       d.IdTipoDebito,
	       d.NumeroParcela,
	       ttp.DataVencimento,
	       d.ValorDevido,
	       ttp.ValorPago,
	       ttp.SaldoDevedor,
	       ISNULL(dbo.AtualizaDebitos(ttp.DataVencimento, @DataCalculo, ttp.SaldoDevedor, @PessoaFisica, ttp.IdTipoDebito, ttp.IdMoeda, @Procedimento, 3, ttp.IdDebito, 0), 0) AS Atualizacao,
	       ISNULL(dbo.AtualizaDebitos(ttp.DataVencimento, @DataCalculo, ttp.SaldoDevedor, @PessoaFisica, ttp.IdTipoDebito, ttp.IdMoeda, @Procedimento, 1, ttp.IdDebito, 0), 0) AS Multa,
	       ISNULL(dbo.AtualizaDebitos(ttp.DataVencimento, @DataCalculo, ttp.SaldoDevedor, @PessoaFisica, ttp.IdTipoDebito, ttp.IdMoeda, @Procedimento, 2, ttp.IdDebito, 0), 0) AS Juros,
	       ISNULL(dbo.AtualizaDebitos(ttp.DataVencimento, @DataCalculo, ttp.SaldoDevedor, @PessoaFisica, ttp.IdTipoDebito, ttp.IdMoeda, @Procedimento, 0, ttp.IdDebito, 0), 0) AS ValorTotal,
	       CASE 
	            WHEN @Procedimento = 0 THEN dbo.AchaProcedimento(ttp.DataVencimento, @DataCalculo, @PessoaFisica, ttp.IdTipoDebito, d.NumeroParcela)
	            ELSE @Procedimento
	       END AS Procedimento
	       INTO #tmpTotalAtualizado
	FROM   #tmpTotalPagoOrigensSomenteADever ttp
	       JOIN Debitos d
	            ON  ttp.IdDebito = d.IdDebito
	
	----------- RETORNTO -----------
	SELECT tta.IdDebito,
	       d.IdTipoDebito,
	       td.SiglaDebito,
	       YEAR(d.DataReferencia) AnoRef,
	       d.NumeroParcela,
	       CASE 
	            WHEN d.NumeroParcela = 0 THEN 'Cota-única'
	            ELSE CAST(d.NumeroParcela AS VARCHAR) + 'ª Parcela'
	       END AS Parcela,
	       tta.DataVencimento,
	       d.ValorDevido,
	       tta.ValorPago,
	       tta.SaldoDevedor,
	       tta.Atualizacao,
	       tta.Multa,
	       tta.Juros,
	       tta.ValorTotal,
	       pa.IdProcedimentoAtraso,
	       pa.NomeProcedimentoAtraso
	FROM   #tmpTotalAtualizado tta
	       JOIN Debitos d
	            ON  tta.IdDebito = d.IdDebito
	       JOIN TiposDebito td
	            ON  td.IdTipoDebito = d.IdTipoDebito
	       LEFT JOIN ProcedimentosAtraso pa
	            ON  tta.Procedimento = pa.IdProcedimentoAtraso
	ORDER BY
	       YEAR(d.DataReferencia) DESC,
	       d.IdTipoDebito
END
