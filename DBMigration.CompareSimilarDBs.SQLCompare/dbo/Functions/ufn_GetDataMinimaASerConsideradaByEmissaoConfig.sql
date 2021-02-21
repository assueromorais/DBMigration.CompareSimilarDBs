
CREATE FUNCTION dbo.ufn_GetDataMinimaASerConsideradaByEmissaoConfig ( @IdEmissaoConfig INT ) 
RETURNS DATETIME
BEGIN
	DECLARE @IdContaCorrente           INT,
	        @TipoEmissao               INT,
		    @DataMinimaASerConsiderada DATETIME
	
	SELECT @IdContaCorrente = IdContaCorrente,
	       @TipoEmissao     = TipoEmissao	
	FROM   EmissoesConfig
	WHERE  IdEmissaoConfig = @IdEmissaoConfig  
	
	SELECT @DataMinimaASerConsiderada = dbo.ufn_GetDataMinimaASerConsiderada(@IdContaCorrente, @TipoEmissao)
		
	RETURN @DataMinimaASerConsiderada				 
END
