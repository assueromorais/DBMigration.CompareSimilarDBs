
CREATE PROCEDURE dbo.usp_GetProximoSeuNumero ( @EmissaoWeb BIT,
                                               @SeuNumero  VARCHAR(11) OUTPUT ) 
AS
BEGIN		
	IF @EmissaoWeb = 1
	BEGIN		
		SELECT @SeuNumero = ISNULL(SequencialNumeroDocumento, InicioNossoNum) + 1
		FROM   ParametrosSiscafweb
				
		UPDATE ParametrosSiscafweb
        SET    SequencialNumeroDocumento = @SeuNumero
	END
	ELSE
	BEGIN	
		SELECT @SeuNumero = ISNULL(SequencialSeuNumero, 0) + 1
		FROM   ParametrosSiscafw
	
		UPDATE ParametrosSiscafw
		SET    SequencialSeuNumero = @SeuNumero
	END	

	SELECT @SeuNumero = RIGHT( REPLICATE('0',11) + @SeuNumero, 11)	
END
