

CREATE FUNCTION dbo.ufn_PermitirMaisDeUmDesconto
(
	@IdEmissaoConfig INT
)
RETURNS BIT
AS
BEGIN
	DECLARE @PermitirMaisDeUmDesconto BIT
	
	/* Por enquanto, vamos avaliar apenas para o Banco do Brasil, o único atualmente que possui esta limitação. */
	IF EXISTS(
	       SELECT TOP 1 1
	       FROM   EmissoesConfig ec
	              JOIN BancosSiscafw bs
	                   ON  ec.IdBanco = bs.IdBancoSiscafw
	       WHERE  ec.IdEmissaoConfig = @IdEmissaoConfig
	              AND bs.CodigoBanco = '001'
	   )
	BEGIN
	    DECLARE @RegistroOnline BIT
	    
	    SELECT @RegistroOnline = 0
	    
	    IF EXISTS(
	           SELECT TOP 1 1
	           FROM   EmissoesConfig
	           WHERE  IdEmissaoConfig = @IdEmissaoConfig
	                  AND EmissaoWeb  = 1
	       )
	    BEGIN
		    /* Se for uma emissão feita pela Web vamos verificar se o registro online está habilitado no SiscafWeb */
	        SELECT @RegistroOnline = ISNULL(
	                   (
	                       SELECT TOP 1 1
	                       FROM   AppConfig
	                       WHERE  Chave = 'WEB_SERVICE_REGISTRO_SISTEMA_CHAVE'
	                              AND Valor LIKE '%"habilitado":true%'
	                   ),
	                   0
	               )
	    END
	    ELSE
	    BEGIN
		    /* Aqui estamos tratando emissões feitas pelo Desktop */
	        DECLARE @IdContaCorrente     INT,
	                @IdConvenio          INT,
	                @EmissaoColetiva     BIT
	        
	        SELECT @IdContaCorrente = IdContaCorrente,
	               @IdConvenio          = IdConvenio,
	               @EmissaoColetiva     = Coletiva
	        FROM   EmissoesConfig
	        WHERE  IdEmissaoConfig      = @IdEmissaoConfig
	        
	        /* Apenas emissões individuais possuem a possíbilidade de registro online */
	        IF @EmissaoColetiva = 0
	        BEGIN
	            SELECT @RegistroOnline = ISNULL(
	                       (
	                           SELECT HabilitaRegistroOnline
	                           FROM   ConfigBancoParaEmissao
	                           WHERE  IdConfigBancoParaEmissao = (
	                                      SELECT ISNULL(
	                                                 CASE 
	                                                      WHEN c.IdConfigBancoParaEmissao IS NOT NULL THEN 
	                                                           c.IdConfigBancoParaEmissao
	                                                      ELSE cc.IdConfigBancoParaEmissao
	                                                 END,
	                                                 NULL
	                                             )
	                                      FROM   ContasCorrentes cc
	                                             LEFT JOIN Convenios c
	                                                  ON  c.IdContaCorrente = cc.IdContaCorrente
	                                                  AND c.IdConvenio = @IdConvenio
	                                      WHERE  cc.IdContaCorrente = @IdContaCorrente
	                                  )
	                       ),
	                       0
	                   )
	        END
	        ELSE
	        BEGIN
	            /* Emissão coletiva não utiliza registro online */
	            SELECT @RegistroOnline = 0
	        END
	    END
	    
	    /* Se o registro online está ativo então não podemos permitir mais de um desconto */
	    SELECT @PermitirMaisDeUmDesconto = CASE 
	                                            WHEN @RegistroOnline = 1 THEN 0
	                                            ELSE 1
	                                       END
	END
	ELSE
	BEGIN
		/* Para os demais bancos podemos permitir mais de um desconto */
	    SELECT @PermitirMaisDeUmDesconto = 1
	END
	
	RETURN @PermitirMaisDeUmDesconto
END


