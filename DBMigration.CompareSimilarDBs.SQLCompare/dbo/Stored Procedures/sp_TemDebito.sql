

CREATE PROCEDURE dbo.sp_TemDebito @TipoPessoa CHAR( 1 ), 
                                  @IdPessoa   INT

AS
SET NOCOUNT ON
DECLARE @TemDebitos Bit, @Qtd Int

IF @TipoPessoa = 'F'
  SELECT TOP 1 @Qtd = 1
          FROM Debitos 
         WHERE IdProfissional = @IdPessoa

IF @TipoPessoa = 'J'
  SELECT TOP 1 @Qtd = 1
          FROM Debitos 
         WHERE IdPessoaJuridica = @IdPessoa

SET @TemDebitos = @@RowCount
SELECT TemDebitos = @TemDebitos
SET NOCOUNT OFF




