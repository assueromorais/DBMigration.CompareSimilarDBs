/*Gaspar PCS/SISPAD
Adicionado por André em 24/11/2009
Oc. 49617*/

CREATE PROCEDURE [dbo].[sp_RecusaSolicitacao]
	@IdResponsavel int,
	@IdPessoaSolicitacaoViagem int,
	@Justificativa nvarchar(1000),
	@CancelaSolicitacao int

AS

SET NOCOUNT ON
DECLARE @IdNivelAtual int, 
@SequenciaAtual int, 
@CentroCustoAtual int, 
@ProximaSequencia int, 
@IdNivelAutorizacao int, 
@VoltaNivelAnterior bit,
@retorno int

SET @IdNivelAtual = (SELECT IdNivelAutorizacao FROM HistoricoSolicitacao WHERE Concluido = 0 AND IdPessoaSolicitacaoViagem = @IdPessoaSolicitacaoViagem)
SET @SequenciaAtual = (SELECT SequenciaAutorizacao FROM HistoricoSolicitacao WHERE Concluido = 0 AND IdPessoaSolicitacaoViagem = @IdPessoaSolicitacaoViagem)
SET @CentroCustoAtual = (SELECT IdCentroCusto FROM HistoricoSolicitacao WHERE Concluido = 0 AND IdPessoaSolicitacaoViagem = @IdPessoaSolicitacaoViagem)
SET @VoltaNivelAnterior = (SELECT NivelAnteriorAutorizacaoRecusada FROM ConfiguracoesSispad)

EXEC('UPDATE HistoricoSolicitacao SET Concluido = 1 WHERE IdPessoaSolicitacaoViagem = ' + @IdPessoaSolicitacaoViagem)

IF @CancelaSolicitacao = 1
	BEGIN
		SET @ProximaSequencia = @SequenciaAtual + 1
		
		EXEC('UPDATE PessoasSolicitacoesViagem SET IdSituacaoSolicitacao = 4 WHERE IdPessoaSolicitacaoViagem = ' + @IdPessoaSolicitacaoViagem)
						
		INSERT HistoricoSolicitacao
		VALUES (@IdPessoaSolicitacaoViagem, getDate(), @IdResponsavel, 
		@IdNivelAtual, @ProximaSequencia, @CentroCustoAtual, 4, 1, @Justificativa)
		
		SET @retorno = 1
	END
ELSE
	BEGIN
		IF @VoltaNivelAnterior = 1
			BEGIN
				SET @ProximaSequencia = @SequenciaAtual - 1
				
				IF @ProximaSequencia = 0
					BEGIN
						SET @ProximaSequencia = @SequenciaAtual + 1
						
						EXEC('UPDATE PessoasSolicitacoesViagem SET IdSituacaoSolicitacao = 12 WHERE IdPessoaSolicitacaoViagem = ' + @IdPessoaSolicitacaoViagem)
						
						INSERT HistoricoSolicitacao
						VALUES (@IdPessoaSolicitacaoViagem, getDate(), @IdResponsavel, 
						@IdNivelAtual, @ProximaSequencia, @CentroCustoAtual, 12, 0, @Justificativa)
					END
				ELSE
					BEGIN
						INSERT HistoricoSolicitacao
						VALUES (@IdPessoaSolicitacaoViagem, getDate(), @IdResponsavel, 
						@IdNivelAtual, @ProximaSequencia, @CentroCustoAtual, 1, 0, @Justificativa)
					END

				SET @retorno = 1
			END
		ELSE
			BEGIN
				EXEC('UPDATE PessoasSolicitacoesViagem SET IdSituacaoSolicitacao = 12 WHERE IdPessoaSolicitacaoViagem = ' + @IdPessoaSolicitacaoViagem)
				
				INSERT HistoricoSolicitacao
				VALUES (@IdPessoaSolicitacaoViagem, getDate(), @IdResponsavel, 
				@IdNivelAtual, 1, @CentroCustoAtual, 12, 0, @Justificativa)

				SET @retorno = 1
			END
	END

SELECT @retorno AS retorno
