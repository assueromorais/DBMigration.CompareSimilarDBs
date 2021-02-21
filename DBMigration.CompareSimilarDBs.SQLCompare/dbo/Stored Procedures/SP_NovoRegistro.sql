/* OC 143082 - José Mário*/
CREATE PROCEDURE [dbo].[SP_NovoRegistro]      
                     @Registro        VARCHAR( 15 ) OUTPUT,      
                     @IdCategoria     INTEGER,   /*Parametro usado para buscar Categoria PF ou PJ*/      
                     @TipoPessoa      VARCHAR( 1 ), /*Fisica ou Juridica ( F / J )*/      
                     @IdTipoInscricao INTEGER, 
                     @WhereAdicional  VARCHAR (1000) = '',     
                     @Sigla           VARCHAR ( 10 ) OUTPUT   /*Parametro guardar prefixo ou sufixo*/      
      
AS      
      
SET NOCOUNT ON      
      
DECLARE @TamanhoNumRegistroPJ   INTEGER  /*Tamanho numerico do registro sem sufixo e prefixo */      
DECLARE @TamanhoNumRegistroProf INTEGER      
DECLARE @Registro2              CHAR( 15 ) /*Comparar registro*/      
DECLARE @IndIncremento          INTEGER  /*Tipo de incremento*/      
DECLARE @IndPrefixo_Sufixo      INTEGER  /*Como incrementar*/      
DECLARE @IndIncConj             INTEGER      
DECLARE @Sufixo                 VARCHAR( 10 )      
DECLARE @Prefixo                VARCHAR( 10 )      
DECLARE @TamanhoRegistro        INTEGER      
DECLARE @ValorRegistroPF        INTEGER      
DECLARE @ValorRegistroPJ        INTEGER      
DECLARE @Temp                   VARCHAR( 10 )      
DECLARE @Where           VARCHAR( 100 )    
DECLARE @Categoria  VARCHAR( 40 ), @IdConselhoCorrente INT, @SiglaConselho VARCHAR(15)
     
     
SET @Registro = NULL      
/* LEITURA DOS PARAMETROS PARA PESSOA FÖSICA*/      
IF @TipoPessoa = 'F'      
  SELECT @IndIncConj             = IncrementoConjunto,      
         @IndIncremento          = IndIncrementoRegistroProf,      
         @IndPrefixo_Sufixo      = IndPre_sufNumRegistroProf,      
         @TamanhoNumRegistroProf = TamanhoNumRegistroProf,      
         @TamanhoNumRegistroPJ   = TamanhoNumRegistroPJ ,
         @IdConselhoCorrente=IdConselhoCorrente          
  FROM ParametrosSiscaFW    
      
/* LEITURA DOS PARAMETROS PARA PESSOA JURIDICA*/      
IF @TipoPessoa = 'J'      
  SELECT @IndIncConj             = IncrementoConjunto ,      
         @IndIncremento          = IndIncrementoRegistroPJ,      
         @IndPrefixo_Sufixo      = IndPre_sufNumRegistroPJ,      
         @TamanhoNumRegistroPJ   = TamanhoNumRegistroPJ,      
         @TamanhoNumRegistroProf = TamanhoNumRegistroProf  ,
         @IdConselhoCorrente=IdConselhoCorrente               
  FROM ParametrosSiscaFW    
 
SELECT @SiglaConselho=Sigla
FROM Pessoas
WHERE IdPessoa=@IdConselhoCorrente
       
IF @IndIncremento IS NULL      
  SET @IndIncremento = 1      
     
/* INICIALIZACAO */      
SET @Prefixo         = ''      
SET @Sufixo          = ''      
SET @TamanhoRegistro = 15      
SET @ValorRegistroPF = 0      
SET @ValorRegistroPJ = 0      
      
IF @TipoPessoa = 'F'  SET @TamanhoRegistro = @TamanhoNumRegistroProf      
IF @TipoPessoa = 'J'      
  SET @TamanhoRegistro = @TamanhoNumRegistroPJ      
    
/*Oc. 33305 - verificando excecoes*/    
IF ( @TipoPessoa = 'F' ) AND ( @IndIncConj = 0 ) AND ( @IndIncremento > 0 ) AND ( @IndPrefixo_Sufixo > 0 )    
BEGIN     
  IF ( @IndPrefixo_Sufixo = 1 ) OR ( @IndPrefixo_Sufixo = 2 ) OR ( @IndPrefixo_Sufixo = 5 )     
  BEGIN      
           
 IF EXISTS (SELECT 1 FROM ConfigRegistroConselho WHERE EhProfissional = 1 AND IdTipoInscricao = @IdTipoInscricao)    
  SELECT @IndPrefixo_Sufixo = PosicaoSigla    
    FROM ConfigRegistroConselho WHERE EhProfissional = 1 AND IdTipoInscricao = @IdTipoInscricao            
        
 IF EXISTS (SELECT 1 FROM ConfigRegistroConselho WHERE EhProfissional = 1 AND IdCategoria = @IdCategoria)    
      SELECT @IndPrefixo_Sufixo = PosicaoSigla    
     FROM ConfigRegistroConselho WHERE EhProfissional = 1 AND IdCategoria = @IdCategoria        
  END    

  IF ( @IndPrefixo_Sufixo = 3 ) OR ( @IndPrefixo_Sufixo = 4 ) OR ( @IndPrefixo_Sufixo = 6 )    
  BEGIN    
   IF EXISTS (SELECT 1 FROM ConfigRegistroConselho WHERE EhProfissional = 1 AND IdCategoria = @IdCategoria)    
     SELECT @IndPrefixo_Sufixo = PosicaoSigla    
       FROM ConfigRegistroConselho WHERE EhProfissional = 1 AND IdCategoria = @IdCategoria            
       
   IF EXISTS (SELECT 1 FROM ConfigRegistroConselho WHERE EhProfissional = 1 AND IdTipoInscricao = @IdTipoInscricao)    
   SELECT @IndPrefixo_Sufixo = PosicaoSigla    
     FROM ConfigRegistroConselho WHERE EhProfissional = 1 AND IdTipoInscricao = @IdTipoInscricao     
         
    
  END    
END    
  
  
IF ( @IndPrefixo_Sufixo = 1 ) OR ( @IndPrefixo_Sufixo = 2 ) OR ( @IndPrefixo_Sufixo = 5 ) /*Oc. 33305*/     
BEGIN      
  IF @TipoPessoa = 'F'      
    SELECT @Sigla = isnull(SiglaCategoriaProf,'')    
      
    FROM CategoriasProf      
     WHERE IdCategoriaProf = @IdCategoria      
      
  IF @TipoPessoa = 'J'      
    SELECT @Sigla = isnull(SiglaCategoriaPJ  ,'')    
      FROM CategoriasPJ      
     WHERE IdCategoriaPJ = @IdCategoria      
END      
      
IF ( @IndPrefixo_Sufixo = 3 ) OR ( @IndPrefixo_Sufixo = 4 ) OR ( @IndPrefixo_Sufixo = 6 ) /*Oc. 33305*/      
BEGIN      
  SELECT @Sigla = LTRIM( RTRIM( SiglaTipoInscricao ) )      
    FROM TiposInscricao      
   WHERE IdTipoInscricao = @IdTipoInscricao AND      
         SiglaTipoInscricao IS NOT  NULL      
END      
      
IF ( @IndPrefixo_Sufixo = 1 ) OR ( @IndPrefixo_Sufixo = 3 )      
  SET @Prefixo = @Sigla      
ELSE IF ( @IndPrefixo_Sufixo = 2 ) OR ( @IndPrefixo_Sufixo = 4 )   /*Oc. 33305*/    
  SET @Sufixo  = @Sigla    
    

CREATE TABLE #TempNumeroPF ( Registro CHAR( 15 ) )  /* Usada para a tabela Profissionais_CategoriasProf*/      
CREATE TABLE #TempNumeroPJ ( Registro CHAR( 15 ) )  /* Usada para a tabela PessoasJuridicas_CategoriaPJ */      

/* INCREMENTO INDEPENDENTE*/      
IF @IndIncremento = 1      
BEGIN      
  INSERT INTO #TempNumeroPF EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'Profissionais_CategoriasProf', 'RegistroConselho', ''      
  SELECT @Registro    = Registro from #TempNumeroPF      
      
  IF EXISTS( SELECT RegistroConselhoAtual FROM Profissionais WHERE RegistroConselhoAtual = @Registro )      
  BEGIN      
    DELETE #TempNumeroPF      
    INSERT INTO #TempNumeroPF EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'Profissionais', 'RegistroConselhoAtual', ''      
    SELECT @Registro  = Registro from #TempNumeroPF      
  END      
      
  INSERT INTO #TempNumeroPJ EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'PessoasJuridicas_CategoriaPJ', 'RegistroConselho', ''      
  SELECT @Registro2   = Registro from #TempNumeroPJ      
  IF EXISTS( SELECT RegistroConselhoAtual FROM PessoasJuridicas WHERE RegistroConselhoAtual = @Registro2 )      
  BEGIN      
    DELETE #TempNumeroPJ      
    INSERT INTO #TempNumeroPJ EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'PessoasJuridicas', 'RegistroConselhoAtual', ''      
    SELECT @Registro2 = Registro from #TempNumeroPJ      
  END      
      
  IF ( @IndIncConj = 0 ) AND ( @TipoPessoa = 'J' )      
    SET @Registro2 = @Registro      
      
  IF ( @IndIncConj = 1 )  /* Incremento em conjunto */      
  BEGIN      
    /* QUAL REGISTRO  O MAIOR */      
    IF @Registro IS NOT NULL      
    BEGIN      
      SET @Temp = @Registro      
      IF LEN( @Prefixo ) > 0      
        SET @Temp = SUBSTRING( @Temp, LEN( @Prefixo ) + 1, @TamanhoRegistro )      
      IF LEN( @Sufixo  ) > 0      
        SET @Temp = SUBSTRING( @Temp, 1, @TamanhoRegistro )      
      
      SET @ValorRegistroPF = CAST( @Temp AS INT )      
    END      
    IF @Registro2 IS NOT NULL      
    BEGIN      
      SET @Temp = @Registro2      
      IF LEN( @Prefixo ) > 0      
        SET @Temp = SUBSTRING( @Temp, LEN( @Prefixo ) + 1, @TamanhoRegistro )      
      IF LEN( @Sufixo  ) > 0      
        SET @Temp = SUBSTRING( @Temp, 1, @TamanhoRegistro )      
      
      SET @ValorRegistroPJ = CAST( @Temp AS INT )      
    END      
    IF @ValorRegistroPJ > @ValorRegistroPF      
      SET @Registro = @Registro2      
  END      
END      
ELSE      
BEGIN      
  IF ( @IndIncremento = 2 ) /*INCREMENTO DEPENDENTE DO TIPO DE PESSOA ( Ou Profissional, ou PJ )*/      
  BEGIN      
    --SELECT 'Enstroi', @IndIncremento      
      
    IF @TipoPessoa = 'F'    
    BEGIN      
      IF ( @IndPrefixo_Sufixo = 5 ) OR ( @IndPrefixo_Sufixo = 6 )     
        INSERT INTO #TempNumeroPF EXEC spProximoNumero_Entre @Sigla, @TamanhoRegistro, 'Profissionais_CategoriasProf', 'RegistroConselho', ''      
      ELSE    
       INSERT INTO #TempNumeroPF EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'Profissionais_CategoriasProf', 'RegistroConselho', ''      
      SELECT @Registro    = Registro from #TempNumeroPF      
      IF EXISTS( SELECT RegistroConselhoAtual FROM Profissionais WHERE RegistroConselhoAtual = @Registro )      
      BEGIN      
        DELETE #TempNumeroPF      
  IF ( @IndPrefixo_Sufixo = 5 ) OR ( @IndPrefixo_Sufixo = 6 )     
    INSERT INTO #TempNumeroPF EXEC spProximoNumero_Entre @Sigla, @TamanhoRegistro, 'Profissionais', 'RegistroConselhoAtual', ''      
        ELSE    
        /*DM52971-Inicio*******************************************************/    
        BEGIN    
          IF @TamanhoNumRegistroProf > 0    
      SET @Where = 'LEN(RegistroConselhoAtual) = ' + CAST(@TamanhoRegistro AS VARCHAR(15))    
          INSERT INTO #TempNumeroPF EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'Profissionais', 'RegistroConselhoAtual', @Where      
        END    
        /*DM52971-Fim***********************************************************/             
        SELECT @Registro  = Registro from #TempNumeroPF      
      END      
    END      
  ELSE      
    BEGIN      
      INSERT INTO #TempNumeroPJ EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'PessoasJuridicas_CategoriaPJ', 'RegistroConselho', ''      
      SELECT @Registro   = Registro from #TempNumeroPJ      
      IF EXISTS( SELECT RegistroConselhoAtual FROM PessoasJuridicas WHERE RegistroConselhoAtual = @Registro )      
      BEGIN     
       /*DM52971-Inicio*******************************************************/    
        IF @TamanhoNumRegistroPJ > 0    
   SET @Where = 'LEN(RegistroConselhoAtual) = ' + CAST(@TamanhoRegistro AS VARCHAR(15))    
        DELETE #TempNumeroPJ      
        INSERT INTO #TempNumeroPJ EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'PessoasJuridicas', 'RegistroConselhoAtual', @Where      
        /*DM52971-Fim***********************************************************/     
        SELECT @Registro  = Registro from #TempNumeroPJ      
      END      
    END      
  END      
      
  IF @IndIncremento = 3 /*INCREMENTO POR CATEGORIA */      
  BEGIN     
   /*PRINT @IndPrefixo_Sufixo */    
    IF @TipoPessoa = 'F'      
    BEGIN     
      SET @Categoria = (SELECT NomeCategoriaProf FROM CategoriasProf WHERE IdCategoriaProf = @IdCategoria)       
      SET @Where = ' IdCategoriaProf = ' + CAST (@IdCategoria AS VARCHAR(10))   

     IF ( @IndPrefixo_Sufixo = 3 ) OR ( @IndPrefixo_Sufixo = 4 ) OR ( @IndPrefixo_Sufixo = 6 )   /*Italo */    
       BEGIN  
			-- Implementação  para o CRQ/RJ quando o tipo de inscrição for LICENÇA PROVISÓRIA 
			-- haverá uma numeração especifica considerando a categoria e o prefixo da categoria.
			-- Para os demais tipos de inscrição só 
			IF @SiglaConselho='CRQRJ'  
			BEGIN
				IF @IdTipoInscricao=2
					BEGIN                
						INSERT INTO #TempNumeroPF  
						SELECT MAX( RIGHT( REPLICATE( '0',@TamanhoNumRegistroProf ) + CAST( CAST( SUBSTRING(  REPLACE( dbo.FNUMEROS(RegistroConselho), '.', '' ), 1, LEN( REPLACE( RegistroConselho, '.', '' ) ) ) AS BIGINT ) + 1 AS VARCHAR(10) ),@TamanhoNumRegistroProf ) ) AS Proximo    
						FROM Profissionais_CategoriasProf  
						WHERE  IdCategoriaProf =  @IdCategoria and IdTipoInscricao=@IdTipoInscricao and LEFT(RegistroConselho,LEN(@Prefixo))= @Prefixo
					END
					ELSE 
					BEGIN
						INSERT INTO #TempNumeroPF  
						SELECT MAX( RIGHT( REPLICATE( '0',@TamanhoNumRegistroProf ) + CAST( CAST( SUBSTRING(  REPLACE( dbo.FNUMEROS(RegistroConselho), '.', '' ), 1, LEN( REPLACE( RegistroConselho, '.', '' ) ) ) AS BIGINT ) + 1 AS VARCHAR(10) ),@TamanhoNumRegistroProf ) ) AS Proximo    
						FROM Profissionais_CategoriasProf  
						WHERE  IdCategoriaProf =  @IdCategoria and LEFT(RegistroConselho,LEN(@Prefixo))= @Prefixo
					
					END
			END
			ELSE
			BEGIN
				INSERT INTO #TempNumeroPF  
				SELECT MAX( RIGHT( REPLICATE( '0',@TamanhoNumRegistroProf ) + CAST( CAST( SUBSTRING(  REPLACE( dbo.FNUMEROS(RegistroConselho), '.', '' ), 1, LEN( REPLACE( RegistroConselho, '.', '' ) ) ) AS BIGINT ) + 1 AS VARCHAR(10) ),@TamanhoNumRegistroProf ) ) AS Proximo    
				FROM Profissionais_CategoriasProf  
				WHERE  IdCategoriaProf =  @IdCategoria 
			END          
        /*INSERT INTO #TempNumeroPF EXEC spProximoNumero '', '', @TamanhoRegistro, '', 'Profissionais_CategoriasProf', 'RegistroConselho',  @Where      */    
			SELECT @Registro  = @Prefixo + isnull(Rtrim( LTrim(Registro)),REPLICATE( '0',@TamanhoNumRegistroProf )+'1') + @Sufixo    from #TempNumeroPF   
                 
        /*PRINT @Where*/    
       END     
       ELSE    
        BEGIN             
			   IF ( @IndPrefixo_Sufixo = 5 ) /*OR ( @IndPrefixo_Sufixo = 6 ) */    
				   INSERT INTO #TempNumeroPF EXEC spProximoNumero_Entre @Sigla, @TamanhoRegistro, 'Profissionais_CategoriasProf', 'RegistroConselho', @Where      
			   ELSE    
				  /*IF (@Prefixo ='' AND  @Sufixo ='' )     
				   INSERT INTO #TempNumeroPF  SELECT MAX( RIGHT( REPLICATE( '0',@TamanhoNumRegistroProf ) + CAST( CAST( SUBSTRING(  REPLACE( dbo.FNUMEROS(RegistroConselho), '.', '' ), 1, LEN( REPLACE( RegistroConselho, '.', '' ) ) ) AS INT ) + 1 AS VARCHAR(10) ),@Tam
			anhoNumRegistroProf ) ) AS Proximo    
				  FROM Profissionais_CategoriasProf  Where  IdCategoriaProf =  + CAST (@IdCategoria AS VARCHAR(10))                 
				 ELSE*/      
				INSERT INTO #TempNumeroPF EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'Profissionais_CategoriasProf', 'RegistroConselho',  @Where     
			   SELECT @Registro  = Registro from #TempNumeroPF      
        END       
 	
 		IF EXISTS( SELECT RegistroConselhoAtual FROM Profissionais WHERE RegistroConselhoAtual = @Registro AND CategoriaAtual = @Categoria)      
			  BEGIN      
				DELETE #TempNumeroPF      
				SET @Where = ' CategoriaAtual = '' + @Categoria + '''    
				IF ( @IndPrefixo_Sufixo = 5 ) OR ( @IndPrefixo_Sufixo = 6 )     
					INSERT INTO #TempNumeroPF EXEC spProximoNumero_Entre @Sigla, @TamanhoRegistro, 'Profissionais', 'RegistroConselhoAtual', @Where      
				ELSE    
					INSERT INTO #TempNumeroPF EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'Profissionais', 'RegistroConselhoAtual', @Where      

				SELECT @Registro  = Registro from #TempNumeroPF      
			  END      
            
    END      
    ELSE      
    BEGIN     
      SET @Categoria = (SELECT NomeCategoriaPJ FROM CategoriasPJ WHERE IdCategoriaPJ = @IdCategoria)    
      SET @Where = ' IdCategoriaPJ = ' + CAST (@IdCategoria AS VARCHAR(10))      
      INSERT INTO #TempNumeroPJ EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'PessoasJuridicas_CategoriaPJ', 'RegistroConselho', @Where      
      SELECT @Registro   = Registro from #TempNumeroPJ      
      IF EXISTS( SELECT RegistroConselhoAtual FROM PessoasJuridicas WHERE RegistroConselhoAtual = @Registro AND CategoriaAtual = @Categoria)      
      BEGIN      
        DELETE #TempNumeroPJ      
		SET @Where = ' CategoriaAtual = '' + @Categoria + '''    
        INSERT INTO #TempNumeroPJ EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'PessoasJuridicas', 'RegistroConselhoAtual', @Where      
        SELECT @Registro  = Registro from #TempNumeroPJ      
      END      
           
    END      
  END   
     
  IF @IndIncremento = 4 /*INCREMENTO POR TIPO DE INSCRICAO*/    
  BEGIN      
    SET @Where = ' IdTipoInscricao = ' + CAST (@IdTipoInscricao AS VARCHAR(10))    
	IF ( @IndPrefixo_Sufixo = 5 ) OR ( @IndPrefixo_Sufixo = 1 ) OR ( @IndPrefixo_Sufixo = 2 )   
    BEGIN    
      INSERT INTO #TempNumeroPF  SELECT MAX( RIGHT( REPLICATE( '0',@TamanhoNumRegistroProf ) + CAST( CAST( SUBSTRING(  REPLACE( dbo.FNUMEROS(RegistroConselho), '.', '' ), 1, LEN( REPLACE( RegistroConselho, '.', '' ) ) ) AS INT ) + 1 AS VARCHAR(10) ),@TamanhoNumRegistroProf ) ) AS Proximo  
        FROM Profissionais_CategoriasProf  Where  IdTipoInscricao = CAST (@IdTipoInscricao AS VARCHAR(10))          
		/*EXEC spProximoNumero '', '', @TamanhoRegistro, '', 'Profissionais_CategoriasProf', 'RegistroConselho',  @Where      */  
		SELECT @Registro  = @Prefixo + isnull(Rtrim( LTrim(Registro)),REPLICATE( '0',@TamanhoNumRegistroProf )+'1')  + @Sufixo    from #TempNumeroPF                        
		/*PRINT @Sufixo */  
    END  
    ELSE   
    BEGIN   
		IF /*( @IndPrefixo_Sufixo = 5 ) OR */ ( @IndPrefixo_Sufixo = 6 )   
			INSERT INTO #TempNumeroPF EXEC spProximoNumero_Entre @Sigla, @TamanhoRegistro, 'Profissionais_CategoriasProf', 'RegistroConselho', @Where    
    ELSE       
		IF (@Prefixo ='' AND  @Sufixo ='' )  
			IF @WhereAdicional <> ''
				EXEC('INSERT INTO #TempNumeroPF  SELECT MAX( RIGHT( REPLICATE( ''0'',' + @TamanhoNumRegistroProf + ' ) + CAST( CAST( SUBSTRING(  REPLACE( dbo.FNUMEROS(RegistroConselho), ''.'', '''' ), 1, LEN( REPLACE( RegistroConselho, ''.'', '''' ) ) ) AS INT ) + 1 AS VARCHAR(10) ), ' + @TamanhoNumRegistroProf + ' ) ) AS Proximo  
				FROM Profissionais_CategoriasProf  Where  IdTipoInscricao = CAST (' + @IdTipoInscricao + ' AS VARCHAR(10))  
				AND ' + @WhereAdicional)       		
			ELSE
				INSERT INTO #TempNumeroPF  SELECT MAX( RIGHT( REPLICATE( '0',@TamanhoNumRegistroProf ) + CAST( CAST( SUBSTRING(  REPLACE( dbo.FNUMEROS(RegistroConselho), '.', '' ), 1, LEN( REPLACE( RegistroConselho, '.', '' ) ) ) AS BIGINT ) + 1 AS VARCHAR(10) ),@TamanhoNumRegistroProf ) ) AS Proximo  
				FROM Profissionais_CategoriasProf  Where  IdTipoInscricao = CAST (@IdTipoInscricao AS VARCHAR(10))       
     ELSE   
     BEGIN  
     	IF @WhereAdicional <> ''
     		SET @Where = @Where + ' AND ' + @WhereAdicional 
		INSERT INTO #TempNumeroPF EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'Profissionais_CategoriasProf', 'RegistroConselho', @Where   
     END
    SELECT @Registro  = Registro from #TempNumeroPF    
    /*    
    IF EXISTS( SELECT RegistroConselhoAtual FROM Profissionais WHERE RegistroConselhoAtual = @Registro)    
    BEGIN    
      DELETE #TempNumeroPF    
      INSERT INTO #TempNumeroPF EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'Profissionais', 'RegistroConselhoAtual'  
      SELECT @Registro  = Registro from #TempNumeroPF    
    END    
    */    
    INSERT INTO #TempNumeroPJ EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'PessoasJuridicas_CategoriaPJ', 'RegistroConselho', @Where    
    SELECT @Registro2 = Registro from #TempNumeroPJ    
    END   
    /*    
    IF EXISTS( SELECT RegistroConselhoAtual FROM PessoasJuridicas WHERE RegistroConselhoAtual = @Registro2 )    
    BEGIN    
      DELETE #TempNumeroPJ    
      INSERT INTO #TempNumeroPJ EXEC spProximoNumero @Prefixo, @Sufixo, @TamanhoRegistro, '', 'PessoasJuridicas', 'RegistroConselhoAtual', ''    
      SELECT @Registro2  = Registro from #TempNumeroPJ    
    END    
    */     
    IF ( @IndIncConj = 1 )    
    BEGIN    
      /* QUAL REGISTRO  O MAIOR */    
      IF @Registro IS NOT NULL    
      BEGIN    
        SET @Temp = @Registro    
        IF LEN( @Prefixo ) > 0    
          SET @Temp = SUBSTRING( @Temp, LEN( @Prefixo ) + 1, @TamanhoRegistro )    
        IF LEN( @Sufixo ) > 0    
          SET @Temp = SUBSTRING( @Temp, 1, @TamanhoRegistro )    
            
        SET @ValorRegistroPF = CAST( @Temp AS INT )    
      END    
    
      IF @Registro2 IS NOT NULL    
      BEGIN    
        SET @Temp = @Registro2    
        IF LEN( @Prefixo ) > 0    
          SET @Temp = SUBSTRING( @Temp, LEN( @Prefixo ) + 1, @TamanhoRegistro )    
    
        IF LEN( @Sufixo ) > 0    
          SET @Temp = SUBSTRING( @Temp, 1, @TamanhoRegistro )    
    
        SET @ValorRegistroPJ = CAST( @Temp AS INT )    
      END    
      IF @ValorRegistroPJ > @ValorRegistroPF    
        SET @Registro = @Registro2    
    END    
    IF ( @TipoPessoa = 'J') AND ( @IndIncConj = 0 )    
      SET @Registro = @Registro2    
  END          
END            
IF @IndIncremento IS NOT NULL       
BEGIN     
     
  IF @Registro is null      
    SET @Registro = '1'        
    
END      
      
--SELECT Registro = @Registro      
DROP TABLE #TempNumeroPF      
DROP TABLE #TempNumeroPJ
