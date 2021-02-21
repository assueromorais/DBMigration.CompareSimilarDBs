
CREATE FUNCTION dbo.ufn_GetDescontos
(
	@IdDebito INT,
	@DataMinimaASerConsiderada DATETIME
)
RETURNS @Result TABLE (
            DataDesconto DATETIME,
            ValorDesconto NUMERIC(10, 2),
            E_Percentual BIT,
            Ordem INT
        )
AS
BEGIN		
	IF ISNULL(@DataMinimaASerConsiderada,0) = 0 
		SET @DataMinimaASerConsiderada = CAST(CONVERT(VARCHAR(8), GETDATE(), 112) AS DATETIME) 
		
	INSERT INTO @Result
	  (
	    DataDesconto,
	    ValorDesconto,
	    E_Percentual,
	    Ordem
	  )
	SELECT dbo.ufn_GetDataPgtoDesconto(opd.IdOpcaoPgtoDesconto, d.DataVencimento),
	       opd.ValorPgtoDesconto,
	       opd.E_Percentual,
	       ROW_NUMBER() OVER(ORDER BY dbo.ufn_GetDataPgtoDesconto(opd.IdOpcaoPgtoDesconto, d.DataVencimento)) Ordem
	FROM   Debitos d
	       JOIN ConfigGeracaoDebito cgd
	            ON  cgd.IdConfigGeracaoDebito = d.IdConfigGeracaoDebito
	       JOIN ConfigParcelasDebito cpd
	            ON  cpd.IdConfigGeracaoDebito = cgd.IdConfigGeracaoDebito
	                AND cpd.NumeroParcela = d.NumeroParcela
	       JOIN OpcoesPgtoDesconto opd
	            ON  opd.IdConfigParcelaDebito = cpd.IdConfigParcelaDebito
	WHERE  d.IdDebito = @IdDebito      
	  AND  dbo.ufn_GetDataPgtoDesconto(opd.IdOpcaoPgtoDesconto, d.DataVencimento) >= @DataMinimaASerConsiderada
	ORDER BY
	       dbo.ufn_GetDataPgtoDesconto(opd.IdOpcaoPgtoDesconto, d.DataVencimento)              	
	
	RETURN
END
