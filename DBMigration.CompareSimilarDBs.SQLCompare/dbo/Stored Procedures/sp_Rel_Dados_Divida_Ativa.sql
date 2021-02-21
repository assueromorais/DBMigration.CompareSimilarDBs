/*Criada pelo VictorB - Ocorr. 69125 - 03/11/2011*/

Create PROCEDURE [dbo].[sp_Rel_Dados_Divida_Ativa]
	@DataInicio DATETIME,
	@DataFim DATETIME,
	@TipoDividaAtiva TINYINT,
	@TipoPessoa TINYINT
AS
	/*
	Criada pelo VictorB - Ocorr. 69125 - 03/11/2011
	*/
	SET DATEFORMAT dmy
	SET NOCOUNT ON
	
	DECLARE @IdDividaAtiva              INT
	DECLARE @TipoDA                     INT
	DECLARE @Data                       DATETIME
	DECLARE @IdDividaAtivaANT           INT
	DECLARE @TipoDAANT                  INT
	DECLARE @SITDA                      INT
	DECLARE @SitDAANT                   INT
	DECLARE @IdDebito                   INT
	DECLARE @IdDebitoANT                INT
	DECLARE @IdSituacaoDebito           INT
	DECLARE @IdSituacaoDebitoANT        INT
	DECLARE @DataSituacao               DATETIME  
	
	DECLARE @PagoEmDANaoRenegociado     MONEY
	DECLARE @PagoEmDARenegociado        MONEY
	DECLARE @PagoMenorEmDA              MONEY
	DECLARE @NaoPagoEmDANaoRenegociado  MONEY
	DECLARE @NaoPagoEmDARenegociado     MONEY
	DECLARE @TotTransf                  MONEY
	
	IF @DataInicio IS NULL
	    SET @DataInicio = CONVERT(DATETIME, '01/01/1980')
	
	IF @DataFim IS NULL
	    SET @DataFim = GETDATE()
	ELSE
		SET @DataFim = DATEADD(n,-1,DATEADD(d,1,CONVERT(DATETIME, CONVERT(VARCHAR(10), @DataFim, 103))))
	
	-- Calcula o valor esperado a partir da composição de debito
	SELECT idDebito,
	       SUM(
	           ISNULL(cd.ValorEsperadoDAPrincipal  , 0) + 
	           ISNULL(cd.ValorEsperadoDAAtualizacao, 0) + 
	           ISNULL(cd.ValorEsperadoDAMulta      , 0) + 
	           ISNULL(cd.ValorEsperadoDAJuros      , 0)
	          -- + ISNULL(cd.ValorEsperadoDADespBco, 0) 
	          -- + ISNULL(cd.ValorEsperadoDADespAdv, 0) 
	          -- + ISNULL(cd.ValorEsperadoDADespPostais, 0)
	       ) AS ValorEsperado,
	       SUM(
	           ISNULL(cd.ValorPagoDAPrincipal  , 0) + 
	           ISNULL(cd.ValorPagoDAAtualizacao, 0) + 
	           ISNULL(cd.ValorPagoDAMulta      , 0) + 
	           ISNULL(cd.ValorPagoDAJuros      , 0)
	          -- + ISNULL(cd.ValorPagoDADespBco, 0) 
	          -- + ISNULL(cd.ValorPagoDADespAdv, 0) 
	          -- + ISNULL(cd.ValorPagoDADespPostais, 0)
	       ) AS ValorPagoDA
	INTO   #COMP_DEB   
	FROM   ComposicoesDebito cd
	WHERE  IdDebito IN (SELECT IdDebito
	                           FROM DebitosDividaAtiva dda)
	GROUP BY
	       cd.IdDebito
	ORDER BY
	       cd.IdDebito DESC
	
	SELECT dda.IdDebito,
	       dda.IdDividaAtiva,
	       ISNULL(dda.ValorPrincipal, 0) + ISNULL(dda.ValorAtualizacao, 0) + ISNULL(dda.ValorMulta, 0) +
	       ISNULL(dda.ValorJuros, 0) AS ValorLancado,
	       ISNULL(ce.ValorEsperado, 0) AS ValorEsperado
	INTO   #VALOR_LANC0   
	FROM   DebitosDividaAtiva dda
	       LEFT JOIN #COMP_DEB CE
	            ON  dda.IdDebito = ce.IdDebito
	WHERE DDA.SituacaoDebito<>2
		
	SELECT IdDebito,
	       IdDividaAtiva,
	       CASE 
	            WHEN ValorEsperado <> 0 THEN ValorEsperado
	            ELSE ValorLancado
	       END AS ValorEsperado
	INTO   #VALOR_ESPERADO   
	FROM   #VALOR_LANC0 
	
	-- Seleciona a última situação do DÉBITO dentro do período
	CREATE TABLE #MAXSIT_DEB
	(
		IdDebito          INT,
		IdSituacaoDebito  INT,
		DataSituacao      DATETIME
	)
	DECLARE X_SIT                  CURSOR  
	FOR
	    SELECT dsd.IdDebito,
	           dsd.IdSituacaoDebito,
	           dsd.DataSituacao
	           FROM Debitos_SituacoesDebito dsd,
	           DebitosDividaAtiva  dda
	           WHERE dsd.DataSituacao <= @DataFim
	           AND dsd.IdDebito = dda.IdDebito
	           ORDER BY
	           dsd.IdDebito,
	           dsd.DataSituacao DESC
	
	OPEN X_SIT           
	SET @IdDebitoANT = 0 
	FETCH NEXT FROM X_SIT 
	      INTO @IdDebito, @IdSituacaoDebito, @DataSituacao
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    IF @IdDebito <> @IdDebitoANT
	    BEGIN
	        INSERT INTO #MAXSIT_DEB 
	            VALUES ( 
	             @IdDebito, 
	             @IdSituacaoDebito, 
	             @DataSituacao 
	             )
	        PRINT CONVERT(VARCHAR(10), @IdDebito) + '  ' + CONVERT(VARCHAR(10), @IdDebitoANT)
	    END
	    
	    SET @IdDebitoANT = @IdDebito
	    FETCH NEXT FROM X_SIT 
	          INTO @IdDebito, @IdSituacaoDebito, @DataSituacao
	END 
	CLOSE X_SIT
	DEALLOCATE X_SIT
	
	-- Último TIPO no período ---------------------------------------------------------------------------
	CREATE TABLE #MAXTIPO_DIV0
	(
		IdDividaAtiva       INT,
		TipoDividaAtiva     INT,
		DATA                DATETIME,
		TipoDividaAtivaANT  INT
	)
	
	CREATE TABLE #MAXTIPO_DIV
	(
		IdDividaAtiva       INT,
		TipoDividaAtiva     INT,
		DATA                DATETIME,
		TipoDividaAtivaANT  INT
	)
	
	DECLARE X        CURSOR  
	FOR
	    SELECT DISTINCT IdDividaAtiva,
	           TipoDividaAtiva,
	           DATA  
	           FROM SituacoesDivAtiva
	           
	    -- excluindo D. A. com data null no histórico ------------------------------------------------------
	    -- WHERE IdDividaAtiva NOT IN (SELECT dn.IdDividaAtiva FROM SituacoesDivAtiva dn WHERE dn.DATA IS null)
	    -- -------------------------------------------------------------------------------------------------
	           
	           ORDER BY
	           IdDividaAtiva,
	           DATA  
	
	OPEN x
	SET @IdDividaAtivaANT = 0
	SET @TipoDAANT = 0 
	FETCH NEXT FROM x 
	      INTO @IdDividaAtiva, @TipoDA, @Data
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    IF @IdDividaAtiva <> @IdDividaAtivaANT
	       OR @TipoDA <> @TipoDAANT
	    BEGIN
	        IF @IdDividaAtiva <> @IdDividaAtivaANT
	            SET @TipoDAANT = 0
	        
	        INSERT INTO #MAXTIPO_DIV0 
	            VALUES ( 
	             @IdDividaAtiva, 
	             @TipoDA, 
	             @Data, 
	             @TipoDAANT 
	             )
	    END
	    
	    SET @IdDividaAtivaANT = @IdDividaAtiva
	    SET @TipoDAANT = @TipoDA 
	    FETCH NEXT FROM x 
	          INTO @IdDividaAtiva, @TipoDA, @Data
	END
	CLOSE x
	DEALLOCATE x
	
	INSERT INTO #MAXTIPO_DIV
	SELECT D0.*
	       FROM #MAXTIPO_DIV0 D0,
	       (
	           SELECT IdDividaAtiva,
	                  MAX(DATA) AS DATA
	                  FROM #MAXTIPO_DIV0
	                  WHERE DATA <= @DataFim
	                  GROUP BY
	                  IdDividaAtiva
	       ) D1
	       WHERE D0.IdDividaAtiva = D1.idDividaAtiva
	       AND D0.Data = D1.Data
	       ORDER BY
	       D0.IdDividaAtiva
	
	DROP TABLE #MAXTIPO_DIV0
	
	
	-- Última SITUAÇÃO no período -----------------------------------------------------------------------
	CREATE TABLE #MAXSIT_DIV0
	(
		IdDividaAtiva        INT,
		SituacaoDivAtiva     INT,
		DATA                 DATETIME,
		SituacaoDivAtivaANT  INT
	)
	
	CREATE TABLE #MAXSIT_DIV
	(
		IdDividaAtiva        INT,
		SituacaoDivAtiva     INT,
		DATA                 DATETIME,
		SituacaoDivAtivaANT  INT
	)
	
	DECLARE X        CURSOR  
	FOR
	    SELECT DISTINCT IdDividaAtiva,
	           SituacaoDivAtiva,
	           DATA  
	           FROM SituacoesDivAtiva
	           ORDER BY
	           IdDividaAtiva,
	           DATA  
	
	OPEN x
	SET @IdDividaAtivaANT = 0
	SET @SitDAANT = 0 
	FETCH NEXT FROM x 
	      INTO @IdDividaAtiva, @SitDA, @Data
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    IF @IdDividaAtiva <> @IdDividaAtivaANT
	       OR @SitDA <> @SitDAANT
	    BEGIN
	        IF @IdDividaAtiva <> @IdDividaAtivaANT
	            SET @SitDAANT = 0
	        
	        INSERT INTO #MAXSIT_DIV0 
	            VALUES ( 
	             @IdDividaAtiva, 
	             @SitDA, 
	             @Data, 
	             @SitDAANT 
	             )
	    END
	    
	    SET @IdDividaAtivaANT = @IdDividaAtiva
	    SET @SitDAANT = @SitDA 
	    FETCH NEXT FROM x 
	          INTO @IdDividaAtiva, @SitDA, @Data
	END
	CLOSE x
	DEALLOCATE x
	
	INSERT INTO #MAXSIT_DIV
	SELECT D0.*
	       FROM #MAXSIT_DIV0 D0,
	       (
	           SELECT IdDividaAtiva,
	                  MAX(DATA) AS DATA
	                  FROM #MAXSIT_DIV0
	                  WHERE DATA <= @DataFim
	                  GROUP BY
	                  IdDividaAtiva
	       ) D1
	       WHERE D0.IdDividaAtiva = D1.idDividaAtiva
	       AND D0.Data = D1.Data
	       ORDER BY
	       D0.IdDividaAtiva
	
	DROP TABLE #MAXSIT_DIV0
	
	-------------------------------------------------------------------
	-- Conjuntos de REN DA
	-- Identifica os conjuntos de renegociação (só os que foram renegociados até o fim do período)
	SELECT DISTINCT ISNULL(d.IdProfissional, 0) AS IdProfissional,
	       ISNULL(d.IdPessoaJuridica, 0) AS IdPessoaJuridica,
	       ISNULL(d.IdPessoa, 0) AS IdPessoa,
	       ISNULL(d.NumConjReneg, 0) AS NumConjReneg,
	       CASE 
	            WHEN ISNULL(d.IdProfissional, 0) <> 0 THEN 1
	            WHEN ISNULL(d.IdPessoaJuridica, 0) <> 0 THEN 2
	            WHEN ISNULL(d.IdPessoa, 0) <> 0 THEN 3
	       END AS TipoPessoa
	INTO   #REN1   
	FROM   debitos d,
	       DebitosDividaAtiva dda,
	       #MAXSIT_DEB MS
	WHERE  d.IdDebito = MS.IdDebito
	       AND d.IdDebito = dda.IdDebito
	       AND MS.IdSituacaoDebito = 14
	
	IF @TipoPessoa <> 0
	    DELETE 
	    FROM   #REN1
	    WHERE  TipoPessoa <> @TipoPessoa	
	
	-- Identifica os débitos resultantes das renegociações acima
	SELECT D.IdDebito,
	       D.DataPgto,
	       D.IdSituacaoAtual,
	       ISNULL(D.ValorPago, 0) AS ValorPago,
	       #REN1.IdProfissional,
	       #REN1.IdPessoaJuridica,
	       #REN1.IdPessoa,
	       #REN1.NumConjReneg
	INTO   #REN2   
	FROM   debitos D,
	       #REN1
	WHERE  ISNULL(d.IdProfissional, 0) = #REN1.IdProfissional
	       AND ISNULL(d.IdPessoaJuridica, 0) = #REN1.IdPessoaJuridica
	       AND ISNULL(d.IdPessoa, 0) = #REN1.IdPessoa
	       AND ISNULL(d.NumConjReneg, 0) = #REN1.NumConjReneg
	       AND d.IdSituacaoAtual NOT IN (6, 14, 9, 12)
	
	-- classifica os lancamentos acima quanto a quitação
	SELECT IdProfissional,
	       IdPessoaJuridica,
	       IdPessoa,
	       NumConjReneg,
	       MAX(DataPgto) AS MaxData,
	       COUNT(IdDebito) AS QTDDebitos,
	       SUM(
	           CASE 
	                WHEN IdSituacaoAtual IN (2,4,5) THEN 1
	                ELSE 0 
	           END
	       ) AS QTDPagos,
	       ISNULL(SUM(ISNULL(ValorPago, 0)), 0) AS ValorPago
	INTO   #REN_DA   
	FROM   #REN2
	GROUP BY
	       IdProfissional,
	       IdPessoaJuridica,
	       IdPessoa,
	       NumConjReneg
	
	SELECT *
	INTO   #REN_DA_QUITADOS   
	FROM   #REN_DA
	WHERE  QTDDebitos = QTDPagos
	       AND Maxdata BETWEEN @DataInicio AND @DataFim
	
	SELECT *
	INTO   #REN_DA_NAO_QUITADOS   
	FROM   #REN_DA
	WHERE  QTDDebitos <> QTDPagos
	
	--SELECT * FROM   #REN_DA_NAO_QUITADOS
	
	DROP TABLE #REN1
	DROP TABLE #REN2
	
	-------------------------------------------------------------------	
	CREATE TABLE #REL
	(
		Item             VARCHAR(100),
		Valor            MONEY,
		DataInicio       VARCHAR(10),
		DataFim          VARCHAR(10),
		TipoDividaAtiva  VARCHAR(20),
		TipoPessoa       VARCHAR(30)
	)
	-------------------------------------------------------------------
	-- Calcula PAGAMENTOS
	/*
	Pagamentos - somatória dos valores pagos dos débitos de acordo com os seguintes critérios abaixo
	•	Data de pagamento entre data inicial e final do período ou caso exista débitos renegociados, todas as parcelas devem estar quitadas
	•	Última Situação da Dívida Ativa deverá ser igual ao informado no filtro
	•	Tipo pessoa igual a informada no filtro
	•	Situação do pagamento igual a Pago Div.Ativa
	
	*/
	
	-- 1.  Débitos pagos em dívida ativa no período
	
	SELECT d.ValorPago,
	       CASE 
	            WHEN ISNULL(d.IdProfissional, 0) <> 0 THEN 1
	            WHEN ISNULL(d.IdPessoaJuridica, 0) <> 0 THEN 2
	            WHEN ISNULL(d.IdPessoa, 0) <> 0 THEN 3
	       END AS TipoPessoa
	INTO   #NAOREN   
	FROM   Debitos d,
	       DebitosDividaAtiva dda,
	       DividaAtiva da,
	       #MAXTipo_DIV MT,
           #MAXSIT_DIV MS
	WHERE  d.IdSituacaoAtual = 11
	       AND d.IdDebito = dda.IdDebito
	       AND dda.IdDividaAtiva = da.IdDividaAtiva
	       AND MS.IdDividaAtiva = da.IdDividaAtiva
           AND MS.SituacaoDivAtiva <> 2
	       AND DA.IdDividaAtiva = MT.IdDividaAtiva
	       AND MT.TipoDividaAtiva = @TipoDividaAtiva
	       AND d.DataPgto BETWEEN @DataInicio AND @DataFim
	
	IF @TipoPessoa <> 0
	    DELETE 
	    FROM   #NAOREN
	    WHERE  TipoPessoa <> @TipoPessoa
	
	SELECT @PagoEmDANaoRenegociado = ISNULL(SUM(ISNULL(ValorPago, 0)), 0)
	       FROM #NAOREN 
	
	-- 2.  Renegociações pagas no período
	SELECT @PagoEmDARenegociado = ISNULL(SUM(cd.ValorPagoPrincipal  ) +
	                                     SUM(cd.ValorPagoAtualizacao) +
	                                     SUM(cd.ValorPagoMulta      ) +
	                                     SUM(cd.ValorPagoJuros      ) +
	                                     SUM(cd.ValorPagoDespBco    ) +
	                                     SUM(cd.ValorPagoDespAdv    ) +
	                                     SUM(cd.ValorPagoDespPostais), 0) 
	       FROM Debitos d,
	       DebitosDividaAtiva dda,
	       ComposicoesDebito cd,
	       Debitos drr,
	       #REN_DA_QUITADOS R,
	       #MAXTIPO_DIV MT,
           #MAXSIT_DIV MS
	       WHERE d.IdDebito = dda.IdDebito
	       AND cd.IdDebitoOrigemRen = d.IdDebito
	       AND cd.IdDebito = drr.IdDebito
	       AND MS.IdDividaAtiva = dda.IdDividaAtiva
           AND MS.SituacaoDivAtiva <> 2	       
	       AND drr.NumConjReneg = d.NumConjReneg
	       AND d.IdSituacaoAtual = 14
	       AND ISNULL(d.IdProfissional, 0) = R.IdProfissional
	       AND ISNULL(d.IdPessoaJuridica, 0) = R.IdPessoaJuridica
	       AND ISNULL(d.IdPessoa, 0) = R.IdPessoa
	       AND ISNULL(d.NumConjReneg, 0) = R.NumConjReneg
	       AND dDA.IdDividaAtiva = MT.IdDividaAtiva
	       AND MT.TipoDividaAtiva = @TipoDividaAtiva
		
	INSERT INTO #REL 
	    VALUES ( 
	     'Pagamentos', 
	     ISNULL(@PagoEmDANaoRenegociado + @PagoEmDARenegociado,0), 
	     CONVERT(VARCHAR(10), @DataInicio, 103), 
	     CONVERT(VARCHAR(10), @DataFim, 103), 
	     CASE @TipoDividaAtiva
	          WHEN 1 THEN 'ADMINISTRATIVA'
	          ELSE 'EXECUTIVA'
	     END, 
	     CASE @TipoPessoa
	          WHEN 0 THEN 'TODOS'
	          WHEN 1 THEN 'PROFISSIONAIS'
	          WHEN 2 THEN 'PESSOAS JURÍDICAS'
	          ELSE 'OUTRAS PESSOAS'
	     END 
	     )
	---------------------------------------------------------------------------------------------------------------
	-- Calcula CANCELAMENTOS
	CREATE TABLE #DebCANC
	(
		IdDebito               INT,
		IdProfissional         INT,
		IdPessoaJuridica       INT,
		IdPessoa               INT,
		RegistroConselhoAtual  VARCHAR(20),
		TipoPessoa             INT,
		IdTipoDebito           INT,
		IdDividaAtiva          INT,
		ValorPrincipal         MONEY,
		ValorAtualizacao       MONEY,
		ValorMulta             MONEY,
		ValorJuros             MONEY
	)
	INSERT INTO #DebCANC (
		 IdDebito, 
	     IdProfissional, 
	     IdPessoaJuridica, 
	     IdPessoa, 
	     RegistroConselhoAtual, 
	     TipoPessoa, 
	     IdTipoDebito, 
	     IdDividaAtiva, 
	     ValorPrincipal, 
	     ValorAtualizacao, 
	     ValorMulta, 
	     ValorJuros 
	           )
	SELECT D.IdDebito,
	       D.IdProfissional,
	       D.IdPessoaJuridica,
	       D.IdPessoa,
	       CASE 
	            WHEN ISNULL(d.IdProfissional, 0) <> 0 THEN (
	                     SELECT P.RegistroConselhoAtual
	                     FROM   PROFISSIONAIS P
	                     WHERE  P.IdProfissional = D.IdProfissional
	                 )
	            WHEN ISNULL(d.IdPessoaJuridica, 0) <> 0 THEN (
	                     SELECT P.RegistroConselhoAtual
	                     FROM   PESSOASJURIDICAS P
	                     WHERE  P.IdPessoaJuridica = D.IdPessoaJuridica
	                 )
	            ELSE ''
	       END AS RegistroConselhoAtual,
	       CASE 
	            WHEN ISNULL(d.IdProfissional, 0) <> 0 THEN 1
	            WHEN ISNULL(d.IdPessoaJuridica, 0) <> 0 THEN 2
	            WHEN ISNULL(d.IdPessoa, 0) <> 0 THEN 3
	       END AS TipoPessoa,
	       D.IdTipoDebito,
	       dda.IdDividaAtiva,
	       ISNULL(dda.ValorPrincipal, 0) AS ValorPrincipal,
	       ISNULL(dda.ValorAtualizacao, 0) AS ValorAtualizacao,
	       ISNULL(dda.ValorMulta, 0) AS ValorMulta,
	       ISNULL(dda.ValorJuros, 0) AS ValorJuros
	FROM   debitos d,
	       DebitosDividaAtiva dda,
	       DividaAtiva da,
	       #MAXTIPO_DIV MT
	WHERE  d.IdDebito = dda.IdDebito
	       AND dda.IdDividaAtiva = da.IdDividaAtiva
	       AND da.IdDividaAtiva = MT.IdDividaAtiva
	       AND mt.TipoDividaAtiva = @TipoDividaAtiva
	       AND (
	               da.IdDividaAtiva IN (SELECT IdDividaAtiva
	                                    FROM   #MAXSIT_DIV SDA
	                                    WHERE  SDA.SituacaoDivAtiva = 2
	                                           AND SDA.[DATA] BETWEEN @DataInicio AND @DataFim)
	               OR d.IdDebito IN (SELECT dda2.IdDebito
	                                 FROM   DebitosDividaAtiva dda2
	                                 WHERE  dda2.DtCancelIndividual BETWEEN @DataInicio AND @DataFim
	                                   AND  dda2.IdDividaAtiva = da.IdDividaAtiva)
	           )
	
	IF @TipoPessoa <> 0
	    DELETE 
	    FROM   #DebCANC
	    WHERE  TipoPessoa <> @TipoPessoa
	
	INSERT INTO #REL
	SELECT 'Cancelamentos',
	       ISNULL(SUM(ISNULL(ValorPrincipal, 0) + ISNULL(ValorAtualizacao, 0) + ISNULL(ValorMulta, 0) + ISNULL(ValorJuros, 0)), 0),
	       CONVERT(VARCHAR(10), @DataInicio, 103),
	       CONVERT(VARCHAR(10), @DataFim, 103),
	       CASE @TipoDividaAtiva
	            WHEN 1 THEN 'ADMINISTRATIVA'
	            ELSE 'EXECUTIVA'
	       END,
	       CASE @TipoPessoa
	            WHEN 0 THEN 'TODOS'
	            WHEN 1 THEN 'PROFISSIONAIS'
	            WHEN 2 THEN 'PESSOAS JURÍDICAS'
	            ELSE 'OUTRAS PESSOAS'
	       END
	       FROM #DebCANC
	
	DROP TABLE #DebCANC
	
	---- Calcula TRANSF.
	
	SELECT IdDividaAtiva
	INTO   #LISTA   
	FROM   #MAXTIPO_DIV
	WHERE  IdDividaAtiva = IdDividaAtiva
	       AND TipoDividaAtivaANT <> 0
	       AND TipoDividaAtiva = @TipoDividaAtiva
	       AND [DATA] BETWEEN @DataInicio AND @DataFim
	ORDER BY
	       IdDividaAtiva
		
	SELECT ISNULL(SUM(ISNULL(dda.ValorPrincipal, 0) + ISNULL(dda.ValorAtualizacao, 0) + ISNULL(dda.ValorMulta, 0) + ISNULL(dda.ValorJuros, 0)), 0) AS TotalTransf,
	       CASE 
	            WHEN ISNULL(d.IdProfissional, 0) <> 0 THEN 1
	            WHEN ISNULL(d.IdPessoaJuridica, 0) <> 0 THEN 2
	            WHEN ISNULL(d.IdPessoa, 0) <> 0 THEN 3
	       END AS TipoPessoa
	       INTO #LISTA2
	FROM   Debitos d,
	       DebitosDividaAtiva dda,
	       #LISTA L,
	       #MAXSIT_DEB MS
	WHERE  d.IdDebito = dda.IdDebito
	       AND dda.IdDividaAtiva = L.IdDividaAtiva
	       AND D.IdDebito = MS.IdDebito
	       AND MS.IdSituacaoDebito >= 10
	       AND dda.SituacaoDebito = 1
	       
	GROUP BY d.IdProfissional, d.IdPessoaJuridica, d.IdPessoa 	       
		
	IF @TipoPessoa <> 0
	    DELETE 
	    FROM   #LISTA2
	    WHERE  TipoPessoa <> @TipoPessoa
	    
	SELECT @TotTransf = SUM(TotalTransf)
	FROM   #LISTA2 L 
	
	INSERT INTO #REL 
	    VALUES ( 
	     'Transferido para ' + CASE @TipoDividaAtiva
	                                WHEN 1 THEN '"ADMINISTRATIVA"'
	                                ELSE '"EXECUTIVA"'
	                           END, 
	     ISNULL(@TotTransf,0), 
	     CONVERT(VARCHAR(10), @DataInicio, 103), 
	     CONVERT(VARCHAR(10), @DataFim, 103), 
	     CASE @TipoDividaAtiva
	          WHEN 1 THEN 'ADMINISTRATIVA'
	          ELSE 'EXECUTIVA'
	     END, 
	     CASE @TipoPessoa
	          WHEN 0 THEN 'TODOS'
	          WHEN 1 THEN 'PROFISSIONAIS'
	          WHEN 2 THEN 'PESSOAS JURÍDICAS'
	          ELSE 'OUTRAS PESSOAS'
	     END 
	     )
	
	
	---- Calcula EM ABERTO
	/*
	Posição na data final somatória dos valores  que faltam o Conselho receber
	•	Último Tipo da dívida igual ao informado no filtro
	•	Situação do débito igual a Não Pago, Pago a Menor ou débitos renegociados que ainda 
	tenha alguma parcela em aberta
	•	Tipo pessoa igual a informado no filtro
	•	Como resultado devem ser listados as seguinte somatórias
				Débitos em aberto
				Débitos renegociados (vencidos e a vencer)
				Saldo de pgtos a menor
				Total
	*/
	
	-- 1.  Débitos não pagos em dívida ativa no período
	SELECT dda.ValorEsperado,
	       CASE 
	            WHEN ISNULL(d.IdProfissional, 0) <> 0 THEN 1
	            WHEN ISNULL(d.IdPessoaJuridica, 0) <> 0 THEN 2
	            WHEN ISNULL(d.IdPessoa, 0) <> 0 THEN 3
	       END AS TipoPessoa
	INTO   #NAOREN1   
	FROM   Debitos d,
	       #VALOR_ESPERADO dda,
	       DividaAtiva da,
	       #MAXTipo_DIV MT,
	       #MAXSIT_DEB MS
	WHERE  d.IdDebito = dda.IdDebito
	       AND dda.IdDividaAtiva = da.IdDividaAtiva
	       AND DA.IdDividaAtiva = MT.IdDividaAtiva
	       AND D.IdDebito = MS.IdDebito
	       AND MS.IdSituacaoDebito = 10 -- Lançados em DA	    
	       AND MT.TipoDividaAtiva = @TipoDividaAtiva

	    -- excluindo D. A. com data null no histórico ------------------------------------------------------
	    -- and dda.IdDividaAtiva NOT IN (SELECT dn.IdDividaAtiva FROM SituacoesDivAtiva dn WHERE dn.DATA IS null)
	    -- -------------------------------------------------------------------------------------------------
	
	IF @TipoPessoa <> 0
	    DELETE 
	    FROM   #NAOREN1
	    WHERE  TipoPessoa <> @TipoPessoa
	
	SELECT @NaoPagoEmDANaoRenegociado = ISNULL(SUM(ISNULL(ValorEsperado, 0)), 0)
	       FROM #NAOREN1 
	
	INSERT INTO #REL 
	    VALUES ( 
	     'Posição na data final - débitos EM ABERTO', 
	     ISNULL(@NaoPagoEmDANaoRenegociado,0), 
	     CONVERT(VARCHAR(10), @DataInicio, 103), 
	     CONVERT(VARCHAR(10), @DataFim, 103), 
	     CASE @TipoDividaAtiva
	          WHEN 1 THEN 'ADMINISTRATIVA'
	          ELSE 'EXECUTIVA'
	     END, 
	     CASE @TipoPessoa
	          WHEN 0 THEN 'TODOS'
	          WHEN 1 THEN 'PROFISSIONAIS'
	          WHEN 2 THEN 'PESSOAS JURÍDICAS'
	          ELSE 'OUTRAS PESSOAS'
	     END 
	     )
	
	---- Calcula RENEGOCIADOS NÃO QUITADOS
	SELECT @NaoPagoEmDARenegociado = ISNULL(SUM(dda.ValorEsperado), 0)
	       FROM Debitos d,
	       #VALOR_ESPERADO dda,
	       #MAXTIPO_DIV MT,
	       #MAXSIT_DEB MS
	       WHERE d.IdDebito = dda.IdDebito
	       AND d.IdDebito IN (SELECT D0.IdDebito
	                                 FROM Debitos D0,
	                                 #REN_DA_NAO_QUITADOS R
	                                 WHERE ISNULL(d0.IdProfissional, 0) = R.IdProfissional
	                                 AND ISNULL(d0.IdPessoaJuridica, 0) = R.IdPessoaJuridica
	                                 AND ISNULL(d0.IdPessoa, 0) = R.IdPessoa
	                                 AND ISNULL(d0.NumConjReneg, 0) = R.NumConjReneg)
	       AND dda.IdDividaAtiva = MT.IdDividaAtiva
	       AND MT.TipoDividaAtiva = @TipoDividaAtiva
	       AND d.IdDebito = MS.IdDebito
	       AND Ms.IdSituacaoDebito = 14

	    -- excluindo D. A. com data null no histórico ------------------------------------------------------
	    -- and dda.IdDividaAtiva NOT IN (SELECT dn.IdDividaAtiva FROM SituacoesDivAtiva dn WHERE dn.DATA IS null)
	    -- -------------------------------------------------------------------------------------------------
	    
	INSERT INTO #REL 
	    VALUES ( 
	     'Posição na data final - renegociados não quitados', 
	     ISNULL(@NaoPagoEmDARenegociado,0), 
	     CONVERT(VARCHAR(10), @DataInicio, 103), 
	     CONVERT(VARCHAR(10), @DataFim, 103), 
	     CASE @TipoDividaAtiva
	          WHEN 1 THEN 'ADMINISTRATIVA'
	          ELSE 'EXECUTIVA'
	     END, 
	     CASE @TipoPessoa
	          WHEN 0 THEN 'TODOS'
	          WHEN 1 THEN 'PROFISSIONAIS'
	          WHEN 2 THEN 'PESSOAS JURÍDICAS'
	          ELSE 'OUTRAS PESSOAS'
	     END 
	     )
	
	---- Calcula Saldo PAGO A MENOR
	SELECT dda.ValorEsperado - cd.ValorPagoDA AS DifPagoMenor,
	       CASE 
	            WHEN ISNULL(d.IdProfissional, 0) <> 0 THEN 1
	            WHEN ISNULL(d.IdPessoaJuridica, 0) <> 0 THEN 2
	            WHEN ISNULL(d.IdPessoa, 0) <> 0 THEN 3
	       END AS TipoPessoa
	INTO   #PGMENOR   
	FROM   Debitos d,
	       #VALOR_ESPERADO dda,
	       DividaAtiva da,
	       #MAXTipo_DIV MT,
	       #MAXSIT_DEB MS,
	       #COMP_DEB cd
	WHERE  d.IdDebito = dda.IdDebito
	       AND dda.IdDividaAtiva = da.IdDividaAtiva
	       AND DA.IdDividaAtiva = MT.IdDividaAtiva
	       AND cd.IdDebito = d.IdDebito
	       AND D.IdDebito = MS.IdDebito
	       AND MS.IdSituacaoDebito = 15 -- Pg Menor DA
	       AND MT.TipoDividaAtiva = @TipoDividaAtiva
	       AND dda.ValorEsperado - cd.ValorPagoDA > 0

	    -- excluindo D. A. com data null no histórico ------------------------------------------------------
	    --- and dda.IdDividaAtiva NOT IN (SELECT dn.IdDividaAtiva FROM SituacoesDivAtiva dn WHERE dn.DATA IS null)
	    -- -------------------------------------------------------------------------------------------------
	
	IF @TipoPessoa <> 0
	    DELETE 
	    FROM   #PGMENOR
	    WHERE  TipoPessoa <> @TipoPessoa	
	
	SELECT @PagoMenorEmDA = ISNULL(SUM(ISNULL(DifPagoMenor, 0)), 0)
	       FROM #PGMENOR	       
	
	INSERT INTO #REL 
	    VALUES ( 
	     'Posição na data final - saldo pago a menor', 
	     ISNULL(@PagoMenorEmDA,0), 
	     CONVERT(VARCHAR(10), @DataInicio, 103), 
	     CONVERT(VARCHAR(10), @DataFim, 103), 
	     CASE @TipoDividaAtiva
	          WHEN 1 THEN 'ADMINISTRATIVA'
	          ELSE 'EXECUTIVA'
	     END, 
	     CASE @TipoPessoa
	          WHEN 0 THEN 'TODOS'
	          WHEN 1 THEN 'PROFISSIONAIS'
	          WHEN 2 THEN 'PESSOAS JURÍDICAS'
	          ELSE 'OUTRAS PESSOAS'
	     END 
	     )
	
	UPDATE #REL
	SET    Valor = ROUND(Valor, 2)
	
	DECLARE @Tot MONEY
	SELECT @Tot = SUM(Valor)
	       FROM #REL
	       WHERE Item LIKE 'Pos%'
	
	INSERT INTO #REL 
	    VALUES ( 
	     'Posição na data final - TOTAL', 
	     ISNULL(@Tot,0), 
	     CONVERT(VARCHAR(10), @DataInicio, 103), 
	     CONVERT(VARCHAR(10), @DataFim, 103), 
	     CASE @TipoDividaAtiva
	          WHEN 1 THEN 'ADMINISTRATIVA'
	          ELSE 'EXECUTIVA'
	     END, 
	     CASE @TipoPessoa
	          WHEN 0 THEN 'TODOS'
	          WHEN 1 THEN 'PROFISSIONAIS'
	          WHEN 2 THEN 'PESSOAS JURÍDICAS'
	          ELSE 'OUTRAS PESSOAS'
	     END 
	     )
	
	SELECT *
	       FROM #REL
	
	DROP TABLE #REL
