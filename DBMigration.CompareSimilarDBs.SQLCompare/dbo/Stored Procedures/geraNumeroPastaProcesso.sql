/*Oc. 67866 - Orlando 07/10/10*/

CREATE PROCEDURE dbo.geraNumeroPastaProcesso @idTipoProcesso INT
AS
 BEGIN 
	BEGIN TRANSACTION
	DECLARE	@NumeroPasta INT


	SELECT
		@NumeroPasta = ISNULL(TP.UltimoNumeroPasta,0) + 1
	FROM
		TipoProcesso TP (XLOCK)
	WHERE 
		IdTipoProcesso = @idTipoProcesso

	UPDATE
		TP
	SET
		TP.UltimoNumeroPasta = @NumeroPasta
	FROM
		TipoProcesso TP
	WHERE 
		IdTipoProcesso = @idTipoProcesso

	COMMIT TRANSACTION

	SELECT
		@NumeroPasta AS Retorno
END
