

CREATE PROCEDURE dbo.sp_DeletarProcesso @IdProcesso            INTEGER, 
                                        @DeletarDocsRelacProc  BIT,
                                        @DeletarDebitosAutoInf BIT,
                                        @DeletarFiscalizacoes  BIT,
                                        @DeletarDocsRelacFisc  BIT,
                                        @Deletado              BIT OUTPUT
AS

SET NOCOUNT ON
DECLARE @ContinuaDelecao           BIT,
        @DocsRelacProcFoiDeletado  BIT,
        @DebitosAutoInfFoiDeletado BIT,
        @FiscalizacaoFoiDeletada   BIT
        
SET @ContinuaDelecao = 1

/* DELEÇÃO DE AUTOS DE INFRAÇÃO RELACIONADOS COM PROCESSO */
DECLARE @IdAutoInfracao Int
DECLARE Cursor_AutosInfracao CURSOR FAST_FORWARD READ_ONLY
        FOR SELECT IdAutoInfracao
              FROM AutosInfracao
             WHERE IdProcesso = @IdProcesso 

OPEN Cursor_AutosInfracao 
FETCH NEXT FROM Cursor_AutosInfracao INTO @IdAutoInfracao
WHILE (@@fetch_status <> -1)
BEGIN
  EXEC sp_DeletarAutoInfracao @IdAutoInfracao, @DeletarDebitosAutoInf, @Deletado = @DebitosAutoInfFoiDeletado OUTPUT
  IF @DebitosAutoInfFoiDeletado = 0 
  BEGIN
    SET @ContinuaDelecao = 0
    BREAK
  END  
  FETCH NEXT FROM Cursor_AutosInfracao INTO @IdAutoInfracao
END
CLOSE      Cursor_AutosInfracao 
DEALLOCATE Cursor_AutosInfracao

IF @ContinuaDelecao = 1 
BEGIN
  IF @DeletarFiscalizacoes = 1
  BEGIN
    /* DELEÇÃO FISCALIZACOES RELACIONADAS AO PROCESSO, e OPCIONALMENTE,
       OS DOCUMENTOS RELACIONADOS ÀS FISCALIZACOES DELETADAS
    */
    DECLARE @IdFiscalizacao Int
    DECLARE Cursor_Fiscalizacoes CURSOR FAST_FORWARD READ_ONLY
            FOR SELECT IdFiscalizacao
                  FROM Fiscalizacoes
                 WHERE IdProcesso = @IdProcesso 
    
    OPEN Cursor_Fiscalizacoes 
    FETCH NEXT FROM Cursor_Fiscalizacoes INTO @IdFiscalizacao
    WHILE (@@fetch_status <> -1)
    BEGIN
      EXEC sp_DeletarFiscalizacao @IdFiscalizacao, @DeletarDocsRelacFisc
      FETCH NEXT FROM Cursor_Fiscalizacoes INTO @IdFiscalizacao
    END
    CLOSE      Cursor_Fiscalizacoes 
    DEALLOCATE Cursor_Fiscalizacoes
  END
  ELSE
  BEGIN
    /*  CASO TENHA QUE MANTER FISCALIZACOES, O CAMPO IdProcesso SERÁ LIMPO */
    UPDATE Fiscalizacoes 
       SET IdProcesso = Null 
     WHERE IdProcesso = @IdProcesso
  END
END

IF @ContinuaDelecao = 1 
BEGIN
  /* DELEÇÃO DE DOCUMENTOS RELACIONADOS AO PROCESSO */
  IF ( @DeletarDocsRelacProc = 1 )
  BEGIN
    DECLARE @IdDocProcesso Int
    DECLARE Cursor_DocsProcesso CURSOR FAST_FORWARD READ_ONLY
            FOR SELECT IdDocumento
                  FROM Processos_Documentos
                 WHERE IdProcesso = @IdProcesso 
    
    OPEN Cursor_DocsProcesso 
    FETCH NEXT FROM Cursor_DocsProcesso INTO @IdDocProcesso
    WHILE (@@fetch_status <> -1)
    BEGIN
      EXEC sp_DeletarDocumentoSisDoc @IdDocProcesso
      FETCH NEXT FROM Cursor_DocsProcesso INTO @IdDocProcesso
    END
    CLOSE      Cursor_DocsProcesso 
    DEALLOCATE Cursor_DocsProcesso 
  END
  /* DELEÇÃO DO LINK DE PROCESSOS COM DOCUMENTOS */
  DELETE Processos_Documentos WHERE IdProcesso = @IdProcesso 
END

IF @ContinuaDelecao = 1
BEGIN
  DELETE Ocorrencias                 WHERE IndPaiOcorrencia = 1 AND IdPaiOcorrencia = @IdProcesso
  DELETE Processos_SituacoesProcesso WHERE IdProcesso = @IdProcesso
  DELETE Tramitacoes                 WHERE IdProcesso = @IdProcesso
  DELETE Processos_Prof_PJ           WHERE IdProcesso = @IdProcesso
  DELETE Processos_Prof_PJ_Pessoas1           WHERE IdProcesso = @IdProcesso
  DELETE Processo_Fases           WHERE IdProcesso = @IdProcesso
  UPDATE DividaAtiva 
     SET IdProcesso = Null           WHERE IdProcesso = @IdProcesso
  DELETE Processos                   WHERE IdProcesso = @IdProcesso
END
SET @Deletado   = @ContinuaDelecao
SELECT Deletado = @ContinuaDelecao
SET NOCOUNT OFF




