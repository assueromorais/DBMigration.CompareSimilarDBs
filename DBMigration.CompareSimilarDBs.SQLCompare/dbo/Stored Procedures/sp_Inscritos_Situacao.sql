				
-- ============================================================================
--	sp_Inscritos_Situacao
-- ============================================================================	
CREATE PROCEDURE [dbo].[sp_Inscritos_Situacao]
	@tipoPessoa VARCHAR(10),
	@idSubRegiao VARCHAR(10),
	@Situacao VARCHAR(150),
	@Sigla VARCHAR(7)
AS
BEGIN
	SET NOCOUNT ON         
	
	DECLARE @FOR                VARCHAR(1000),
	        @Separador          VARCHAR(5),
	        @idsit              INT,
	        @sit                VARCHAR(150),
	        @idNomePFPJ         VARCHAR(30),
	        @sitWhere           VARCHAR(1000),
	        @Sub                VARCHAR(150),
	        @subWhere           VARCHAR(1000),
	        @Select             VARCHAR(8000),
	        @SelectSum          VARCHAR(1000),
	        @selectTotalizador  VARCHAR(1000),
	        @Where              VARCHAR(1000)        
	
	SET @FOR = ''        
	IF @tipoPessoa = 'PJ'
	BEGIN
	    SET @idNomePFPJ = ' IdPessoaJuridica'
	END
	ELSE
	BEGIN
	    SET @idNomePFPJ = ' IdProfissional'
	END         
	
	SET @Separador = ''        
	SET @Select = ' '        
	SET @SelectSum = ' '        
	SET @selectTotalizador = ' '        
	SET @sitWhere = ''        
	
	CREATE TABLE #sitTemp
	(
		situacao VARCHAR(150)
	)        
	
	
	CREATE TABLE #SubTemp
	(
		SubRegiao INT
	)        
	INSERT INTO #SubTemp
	SELECT @idSubRegiao        
	
	IF @Situacao <> '0'
	BEGIN
	    INSERT INTO #sitTemp
	    SELECT @Situacao
	END          
	
	
	SET @SubWhere = ''        
	
	IF @idSubRegiao <> '0'
	    SET @SubWhere = ' WHERE PF.IdSubRegiao = ' + @idSubRegiao            
	
	IF @idSubRegiao <> '0'
	   AND @Situacao <> '0'
	BEGIN
	    DECLARE p_Cursor CURSOR FAST_FORWARD 
	    FOR
	        SELECT IdSituacaoPFPJ,
	               NomeSituacao
	        FROM   SituacoesPFPJ
	        WHERE  NomeSituacao COLLATE SQL_Latin1_General_CP1_CI_AI IN (SELECT 
	                                                                            situacaoAtual 
	                                                                            COLLATE 
	                                                                            SQL_Latin1_General_CP1_CI_AI
	                                                                     FROM   
	                                                                            profissionais
	                                                                     WHERE  
	                                                                            Profissionais.IdSubRegiao IN (SELECT 
	                                                                                                                 SubRegiao
	                                                                                                          FROM   
	                                                                                                                 #SubTemp))
	               AND NomeSituacao COLLATE SQL_Latin1_General_CP1_CI_AI IN (SELECT 
	                                                                                situacao 
	                                                                                COLLATE 
	                                                                                SQL_Latin1_General_CP1_CI_AI
	                                                                         FROM   
	                                                                                #sitTemp)
	        ORDER BY
	               NomeSituacao 
	    
	    OPEN p_Cursor 
	    FETCH NEXT FROM p_Cursor 
	    INTO @idSit,@sit
	END        
	
	IF @idSubRegiao <> '0'
	   AND @Situacao = '0'
	BEGIN
	    DECLARE p_Cursor CURSOR FAST_FORWARD 
	    FOR
	        SELECT IdSituacaoPFPJ,
	               NomeSituacao
	        FROM   SituacoesPFPJ
	        WHERE  NomeSituacao IN (SELECT situacaoAtual
	                                FROM   profissionais
	                                WHERE  Profissionais.IdSubRegiao IN (SELECT 
	                                                                            SubRegiao
	                                                                     FROM   
	                                                                            #SubTemp))
	        ORDER BY
	               NomeSituacao 
	    
	    OPEN p_Cursor 
	    FETCH NEXT FROM p_Cursor 
	    INTO @idSit,@sit
	END        
	
	IF @idSubRegiao = '0'
	   AND @Situacao <> '0'
	BEGIN
	    DECLARE p_Cursor CURSOR FAST_FORWARD 
	    FOR
	        SELECT IdSituacaoPFPJ,
	               NomeSituacao
	        FROM   SituacoesPFPJ
	        WHERE  NomeSituacao COLLATE SQL_Latin1_General_CP1_CI_AI IN (SELECT 
	                                                                            situacaoAtual 
	                                                                            COLLATE 
	                                                                            SQL_Latin1_General_CP1_CI_AI
	                                                                     FROM   
	                                                                            profissionais)
	               AND NomeSituacao COLLATE SQL_Latin1_General_CP1_CI_AI IN (SELECT 
	                                                                                situacao 
	                                                                                COLLATE 
	                                                                                SQL_Latin1_General_CP1_CI_AI
	                                                                         FROM   
	                                                                                #sitTemp)
	        ORDER BY
	               NomeSituacao 
	    
	    OPEN p_Cursor 
	    FETCH NEXT FROM p_Cursor 
	    INTO @idSit,@sit
	END
	
	IF @idSubRegiao = '0'
	   AND @Situacao = '0'
	BEGIN
	    DECLARE p_Cursor CURSOR FAST_FORWARD 
	    FOR
	        SELECT IdSituacaoPFPJ,
	               NomeSituacao
	        FROM   SituacoesPFPJ
	        WHERE  NomeSituacao IN (SELECT situacaoAtual
	                                FROM   profissionais)
	        ORDER BY
	               NomeSituacao 
	    
	    OPEN p_Cursor 
	    FETCH NEXT FROM p_Cursor 
	    INTO @idSit,@sit
	END          
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    SET @Select = @Select + @Separador + '[' + @sit + ']' +
	        ' = count(case when  IdSituacaoPFPJ = ' + CAST(@idSit AS VARCHAR) +
	        '  then #TMPCOntagem.Nome end )'
	    
	    SET @Separador = ',' 
	    FETCH NEXT FROM p_Cursor 
	    INTO @idSit,@sit
	END 
	CLOSE p_Cursor 
	DEALLOCATE p_Cursor 
	
	DROP TABLE #sitTemp 
	DROP TABLE #SubTemp        
	
	EXEC (
	         'SELECT PF.IdProfissional, PFS.IdSituacaoPFPJ, PS.Nome        
							INTO #TMPCOntagem        
						  FROM  Profissionais PF
										LEFT JOIN   Pessoas PS ON PF.IdSubRegiao = PS.IdPessoa
										JOIN SituacoesPFPJ PFS ON PF.SituacaoAtual = PFS.NomeSituacao ' 
	         + @SubWhere +
	         ' select Nome as [RegiÃ£o],' + @Select +
	         'from #TMPCOntagem GROUP BY #TMPCOntagem.Nome '
	     )
END
