
CREATE PROCEDURE dbo.usp_SetDetalhesEmissaoConfig ( @IdDetalheEmissao INT,
	                                                @IdContaCorrente  INT, 
			                                        @IdConvenio       INT )
AS
BEGIN
	DECLARE @ExisteSomenteRenRec  BIT, 
		    @NaoCobrarMultaRenRec BIT
	        	
	SELECT @ExisteSomenteRenRec  = 0,
	       @NaoCobrarMultaRenRec = 0
	
	SELECT @NaoCobrarMultaRenRec = ISNULL(CAST(Valor AS BIT), 0)
	FROM   AppConfig
	WHERE  Chave = 'NAO_COBRAR_MULTA_PARA_REN_REC'
	
	IF @NaoCobrarMultaRenRec = 1 
		SELECT @ExisteSomenteRenRec = CASE 
		                                   WHEN COUNT(*) > 0 THEN 0
		                                   ELSE 1
		                              END
		FROM   DetalhesEmissao de
		       JOIN ComposicoesEmissao ce
		            ON  ce.IdDetalheEmissao = de.IdDetalheEmissao
		       JOIN Debitos d
		            ON  d.IdDebito = ce.IdDebito
		WHERE  de.IdDetalheEmissao = @IdDetalheEmissao
		       AND d.IdTipoDebito NOT IN (2, 10)
		  		
	IF NOT EXISTS(
	       SELECT TOP 1 1
	       FROM   DetalhesEmissaoConfig     
	       WHERE  IdDetalheEmissao = @IdDetalheEmissao
	   )
	BEGIN
		INSERT INTO DetalhesEmissaoConfig
		(
			IdDetalheEmissao,
			CodMulta,
			ValorMulta,
			CodJuros,
			ValorJuros,
			AtualizacaoWeb
		)
		SELECT @IdDetalheEmissao,
			   CASE WHEN @NaoCobrarMultaRenRec = 1 AND @ExisteSomenteRenRec = 1 THEN 0 ELSE ced.CodMulta   END,
			   CASE WHEN @NaoCobrarMultaRenRec = 1 AND @ExisteSomenteRenRec = 1 THEN 0 ELSE ced.ValorMulta END,
			   CASE WHEN ced.CodJuros = 2 AND ISNULL(ConverterTaxaMensalEmValorDiario,0) = 1 THEN 1
			        ELSE ced.CodJuros
			   END,
			   CASE WHEN ced.CodJuros = 2 AND ISNULL(ConverterTaxaMensalEmValorDiario,0) = 1 THEN (SELECT CAST((ValorEmissao * ced.ValorJuros / 100 / 30) AS NUMERIC(10,2))
																								   FROM   DetalhesEmissao 
																								   WHERE  IdDetalheEmissao = @IdDetalheEmissao)
			        ELSE ced.ValorJuros
			   END,
			   ( SELECT AtualizacaoWeb 
			     FROM   DetalhesEmissao 
			     WHERE  IdDetalheEmissao = @IdDetalheEmissao)
		FROM   ConfigBancoParaEmissao ced		       
		WHERE  ced.IdConfigBancoParaEmissao = (SELECT ISNULL(CASE WHEN c.IdConfigBancoParaEmissao IS NOT NULL THEN c.IdConfigBancoParaEmissao
                                                                  ELSE cc.IdConfigBancoParaEmissao 
                                                              END, NULL)
                                               FROM   ContasCorrentes cc
                                                      LEFT JOIN Convenios c
                                                           ON  c.IdContaCorrente = cc.IdContaCorrente
                                                               AND c.IdConvenio = @IdConvenio
		                                       WHERE  cc.IdContaCorrente = @IdContaCorrente) 
	END
END                                                      
