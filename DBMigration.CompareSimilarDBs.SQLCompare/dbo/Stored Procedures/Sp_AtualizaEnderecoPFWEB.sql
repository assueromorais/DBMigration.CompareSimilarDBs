

CREATE Procedure dbo.Sp_AtualizaEnderecoPFWEB 
   @IdProfissional int = -1,
   @IdEndereco int = 0,
   @Sel bit
AS
SET NOCOUNT ON

DECLARE @Corresp Bit,
        @NomeBairro varchar(35),
        @NomeCidade varchar(30),
        @SiglaUF varchar(2), 
        @Endereco varchar(60),
        @CEP varchar(8),
        @E_Residencial bit, 
        @Atualizado bit,
        @DataUltimaAtualizacao datetime
         
   IF @IdProfissional <> -1
   BEGIN
      SELECT @Corresp = Correspondencia, @NomeBairro = NomeBairro, @NomeCidade = NomeCidade, @SiglaUF = SiglaUF, @Endereco = Endereco,   
             @CEP = Cep, @E_Residencial = E_Residencial, @Atualizado = Atualizado, @DataUltimaAtualizacao = DataUltimaAtualizacao
      FROM Enderecos WHERE IdEndereco = @IdEndereco  
      
      IF @Corresp = 1
      BEGIN
         IF @Sel = 0
         BEGIN
            UPDATE Profissionais 
         	   SET NomeBairro = null,
             	    NomeCidade = null,
             		 SiglaUF    = null,
             		 Endereco   = null,
             		 CEP        = null,
             		 E_Residencial = 0,
             		 Atualizado    = 0,
             		 DataUltimaAtualizacao = null
         	WHERE IdProfissional = @IdProfissional 
         END
         ELSE
         BEGIN
            UPDATE Profissionais 
         	   SET NomeBairro = @NomeBairro,
             	    NomeCidade = @NomeCidade,
             		 SiglaUF    = @SiglaUF,
             		 Endereco   = @Endereco,
             		 CEP        = @CEP,
             		 E_Residencial = @E_Residencial,
             		 Atualizado    = @Atualizado,
             		 DataUltimaAtualizacao = @DataUltimaAtualizacao
         	WHERE IdProfissional = @IdProfissional 
         END
      END
      ELSE
      BEGIN
         IF @Sel = 1
            UPDATE Profissionais 
         	   SET NomeBairro = @NomeBairro,
             	    NomeCidade = @NomeCidade,
             		 SiglaUF    = @SiglaUF,
             		 Endereco   = @Endereco,
             		 CEP        = @CEP,
             		 E_Residencial = @E_Residencial,
             		 Atualizado    = @Atualizado,
             		 DataUltimaAtualizacao = @DataUltimaAtualizacao
         	WHERE IdProfissional = @IdProfissional 
      END
      UPDATE Enderecos SET Correspondencia = 0 WHERE IdProfissional = @IdProfissional
      /* UPDATE Enderecos SET Correspondencia = @Sel WHERE IdEndereco = @IdEndereco */
   END

SET NOCOUNT OFF




