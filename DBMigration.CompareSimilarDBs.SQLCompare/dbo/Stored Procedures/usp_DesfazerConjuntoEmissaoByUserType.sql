

CREATE PROCEDURE dbo.usp_DesfazerConjuntoEmissaoByUserType ( @Debitos Debitos READONLY)
AS
BEGIN
	DECLARE @IdDebito INT

	SELECT @IdDebito = MIN(IdDebito)
	FROM   @Debitos	
	
	WHILE @IdDebito IS NOT NULL	 
	BEGIN		
		EXEC dbo.usp_DesfazerConjuntoEmissao @IdDebito
		
		SELECT @IdDebito = MIN(IdDebito)
		FROM   @Debitos	
		WHERE  IdDebito > @IdDebito
	END	
END
