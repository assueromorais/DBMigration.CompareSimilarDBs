
CREATE PROCEDURE dbo.usp_DesfazerConjuntoEmissao ( @IdDebito INT ) 
AS 
BEGIN	
	DECLARE @IdPessoa           INT,                                                     
			@NumConjComposicao  INT,                                                     
			@TipoPessoa         CHAR(2)                                                  
                                                                                     
	SELECT @IdPessoa = CASE                                                              
							WHEN d.IdProfissional   IS NOT NULL THEN d.IdProfissional      
							WHEN d.IdPessoaJuridica IS NOT NULL THEN d.IdPessoaJuridica  
							WHEN d.IdPessoa         IS NOT NULL THEN d.IdPessoa                  
							ELSE -1                                                      
					   END,                                                              
		   @TipoPessoa = CASE                                                            
							  WHEN d.IdProfissional   IS NOT NULL THEN 'PF'            
							  WHEN d.IdPessoaJuridica IS NOT NULL THEN 'PJ'            
							  WHEN d.IdPessoa         IS NOT NULL THEN 'OP'            
							  ELSE 'XX'                                                
						 END,                                                            
		   @NumConjComposicao = d.NumConjEmissao                                         
	FROM   Debitos d                                                                     
	WHERE  d.IdDebito = @IdDebito                                                        
	  AND  d.TpEmissaoConjunta > 0                                                       
	  AND  d.NumConjEmissao IS NOT NULL                                                  
                               
	IF @TipoPessoa = 'PF'
	BEGIN
	    UPDATE d
	    SET    d.TpEmissaoConjunta = 0,
	           d.NumConjEmissao = 0,
	           d.TpCompDespesas = 0,
	           d.NossoNumero = NULL,
	           d.SeuNumero = NULL
	    FROM   Debitos d
	    WHERE  d.NumConjEmissao = @NumConjComposicao
	           AND d.IdProfissional = @IdPessoa
	END
	ELSE 
	IF @TipoPessoa = 'PJ'
	BEGIN
	    UPDATE d
	    SET    d.TpEmissaoConjunta = 0,
	           d.NumConjEmissao = 0,
	           d.TpCompDespesas = 0,
	           d.NossoNumero = NULL,
	           d.SeuNumero = NULL
	    FROM   Debitos d
	    WHERE  d.NumConjEmissao = @NumConjComposicao
	           AND d.IdPessoaJuridica = @IdPessoa
	END
	ELSE 
	IF @TipoPessoa = 'OP'
	BEGIN
	    UPDATE d
	    SET    d.TpEmissaoConjunta = 0,
	           d.NumConjEmissao = 0,
	           d.TpCompDespesas = 0,
	           d.NossoNumero = NULL,
	           d.SeuNumero = NULL
	    FROM   Debitos d
	    WHERE  d.NumConjEmissao = @NumConjComposicao
	           AND d.IdPessoa = @IdPessoa
	END                                                                       
END
