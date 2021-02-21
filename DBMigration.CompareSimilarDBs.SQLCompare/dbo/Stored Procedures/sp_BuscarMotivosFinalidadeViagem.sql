/*
Criação das procedures do Sispad
André - 17/09/2009
*/

CREATE PROCEDURE [dbo].[sp_BuscarMotivosFinalidadeViagem] 
	@IdSolicitante int 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT msv.IdMotivoSolicitacao AS IdMotivoSolicitacao,ms.MotivoSolicitacao AS Descricao
	  FROM MotivosSolicitacoesViagem msv,MotivosSolicitacoes ms
	WHERE msv.IdPessoaSolicitacaoViagem = @IdSolicitante
	AND ms.IdMotivoSolicitacao = msv.IdMotivoSolicitacao
	

END
