/*69125*/

CREATE PROCEDURE [dbo].[sp_Ajusta_Historico_Debitos]
AS
/*
* Criada por Victor Bandeira Macedo
* Ajusta histórico de débitos
*/
	SET NOCOUNT ON
	SET DATEFORMAT dmy
	-- Determina a data de geração de um conjunto de renegociação
	SELECT 'Cria tabela com as dadas dos conj. ren.'
	CREATE TABLE #DATA_REN
	(
		IdProfissional    INT,
		IdPessoaJuridica  INT,
		IdPessoa          INT,
		NumConjReneg      INT,
		DataGeracao       DATETIME
	)	
	INSERT INTO #DATA_REN
	SELECT d.IdProfissional,
	       d.IdPessoaJuridica,
	       d.IdPessoa,
	       d.NumConjReneg,
	       MAX(CASE WHEN d.DataGeracao IS NOT NULL THEN d.DataGeracao ELSE d.DataReferencia END)
	FROM   debitos d
	WHERE  IdTipoDebito IN (2, 10)
	       AND d.NumConjReneg IS NOT NULL
	GROUP BY
	       d.IdProfissional,
	       d.IdPessoaJuridica,
	       d.IdPessoa,
	       d.NumConjReneg 
	-----------------------------------------------------------------------
	-- Determina quais débitos não possuem histórico de situações
	SELECT 'Seleciona débitos sem histórico'
	SELECT iddebito,
	       D.IdProfissional,
	       D.IdPessoaJuridica,
	       D.IdPessoa,
	       D.NumConjReneg,
	       D.IdDebitoOrigem,
	       IdSituacaoAtual,
	       sd.SituacaoDebito,
	       DataGeracao,
	       DataReferencia,
	       D.DataVencimento,
	       DataPgto
	       INTO #DEB0
	FROM   debitos D,
	       SituacoesDebito sd
	WHERE  iddebito NOT IN (SELECT iddebito
	                        FROM   Debitos_SituacoesDebito)
	       AND D.IdSituacaoAtual = sd.IdSituacaoDebito
	
	UPDATE #DEB0
	SET    DataGeracao = CASE 
	                          WHEN DataReferencia IS NULL THEN DataVencimento
	                          ELSE DataReferencia
	                     END
	WHERE  DataGeracao IS NULL
	
	SELECT #DEB0.*,
	       Div.DtLancamento
	       INTO #DEB
	FROM   #DEB0
	       LEFT JOIN (
	                SELECT IdDebito,
	                       da.DtLancamento
	                FROM   DebitosDividaAtiva dda,
	                       DividaAtiva da
	                WHERE  dda.IdDividaAtiva = da.IdDividaAtiva
	            ) Div
	            ON  #DEB0.IdDebito = Div.IdDebito
	-----------------------------------------------------------------------
	CREATE TABLE #DebSit
	(
		[IdDebito]                       [int] NOT NULL,
		[IdSituacaoDebito]               [int] NOT NULL,
		[DataSituacao]                   [datetime] NOT NULL,
		[UsuarioUltimaAtualizacao]       [varchar](35) NULL,
		[DepartamentoUltimaAtualizacao]  [varchar](60) NULL,
		[IdMotivoEstorno]                [int] NULL
	) 
	-----------------------------------------------------------------------
	SELECT 'PROCESSANDO OS DÉBITOS SEM HISTÓRICO'
	SELECT '   1-Cria o primeiro registro'
	INSERT INTO #DebSit
	SELECT IdDebito,
	       1,
	       DataGeracao,
	       NULL,
	       NULL,
	       NULL
	FROM   #DEB
	
	DELETE 
	FROM   #DEB
	WHERE  IdSituacaoAtual = 1
	
	DELETE 
	FROM   #DEB
	WHERE  IdSituacaoAtual = 2
	       AND DataPgto IS NULL
	
	SELECT '   2-Cria o registro final de todos os Pagos'
	DELETE 
	FROM   #DEB
	WHERE  IdSituacaoAtual IN (2, 3, 4, 5, 11, 15)
	       AND DataPgto IS NULL
	
	INSERT INTO #DebSit
	SELECT IdDebito,
	       IdSituacaoAtual,
	       DataPgto,
	       NULL,
	       NULL,
	       NULL
	FROM   #DEB
	WHERE  IdSituacaoAtual IN (2, 3, 4, 5, 8, 11, 15)
	
	DELETE 
	FROM   #DEB
	WHERE  IdSituacaoAtual IN (2, 3, 4, 5, 8)
	
	SELECT '   3-Cria o registro de lancamento em da'
	INSERT INTO #DebSit
	SELECT IdDebito,
	       IdSituacaoAtual,
	       DtLancamento,
	       NULL,
	       NULL,
	       NULL
	FROM   #DEB
	WHERE  IdSituacaoAtual IN (10, 11, 12, 13, 14, 15)
	       AND DtLancamento IS NOT NULL
	
	DELETE 
	FROM   #DEB
	WHERE  IdSituacaoAtual = 10
	
	DELETE 
	FROM   #DEB
	WHERE  DataPgto IS NOT NULL
	
	SELECT '   4-Cria o registro dos renegociados'
	INSERT INTO #DebSit
	SELECT IdDebito,
	       IdSituacaoAtual,
	       D.DataGeracao,
	       NULL,
	       NULL,
	       NULL
	FROM   #DEB
	       INNER JOIN #DATA_REN D
	            ON  #DEB.IdProfissional = D.IdProfissional
	                AND #DEB.IdPessoaJuridica = D.IdPessoaJuridica
	                AND #DEB.IdPessoa = D.IdPessoa
	                AND #DEB.NumConjReneg = D.NumConjReneg
	WHERE  idSituacaoAtual IN (6, 14)
	
	DELETE 
	FROM   #DEB
	WHERE  IdSituacaoAtual IN (6, 14)
	
	SELECT '   5-Cria o registro do resto'
	INSERT INTO #DebSit
	SELECT IdDebito,
	       IdSituacaoAtual,
	       DataVencimento,
	       NULL,
	       NULL,
	       NULL
	FROM   #DEB
	
	-------------------------------------------------------------------------
	select 'PROCESSANDO OS DÉBITOS COM HISTÓRICO'
	
	SELECT '   Seleciona a última situação do DÉBITO'
	CREATE TABLE #SIT2
	(
		IdDebito      INT,
		DataSituacao  DATETIME
	)
	INSERT INTO #SIT2
	SELECT SD.IdDebito,
	       MAX(SD.DataSituacao)
	FROM   Debitos_SituacoesDebito SD
	GROUP BY
	       SD.IdDebito
	ORDER BY
	       SD.IdDebito	
	
	CREATE TABLE #MAXSIT_DEB
	(
		IdDebito          INT,
		IdSituacaoDebito  INT,
		DataSituacao      DATETIME
	)
	INSERT INTO #MAXSIT_DEB
	SELECT SD.IdDebito,
	       SD.IdSituacaoDebito,
	       SD.DataSituacao
	FROM   Debitos_SituacoesDebito SD,
	       #SIT2 S2
	WHERE  SD.IdDebito = S2.IdDebito
	       AND SD.DataSituacao = S2.DataSituacao
	
	SELECT D.IdDebito,
	       D.IdProfissional,
	       D.IdPessoaJuridica,
	       D.IdPessoa,
	       D.NumConjReneg,
	       D.IdSituacaoAtual,
	       D.DataGeracao,
	       D.DataReferencia,
	       D.DataVencimento,
	       D.DataPgto,
	       S.IdSituacaoDebito,
	       S.DataSituacao
	       INTO #T1
	FROM   Debitos D,
	       #MAXSIT_DEB S
	WHERE  D.IdDebito = S.IdDebito
	       AND d.IdSituacaoAtual <> S.IdSituacaoDebito
	ORDER BY
	       d.IdSituacaoAtual
	
	SELECT #T1.*,
	       D.DtLancamento
	       INTO #T2
	FROM   #T1
	       LEFT JOIN (
	                SELECT DISTINCT dda.IdDebito,
	                       MAX(da.DtLancamento) AS DtLancamento
	                FROM   DebitosDividaAtiva dda,
	                       DividaAtiva da
	                WHERE  dda.IdDividaAtiva = da.IdDividaAtiva
	                GROUP BY
	                       dda.IdDebito
	            ) D
	            ON  #T1.IdDebito = d.IdDebito
	
	SELECT '   1-Pagos'
	INSERT INTO #DebSit
	  (
	    IdDebito,
	    IdSituacaoDebito,
	    DataSituacao,
	    UsuarioUltimaAtualizacao,
	    DepartamentoUltimaAtualizacao,
	    IdMotivoEstorno
	  )
	SELECT IdDebito,
	       IdSituacaoAtual,
	       CASE 
	            WHEN DataPgto >= DataSituacao THEN DataPgto
	            ELSE DATEADD(d, 1, DataSituacao)
	       END,
	       NULL,
	       NULL,
	       NULL
	FROM   #T2
	WHERE  idSituacaoAtual IN (2, 3, 4, 5, 8, 11, 15)
	
	Select '   2-Cancelados'
	INSERT INTO #DebSit
	  (
	    IdDebito,
	    IdSituacaoDebito,
	    DataSituacao,
	    UsuarioUltimaAtualizacao,
	    DepartamentoUltimaAtualizacao,
	    IdMotivoEstorno
	  )
	SELECT IdDebito,
	       IdSituacaoAtual,
	       DATEADD(d, 1, DataSituacao),
	       NULL,
	       NULL,
	       NULL
	FROM   #T2
	WHERE  idSituacaoAtual IN (1, 9, 12, 13)
	
	INSERT INTO #DebSit
	  (
	    IdDebito,
	    IdSituacaoDebito,
	    DataSituacao,
	    UsuarioUltimaAtualizacao,
	    DepartamentoUltimaAtualizacao,
	    IdMotivoEstorno
	  )
	SELECT IdDebito,
	       IdSituacaoAtual,
	       CASE 
	            WHEN DtLancamento >= DataSituacao THEN DtLancamento
	            ELSE DATEADD(d, 1, DataSituacao)
	       END,
	       NULL,
	       NULL,
	       NULL
	FROM   #T2
	WHERE  idSituacaoAtual = 10
	
	select '   3-RENEGOCIADOS'
	INSERT INTO #DebSit
	  (
	    IdDebito,
	    IdSituacaoDebito,
	    DataSituacao,
	    UsuarioUltimaAtualizacao,
	    DepartamentoUltimaAtualizacao,
	    IdMotivoEstorno
	  )
	SELECT IdDebito,
	       IdSituacaoAtual,
	       CASE 
	            WHEN D.DataGeracao >= DataSituacao THEN D.DataGeracao
	            ELSE DATEADD(d, 1, DataSituacao)
	       END,
	       NULL,
	       NULL,
	       NULL
	FROM   #T2
	       INNER JOIN #DATA_REN D
	            ON  #T2.IdProfissional = D.IdProfissional
	                AND #T2.IdPessoaJuridica = D.IdPessoaJuridica
	                AND #T2.IdPessoa = D.IdPessoa
	                AND #T2.NumConjReneg = D.NumConjReneg
	WHERE  idSituacaoAtual IN (6, 14)
	
	INSERT INTO Debitos_SituacoesDebito
	  (
	    IdDebito,
	    IdSituacaoDebito,
	    DataSituacao,
	    UsuarioUltimaAtualizacao,
	    DepartamentoUltimaAtualizacao,
	    IdMotivoEstorno
	  )
	SELECT IdDebito,
	       IdSituacaoDebito,
	       DataSituacao,
	       UsuarioUltimaAtualizacao,
	       DepartamentoUltimaAtualizacao,
	       IdMotivoEstorno
	FROM   #DebSit
	

