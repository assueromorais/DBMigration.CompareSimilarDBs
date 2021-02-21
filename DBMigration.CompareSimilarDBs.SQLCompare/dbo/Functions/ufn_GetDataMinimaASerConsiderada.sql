
CREATE FUNCTION dbo.ufn_GetDataMinimaASerConsiderada ( @IdContaCorrente INT, @TipoEmissao INT ) 
RETURNS DATETIME
BEGIN
	DECLARE @NumeroDias                INT,
		    @DataMinimaASerConsiderada DATETIME
		
	IF @IdContaCorrente > 0 AND @TipoEmissao = 2 -- 2 -> Arquivo Remessa
		SELECT @NumeroDias = ISNULL(QtdDiasMinEntreEmissaoVenc, 0)
		FROM   ContasCorrentes
		WHERE  IdContaCorrente = @IdContaCorrente
	ELSE
		SELECT @NumeroDias = (SELECT CAST(Valor AS INT)
                              FROM   AppConfig
                              WHERE  Chave = 'NUMERO_DIAS_MINIMO_VENCIMENTO')
	
	SELECT @DataMinimaASerConsiderada = DATEADD( DAY, ISNULL(@NumeroDias, 0), CAST(CONVERT(VARCHAR(8), GETDATE(), 112) AS DATETIME) )
	
	RETURN @DataMinimaASerConsiderada				 
END
