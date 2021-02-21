
	
CREATE PROCEDURE [dbo].[sp_Rel_Cancelamentos_de_Registro]
	@TipoPessoa TINYINT
AS
	SET DATEFORMAT dmy
	SET NOCOUNT ON
	
	DECLARE @TituloCampo       VARCHAR(40)
	DECLARE @TipoCampo         VARCHAR(1)
	DECLARE @Campos            VARCHAR(8000)
	DECLARE @CampoDados        VARCHAR(40)
	DECLARE @NomeCampo         VARCHAR(40)
	DECLARE @ChaveEstrangeira  VARCHAR(40)
	DECLARE @TabelaAuxiliar    VARCHAR(40)
	/*
	Demanda 74690
	
	- O resultado desse relatório será utilizado para identificar para quais processos 
	o conselho deve entrar com o pedido judicial de extinção do processo no fórum devido 
	ao fato do profissional ter solicitado o cancelamento do registro.
	
	- Esse relatório deve listar todos os processos de execução de dívida ativa, que a ultima 
	situação não indique que esteja extinto ou suspenso e a pessoa (pf, pj ou pe) tenha 
	cadastradas ocorrências do tipo solicitação.
	
	FILTROS DO RELATÓRIO
	INTERNOS
	- Classificação do processo = Fiscal (DA)
	- Última situação diferente de  “Indica processo extinto” diferente de “Verdadeiro”,
	“Suspenso – negociação” e “Suspenso – Parcelamento em dia”
	- Ocorrências cadastradas - “Solicitação de cancelamento c/ carta” ou
	“Solicitação de Interrupção de pagtº”
	
	EXTERNOS (SELECIONADOS PELO USUÁRIOS)
	- Tipos de Pessoa Profissionais, Pessoas Jurídicas e Todos
	
	*/
	CREATE TABLE #OCORR
	(
		IdProfissional    INT,
		IdPessoaJuridica  INT,
		DataOcorrencia    DATETIME
	)
	INSERT INTO #OCORR
	SELECT ISNULL(IdProfissional, 0),
	       ISNULL(op.IdPessoaJuridica, 0),
	       MAX(op.DataOcorrencia)
	FROM   OcorrenciasPFPJ op
	WHERE  op.IdOcorrencia IN (24, 25)
	GROUP BY
	       ISNULL(IdProfissional, 0),
	       ISNULL(op.IdPessoaJuridica, 0)
	ORDER BY
	       ISNULL(IdProfissional, 0),
	       ISNULL(op.IdPessoaJuridica, 0)
	
	-- Seleciona ultima situacao dos processos
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
	       AND ISNULL(S.IndicaProcessoExtinto, 0) <> 1
	       AND PSP.IdSituacaoProcFis NOT IN (27, 28)
	
	
	-- Seleciona os Conjuntos de reneg com a primeira parcela paga
	SELECT DISTINCT ISNULL(D.IdProfissional, 0) AS IdProfissional,
	       ISNULL(D.IdPessoaJuridica, 0) AS IdPessoaJuridica,
	       ISNULL(D.IdPessoa, 0) AS IdPessoa,
	       ISNULL(D.NumConjReneg, 0) AS NumConjReneg
	       INTO #REN_COM_PAGAMENTO
	FROM   Debitos D
	WHERE  ISNULL(D.NumConjReneg, 0) > 0
	       AND D.IdTipoDebito IN (2, 10)
	       AND IdSituacaoAtual IN (2, 14)
	       AND D.NumeroParcela < 2
	
	-- Seleciona os Conjuntos de reneg com débitos renegociados em DA
	SELECT DISTINCT ISNULL(D.IdProfissional, 0) AS IdProfissional,
	       ISNULL(D.IdPessoaJuridica, 0) AS IdPessoaJuridica,
	       ISNULL(D.IdPessoa, 0) AS IdPessoa,
	       ISNULL(D.NumConjReneg, 0) AS NumConjReneg,
	       DA.IdProcesso
	       INTO #REN_DA
	FROM   Debitos D,
	       DebitosDividaAtiva dda,
	       DividaAtiva da,
	       #MAXSIT S
	WHERE  ISNULL(D.NumConjReneg, 0) > 0
	       AND IdSituacaoAtual = 14
	       AND d.IdDebito = dda.IdDebito
	       AND dda.IdDividaAtiva = da.IdDividaAtiva
	       AND da.IdProcesso = S.IdProcesso
	
	-- Seleciona os Conjuntos de reneg com débitos renegociados em DA com a primeira parcela paga
	SELECT DISTINCT R1.IdProfissional,
	       R1.IdPessoaJuridica,
	       R1.IdPessoa,
	       R1.NumConjReneg,
	       R2.IdProcesso
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
	       CASE 
	            WHEN ISNULL(D.IdProfissional, 0) <> 0 THEN 1
	            WHEN ISNULL(D.IdPessoaJuridica, 0) <> 0 THEN 2
	       END AS TipoPessoa,
	       D.DataVencimento,
	       YEAR(D.DataReferencia) AS AnoRef,
	       O.DataOcorrencia,
	       D.IdTipoDebito,
	       TD.NomeDebito,
	       D.IdSituacaoAtual,
	       SD.SituacaoDebito,
	       D.DataPgto,
	       D.ValorPago,
	       D.NumeroParcela,
	       R.IdProcesso
	       INTO #DEB1
	FROM   Debitos D,
	       #REN_DA_PAG R,
	       SituacoesDebito sd,
	       TiposDebito td,
	       #OCORR O
	WHERE  ISNULL(D.IdProfissional, 0) = ISNULL(R.IdProfissional, 0)
	       AND ISNULL(D.IdPessoaJuridica, 0) = ISNULL(R.IdPessoaJuridica, 0)
	       AND ISNULL(D.NumConjReneg, 0) = ISNULL(R.NumConjReneg, 0)
	       AND ISNULL(D.IdProfissional, 0) = ISNULL(O.IdProfissional, 0)
	       AND ISNULL(D.IdPessoaJuridica, 0) = ISNULL(O.IdPessoaJuridica, 0)
	       AND D.IdSituacaoAtual = SD.IdSituacaoDebito
	       AND D.IdTipoDebito = TD.IdTipoDebito
	       AND D.IdSituacaoAtual NOT IN (6, 14) -- desprezar o original
	
	IF @TipoPessoa <> 0
	    DELETE 
	    FROM   #DEB1
	    WHERE  TipoPessoa <> @TipoPessoa
	
	-- Seleciona processos do tipo 1 (Execução Fiscal - Fiscal (D.A.))
	SELECT P.*,
	       MS.SituacaoProcFis,
	       IdDebito,
	       Nome,
	       RegistroConselhoAtual,
	       TipoPessoa,
	       IdTipoDebito,
	       NomeDebito,
	       AnoRef,
	       DataOcorrencia,
	       DataVencimento,
	       DataPgto,
	       ValorPago,
	       IdSituacaoAtual,
	       SituacaoDebito,
	       NumeroParcela
	       INTO #PARCIAL1
	FROM   PROCESSOS P,
	       TipoProcesso tp,
	       #MAXSIT MS,
	       #DEB1 C
	WHERE  tp.MODELOTIPOPROCESSO = 'Fiscal (D.A.)'
	       AND P.IdProcesso = MS.IdProcesso
	       AND P.IdProcesso = C.IdProcesso
	       AND P.IDTIPOPROCESSO = TP.IdTipoProcesso
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
	
	SET @SQL = 'SELECT IdProcesso, NumeroProc, SituacaoProcFis, IdDebito,  IdSituacaoAtual, SituacaoDebito,'
	SET @SQL = @SQL +
	    'IdTipoDebito,NomeDebito,Nome,RegistroConselhoAtual,TipoPessoa,AnoRef,'
	
	SET @SQL = @SQL + 
	    'DataOcorrencia, DataVencimento,DataPgto,ValorPago,NumeroParcela'
	
	
	SET @SQL = @SQL + @Campos + ' from #PARCIAL1'
	EXEC (@SQL)
