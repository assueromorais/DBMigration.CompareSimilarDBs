    
CREATE PROCEDURE dbo.usp_Get_CodCC_Conv_Ced (
    @IdContaCorrente     INT,
    @IdConvenio          INT,
    @CodCC_Conv_Ced      VARCHAR(16) OUTPUT,
    @CodOperacao         VARCHAR(3) OUTPUT
)
AS
BEGIN
	SELECT @CodCC_Conv_Ced = CASE 
	                              WHEN bs.CodigoBanco = '001' THEN c.CodConvenio
	                              WHEN bs.CodigoBanco = '104' THEN CASE 
	                                                                    WHEN cc.E_CNAB = 0 THEN cc.ContaCorrente
	                                                                    ELSE CASE 
	                                                                              WHEN cc.LeiauteCnab = 1 THEN c.CodConvenio
	                                                                              ELSE cc.CodigoCedente
	                                                                         END
	                                                               END
	                              WHEN bs.CodigoBanco = '748' THEN RIGHT(REPLICATE('0', 5) + cc.ContaCorrente, 5)
	                              ELSE cc.ContaCorrente
	                         END,
	       @CodOperacao = CASE 
	                           WHEN bs.CodigoBanco = '104' THEN cc.Operacao_CX
	                           ELSE ''
	                      END
	FROM   BancosSiscafw bs WITH (NOLOCK)
	       JOIN ContasCorrentes cc WITH (NOLOCK)
	            ON  cc.IdBancoSiscafw = bs.IdBancoSiscafw
	       LEFT JOIN Convenios c WITH (NOLOCK)
	            ON  c.IdContaCorrente = cc.IdContaCorrente
	                AND c.IdConvenio = @IdConvenio
	WHERE  cc.IdContaCorrente = @IdContaCorrente
END            
