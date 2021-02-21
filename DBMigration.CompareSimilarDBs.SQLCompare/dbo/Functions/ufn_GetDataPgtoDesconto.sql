
CREATE FUNCTION dbo.ufn_GetDataPgtoDesconto
(
	@IdOpcaoPgtoDesconto      INT,
	@DataVencimentoDebito     DATETIME
)
RETURNS DATETIME
AS
BEGIN
	DECLARE @DiasAntecipacaoPgto INT,
	        @DataLimitePgtoDesconto DATETIME
	        
	IF @DataVencimentoDebito IS NULL
		RETURN NULL
	        
	SELECT @DiasAntecipacaoPgto = opd.DiaAntecipacao,
	       @DataLimitePgtoDesconto = opd.DataPgtoDesconto
	FROM OpcoesPgtoDesconto AS opd
	WHERE opd.IdOpcaoPgtoDesconto = @IdOpcaoPgtoDesconto
	
	IF (@DiasAntecipacaoPgto IS NULL) AND (@DataLimitePgtoDesconto IS NULL)
		RETURN @DataVencimentoDebito
	
	IF (@DiasAntecipacaoPgto IS NOT NULL)
		RETURN DATEADD(d, -@DiasAntecipacaoPgto, @DataVencimentoDebito)
	
	IF (@DataLimitePgtoDesconto IS NOT NULL)
		RETURN @DataLimitePgtoDesconto
	
	RETURN NULL
END
