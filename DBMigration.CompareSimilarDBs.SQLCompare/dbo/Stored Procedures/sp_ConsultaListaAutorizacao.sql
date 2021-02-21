/*Gaspar PCS/SISPAD
Adicionado por André em 24/11/2009
Oc. 49617*/

CREATE PROCEDURE [dbo].[sp_ConsultaListaAutorizacao]
@IdResponsavel int, @Cons_NumSolicitacao varchar(50), @Cons_Passageiro varchar(50), @Cons_Evento varchar(50)
 As 

SET NOCOUNT ON
DECLARE @IdNivelAutorizacao int, 
@Sequencia int, 
@IdHistoricoSolicitacao int, 
@IdSolicitacaoViagem int,
@NumSolicitacaoViagem nvarchar(20),
@IdPessoaSolicitacaoViagem int,
@IdPessoaAutorizador int, 
@NomeAutorizador varchar(120),
@IdPassageiro int, 
@Passageiro varchar(120),
@IdEvento int,
@NomeEvento nvarchar(150),
@IdSituacaoSolicitacao int, 
@SituacaoSolicitacao varchar(50),
@Observacao nvarchar(1000),
@IdNivelAutorizacao1 int, 
@SequenciaAutorizacao int,
@IdCentroCusto int,
@Consulta varchar(500)

CREATE TABLE #HIST_SOLICITACAO
(	IdHistoricoSolicitacao int, 
	IdSolicitacaoViagem int,
	NumSolicitacaoViagem nvarchar(20),
	IdPessoaSolicitacaoViagem int,
	IdPessoaAutorizador int, 
	NomeAutorizador varchar(120),
	IdPassageiro int, 
	Passageiro varchar(120),
	IdEvento int,
	NomeEvento nvarchar(150),
	IdSituacaoSolicitacao int, 
	SituacaoSolicitacao varchar(50),
	Observacao nvarchar(1000),
	IdNivelAutorizacao int, 
	SequenciaAutorizacao int,
	IdCentroCusto int)

DECLARE ITENS_SEQUENCIA_AUT CURSOR FAST_FORWARD FOR 
SELECT 
SA.IdNivelAutorizacao, 
SA.Sequencia 
FROM SequenciaAutorizacao SA 
INNER JOIN PessoasSispad PS 
ON PS.IdNivelAutorizacao = SA.IdNivelAutorizou
WHERE PS.IdPessoaSispad = @IdResponsavel
OPEN ITENS_SEQUENCIA_AUT
FETCH NEXT FROM ITENS_SEQUENCIA_AUT
INTO @IdNivelAutorizacao, @Sequencia
WHILE @@FETCH_STATUS = 0
BEGIN

	DECLARE ITENS_SOLICITACAO CURSOR FAST_FORWARD FOR 
	SELECT H.IdHistoricoSolicitacao, S.IdSolicitacaoViagem, S.NumSolicitacaoViagem, 
	PSV.IdPessoaSolicitacaoViagem, S.IdPessoaSolicitante, 
	(SELECT P1.Nome FROM Pessoas P1 INNER JOIN PessoasSispad PS1 
	ON PS1.IdPessoa = P1.IdPessoa WHERE (PS1.IdPessoaSispad = S.IdPessoaSolicitante)) AS NomeSolicitante, 
	PS.IdPessoaSispad AS IdPassageiro, 
	(SELECT P2.Nome FROM Pessoas P2 WHERE (P2.IdPessoa = PS.IdPessoa)) AS Passageiro, 
	S.IdEvento, S.NomeEvento, PSV.IdSituacaoSolicitacao, SS.SituacaoSolicitacao, 
	H.Observacao, H.IdNivelAutorizacao, H.SequenciaAutorizacao, H.IdCentroCusto 
	FROM PessoasSolicitacoesViagem PSV 
	INNER JOIN SolicitacoesViagem S ON S.IdSolicitacaoViagem = PSV.IdSolicitacaoViagem 
	INNER JOIN PessoasSispad PS ON PS.IdPessoaSispad = PSV.IdPessoaPassageiro
	INNER JOIN HistoricoSolicitacao H ON H.IdPessoaSolicitacaoViagem = PSV.IdPessoaSolicitacaoViagem 
	INNER JOIN SituacoesSolicitacao SS ON PSV.IdSituacaoSolicitacao = SS.IdSituacaoSolicitacao 
	WHERE H.Concluido = 0 AND H.IdSituacaoSolicitacao IN (1)
	AND H.IdCentroCusto IN (SELECT IdCentroCusto FROM PessoaCCustoAutorizacao WHERE IdPessoaSispad = @IdResponsavel)
	AND H.IdNivelAutorizacao = @IdNivelAutorizacao 
	AND H.SequenciaAutorizacao = @Sequencia
	OPEN ITENS_SOLICITACAO
	FETCH NEXT FROM ITENS_SOLICITACAO
	INTO 
	@IdHistoricoSolicitacao, @IdSolicitacaoViagem, @NumSolicitacaoViagem, 
	@IdPessoaSolicitacaoViagem, @IdPessoaAutorizador, @NomeAutorizador, 
	@IdPassageiro, @Passageiro,	@IdEvento, @NomeEvento, @IdSituacaoSolicitacao, 
	@SituacaoSolicitacao, @Observacao, @IdNivelAutorizacao1, @SequenciaAutorizacao, @IdCentroCusto
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT #HIST_SOLICITACAO
		VALUES (
			@IdHistoricoSolicitacao, 
			@IdSolicitacaoViagem,
			@NumSolicitacaoViagem,
			@IdPessoaSolicitacaoViagem,
			@IdPessoaAutorizador, 
			@NomeAutorizador,
			@IdPassageiro, 
			@Passageiro,
			@IdEvento,
			@NomeEvento,
			@IdSituacaoSolicitacao, 
			@SituacaoSolicitacao,
			@Observacao,
			@IdNivelAutorizacao1,
			@SequenciaAutorizacao,
			@IdCentroCusto)

		FETCH NEXT FROM ITENS_SOLICITACAO
		INTO 
		@IdHistoricoSolicitacao, @IdSolicitacaoViagem, @NumSolicitacaoViagem, 
		@IdPessoaSolicitacaoViagem, @IdPessoaAutorizador, @NomeAutorizador, 
		@IdPassageiro, @Passageiro,	@IdEvento, @NomeEvento, @IdSituacaoSolicitacao, 
		@SituacaoSolicitacao, @Observacao, @IdNivelAutorizacao1, @SequenciaAutorizacao, @IdCentroCusto
	END
	CLOSE ITENS_SOLICITACAO
	DEALLOCATE ITENS_SOLICITACAO
	
	FETCH NEXT FROM ITENS_SEQUENCIA_AUT
	INTO @IdNivelAutorizacao, @Sequencia
END
CLOSE ITENS_SEQUENCIA_AUT
DEALLOCATE ITENS_SEQUENCIA_AUT

SET @Consulta = 'SELECT * FROM #HIST_SOLICITACAO WHERE IdPassageiro > 0'
IF @Cons_NumSolicitacao <> ''
BEGIN
	SET @Consulta = @Consulta + ' AND NumSolicitacaoViagem = ''' + @Cons_NumSolicitacao + ''' '
END
IF @Cons_Passageiro <> ''
BEGIN
	SET @Consulta = @Consulta + ' AND Passageiro = ''' + @Cons_Passageiro + ''' '
END
IF @Cons_Evento <> ''
BEGIN
	SET @Consulta = @Consulta + ' AND Evento = ''' + @Cons_Evento + ''''
END

EXEC (@Consulta)
