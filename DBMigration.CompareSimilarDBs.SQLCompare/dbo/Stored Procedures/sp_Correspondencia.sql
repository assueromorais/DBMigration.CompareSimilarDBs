/*Oc.104900 - Gustavo*/

CREATE PROCEDURE [dbo].[sp_Correspondencia]
	@IdPessoa INT,
	@TipoPessoa INT,
	@IdEndereco INT
AS
	SET NOCOUNT ON
	
	IF @TipoPessoa = 0
	BEGIN
	    UPDATE Enderecos
	    SET    Correspondencia = 0,
	           OrdemCorresp    = 2
	    WHERE  IdProfissional = @IdPessoa
	           AND IdEndereco <> @IdEndereco
	END
	
	IF @TipoPessoa = 1
	BEGIN
	    UPDATE Enderecos
	    SET    Correspondencia = 0,
	           OrdemCorresp    = 2
	    WHERE  IdPessoaJuridica = @IdPessoa
	           AND IdEndereco <> @IdEndereco
	END
	
	
	SET NOCOUNT OFF

