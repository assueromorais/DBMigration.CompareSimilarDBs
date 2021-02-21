

CREATE PROCEDURE dbo.usp_DesfazerConjuntoEmissaoByListaID ( @Debitos VARCHAR(MAX) )
AS
BEGIN
	DECLARE @IdDebito INT

	SELECT @IdDebito = MIN(ID)
	FROM   dbo.ufn_SplitID( @Debitos )	
	
	WHILE @IdDebito IS NOT NULL	 
	BEGIN		
		EXEC dbo.usp_DesfazerConjuntoEmissao @IdDebito
		
		SELECT @IdDebito = MIN(ID)
		FROM   dbo.ufn_SplitID( @Debitos )
		WHERE  ID > @IdDebito
	END	
END
