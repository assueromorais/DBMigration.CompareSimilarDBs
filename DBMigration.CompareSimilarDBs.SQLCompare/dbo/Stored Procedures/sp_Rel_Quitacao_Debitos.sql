
/*Criada pelo VictorB - Ocorr. 74685 - 04/11/2011*/


CREATE PROCEDURE dbo.sp_Rel_Quitacao_Debitos
	@TipoPessoa TINYINT
AS
	/*
	Demanda- 74685
	
	Descrição
	- O resultado desse relatórios será utilizado para identificar para quais processos 
	o conselho deve entrar com o pedido judicial de extinção do processo no fórum.
	
	- Esse relatório deve listar todos os processos de execução de dívida ativa, que a 
	ultima situação não indique que esteja extinto e cujos débitos vinculados foram 
	totalmente quitados a vista ou renegociados/recobrados.
	
	- No caso de débitos renegociados em mais de uma parcela, os sistema deve considerar 
	totalmente pago a partir do momento que as parcelas pagas quitarem a origem do 
	débito vinculado ao processo.
	*/
	SET DATEFORMAT dmy
	SET NOCOUNT ON
	
	DECLARE @TituloCampo       VARCHAR(40)
	DECLARE @TipoCampo         VARCHAR(1)
	DECLARE @Campos            VARCHAR(8000)
	DECLARE @CampoDados        VARCHAR(40)
	DECLARE @NomeCampo         VARCHAR(40)
	DECLARE @ChaveEstrangeira  VARCHAR(40)
	DECLARE @TabelaAuxiliar    VARCHAR(40)
	-- Seleciona os Conjuntos de reneg com, ao menos, uma parcela em aberto
	SELECT DISTINCT ISNULL(D.IdProfissional, 0) AS IdProfissional,
	       ISNULL(D.IdPessoaJuridica, 0) AS IdPessoaJuridica,
	       ISNULL(D.IdPessoa, 0) AS IdPessoa,
	       ISNULL(D.NumConjReneg, 0) AS NumConjReneg
	       INTO #REN_ABERTO
	FROM   Debitos D
	WHERE  ISNULL(D.NumConjReneg, 0) > 0
	       AND D.IdTipoDebito IN (2, 10)
	       AND IdSituacaoAtual = 1
	
	-- Seleciona os Conjuntos de reneg com todas as parcelas pagas
	SELECT ISNULL(D.IdProfissional, 0) AS IdProfissional,
	       ISNULL(D.IdPessoaJuridica, 0) AS IdPessoaJuridica,
	       ISNULL(D.IdPessoa, 0) AS IdPessoa,
	       ISNULL(D.NumConjReneg, 0) AS NumConjReneg
	       INTO #REN_QUITADAS1
	FROM   Debitos D
	       LEFT JOIN #REN_ABERTO R
	            ON  ISNULL(D.IdProfissional, 0) = R.IdProfissional
	                AND ISNULL(D.IdPessoaJuridica, 0) = R.IdPessoaJuridica
	                AND ISNULL(D.IdPessoa, 0) = R.IdPessoa
	                AND ISNULL(D.NumConjReneg, 0) = R.NumConjReneg
	WHERE  ISNULL(R.NumConjReneg, 0) = 0
	       AND D.IdSituacaoAtual IN (2, 4)
	       AND ISNULL(D.NumConjReneg, 0) <> 0
	GROUP BY
	       ISNULL(D.IdProfissional, 0),
	       ISNULL(D.IdPessoaJuridica, 0),
	       ISNULL(D.IdPessoa, 0),
	       ISNULL(D.NumConjReneg, 0)
	ORDER BY
	       ISNULL(D.IdProfissional, 0),
	       ISNULL(D.IdPessoaJuridica, 0),
	       ISNULL(D.IdPessoa, 0),
	       ISNULL(D.NumConjReneg, 0)
	
	SELECT DA.IdProcesso,
	       ISNULL(D.IdProfissional, 0) AS IdProfissional,
	       ISNULL(D.IdPessoaJuridica, 0) AS IdPessoaJuridica,
	       ISNULL(D.IdPessoa, 0) AS IdPessoa,
	       ISNULL(D.NumConjReneg, 0) AS NumConjReneg
	       INTO #REN_PROCESSO
	FROM   Debitos D,
	       DebitosDividaAtiva dda,
	       DividaAtiva da
	WHERE  D.IdDebito = dda.IdDebito
	       AND dda.IdDividaAtiva = da.IdDividaAtiva
	       AND D.IdSituacaoAtual = 14
	       AND DA.IdProcesso IS NOT NULL
	GROUP BY
	       IdProcesso,
	       ISNULL(D.IdProfissional, 0),
	       ISNULL(D.IdPessoaJuridica, 0),
	       ISNULL(D.IdPessoa, 0),
	       ISNULL(D.NumConjReneg, 0)    
	
	SELECT P.*,
	       PR.NumeroProc
	       INTO #REN_QUITADAS
	FROM   #REN_QUITADAS1 Q,
	       #REN_PROCESSO P,
	       Processos PR,
	       dbo.TipoProcesso tp
	WHERE  Q.NumConjReneg = 1
	       AND Q.IdProfissional = P.IdProfissional
	       AND Q.IdPessoaJuridica = P.IdPessoaJuridica
	       AND Q.IdPessoa = P.IdPessoa
	       AND Q.NumConjReneg = P.NumConjReneg
	       AND P.IdProcesso = PR.IdProcesso
	       AND TP.IdTipoProcesso = PR.IDTIPOPROCESSO
	       AND TP.ModeloTipoProcesso = 'Fiscal (D.A.)'
	--SELECT * FROM #REN_QUITADAS       
	DROP TABLE #REN_QUITADAS1
	DROP TABLE #REN_PROCESSO
	DROP TABLE #REN_ABERTO
	
	-- Seleciona ultima situacao dos processos, desprezando os extintos
	SELECT maxid.idprocesso,
	       MAX(maxid.idprocesso_SitProcesso) idprocesso_SitProcesso
	       INTO #MAXSIT1
	FROM   Processos_SituacoesProcesso maxid
	       LEFT JOIN (
	                SELECT idprocesso,
	                       MAX(DataSituacao) DataSituacao
	                FROM   Processos_SituacoesProcesso
	                GROUP BY
	                       idprocesso
	            ) AS maxdata
	            ON  maxdata.DataSituacao = maxid.DataSituacao
	                AND maxdata.idprocesso = maxid.idprocesso
	GROUP BY
	       maxid.idprocesso	
	
	SELECT MS.IdProcesso,
	       S.IdSituacaoProcFis,
	       S.IndicaProcessoExtinto,
	       S.SituacaoProcFis
	       INTO #MAXSIT
	FROM   #MAXSIT1 MS,
	       Processos_SituacoesProcesso PSP,
	       SituacoesProcFis S
	WHERE  MS.idprocesso_SitProcesso = PSP.idprocesso_SitProcesso
	       AND PSP.IdSituacaoProcFis = S.IdSituacaoProcFis
	       AND ISNULL(S.IndicaProcessoExtinto, 0) = 0
	
	DROP TABLE #MAXSIT1
	----------------------------------------------------------------------
	-- Débitos em DA quitados sem renegociação       
	SELECT P.IdProcesso,
	       P.NumeroProc,
	       D.IdDebito,
	       D.IdProfissional,
	       D.IdPessoaJuridica,
	       D.IdPessoa,
	       D.IdTipoDebito,
	       D.IdSituacaoAtual,
	       DDA.SituacaoDebito,
	       D.DataVencimento,
	       D.DataReferencia,
	       D.DataPgto,
	       ISNULL(DDA.ValorPrincipal, 0) +
	       ISNULL(DDA.ValorAtualizacao, 0) +
	       ISNULL(DDA.ValorMulta, 0) +
	       ISNULL(DDA.ValorJuros, 0) AS ValorDevido,
	       D.ValorPago,
	       CONVERT(INT, 0) AS NumConjReneg,
	       MS.SituacaoProcFis
	       INTO #DEB_NAO_REN_QUIT
	FROM   dbo.Debitos D
	       INNER JOIN dbo.DebitosDividaAtiva DDA
	            ON  D.IdDebito = DDA.IdDebito
	       INNER JOIN dbo.DividaAtiva DA
	            ON  DDA.IdDividaAtiva = DA.IdDividaAtiva
	       INNER JOIN dbo.Processos P
	            ON  DA.IdProcesso = P.IdProcesso
	       INNER JOIN dbo.TipoProcesso tp
	            ON  P.IDTIPOPROCESSO = TP.IdTipoProcesso
	       INNER JOIN #MAXSIT MS
	            ON  P.IdProcesso = MS.IdProcesso
	WHERE  ISNULL(D.NumConjReneg, 0) = 0
	       AND TP.ModeloTipoProcesso = 'Fiscal (D.A.)'
	       AND D.IdSituacaoAtual IN (2, 4, 11)
	       AND DDA.SituacaoDebito <> 2
	       AND D.DataPgto IS NOT NULL
	---------------------------------------------------------------
	-- Débitos renegociados em DA quitados
	
	SELECT R.IdProcesso,
	       R.NumeroProc,
	       D.IdDebito,
	       D.IdProfissional,
	       D.IdPessoaJuridica,
	       D.IdPessoa,
	       D.IdTipoDebito,
	       D.IdSituacaoAtual,
	       0 AS SituacaoDebito,
	       D.DataVencimento,
	       D.DataReferencia,
	       D.DataPgto,
	       D.ValorDevido,
	       D.ValorPago,
	       D.NumConjReneg,
	       MS.SituacaoProcFis
	       INTO #DEB_REN_QUIT
	FROM   dbo.Debitos D
	       INNER JOIN #REN_QUITADAS R
	            ON  ISNULL(D.IdProfissional, 0) = R.IdProfissional
	                AND ISNULL(D.IdPessoaJuridica, 0) = R.IdPessoaJuridica
	                AND ISNULL(D.IdPessoa, 0) = R.IdPessoa
	                AND ISNULL(D.NumConjReneg, 0) = R.NumConjReneg
	       INNER JOIN #MAXSIT MS
	            ON  R.IdProcesso = MS.IdProcesso
	WHERE  D.IdSituacaoAtual IN (2)
	       AND D.DataPgto IS NOT NULL
	
	SELECT * INTO #DEB0
	FROM   #DEB_NAO_REN_QUIT
	
	INSERT INTO #DEB0
	SELECT *
	FROM   #DEB_REN_QUIT
	
	SELECT P.*,
	       SituacaoDebito,
	       CASE 
	            WHEN ISNULL(NumConjReneg, 0) = 0 THEN 'DÉBITO QUITADO'
	            ELSE 'RENEGOCIAÇÃO QUITADA'
	       END AS TipoQuitacao,
	       IdDebito,
	       ISNULL(D.IdProfissional, 0) AS IdProfissional,
	       ISNULL(D.IdPessoaJuridica, 0) AS IdPessoaJuridica,
	       ISNULL(D.IdPessoa, 0) AS IdPessoa,
	       CASE 
	            WHEN ISNULL(D.IdProfissional, 0) <> 0 THEN (
	                     SELECT Nome
	                     FROM   PROFISSIONAIS P
	                     WHERE  P.IdProfissional = D.IdProfissional
	                 )
	            WHEN ISNULL(D.IdPessoaJuridica, 0) <> 0 THEN (
	                     SELECT Nome
	                     FROM   PESSOASJURIDICAS P
	                     WHERE  P.IdPessoaJuridica = D.IdPessoaJuridica
	                 )
	            WHEN ISNULL(D.IdPessoa, 0) <> 0 THEN (
	                     SELECT Nome
	                     FROM   PESSOAS P
	                     WHERE  P.IdPessoa = D.IdPessoa
	                 )
	            ELSE 'Nulo'
	       END AS Nome,
	       CASE 
	            WHEN ISNULL(D.IdProfissional, 0) <> 0 THEN (
	                     SELECT P.RegistroConselhoAtual
	                     FROM   PROFISSIONAIS P
	                     WHERE  P.IdProfissional = D.IdProfissional
	                 )
	            WHEN ISNULL(D.IdPessoaJuridica, 0) <> 0 THEN (
	                     SELECT P.RegistroConselhoAtual
	                     FROM   PESSOASJURIDICAS P
	                     WHERE  P.IdPessoaJuridica = D.IdPessoaJuridica
	                 )
	            ELSE ''
	       END AS RegistroConselhoAtual,
	       ISNULL(D.NumConjReneg, 0) AS NumConjReneg,
	       CASE 
	            WHEN ISNULL(D.IdProfissional, 0) <> 0 THEN 1
	            WHEN ISNULL(D.IdPessoaJuridica, 0) <> 0 THEN 2
	            WHEN ISNULL(D.IdPessoa, 0) <> 0 THEN 3
	            ELSE 'Nulo'
	       END AS TipoPessoa,
	       D.IdTipoDebito,
	       TD.NomeDebito,
	       D.IdSituacaoAtual,
	       D.DataVencimento,
	       ValorDevido,
	       D.DataPgto,
	       D.ValorPago,
	       YEAR(D.DataReferencia) AS AnoRef,
	       D.SituacaoProcFis
	       INTO #DEB1
	FROM   #DEB0 D
	       INNER JOIN dbo.TiposDebito td
	            ON  D.IdTipoDebito = td.IdTipoDebito
	       INNER JOIN dbo.Processos P
	            ON  D.IdProcesso = P.IdProcesso
	
	
	-- LISTA DOS CAMPOS DINAMICOS UTILIZADOS
	SELECT TP.IDTIPOPROCESSO,
	       TP.PROCESSOTIPO,
	       UPPER(LTRIM(RTRIM(TD.NOMECAMPO))) NOMECAMPO,
	       UPPER(LTRIM(RTRIM(TD.TITULOMONITOR))) TITULOCAMPO,
	       UPPER(LTRIM(RTRIM(NOMETABELAAUX))) TABELAAUXILIAR,
	       TP2.TipoCampo
	       INTO #DIRETOS
	FROM   DBO.TELASDEFINICOES TD
	       JOIN DBO.TIPOPROCESSO TP
	            ON  TP.IDTIPOPROCESSO = TD.IDTIPOPROCESSO
	       JOIN TelasParametros tp2
	            ON  TD.IdTipoProcesso = TP2.IdTipoProcesso
	                AND TD.CodigoTela = tp2.CodigoTela
	                AND td.NomeTabela = tp2.NomeTabela
	                AND td.NomeCampo = tp2.NomeCampo
	WHERE  TD.NOMETABELA = 'PROCESSOS'
	       AND MODELOTIPOPROCESSO = 'Fiscal (D.A.)'
	       AND TD.NOMECAMPO NOT LIKE '%GRID%'
	       AND TD.NomeTabelaAux IS NULL
	       AND TP2.TipoCampo NOT IN ('C', 'P', 'T', 'U')
	
	SELECT TP.IDTIPOPROCESSO,
	       TP.PROCESSOTIPO,
	       UPPER(LTRIM(RTRIM(TD.NOMECAMPO))) NOMECAMPO,
	       UPPER(LTRIM(RTRIM(TD.TITULOMONITOR))) TITULOCAMPO,
	       UPPER(LTRIM(RTRIM(NOMETABELAAUX))) TABELAAUXILIAR,
	       TP2.TipoCampo,
	       CASE TP2.TipoCampo
	            WHEN 'C' THEN 'NomeCidade'
	            WHEN 'U' THEN 'SiglaUF'
	            WHEN 'P' THEN 'Nome'
	            ELSE 'Descricao'
	       END AS CampoDados,
	       CASE TP2.TipoCampo
	            WHEN 'C' THEN 'IdCidade'
	            WHEN 'U' THEN 'IdEstado'
	            WHEN 'P' THEN ''
	            ELSE UPPER(LTRIM(RTRIM(TD.NOMECAMPO)))
	       END AS ChaveEstrangeira
	       INTO #INDIRETOS
	FROM   DBO.TELASDEFINICOES TD
	       JOIN DBO.TIPOPROCESSO TP
	            ON  TP.IDTIPOPROCESSO = TD.IDTIPOPROCESSO
	       JOIN TelasParametros tp2
	            ON  TD.IdTipoProcesso = TP2.IdTipoProcesso
	                AND TD.CodigoTela = tp2.CodigoTela
	                AND td.NomeTabela = tp2.NomeTabela
	                AND td.NomeCampo = tp2.NomeCampo
	WHERE  TD.NOMETABELA = 'PROCESSOS'
	       AND MODELOTIPOPROCESSO = 'Fiscal (D.A.)'
	       AND TD.NOMECAMPO NOT LIKE '%GRID%'
	       AND TP2.TipoCampo IN ('C', 'P', 'T', 'U')
	
	
	SET @Campos = ''
	
	DECLARE x               CURSOR  
	FOR
	    SELECT NOMECAMPO,
	           TITULOCAMPO  
	    FROM   #DIRETOS
	
	OPEN x
	FETCH NEXT FROM x INTO @NomeCampo,@TituloCampo                                                                                                                                                                                                                                                                                                                    
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    SET @Campos = @Campos + ', [' + LTRIM(RTRIM(@NomeCampo)) + '] as [' + @TituloCampo 
	        + ']'
	    
	    FETCH NEXT FROM x INTO @NomeCampo,@TituloCampo
	END
	CLOSE x
	DEALLOCATE x
	
	DECLARE Y                    CURSOR  
	FOR
	    SELECT Nomecampo,
	           TituloCampo,
	           TipoCampo,
	           TabelaAuxiliar,
	           CampoDados,
	           ChaveEstrangeira  
	    FROM   #INDIRETOS
	
	OPEN Y 
	FETCH NEXT FROM Y INTO @NomeCampo,@TituloCampo, @TipoCampo, @TabelaAuxiliar, 
	@CampoDados, @ChaveEstrangeira                                                                                                                                                                                                                                                                                                                                                   
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    IF @TipoCampo <> 'P'
	        SET @Campos = @Campos + ', (SELECT ' + @TipoCampo + '.[' + @CampoDados 
	            + '] from ' + @TabelaAuxiliar + ' ' + @TipoCampo + ' WHERE ' + @TipoCampo
	            + '.[' + @ChaveEstrangeira + ']=#DEB1.[' + @NomeCampo +
	            ']) as [' + @TituloCampo 
	            +
	            ']'
	    ELSE
	        SET @Campos = @Campos + ', case ' +
	            'when ' + LEFT(@NomeCampo, 9) +
	            'PROF is not null then (SELECT Nome from PROFISSIONAIS P WHERE P.IdProfissional=#DEB1.' 
	            + LEFT(@NomeCampo, 9) + 'PROF) ' +
	            'when ' + LEFT(@NomeCampo, 9) +
	            'PJ is not null then (SELECT Nome from PESSOASJURIDICAS P WHERE P.IdPessoaJuridica=#DEB1.' 
	            + LEFT(@NomeCampo, 9) + 'PJ) ' +
	            'when ' + LEFT(@NomeCampo, 9) +
	            'PESSOA is not null then (SELECT Nome from PESSOAS P WHERE P.IdPessoa=#DEB1.' 
	            + LEFT(@NomeCampo, 9) + 'PESSOA) ' +
	            'end as [' + @TituloCampo + ']'
	    
	    FETCH NEXT FROM Y INTO @NomeCampo,@TituloCampo, @TipoCampo, @TabelaAuxiliar, 
	    @CampoDados, @ChaveEstrangeira
	END
	CLOSE Y
	DEALLOCATE Y
	
	DECLARE @SQL VARCHAR(8000)
	
	SET @SQL = 'SELECT IdProcesso, NumeroProc, SituacaoProcFis, IdDebito, '
	SET @SQL = @SQL +
	    'Nome,RegistroConselhoAtual,TipoPessoa,AnoRef,IdTipoDebito,NomeDebito,'
	
	SET @SQL = @SQL +
	    'IdSituacaoAtual, SituacaoDebito, DataVencimento,ValorDevido,ValorPago'
	
	
	SET @SQL = @SQL + @Campos + ' into ##LISTA from #DEB1 ORDER BY NumeroProc'
	EXEC (@SQL)
	
	SELECT *
	FROM   ##LISTA
	
	DROP TABLE ##LISTA
	DROP TABLE #DEB_NAO_REN_QUIT
	DROP TABLE #DEB_REN_QUIT
	DROP TABLE #MAXSIT
	DROP TABLE #REN_QUITADAS
	DROP TABLE #DEB0
	DROP TABLE #DEB1
