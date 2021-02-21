

CREATE PROCEDURE dbo.sp_DeletarAutoInfracao @IdAutoInfracao INTEGER, 
                                            @DeletarDebitos BIT = 0,
                                            @Deletado       BIT OUTPUT
AS

SET NOCOUNT ON
DECLARE @ContinuaDelecao Bit,
        @DebitoFoiDeletado Bit
SET @ContinuaDelecao = 1

/* Deleção dos débitos é opcional */
IF ( @DeletarDebitos = 1 )
BEGIN
  DECLARE @IdDebito Int
  DECLARE Cursor_Debitos CURSOR FAST_FORWARD READ_ONLY
          FOR SELECT IdDebito
                FROM Debitos
               WHERE IdAutoInfracao = @IdAutoInfracao
  
  OPEN Cursor_Debitos 
  FETCH NEXT FROM Cursor_Debitos INTO @IdDebito
  WHILE (@@fetch_status <> -1)
  BEGIN
    EXEC sp_DeletarDebito @IdDebito, @Deletado = @DebitoFoiDeletado OUTPUT
    /* Se não foi deletado um débito existente, auto de infração inteiro não pode ser deletado  */
    IF @DebitoFoiDeletado = 0 
    BEGIN
      SET @ContinuaDelecao = 0 
      BREAK
    END
    FETCH NEXT FROM Cursor_Debitos INTO @IdDebito
  END
  CLOSE Cursor_Debitos 
  DEALLOCATE Cursor_Debitos 
END

IF @ContinuaDelecao = 1
BEGIN
  DELETE AutosInfracao_InstrucoesAutoInf WHERE IdAutoInfracao   = @IdAutoInfracao
  DELETE AutosInfracao_Infringencias     WHERE IdAutoInfracao   = @IdAutoInfracao
  DELETE AutosInfracao_Sansoes           WHERE IdAutoInfracao   = @IdAutoInfracao
  DELETE Ocorrencias                     WHERE IndPaiOcorrencia = 6 AND IdPaiOcorrencia = @IdAutoInfracao
  DELETE AutosInfracao                   WHERE IdAutoInfracao   = @IdAutoInfracao
END
SET @Deletado = @ContinuaDelecao
SELECT Deletado = @ContinuaDelecao
SET NOCOUNT OFF




