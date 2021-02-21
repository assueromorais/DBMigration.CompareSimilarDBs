

CREATE PROCEDURE dbo.sp_DeletarDebito @IdDebito INTEGER, 
                                      @Deletado Bit = 0 OUTPUT

AS

SET NOCOUNT ON

DECLARE @Qtde INT
SET @Deletado = 0
/*
   Se IdSituacaoAtual de Débito for uma das situacoes abaixo, ele não poderá ser deletado
            10  Lanc.Div.Ativa
            11  Pago Div.Ativa
            12  Canc.Div.Ativa
            14  Reneg.Div.Ativa
*/
SELECT @Qtde = COUNT( IdSituacaoAtual )
  FROM Debitos 
 WHERE IdDebito = @IdDebito AND IdSituacaoAtual in ( 10, 11, 12, 14 )
IF @Qtde = 0 
BEGIN
/*
   Se Débito possuir lançamento contábil, ele não poderá ser deletado
*/
  SELECT @Qtde = COUNT( IdDebito )
    FROM Contabeis
   WHERE IdDebito = @IdDebito
  IF @Qtde = 0 
  BEGIN
    DELETE ComposicoesDebito       WHERE IdDebito = @IdDebito
    DELETE Debitos_SituacoesDebito WHERE IdDebito = @IdDebito
    DELETE Debitos                 WHERE IdDebito = @IdDebito
    SET @Deletado = 1
  END
END
SELECT Deletado = @Deletado

SET NOCOUNT OFF




