/*
Criação das procedures do Sispad
André - 17/09/2009
*/

CREATE PROCEDURE [dbo].[sp_AutorizaSolicitacao] 
	@IdResponsavel int,
	@IdPessoaSolicitacaoViagem int
	
AS

SET NOCOUNT ON
DECLARE @IdNivelAtual int, @SequenciaAtual int, @CentroCustoAtual int, 
@ProximaSequencia int, @IdNivelAutorizacao int, @Sequencia int, @retorno int, 
@NomeNivel varchar(50) 

SET @IdNivelAtual = (SELECT IdNivelAutorizacao FROM HistoricoSolicitacao WHERE Concluido = 0 AND IdPessoaSolicitacaoViagem = @IdPessoaSolicitacaoViagem)
SET @SequenciaAtual = (SELECT SequenciaAutorizacao FROM HistoricoSolicitacao WHERE Concluido = 0 AND IdPessoaSolicitacaoViagem = @IdPessoaSolicitacaoViagem)
SET @CentroCustoAtual = (SELECT IdCentroCusto FROM HistoricoSolicitacao WHERE Concluido = 0 AND IdPessoaSolicitacaoViagem = @IdPessoaSolicitacaoViagem)
SET @ProximaSequencia = @SequenciaAtual + 1

SET @Sequencia = 
(SELECT TOP 1 Sequencia FROM SequenciaAutorizacao 
WHERE IdNivelAutorizacao = 
(SELECT IdNivelAutorizacao FROM HistoricoSolicitacao 
WHERE Concluido = 0 AND IdPessoaSolicitacaoViagem = @IdPessoaSolicitacaoViagem) 
AND Sequencia > (SELECT SequenciaAutorizacao FROM HistoricoSolicitacao 
WHERE Concluido = 0 AND IdPessoaSolicitacaoViagem = @IdPessoaSolicitacaoViagem))

SET @NomeNivel = (SELECT DescricaoNivel FROM NiveisAutorizacao NA 
INNER JOIN SequenciaAutorizacao S ON S.IdNivelAutorizou = NA.IdNivelAutorizacao 
WHERE S.IdNivelAutorizacao = @IdNivelAtual AND S.Sequencia = @SequenciaAtual)

EXEC('UPDATE HistoricoSolicitacao SET Concluido = 1 WHERE IdPessoaSolicitacaoViagem = ' + @IdPessoaSolicitacaoViagem)

IF @Sequencia IS NULL
	BEGIN
		INSERT HistoricoSolicitacao
		VALUES (@IdPessoaSolicitacaoViagem, getDate(), @IdResponsavel, 
		@IdNivelAtual, @ProximaSequencia, @CentroCustoAtual, 2, 0, 'Autorização ' + @NomeNivel)

		EXEC('UPDATE PessoasSolicitacoesViagem SET IdSituacaoSolicitacao = 2 WHERE IdPessoaSolicitacaoViagem = ' + @IdPessoaSolicitacaoViagem)
		EXEC('UPDATE DespesasReembolsosPessoasSolicitacoesViagem SET IdSituacaoDespesa = 2 WHERE IdPessoaSolicitacaoViagem = ' + @IdPessoaSolicitacaoViagem)

		SET @retorno = 1
	END
ELSE
	BEGIN
		INSERT HistoricoSolicitacao
		VALUES (@IdPessoaSolicitacaoViagem, getDate(), @IdResponsavel, 
		@IdNivelAtual, @ProximaSequencia, @CentroCustoAtual, 1, 0, 'Autorização ' + @NomeNivel)
		
		SET @retorno = 0
	END

SELECT @retorno AS retorno
