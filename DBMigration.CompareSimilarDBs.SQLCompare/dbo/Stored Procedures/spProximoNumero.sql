/*
 * Oc 199689
 * Criado por Wesley Siva - Adicionado por LeandroS
 */

CREATE PROCEDURE [dbo].[spProximoNumero] @Pre        VARCHAR(  15 ),  
										 @Suf        VARCHAR(  15 ),  
										 @Tam        VARCHAR(  3 ),  
										 @Ano        VARCHAR(  6 ),  
										 @Tabela     VARCHAR( 50 ),  
										 @Campo      VARCHAR( 50 ),  
										 @Where      VARCHAR( 100 ),  
										 @ResetAnual Bit = 1  
  
AS  
  
DECLARE @Texto    VARCHAR( 1000 )  
DECLARE @SufWhere VARCHAR( 200 )  
DECLARE @PreWhere VARCHAR( 200 )  
DECLARE @PreWhen  VARCHAR( 1000 )  
DECLARE @SufWhen  VARCHAR( 1000 )  
  
SET @PreWhere = ''  
SET @SufWhere = ''  
SET @PreWhen  = ''  
SET @SufWhen  = ''  
  
IF @Ano = ''  
 SELECT @Ano = DATEPART(YYYY, GETDATE())  
  
IF @Pre = '' AND @Suf = ''  
BEGIN  
 /* OC 40915 - OC 41965 */  
 SET @Texto =   
              'select right(replicate(''0'', ' + @Tam +') + ' +  
              '             isnull(cast(max(isnull(cast(substring(replace(replace(' + @Campo + ', ''.'', ''''), '','', ''''),' +  
              '                                                   1,' +  
              '                                                   len(replace(replace(' + @Campo + ', ''.'', ''''), '','', ''''))) as int) + 1, ''1'')) as varchar(15)), ''1''), ' + @Tam +') as Proximo' +  
              '  from ' + @Tabela +  
              ' where isnumeric(replace(' + @Campo + ', ''.'', '''' )) = 1' +  
              '   and charindex(''E'','   + @Campo + ') = 0'+ /*Oc.39231*/  
              '   and charindex(''e'','   + @Campo + ') = 0'   
  IF @Where <> ''        
  SET @Texto = @Texto + ' AND ' + @Where + ' option (force order) '         
 EXEC( @Texto )        
END        
ELSE IF @Pre <> '' AND @Suf <> ''        
BEGIN        
  SET @Ano = '''' + @Ano + ''''        
                   
 IF CHARINDEX( 'ANO', @Suf ) > 0        
  BEGIN        
  SET @Suf = '''/''+' + @Ano        
    IF @ResetAnual = 1        
      SET @SufWhere = 'RIGHT( ' + @Campo + ', 5 ) = ''/'' + ' + @Ano + ' '        
    ELSE          
      SET @SufWhere = 'LEFT( RIGHT( ' + @Campo + ', 5 ), 1 ) = ''/'' '        
  END        
  ELSE        
  BEGIN         
  SET @Suf = '''' + @Suf + ''''        
    SET @SufWhere = ' RIGHT( ' + @Campo + ', LEN( ' + @Suf + ' ) ) = ' +  @Suf        
  END         
  IF CHARINDEX( 'ANO', @Pre ) > 0         
  BEGIN        
    SET @Pre = '+ ''/'''        
  SET @Pre = @Ano + @Pre        
    IF @ResetAnual = 1        
      SET @PreWhere = ' WHERE LEFT( ' + @Campo + ', 5 ) = ' + @Ano + ' + ''/'' '        
    ELSE        
      SET @PreWhere = ' WHERE RIGHT( LEFT( ' + @Campo + ', 5 ), 1 )  = ''/'' '        
  END        
  ELSE        
  BEGIN        
    SET @Pre = '''' + @Pre + ''''        
    SET @PreWhen  = '          WHEN ( CHARINDEX( ' + @Pre + ', ' + @Campo + ' ) > 0 ) ' +        
                    ' AND ISNUMERIC( SUBSTRING( ' + @Campo + ', 1 + LEN( ' + @Pre + ' ), LEN( ''' + REPLICATE( '0', @Tam ) + ''' ) ) ) = 1 '        
	SET @PreWhere = ' WHERE LEFT( ' + @Campo + ', LEN( ' + @Pre + ' ) ) = ' + @PRe + ' AND ISNUMERIC(SUBSTRING(' + @Campo + ', LEN(' + @Pre + ') + 1 , 1)) = 1 '                
  END        
        
  IF @ResetAnual = 1        
  BEGIN         
    SET @PreWhen = '          WHEN CHARINDEX( ' + @Pre + ', ' + @Campo + ' ) > 0 AND '        
    SET @SufWhen = '               CHARINDEX( ' + @Suf + ', ' + @Campo + ' ) > 0 '        
  END        
        
  IF ( @PreWhere = '' ) AND ( @SufWhere <> '' )        
    SET @SufWhere = ' WHERE ' + @SufWhere        
        
  if ( @PreWhen = '' ) AND ( @SufWhen = '' )         
    SET @PreWhen = 'WHEN ISNUMERIC( ' + 'SUBSTRING( REPLACE( ' + @Campo + ', ''.'', '''' ), 1 + LEN( ' + @Pre + ' ), LEN( ''' + REPLICATE( '0', @Tam ) + ''' ) ) ) = 1 '        
         
  if ( @PreWhere <> '' ) and ( @SufWhere <> '' )        
    SET @SufWhere = ' AND ' + @SufWhere        
        
  SET @Texto = ' SELECT ' + @Pre + ' + RIGHT( ''' + REPLICATE( '0', @Tam ) + ''' + CAST( IsNull( MAX( CAST( ' +        
                 '        CASE ' + @PreWhen + @SufWhen +         
                 '          THEN REPLACE( SUBSTRING( ' + @Campo + ', 1 + LEN( ' + @Pre + ' ), LEN( ''' + REPLICATE( '0', @Tam ) + ''' ) ), ''.'', '''' ) ' +        
                 '          ELSE 0 ' +        
                 '        END AS INT)) + 1, 1 ) AS VARCHAR( 15 ) ), ' + @Tam + ' ) + ' + @Suf + ' AS Proximo ' +        
                 '  FROM ' + @Tabela + @PreWhere + @SufWhere        
        
  IF @Where <> ''        
    IF @PreWhere = '' AND @SufWhere = ''              
      SET @Texto = @Texto + ' WHERE ' + @Where        
    ELSE        
     SET @Texto = @Texto + ' AND ' + @Where + ' option (force order) '       
 EXEC( @Texto )        
END        
ELSE IF @Pre = '' AND @Suf <> ''        
BEGIN        
      
 IF RIGHT( @Suf, 3 ) = 'ANO'        
 BEGIN        
  SET @Suf = '''/'''        
  SET @Pre = '''' + @Pre + ''''        
  SET @Ano = '''' + @Ano + ''''        
            
    IF @ResetAnual = 1        
      SET @SufWhere = '  WHERE RIGHT( ' + @Campo + ', 5 ) = ''/'' + ' + @Ano + ' '        
    ELSE         
      SET @SufWhere = '  WHERE LEFT( RIGHT( ' + @Campo + ', 5 ), 1 ) LIKE ''%/%'' AND LEN( ' + @Campo + ' ) > 5'        
  SET @Texto = ' SELECT RIGHT( ''' + REPLICATE( '0', @Tam ) + ''' + CAST( ISNULL( MAX( CAST(' +        
                 '        CASE ' +        
                 '          WHEN ISNUMERIC( LEFT( ' + @Campo + ', LEN( ' + @Campo + ' ) -5 ) ) = 1 ' +        
                 '            THEN CAST(    REPLACE( LEFT( ' + @Campo + ', LEN( ' + @Campo + ' ) -5 ), ''.'', '''' ) AS VARCHAR( 15 ) ) ' +        
                 '          ELSE CAST( 0 AS VARCHAR( 15 ) ) ' +        
                 '        END AS INT) ) + 1, CAST( 1 AS VARCHAR( 15 ) ) ) AS VARCHAR( 15 ) ), '  + @Tam + ' ) + ' + @Suf + ' + ' + @Ano + ' AS Proximo ' +        
                 '   FROM ' + @Tabela + @SufWhere        
                         
    IF @Where <> ''        
    BEGIN         
      IF @SufWhere = ''        
     SET @Texto = @Texto + 'WHERE ' + @Where + ' option (force order) '       
      ELSE        
     SET @Texto = @Texto + ' AND  ' + @Where + ' option (force order) '       
    END        
  EXEC( @Texto )        
      
 END        
 ELSE        
 BEGIN        
       
  SET @Pre = '''' + @Pre + ''''        
  SET @Suf = '''' + @Suf + ''''        
  SET @Texto = 'SELECT RIGHT( ''' + REPLICATE( '0', @Tam ) + ''' + CAST( ISNULL( MAX( cast( ' +        
                 '       CASE ' +        
                 '         WHEN ISNUMERIC( LEFT( ' + @Campo + ', LEN( ' + @Campo + ' ) - LEN( ' + @Suf + ' ) ) ) = 1 '+        
                 '           THEN CAST( REPLACE( LEFT( ' + @Campo + ', LEN( ' + @Campo + ' ) - LEN(  ' + @Suf + '  ) ), ''.'', '''' ) AS VARCHAR( 15 ) ) ' +        
                 '         ELSE CAST( 0 AS VARCHAR( 15 ) ) ' +        
                 '       END as int ) ) + 1, CAST( 1 AS VARCHAR( 15 ) ) ) AS VARCHAR( 15 ) ), ' + @Tam + ' ) + ' + @Suf + ' AS Proximo ' +        
                 '  FROM ' + @Tabela +        
                 ' WHERE RIGHT( ' + @Campo + ', LEN( ' + @Suf + ' ) ) = ' + @Suf + ' '        
    IF @Where <> ''        
      SET @Texto = @Texto + ' AND ' + @Where + ' option (force order) '        
/*print @Texto  */    
  EXEC( @Texto )        
 END        
       
END        
ELSE IF @Pre <> '' AND @Suf = ''        
BEGIN        
      
 IF RIGHT( @Pre, 3 ) = 'ANO'        
 BEGIN        
       
  SET @Pre = '/'''        
  SET @Ano = '''' + @Ano + ''        
        
    IF @ResetAnual = 1        
      SET @PreWhere = '  WHERE LEFT( ' + @Campo + ', 5 ) = ' + @Ano + '''+''/'' '        
    ELSE        
      SET @PreWhere = '  WHERE Right( LEFT( ' + @Campo + ', 5 ), 1 ) = ''/'' '        
        
  SET @Texto = ' SELECT ' + @Ano + @Pre + ' + RIGHT( ''' + REPLICATE( '0', @Tam ) + ''' + CAST( ISNULL( MAX( CAST(' +        
                 '        CASE ' +        
                 '          WHEN ISNUMERIC( SUBSTRING( ' + @Campo + ', 6, LEN( ' + @Campo + ' ) ) ) = 1 ' +        
                 '            THEN CAST(    REPLACE( SUBSTRING( ' + @Campo + ', 6, LEN( ' + @Campo + ' ) ), ''.'', '''' ) AS INT ) ' +        
                 '          ELSE CAST( 0 AS VARCHAR( 15 ) ) ' +        
                 '        END AS INT)) + 1, CAST( 1 AS VARCHAR( 15 ) ) ) AS VARCHAR( 15 ) ), '  + @Tam + ' ) ' +        
                 ' AS Proximo ' +        
                 '   FROM ' + @Tabela + @PreWhere  
	          
    IF @Where <> ''        
    BEGIN        
      IF @PreWhere = ''         
         SET @Where = ' WHERE ' + @Where  
      ELSE         
         SET @Where = ' AND ' + @Where         
   SET @Texto = @Texto + @Where + ' option (force order) '       
    END  
         
  EXEC( @Texto )        
 END        
 ELSE        
 BEGIN        
   SET @Pre = '''' + @Pre + ''''        
   SET @Suf = '''' + @Suf + ''''        
   SET @Texto = ' SELECT ' + @Pre + ' + RIGHT( ''' + REPLICATE( '0', @Tam ) + ''' + ISNULL( CAST( MAX( CAST(' +        
                 '        CASE ' +        
                 '          WHEN CHARINDEX( ' + @Pre + ', ' + @Campo + ' ) > 0 ' +        
                 '               AND CHARINDEX( ' + @Suf + ', ' + @Campo + ' ) = 0 ' +        
                 '             THEN REPLACE( SUBSTRING( ' + @Campo + ', LEN( ' + @Pre + ' ) + 1, LEN( ' + @Campo + ' ) - LEN( ' + @Pre + ' ) ), ''.'', '''' ) ' +        
                 '          ELSE 0 ' +        
                 '        END AS INT)) + 1 AS VARCHAR( 15 ) ), 1 ), ' + @Tam + ' ) AS Proximo ' +        
                 '   FROM ' + @Tabela +        
                 '  WHERE LEFT( ' + @Campo + ', LEN( ' + @Pre + ' ) ) = ' + @Pre +        
                 '        AND ISNUMERIC( SUBSTRING( ' + @Campo + ', LEN( ' + @Pre + ' ) + 1, LEN( ' + @Campo + ' ) - LEN( ' + @Pre + ' ) ) ) = 1 '        
    IF @Where <> ''        
      SET @Texto = @Texto + ' AND ' + @Where + ' option (force order) '

   EXEC( @Texto )        
      
  END        
      
END  
