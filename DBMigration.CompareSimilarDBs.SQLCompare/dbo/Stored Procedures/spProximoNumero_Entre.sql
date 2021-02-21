

/* JoaoM - OC. 33305 */ 
CREATE PROCEDURE [dbo].[spProximoNumero_Entre] @Sigla        VARCHAR(  15 ),
                                     @Tam        VARCHAR(  3 ),    
                                     @Tabela     VARCHAR( 50 ),    
                                     @Campo      VARCHAR( 50 ),    
                                     @Where      VARCHAR( 50 )    
    
AS    
    
DECLARE @Texto    VARCHAR( 1000 )    
   
SET @Sigla = '''' + @Sigla + ''''    
SET @Texto = ' SELECT RIGHT( ''' +REPLICATE( '0', @Tam ) + ''' + ISNULL( CAST( MAX( ' +
			 '	CASE '+
		     '			 WHEN CHARINDEX( ' + @Sigla +', '+ @Campo +' ) > 0 AND CHARINDEX( '''', '+@Campo +' ) = 0 THEN ' + 
     		 '			REPLACE( REPLACE('+@Campo +',' + @Sigla +','''') , ''.'', '''' ) '+
			 '		 ELSE 0 '+
			 '	END ) + 1 AS VARCHAR( 5 ) ), 1 ), ' + @Tam +' ) AS Proximo '+
			 '	FROM   '+ @Tabela +
			 '	WHERE  CHARINDEX(' + @Sigla +','+@Campo +') > 0  '+
			 '	AND ISNUMERIC(REPLACE(' + @Campo +',' + @Sigla +','''')) = 1'
IF @Where <> ''    
  SET @Texto = @Texto + ' AND ' + @Where    
EXEC( @Texto )    




