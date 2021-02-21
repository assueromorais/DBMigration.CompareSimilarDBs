
CREATE FUNCTION dbo.ufn_GetDetalharComposicaoDebitoNoBoleto
(
	@IdDetalheEmissao INT
)
RETURNS VARCHAR(5000) 
AS
BEGIN
	DECLARE @Debitos            VARCHAR(5000),
	        @ExisteRenRec       BIT,	        
			@ExibeColunaOrigem BIT
    
   /* Se não existir a chave na AppConfig vou adimitir que é para exibir a coluna no boleto */        
    SELECT  @ExibeColunaOrigem = ISNULL( (SELECT Valor FROM AppConfig AS ac WHERE Chave = 'BOLETO_EXIBE_COLUNA_ORIGEM'), 1)

        
	        
	SET @ExisteRenRec = CASE WHEN EXISTS( SELECT TOP 1 1
	                                      FROM   DetalhesEmissao de
	                                             JOIN ComposicoesEmissao ce
	                                                  ON  ce.IdDetalheEmissao = de.IdDetalheEmissao
	                                             JOIN Debitos d
	                                                  ON  d.IdDebito = ce.IdDebito
	                                      WHERE  ce.IdDetalheEmissao = @IdDetalheEmissao 
	                                        AND  d.IdTipoDebito IN (2,10) ) THEN 1
	                        ELSE 0 
	                    END 
	
	SET @Debitos = 'Débito composto por:' + CHAR(13) + CHAR(10) + 
	                '  ' + 'Referente          Valor devido   Atualização    Multa     Juros' +
	               CASE WHEN @ExibeColunaOrigem = 1 AND @ExisteRenRec = 1 THEN '    Origem' ELSE '' END + CHAR(13) + CHAR(10)		
	
	
	SELECT @Debitos = @Debitos + '  ' +
	   /* Referente         */ LEFT ( CASE WHEN d.NumeroParcela = 0 THEN 'C.Única' 
	                                       ELSE CAST(d.NumeroParcela AS VARCHAR) + 'ªParc.' 
	                                  END + td.SiglaDebito + '/' + CAST(YEAR(d.DataReferencia) AS VARCHAR) + REPLICATE(' ', 18), 20) +
	   /* Valor Principal   */ RIGHT ( REPLICATE(' ', 11) + REPLACE( REPLACE( CAST( CAST ( ISNULL(ce.ValorPrincipal  ,0) AS NUMERIC(10, 2) ) AS VARCHAR( 10 ) ), ',', ''), '.', ','), 11 ) +
	   /* Valor Atualização */ RIGHT ( REPLICATE(' ', 14) + REPLACE( REPLACE( CAST( CAST ( ISNULL(ce.ValorAtualizacao,0) AS NUMERIC(10, 2) ) AS VARCHAR( 10 ) ), ',', ''), '.', ','), 14 ) +
	   /* Valor Multa       */ RIGHT ( REPLICATE(' ', 09) + REPLACE( REPLACE( CAST( CAST ( ISNULL(ce.ValorMulta      ,0) AS NUMERIC(10, 2) ) AS VARCHAR( 10 ) ), ',', ''), '.', ','), 09 ) +
	   /* Valor Juros       */ RIGHT ( REPLICATE(' ', 10) + REPLACE( REPLACE( CAST( CAST ( ISNULL(ce.ValorJuros      ,0) AS NUMERIC(10, 2) ) AS VARCHAR( 10 ) ), ',', ''), '.', ','), 10 ) +
	   CASE WHEN  @ExibeColunaOrigem = 1 AND @ExisteRenRec = 1 AND 
	             d.IdTipoDebito IN (2,10) THEN CHAR(13) + CHAR(10) + dbo.ufn_GetDetalharComposicaoDebitoNoBoletoByIdDebito( ce.IdDebito )
	        ELSE CHAR(13) + CHAR(10) 
	   END    	
	FROM   DetalhesEmissao de
	       JOIN ComposicoesEmissao ce
	            ON  ce.IdDetalheEmissao = de.IdDetalheEmissao
	       JOIN Debitos d
	            ON  d.IdDebito = ce.IdDebito	            
		   JOIN TiposDebito td 
		        ON  td.IdTipoDebito = d.IdTipoDebito
	WHERE  ce.IdDetalheEmissao = @IdDetalheEmissao
	
	RETURN @Debitos
END
