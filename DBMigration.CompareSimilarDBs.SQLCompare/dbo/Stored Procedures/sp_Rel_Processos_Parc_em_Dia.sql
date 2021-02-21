
/*Criada pelo Gino - Ocorr. 74686 - 04/11/2011*/

CREATE PROCEDURE [dbo].[sp_Rel_Processos_Parc_em_Dia]
	@TipoPessoa TINYINT
AS
	/*
	Demanda - 74686
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

	-- Seleciona os Conjuntos de reneg com, ao menos, uma parcela paga
	SELECT DISTINCT ISNULL(D.IdProfissional, 0) AS IdProfissional,
	       ISNULL(D.IdPessoaJuridica, 0) AS IdPessoaJuridica,
	       ISNULL(D.IdPessoa, 0) AS IdPessoa,
	       ISNULL(NumConjReneg, 0) AS NumConjReneg
	       INTO #REN_PAGO
	FROM   Debitos D
	WHERE  NumConjReneg > 0
	       AND IdSituacaoAtual IN (2, 4)
	
	-- Seleciona Debitos
	SELECT PD.IdDebito,
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
	       CASE 
	            WHEN ISNULL(D.IdProfissional, 0) <> 0 THEN 1
	            WHEN ISNULL(D.IdPessoaJuridica, 0) <> 0 THEN 2
	            WHEN ISNULL(D.IdPessoa, 0) <> 0 THEN 3
	            ELSE 'Nulo'
	       END AS TipoPessoa,
	       ISNULL(D.NumConjReneg, 0) AS NumConjReneg,
	       PD.IdProcesso,
	       YEAR(D.DataReferencia) AS AnoRef,
	       D.IdTipoDebito,
	       TD.NomeDebito,
	       D.IdSituacaoAtual,
	       D.DataVencimento,
	       ISNULL(dda.ValorPrincipal, 0) AS ValorPrincipal,
	       ISNULL(dda.ValorAtualizacao, 0) AS ValorAtualizacao,
	       ISNULL(dda.ValorMulta, 0) AS ValorMulta,
	       ISNULL(dda.ValorJuros, 0) AS ValorJuros,
	       d.DataPgto,
	       D.ValorPago,
	       LTRIM(RTRIM(CONVERT(VARCHAR(200), dda.MotivoCancelamento))) AS MotivoCancelamento
	       INTO #DEB_DA
	FROM   Processo_Debitos PD,
	       DebitosDividaAtiva dda,
	       Debitos D,
	       TIposDebito TD,
	       #REN_PAGO R
	WHERE  PD.IdDebito = dda.IdDebito
	       AND D.IdDebito = PD.IdDebito
	       AND D.IdTipoDebito = TD.IdTipoDebito
	       AND ISNULL(D.IdProfissional, 0) = R.IdProfissional
	       AND ISNULL(D.IdPessoaJuridica, 0) = R.IdPessoaJuridica
	       AND ISNULL(D.IdPessoa, 0) = R.IdPessoa
	       AND ISNULL(D.NumConjReneg, 0) = R.NumConjReneg
	       
	IF @TipoPessoa <> 0
	    DELETE 
	    FROM   #DEB_DA
	    WHERE  TipoPessoa <> @TipoPessoa

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
	       AND isnull(S.IndicaProcessoExtinto,0)=0
	       
	-- Seleciona processos do tipo 1 (Execução Fiscal - Fiscal (D.A.))
	SELECT P.*,
	       MS.SituacaoProcFis,
	       IdDebito,
	       Nome,
	       RegistroConselhoAtual,
	       TipoPessoa,
	       AnoRef,
	       IdTipoDebito,
	       NomeDebito,
	       IdSituacaoAtual,
	       sd.SituacaoDebito,
	       DataVencimento,
	       ValorPrincipal,
	       ValorAtualizacao,
	       ValorMulta,
	       ValorJuros,
	       DataPgto,
	       ValorPago,
	       MotivoCancelamento
	       INTO #PARCIAL1
	FROM   PROCESSOS P,
	       SituacoesDebito sd,
	       TipoProcesso tp,
	       #MAXSIT MS,
	       #DEB_DA C
	WHERE  tp.MODELOTIPOPROCESSO = 'Fiscal (D.A.)'
	       AND P.IdProcesso = MS.IdProcesso
	       AND P.IdProcesso = C.IdProcesso
	       AND P.IDTIPOPROCESSO = TP.IdTipoProcesso
	       AND C.IdSituacaoAtual = sd.IdSituacaoDebito
	       AND MS.IdSituacaoProcFis<>28 -- Suspenso - Parcelamento em dia

	ORDER BY
	       C.Nome,
	       ISNULL(P.NumeroProcesso, ''),
	       P.IdProcesso,
	       C.IdDebito
	       
		
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
	            + '.[' + @ChaveEstrangeira + ']=#PARCIAL1.[' + @NomeCampo +
	            ']) as [' + @TituloCampo 
	            +
	            ']'
	    ELSE
	        SET @Campos = @Campos + ', case ' +
	            'when ' + LEFT(@NomeCampo, 9) +
	            'PROF is not null then (SELECT Nome from PROFISSIONAIS P WHERE P.IdProfissional=#PARCIAL1.' 
	            + LEFT(@NomeCampo, 9) + 'PROF) ' +
	            'when ' + LEFT(@NomeCampo, 9) +
	            'PJ is not null then (SELECT Nome from PESSOASJURIDICAS P WHERE P.IdPessoaJuridica=#PARCIAL1.' 
	            + LEFT(@NomeCampo, 9) + 'PJ) ' +
	            'when ' + LEFT(@NomeCampo, 9) +
	            'PESSOA is not null then (SELECT Nome from PESSOAS P WHERE P.IdPessoa=#PARCIAL1.' 
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
	    'Nome,RegistroConselhoAtual,TipoPessoa,AnoRef,IdTipoDebito,'
	
	SET @SQL = @SQL +
	    'NomeDebito,IdSituacaoAtual, SituacaoDebito, DataVencimento,ValorPrincipal,'
	
	SET @SQL = @SQL +
	    'ValorAtualizacao,ValorMulta,ValorJuros,DataPgto,ValorPago,MotivoCancelamento'
	
	
	SET @SQL = @SQL + @Campos + ' into ##LISTA from #PARCIAL1'
	PRINT @SQL
	EXEC (@SQL)
	
	SELECT *
	FROM   ##LISTA
	
	DROP TABLE ##LISTA
