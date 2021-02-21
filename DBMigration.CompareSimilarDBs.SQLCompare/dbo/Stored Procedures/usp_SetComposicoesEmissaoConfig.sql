
CREATE PROCEDURE dbo.usp_SetComposicoesEmissaoConfig (@IdDetalheEmissao INT, @DataMinimaASerConsiderada DATETIME)
AS
BEGIN
	DECLARE @Descontos TABLE (
		        IdComposicaoEmissao INT,
	            IdDebito            INT,
	            DataDesconto        DATETIME,
	            ValorDesconto       NUMERIC(10, 2),
	            E_Percentual        BIT,
	            Ordem               INT
	        )
	
	DECLARE @DataVencimentoBoleto DATETIME,
	        @IdEmissaoConfig      INT
	
	SELECT @DataVencimentoBoleto = DataVencimento,
	       @IdEmissaoConfig = IdEmissaoConfig 
	FROM   DetalhesEmissao 
	WHERE  IdDetalheEmissao = @IdDetalheEmissao
	
	INSERT INTO @Descontos
	  (
	    IdComposicaoEmissao,
	    DataDesconto,
	    ValorDesconto,
	    E_Percentual,
	    Ordem
	  )
	SELECT ce.IdComposicaoEmissao, 
	       gd.DataDesconto,
	       gd.ValorDesconto,
	       gd.E_Percentual,
	       gd.Ordem
	FROM   ComposicoesEmissao ce
	       CROSS APPLY dbo.ufn_GetDescontos(ce.IdDebito, @DataMinimaASerConsiderada) gd
	WHERE  ce.IdDetalheEmissao = @IdDetalheEmissao 
	
	INSERT INTO ComposicoesEmissaoConfig
	  (
	    IdComposicaoEmissao,
	    CodDesconto1,
	    DataDesconto1,
	    ValorDesconto1,
	    AtualizacaoWeb
	  )
	SELECT IdComposicaoEmissao,
	       CASE 
	            WHEN de.E_Percentual IS NULL THEN NULL /* Se é nulo é porque não tem esse desconto, logo é "nenhum = 0" (Obs. Coloco nulo para fazer uma validação logo adinate)*/
	            WHEN de.E_Percentual = 0 THEN 1 /* Se é 0 (zero) é porque é False, logo o valor é em reais (R$), então é "Valor fixo = 1" */
	            WHEN de.E_percentual = 1 THEN 2 /* Se é 1 (um) é porque é True, logo o valor é em percentual (%), então é "Percentual = 2" */
	       END,
	       de.DataDesconto,
	       de.ValorDesconto,
	       ( SELECT AtualizacaoWeb 
			 FROM   DetalhesEmissao 
		     WHERE  IdDetalheEmissao = @IdDetalheEmissao)
	FROM   @Descontos de
	WHERE  Ordem = 1
	  AND  de.DataDesconto <= @DataVencimentoBoleto 
	
	UPDATE ceg
	SET    ceg.CodDesconto2 = CASE 
                                   WHEN de.E_Percentual IS NULL THEN NULL /* Se é nulo é porque não tem esse desconto, logo é "nenhum = 0" (Obs. Coloco nulo para fazer uma validação logo adinate)*/
                                   WHEN de.E_Percentual = 0 THEN 1 /* Se é 0 (zero) é porque é False, logo o valor é em reais (R$), então é "Valor fixo = 1" */
                                   WHEN de.E_percentual = 1 THEN 2 /* Se é 1 (um) é porque é True, logo o valor é em percentual (%), então é "Percentual = 2" */
                              END,
	       ceg.DataDesconto2 = de.DataDesconto,
	       ceg.ValorDesconto2 = de.ValorDesconto
	FROM   ComposicoesEmissaoConfig ceg   
		   JOIN ComposicoesEmissao ce ON ce.IdComposicaoEmissao = ceg.IdComposicaoEmissao
		   JOIN DetalhesEmissao dem ON dem.IdDetalheEmissao = ce.IdDetalheEmissao
	       JOIN @Descontos de ON de.IdComposicaoEmissao = ce.IdComposicaoEmissao
	WHERE  de.Ordem = 2
	  AND  de.DataDesconto <= @DataVencimentoBoleto
	  AND  dbo.ufn_PermitirMaisDeUmDesconto( @IdEmissaoConfig ) = 1
	
	UPDATE ceg
	SET    ceg.CodDesconto3 = CASE 
                                   WHEN de.E_Percentual IS NULL THEN NULL /* Se é nulo é porque não tem esse desconto, logo é "nenhum = 0" (Obs. Coloco nulo para fazer uma validação logo adinate)*/
                                   WHEN de.E_Percentual = 0 THEN 1 /* Se é 0 (zero) é porque é False, logo o valor é em reais (R$), então é "Valor fixo = 1" */
                                   WHEN de.E_percentual = 1 THEN 2 /* Se é 1 (um) é porque é True, logo o valor é em percentual (%), então é "Percentual = 2" */
                              END,
	       ceg.DataDesconto3 = de.DataDesconto,
	       ceg.ValorDesconto3 = de.ValorDesconto
	FROM   ComposicoesEmissaoConfig ceg   
		   JOIN ComposicoesEmissao ce ON ce.IdComposicaoEmissao = ceg.IdComposicaoEmissao
		   JOIN DetalhesEmissao dem ON dem.IdDetalheEmissao = ce.IdDetalheEmissao
	       JOIN @Descontos de ON de.IdComposicaoEmissao = ce.IdComposicaoEmissao
	WHERE  de.Ordem = 3	
	  AND  de.DataDesconto <= @DataVencimentoBoleto
	  AND  dbo.ufn_PermitirMaisDeUmDesconto( @IdEmissaoConfig ) = 1
	
END                                                   
