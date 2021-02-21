	
-- ============================================================================
--	sp_BuscarDetalhesBoleto
-- ============================================================================	
CREATE PROCEDURE [dbo].[sp_BuscarDetalhesBoleto]
	@nossoNumero VARCHAR(150),
	@retornarQtd BIT =0
AS
	/*
	DECLARE @nossoNumero VARCHAR(150),        
	@retornarQtd BIT 
	
	SELECT @nossoNumero = '70003448', @retornarQtd = 0
	*/ 
BEGIN     
	DECLARE @sqlCampos VARCHAR(5000)
	
	IF @retornarQtd = 0
	    SET @sqlCampos = 
	        ' SUBSTRING(        
        CASE ce.numeroParcela        
             WHEN 0 THEN ''C.Ãšnica '' + ISNULL(        
                      (        
                          SELECT substring(td.nomeDebito,1,10) + ''/'' + CAST(YEAR(ce.DataReferenciaDebito)AS VARCHAR(4))        
                          FROM   TiposDebito td        
                          WHERE  IdTipoDebito IN (SELECT d.IdTipoDebito        
                                                  FROM   Debitos d        
                                                  WHERE  d.IdDebito = ce.IdDebito)        
                      ),        
                      ''''        
                  )        
             ELSE CAST(ce.NumeroParcela AS VARCHAR(3)) + '' Parc. '' +         
                  ISNULL(        
                      (        
                          SELECT substring(td.nomeDebito,1,10) + ''/'' + CAST(YEAR(ce.DataReferenciaDebito)AS VARCHAR(4))        
                          FROM   TiposDebito td        
                          WHERE  IdTipoDebito IN (SELECT d.IdTipoDebito        
                                                  FROM   Debitos d        
                                                  WHERE  d.IdDebito = ce.IdDebito)        
                      ),        
                      ''''        
                  )        
        END,        
        0,        
        26        
    ) AS Referente,        
    de.iddetalheemissao,        
    de.DataVencimento,        
    ISNULL(ce.ValorPrincipal,0) AS ValorPrincipal,        
    ISNULL(ce.ValorDevido,0) AS ValorDevido, 
    ISNULL(ce.ValorAtualizacao,0) AS ValorAtualizacao,       
    ISNULL(ce.ValorMulta,0) AS ValorMulta,   
    ISNULL(ce.ValorJuros,0) AS ValorJuros,
    ISNULL(ce.ValorDespBco,0) AS ValorDespBco,
    ISNULL(ce.ValorDespAdv,0) AS ValorDespAdv,
    ISNULL(ce.ValorDespPostais,0) AS ValorDespPostais,
    d.DataVencimento DataVencimentoDebito '
	ELSE
	    SET @sqlCampos = ' COUNT(''*'') Qtde'
	
	
	
	EXEC (
	         'SELECT '
	         +
	         @sqlCampos
	         +
	         '        
FROM   DetalhesEmissao de,        
    ComposicoesEmissao ce    
LEFT JOIN Debitos d on d.IdDebito = ce.IdDebito            
WHERE  de.IdDetalheEmissao = ce.IdDetalheEmissao                                
    AND de.NossoNumero IN(''' + @nossoNumero +
	         ''')
    AND de.IdDetalheEmissao = (SELECT TOP 1 de2.IdDetalheEmissao
                                 FROM DetalhesEmissao de2
                               WHERE de2.NossoNumero IN(''' + @nossoNumero +
	         ''')
                               ORDER BY de2.IdDetalheEmissao DESC)        
     '
	     ) 
	
	
	PRINT(
	    'SELECT '
	    +
	    @sqlCampos
	    +
	    '        
FROM   DetalhesEmissao de,        
    ComposicoesEmissao ce    
LEFT JOIN Debitos d on d.IdDebito = ce.IdDebito            
WHERE  de.IdDetalheEmissao = ce.IdDetalheEmissao                                
    AND de.NossoNumero IN(''' + @nossoNumero +
	    ''')
    AND de.IdDetalheEmissao = (SELECT TOP 1 de2.IdDetalheEmissao
                                 FROM DetalhesEmissao de2
                               WHERE de2.NossoNumero IN(''' + @nossoNumero +
	    ''')
                               ORDER BY de2.IdDetalheEmissao DESC)        
     '
	) 
	
	
END
