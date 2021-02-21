

CREATE Procedure dbo.sp_DeleEnderecosPF 
  @IdProfissional Int,
  @IdEndProfissional Int = -1
AS

SET NOCOUNT ON

DECLARE @Corresp Bit

	IF @IdEndProfissional <> -1
	BEGIN
		SELECT @Corresp = Correspondencia, @IdProfissional = IdProfissional  FROM Enderecos WHERE IdEndereco = @IdEndProfissional  
      DELETE FROM Enderecos WHERE IdEndereco = @IdEndProfissional
      IF @Corresp = 1
		BEGIN
         UPDATE Profissionais 
            SET NomeBairro = NULL,
                NomeCidade = NULL,        	 
                SiglaUF    = NULL,
             	 Endereco   = NULL,
             	 CEP        = NULL,
             	 E_Residencial = 0,
             	 Atualizado    = 0,
             	 DataUltimaAtualizacao = null
         WHERE IdProfissional = @IdProfissional 
		END
	
END
   ELSE
      DELETE FROM Enderecos 
      WHERE IdProfissional = @IdProfissional

SET NOCOUNT OFF




