

CREATE PROCEDURE dbo.sp_DeletarFiscalizacao @IdFiscalizacao    INTEGER, 
                                            @DeletarDocumentos BIT 
AS
SET NOCOUNT ON

IF ( @DeletarDocumentos = 1 ) 
BEGIN
  DECLARE @IdDocumento Int
  DECLARE Cursor_Documentos CURSOR FAST_FORWARD READ_ONLY
          FOR SELECT IdDocumento
                FROM Fiscalizacoes_Documentos
               WHERE IdFiscalizacao = @IdFiscalizacao
  
  OPEN Cursor_Documentos 
  FETCH NEXT FROM Cursor_Documentos INTO @IdDocumento
  WHILE (@@fetch_status <> -1)
  BEGIN
    EXEC sp_DeletarDocumentoSisDoc @IdDocumento
  
    FETCH NEXT FROM Cursor_Documentos INTO @IdDocumento
  END
  CLOSE Cursor_Documentos 
  DEALLOCATE Cursor_Documentos 
END

DELETE ItensFiscalizados                   WHERE IdFiscalizacao   = @IdFiscalizacao
DELETE Fiscalizacoes_SituacoesFiscalizacao WHERE IdFiscalizacao   = @IdFiscalizacao
DELETE Ocorrencias                         WHERE IndPaiOcorrencia = 3 AND IdPaiOcorrencia = @IdFiscalizacao
DELETE Tramitacoes                         WHERE IdFiscalizacao   = @IdFiscalizacao
DELETE Fiscalizacoes_Prof_PJ               WHERE IdFiscalizacao   = @IdFiscalizacao
DELETE Fiscalizacoes_Documentos            WHERE IdFiscalizacao   = @IdFiscalizacao
DELETE Fiscalizacoes                       WHERE IdFiscalizacao   = @IdFiscalizacao

SET NOCOUNT OFF




