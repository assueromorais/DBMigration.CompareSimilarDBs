/*Criado pelo VictorB - Ocorr. 80140*/	



CREATE PROCEDURE [dbo].[sp_Rel_Pag_Divida_Ativa]
	@TipoPessoa TINYINT,
	@DataPagto0 DATETIME,
	@DataPagto1 DATETIME,
	@DataCredito0 DATETIME,
	@DataCredito1 DATETIME
AS
	/*
	Demanda 80140
	
	Esse relatório será utilizado para identificar os pagamentos realizados em dívida ativa, juntamente com 
	os valores pagos e os totais pagos.
	
	O relatório deve ser disponibilizado no caminho Siscafw / Relatórios / Pagamentos em dívida ativa.
	
	O relatório deve ser disponibilizado na versão DA e deve ficar visível para todos os CRTRs.
	
	O filtro de “Tipo de Pessoa” deve permitir selecionar apenas um registro por consulta, 
	para que sejam gerados relatórios separados para profissionais e pessoas jurídicas;
	
	Como resultado da consulta, o sistema deve retornar as seguintes informações
	•	Nome;
	•	Nº Registro no Conselho;
	•	Situação da Dívida;
	•	Data pagamento;
	•	Data crédito;
	•	Valor pago principal;
	•	Valor pago multa;
	•	Valor pago juros;
	•	Valor pago total;
	•	Valor pago líquido;
	•	Valor repasse;
	•	Situação do débito.
		
	O sistema deve calcular o valor total pago em cada campo referente a pagamentos 
	(pago principal, pago multa, pago juros, pago total, líquido e repasse).
	
	O sistema também deve listar os débitos que foram renegociados em dívida ativa e que 
	foram pagos ou tiveram a data crédito durante o período informado.
	
	O relatório deve ordenar a consulta pelos seguintes campos
	•	Data pagamento;
	•	Data crédito;
	•	Nome;
	
	*/
	SET DATEFORMAT dmy
	
	IF @DataPagto0 IS NULL
	    SET @DataPagto0 = CONVERT(DATETIME, '01/01/1980')
	
	IF @DataPagto1 IS NULL
	    SET @DataPagto1 = GETDATE()
	
	IF @DataCredito0 IS NULL
	    SET @DataCredito0 = CONVERT(DATETIME, '01/01/1980')
	
	IF @DataCredito1 IS NULL
	    SET @DataCredito1 = GETDATE()
	
	-- Seleciona a última situação da DÍVIDA ATIVA dentro do período
	CREATE TABLE #SITDA
	(
		IdDividaAtiva     INT,
		SituacaoDivAtiva  INT,
		DATA              DATETIME
	)
	INSERT INTO #SITDA
	SELECT IdDividaAtiva,
	       SituacaoDivAtiva,
	       DATA
	FROM   SituacoesDivAtiva sda
	ORDER BY
	       sda.IdDividaAtiva
	
	UPDATE #SITDA
	SET    #SITDA.DATA = da.DtInscricao
	FROM   DividaAtiva da
	WHERE  #SITDA.IdDividaAtiva = da.IdDividaAtiva
	       AND #SITDA.Data IS NULL
	
	CREATE TABLE #SIT1
	(
		IdDividaAtiva  INT,
		DATA           DATETIME
	)
	INSERT INTO #SIT1
	SELECT IdDividaAtiva,
	       MAX(DATA)
	FROM   #SITDA
	GROUP BY
	       IdDividaAtiva
	ORDER BY
	       IdDividaAtiva
	
	CREATE TABLE #MAXSIT_DIV
	(
		IdDividaAtiva     INT,
		SituacaoDivAtiva  INT,
		DATA              DATETIME
	)
	INSERT INTO #MAXSIT_DIV
	SELECT S.IdDividaAtiva,
	       S.SituacaoDivAtiva,
	       S.Data
	FROM   #SIT1,
	       #SITDA S
	WHERE  #SIT1.IdDividaAtiva = S.IdDividaAtiva
	       AND S.Data = #SIT1.Data
	ORDER BY
	       S.IdDividaAtiva
	
	-- Seleciona os Conjuntos de reneg com, ao menos, uma parcela paga
	SELECT DISTINCT ISNULL(D.IdProfissional, 0) AS IdProfissional,
	       ISNULL(D.IdPessoaJuridica, 0) AS IdPessoaJuridica,
	       ISNULL(D.IdPessoa, 0) AS IdPessoa,
	       ISNULL(D.NumConjReneg, 0) AS NumConjReneg
	       INTO #REN_COM_PAGAMENTO
	FROM   Debitos D
	WHERE  ISNULL(D.NumConjReneg, 0) > 0
	       AND D.IdTipoDebito IN (2, 10)
	       AND IdSituacaoAtual IN (2, 14)
	
	-- Seleciona os Conjuntos de reneg com débitos renegociados em DA
	SELECT DISTINCT ISNULL(D.IdProfissional, 0) AS IdProfissional,
	       ISNULL(D.IdPessoaJuridica, 0) AS IdPessoaJuridica,
	       ISNULL(D.IdPessoa, 0) AS IdPessoa,
	       ISNULL(D.NumConjReneg, 0) AS NumConjReneg
	       INTO #REN_DA
	FROM   Debitos D,
	       DebitosDividaAtiva dda,
	       DividaAtiva da,
	       #MAXSIT_DIV S
	WHERE  ISNULL(D.NumConjReneg, 0) > 0
	       AND IdSituacaoAtual = 14
	       AND d.IdDebito = dda.IdDebito
	       AND dda.IdDividaAtiva = da.IdDividaAtiva
	       AND da.IdDividaAtiva = s.IdDividaAtiva
	       AND S.SituacaoDivAtiva = 1
	
	-- Seleciona os Conjuntos de reneg com débitos renegociados em DA com, pelo menos 1 pagamento
	SELECT DISTINCT R1.IdProfissional,
	       R1.IdPessoaJuridica,
	       R1.IdPessoa,
	       R1.NumConjReneg
	       INTO #REN_DA_PAG
	FROM   #REN_COM_PAGAMENTO R1,
	       #REN_DA R2
	WHERE  R1.IdProfissional = R2.IdProfissional
	       AND R1.IdPessoaJuridica = R2.IdPessoaJuridica
	       AND R1.IdPessoa = R2.IdPessoa
	       AND R1.NumConjReneg = R2.NumConjReneg 
	
	-- Seleciona os débitos pagos pertencentes aos conjuntos acima
	SELECT D.IdDebito,
	       CASE 
	            WHEN ISNULL(D.IdProfissional, 0) <> 0 THEN (
	                     SELECT ISNULL(Nome, '* NULO *')
	                     FROM   Profissionais p
	                     WHERE  D.IdProfissional = P.IdProfissional
	                 )
	            WHEN ISNULL(D.IdPessoaJuridica, 0) <> 0 THEN (
	                     SELECT ISNULL(Nome, '* NULO *')
	                     FROM   PessoasJuridicas p
	                     WHERE  D.IdPessoaJuridica = P.IdPessoaJuridica
	                 )
	       END AS Nome,
	       CASE 
	            WHEN ISNULL(D.IdProfissional, 0) <> 0 THEN (
	                     SELECT ISNULL(P.RegistroConselhoAtual, '* NULO *')
	                     FROM   Profissionais p
	                     WHERE  D.IdProfissional = P.IdProfissional
	                 )
	            WHEN ISNULL(D.IdPessoaJuridica, 0) <> 0 THEN (
	                     SELECT ISNULL(P.RegistroConselhoAtual, '* NULO *')
	                     FROM   PessoasJuridicas p
	                     WHERE  D.IdPessoaJuridica = P.IdPessoaJuridica
	                 )
	       END AS RegistroConselhoAtual,
	       D.DataPgto,
	       D.DataCredito,
	       D.ValorPago,
	       CONVERT(MONEY, D.ValorPago -(D.ValorPago * ISNULL(D.PercentualRepasse, 0) / 100)) AS ValorLiquido,
	       CONVERT(MONEY, D.ValorPago * ISNULL(D.PercentualRepasse, 0) / 100) AS ValorRepasse,
	       'PAGO (RENEG. DA)' AS SituacaoDebito
	       INTO #DEB1
	FROM   Debitos D,
	       #REN_DA_PAG R
	WHERE  ISNULL(D.IdProfissional, 0) = ISNULL(R.IdProfissional, 0)
	       AND ISNULL(D.IdPessoaJuridica, 0) = ISNULL(R.IdPessoaJuridica, 0)
	       AND ISNULL(D.IdPessoa, 0) = ISNULL(R.IdPessoa, 0)
	       AND ISNULL(D.NumConjReneg, 0) = ISNULL(R.NumConjReneg, 0)
	       AND D.IdSituacaoAtual = 2
	       AND CASE 
	                WHEN ISNULL(D.IdProfissional, 0) <> 0 THEN 1
	                WHEN ISNULL(D.IdPessoaJuridica, 0) <> 0 THEN 2
	           END = @TipoPessoa
	       AND D.DataPgto BETWEEN @DataPagto0 AND @DataPagto1
	       AND D.DataCredito BETWEEN @DataCredito0 AND @DataCredito1
	
	-- Seleciona os débitos pagos Pagos em div. ativa 
	SELECT D.IdDebito,
	       CASE 
	            WHEN ISNULL(D.IdProfissional, 0) <> 0 THEN (
	                     SELECT ISNULL(Nome, '* NULO *')
	                     FROM   Profissionais p
	                     WHERE  D.IdProfissional = P.IdProfissional
	                 )
	            WHEN ISNULL(D.IdPessoaJuridica, 0) <> 0 THEN (
	                     SELECT ISNULL(Nome, '* NULO *')
	                     FROM   PessoasJuridicas p
	                     WHERE  D.IdPessoaJuridica = P.IdPessoaJuridica
	                 )
	       END AS Nome,
	       CASE 
	            WHEN ISNULL(D.IdProfissional, 0) <> 0 THEN (
	                     SELECT ISNULL(P.RegistroConselhoAtual, '* NULO *')
	                     FROM   Profissionais p
	                     WHERE  D.IdProfissional = P.IdProfissional
	                 )
	            WHEN ISNULL(D.IdPessoaJuridica, 0) <> 0 THEN (
	                     SELECT ISNULL(P.RegistroConselhoAtual, '* NULO *')
	                     FROM   PessoasJuridicas p
	                     WHERE  D.IdPessoaJuridica = P.IdPessoaJuridica
	                 )
	       END AS RegistroConselhoAtual,
	       D.DataPgto,
	       D.DataCredito,
	       D.ValorPago,
	       CONVERT(MONEY, D.ValorPago -(D.ValorPago * ISNULL(D.PercentualRepasse, 0) / 100)) AS ValorLiquido,
	       CONVERT(MONEY, D.ValorPago * ISNULL(D.PercentualRepasse, 0) / 100) AS ValorRepasse,
	       UPPER(sd.SituacaoDebito) AS SituacaoDebito
	       INTO #DEB2
	FROM   Debitos D,
	       SituacoesDebito sd
	WHERE  D.IdSituacaoAtual IN (11, 15)
	       AND CASE 
	                WHEN ISNULL(D.IdProfissional, 0) <> 0 THEN 1
	                WHEN ISNULL(D.IdPessoaJuridica, 0) <> 0 THEN 2
	           END = @TipoPessoa
	       AND D.DataPgto BETWEEN @DataPagto0 AND @DataPagto1
	       AND D.DataCredito BETWEEN @DataCredito0 AND @DataCredito1
	       AND D.IdSituacaoAtual = sd.IdSituacaoDebito
	
	-- Calcula Composições	  
	CREATE TABLE #COMP
	(
		IdDebito            INT,
		ValorPagoPrincipal  MONEY,
		ValorPagoMulta      MONEY,
		ValorPagoJuros      MONEY
	)
	INSERT INTO #COMP
	SELECT IdDebito,
	       SUM(ISNULL(cd.ValorPagoPrincipal, 0)),
	       SUM(ISNULL(cd.ValorPagoMulta, 0)),
	       SUM(ISNULL(cd.ValorPagoJuros, 0))
	FROM   ComposicoesDebito cd
	GROUP BY
	       cd.IdDebito
	HAVING SUM(ISNULL(cd.ValorPagoPrincipal, 0)) > 0 
	
	---------------------------------------------------
	CREATE TABLE #REL
	(
		IdDebito               INT,
		Nome                   VARCHAR(100),
		RegistroConselhoAtual  VARCHAR(20),
		DataPgto               DATETIME,
		DataCredito            DATETIME,
		ValorPagoPrincipal     MONEY,
		ValorPagoMulta         MONEY,
		ValorPagoJuros         MONEY,
		ValorPago              MONEY,
		ValorLiquido           MONEY,
		ValorRepasse           MONEY,
		SituacaoDebito         VARCHAR(50)
	)
	INSERT INTO #REL
	SELECT D.IdDebito,
	       D.Nome,
	       D.RegistroConselhoAtual,
	       D.DataPgto,
	       D.DataCredito,
	       ISNULL(C.ValorPagoPrincipal, 0),
	       ISNULL(C.ValorPagoMulta, 0),
	       ISNULL(C.ValorPagoJuros, 0),
	       D.ValorPago,
	       D.ValorLiquido,
	       D.ValorRepasse,
	       SituacaoDebito
	FROM   #DEB1 D
	       LEFT JOIN #COMP C
	            ON  D.IdDebito = C.IdDebito 
	
	INSERT INTO #REL
	SELECT D.IdDebito,
	       D.Nome,
	       D.RegistroConselhoAtual,
	       D.DataPgto,
	       D.DataCredito,
	       ISNULL(C.ValorPagoPrincipal, 0),
	       ISNULL(C.ValorPagoMulta, 0),
	       ISNULL(C.ValorPagoJuros, 0),
	       D.ValorPago,
	       D.ValorLiquido,
	       D.ValorRepasse,
	       SituacaoDebito
	FROM   #DEB2 D
	       LEFT JOIN #COMP C
	            ON  D.IdDebito = C.IdDebito
	
	SELECT *
	FROM   #REL
	ORDER BY
	       DataPgto,
	       DataCredito,
	       Nome
	
	DROP TABLE #SITDA
	DROP TABLE #SIT1
	DROP TABLE #REN_COM_PAGAMENTO
	DROP TABLE #REN_DA 
	DROP TABLE #REN_DA_PAG
	DROP TABLE #MAXSIT_DIV
	DROP TABLE #DEB1
	DROP TABLE #COMP
	DROP TABLE #REL

