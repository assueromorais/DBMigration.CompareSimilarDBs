CREATE FUNCTION dbo.ufn_GetDebitoRenRecComposicaoOrigem ( @IdDebito INT )
            RETURNS @Result TABLE ( IdComposicaoDebito INT )
            AS
            BEGIN
            	INSERT INTO @Result ( IdComposicaoDebito ) 
            	SELECT cd.IdComposicaoDebito	
            	FROM   Debitos d
            		   JOIN ComposicoesDebito cd 
            		        ON  cd.IdDebito = d.IdDebito
            	WHERE ISNULL(cd.ValorEsperadoPrincipal, 0) > 0
            	  AND cd.IdDebito <> cd.IdDebitoOrigemRen
            	  AND d.IdTipoDebito IN (2,10)
            	  AND d.IdDebito = @IdDebito
            	   	
            	RETURN 	
          END