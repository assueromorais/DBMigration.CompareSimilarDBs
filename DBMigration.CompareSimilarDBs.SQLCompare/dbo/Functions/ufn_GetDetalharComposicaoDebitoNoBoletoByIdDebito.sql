
CREATE FUNCTION dbo.ufn_GetDetalharComposicaoDebitoNoBoletoByIdDebito
(
	@IdDebito INT
)
RETURNS VARCHAR(5000)
AS
BEGIN	
	DECLARE @Composicao VARCHAR(5000) 
	
	SET @Composicao = ''
		
	SELECT @Composicao = @Composicao +  '  ' + 
	    /* Referente         */ LEFT ( ' - ' + CASE WHEN do.NumeroParcela = 0 THEN 'C.Única' 
	                                                ELSE CAST(do.NumeroParcela AS VARCHAR) + 'ªParc.' 
	                                           END + td.SiglaDebito + '/' + CAST(YEAR(do.DataReferencia) AS VARCHAR) + REPLICATE(' ', 18), 20) +	     
		/* Valor Principal   */ RIGHT ( REPLICATE(' ', 11) + REPLACE( REPLACE( CAST( CAST ( ISNULL( cd.ValorEsperadoPrincipal  ,0) AS NUMERIC(10, 2) ) AS VARCHAR( 10 ) ), ',', ''), '.', ','), 11 ) +
		/* Valor Atualização */ RIGHT ( REPLICATE(' ', 14) + REPLACE( REPLACE( CAST( CAST ( ISNULL( cd.ValorEsperadoAtualizacao,0) AS NUMERIC(10, 2) ) AS VARCHAR( 10 ) ), ',', ''), '.', ','), 14 ) +
		/* Valor Multa       */ RIGHT ( REPLICATE(' ', 09) + REPLACE( REPLACE( CAST( CAST ( ISNULL( cd.ValorEsperadoMulta      ,0) AS NUMERIC(10, 2) ) AS VARCHAR( 10 ) ), ',', ''), '.', ','), 09 ) +
		/* Valor Juros       */ RIGHT ( REPLICATE(' ', 10) + REPLACE( REPLACE( CAST( CAST ( ISNULL( cd.ValorEsperadoJuros      ,0) AS NUMERIC(10, 2) ) AS VARCHAR( 10 ) ), ',', ''), '.', ','), 10 ) +
		/* Valor Origem      */ RIGHT ( REPLICATE(' ', 11) + REPLACE( REPLACE( CAST( CAST ( ISNULL(                                                                                       
                                                                    CASE                                                                                
                                                                         WHEN ( do.IdSituacaoAtual IN (6, 14) AND do.ValorPago > 0) OR ( do.IdSituacaoAtual IN (3, 10))                                                   
                                                                              AND ( dbo.Calc_PagoMenor ( do.IdDebito, CASE                                                                    
                                                                                                                          WHEN do.IdProfissional IS NOT NULL THEN 1                           
                                                                                                                          WHEN do.IdPessoaJuridica IS NOT NULL THEN 0                         
                                                                                                                          ELSE 2                                                             
                                                                                                                     END                                                                     
                                                                                                       ) > 0                                                                       
                                                                                  ) THEN ( (cd.ValorEsperadoPrincipal * 100) / dbo.Calc_PagoMenor ( do.IdDebito, CASE                                                                    
                                                                                                                                                                     WHEN do.IdProfissional IS NOT NULL THEN 1                           
                                                                                                                                                                     WHEN do.IdPessoaJuridica IS NOT NULL THEN 0                         
                                                                                                                                                                     ELSE 2                                                             
                                                                                                                                                                END                                                                     
                                                                                                                                                  )                                                                           
                                                                                         ) 
                                                                         ELSE ( ( cd.ValorEsperadoPrincipal * 100 ) / do.ValorDevido) 
                                                                    END, 0) AS NUMERIC(10, 2) ) AS VARCHAR( 10 ) ), ',', ''), '.', ',') + '%', 11 ) + 
           CHAR(13) + CHAR(10)  	 
	FROM   Debitos d
			JOIN ComposicoesDebito cd 
				ON  cd.IdDebito = d.IdDebito
		    JOIN Debitos do 
		    	ON  do.IdDebito = cd.IdDebitoOrigemRen
		    JOIN TiposDebito td 
		        ON  td.IdTipoDebito = do.IdTipoDebito		    
	WHERE cd.IdComposicaoDebito IN ( SELECT IdComposicaoDebito FROM dbo.ufn_GetDebitoRenRecComposicaoOrigem( @IdDebito ) )
	
	RETURN @Composicao
END
