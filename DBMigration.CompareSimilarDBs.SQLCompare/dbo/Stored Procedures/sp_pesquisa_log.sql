/*Oc. 64821 - ZeMario 
 * Criacao da SP*/ 
 
CREATE PROCEDURE [dbo].[sp_pesquisa_log]( 
    @dataInicio        DATETIME, 
    @dataTermino       DATETIME, 
    @Id_assunto        SMALLINT, 
    @Id_Tipo_Operacao  TINYINT, 
    @Id_Usuario        SMALLINT, 
    @Id_Campo_Log      SMALLINT, 
    @Valor_Campo       SQL_VARIANT 
) 
AS 
 
 
	DECLARE @comando                    VARCHAR(4000), 
	        @comando_Anterior           SMALLINT, 
	        @Id_Tabela                  SMALLINT, 
	        @Tabela                     VARCHAR(128), 
	        @Data_Atualizacao           DATETIME, 
	        @Id_Banco_Dados             SMALLINT, 
	        @Id_Tipo_Operacao_Res       TINYINT, 
	        @Nome_Campo_Chave           VARCHAR(128), 
	        @Id_Usuario_Log             SMALLINT, 
	        @Chave_Registro             SQL_VARIANT, 
	        @Valor_Campo_Ant            SQL_VARIANT, 
	        @Valor_Campo_Atual          SQL_VARIANT, 
	        @cab_Cont_Atual             SMALLINT, 
	        @cab_Cont_Ant               SMALLINT, 
	        @cab_Campo                  SMALLINT, 
	        @cab_Usuario                SMALLINT, 
	        @cab_chave                  SMALLINT, 
	        @cab_Tabela                 SMALLINT, 
	        @cab_data                   SMALLINT, 
	        @Nome_Banco_Dados           VARCHAR(128), 
	        @Campo1                     VARCHAR(100), 
	        @Campo2                     VARCHAR(100), 
	        @Campo3                     VARCHAR(100), 
	        @Campo4                     VARCHAR(100), 
	        @Campo5                     VARCHAR(100), 
	        @Campo6                     VARCHAR(100), 
	        @Campo7                     VARCHAR(100), 
	        @Campo8                     VARCHAR(100), 
	        @Campo9                     VARCHAR(100), 
	        @Campo10                    VARCHAR(100), 
	        @Campo11                    VARCHAR(100), 
	        @Campo12                    VARCHAR(100), 
	        @Campo13                    VARCHAR(100), 
	        @Campo14                    VARCHAR(100), 
	        @Campo15                    VARCHAR(100), 
	        @Campo16                    VARCHAR(100), 
	        @Campo17                    VARCHAR(100), 
	        @Campo18                    VARCHAR(100), 
	        @Campo19                    VARCHAR(100), 
	        @Campo20                    VARCHAR(100), 
	        @Nome_Campo                 VARCHAR(100), 
	        @Nome_Titulo                VARCHAR(100), 
	        @Qtde_Registro              SMALLINT, 
	        @Campo_Aux                  VARCHAR(100), 
	        @Array_Id_Cabecalho         VARCHAR(200), 
	        @i                          SMALLINT, 
	        @Tipo_Campo                 CHAR(1), 
	        @qtde_cabecalho_variavel    SMALLINT, 
	        @Id_chave_tabela            SMALLINT, 
	        @Id_Cabecalho               SMALLINT, 
	        @Id_Resultado               SMALLINT, 
	        @Id_CabVariavel             VARCHAR(4), 
	        @Array_Id_Resultado         VARCHAR(200), 
	        @Qtde_Tabela_Envolvida      SMALLINT, 
	        @IdTipoDominio              TINYINT, 
	        @Chave_Registro_ant         SQL_VARIANT, 
	        @cab_exclusao               SMALLINT, 
	        @Retorno_modo_Apresentacao  SMALLINT 
	 
	 
	CREATE TABLE #Resultado_Pesquisa 
	( 
		Id_log             INT, 
		Data_Atualizacao   DATETIME, 
		Id_Banco_Dados     SMALLINT, 
		Id_Tabela          SMALLINT, 
		Id_Tipo_Operacao   TINYINT, 
		Id_Usuario_Log     SMALLINT, 
		Id_Campo_log       SMALLINT, 
		Chave_Registro     SQL_VARIANT, 
		Valor_Campo_Ant    SQL_VARIANT, 
		Valor_Campo_Atual  SQL_VARIANT 
	) 
	 
	 
	CREATE TABLE #Resultado 
	( 
		TipoRegistro  SMALLINT, 
		Campo1        VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo2        VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo3        VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo4        VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo5        VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo6        VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo7        VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo8        VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo9        VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo10       VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo11       VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo12       VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo13       VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo14       VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo15       VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo16       VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo17       VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo18       VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo19       VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Campo20       VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS 
	) 
		CREATE TABLE #Tab_Campo_Variavel  ( 
	            Id_CabVariavel SMALLINT, 
	            Campo_Variavel VARCHAR(1000) COLLATE SQL_Latin1_General_CP1_CI_AS 
 
	        ) 
	 
	CREATE TABLE #Cabecalho_Resultado 
	( 
		Id_Resultado     INT IDENTITY(1, 1), 
		Nome_Campo       VARCHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Nome_Titulo      VARCHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AS, 
		Tipo_Campo       CHAR(1), 
		Id_chave_tabela  SMALLINT 
	) 
	SET @comando_Anterior = 0 
	SET @comando =  
	    'Insert into #Resultado_Pesquisa 
Select t1.Id_log,Data_Atualizacao,Id_Banco_Dados,Id_Tabela,Id_Tipo_Operacao, 
Id_Usuario_Log,Id_Campo_log,Chave_Registro,Valor_Campo_Ant,Valor_Campo_Atual 
From ImplantaLog.dbo.Log_Aplicacao t1 left join ImplantaLog.dbo.Log_Aplicacao_Detalhe t2 on t1.Id_log=t2.Id_log ' 
	 
	IF (@dataInicio IS NOT NULL AND @dataTermino IS NOT NULL) 
	   OR (@Id_assunto IS NOT NULL) 
	   OR (@Id_Tipo_Operacao IS NOT NULL) 
	   OR (@Id_Usuario IS NOT NULL) 
	BEGIN 
	    SET @comando = @comando + ' Where ' 
	END 
	 
	IF (@dataInicio IS NOT NULL AND @dataTermino IS NOT NULL) 
	BEGIN 
	    IF @dataTermino IS NULL 
	    BEGIN 
	        SET @dataTermino = @dataInicio 
	    END 
	     
	    SET @comando = @comando + ' Data_Atualizacao between ' + CHAR(39) + 
	        CONVERT(VARCHAR(20), @dataInicio, 120) + CHAR(39) + ' and ' + CHAR(39)  
	        + CONVERT(VARCHAR(20), @dataTermino, 120) + CHAR(39) 
	     
	    SET @comando_Anterior = 1 
	END 
	 
	IF (@Id_assunto IS NOT NULL) 
	BEGIN 
	    IF @comando_Anterior = 1 
	    BEGIN 
	        SET @comando = @comando + ' and ' 
	    END 
	     
	    SET @comando = @comando + ' Id_Tabela in ( ' 
	    DECLARE cur_assunto CURSOR   
	    FOR 
	        SELECT Id_Tabela 
	        FROM   ImplantaLog.dbo.Assunto_Tabela_Log t1 
	        WHERE  t1.Id_Assunto = @Id_assunto 
	     
	    OPEN cur_assunto 
	    FETCH NEXT FROM cur_assunto INTO @Id_Tabela 
	    WHILE @@FETCH_STATUS = 0 
	    BEGIN 
	        SET @comando = @comando + CONVERT(VARCHAR(5), @Id_Tabela) 
	        FETCH NEXT FROM cur_assunto INTO @Id_Tabela 
	        IF @@FETCH_STATUS = 0 
	            SET @comando = @comando + ',' 
	    END 
	    CLOSE cur_assunto 
	    DEALLOCATE cur_assunto 
	    SET @comando = @comando + ')' 
	    SET @comando_Anterior = 1 
	END 
	 
	IF (@Id_Tipo_Operacao IS NOT NULL) 
	BEGIN 
	    IF @comando_Anterior = 1 
	    BEGIN 
	        SET @comando = @comando + ' and ' 
	    END 
	     
	    SET @comando = @comando + ' Id_Tipo_Operacao = ' + CONVERT(CHAR(1), @Id_Tipo_Operacao) 
	    SET @comando_Anterior = 1 
	END 
	 
	IF (@Id_Usuario IS NOT NULL) 
	BEGIN 
	    IF @comando_Anterior = 1 
	    BEGIN 
	        SET @comando = @comando + ' and ' 
	    END 
	     
	    SET @comando = @comando + ' Id_Usuario_log = ' + CONVERT(VARCHAR(5), @Id_Usuario) 
	    SET @comando_Anterior = 1 
	END 
	 
	IF (@Id_Campo_Log IS NOT NULL) 
	BEGIN 
	    IF @comando_Anterior = 1 
	    BEGIN 
	        SET @comando = @comando + ' and ' 
	    END 
	     
	    SET @comando = @comando + ' Id_Campo_log = ' + CONVERT(VARCHAR(5), @Id_Campo_Log) 
	    SET @comando_Anterior = 1 
	END 
	 
	IF (@Valor_Campo IS NOT NULL) 
	   AND (@Id_Campo_Log IS NOT NULL) 
	BEGIN 
	    IF @comando_Anterior = 1 
	    BEGIN 
	        SET @comando = @comando + ' and ' 
	    END 
	     
	    SET @comando = @comando + 
	        ' (Convert (varchar(200),Valor_Campo_Atual) like ' + CHAR(39) + 
	        CONVERT(VARCHAR(200), @Valor_Campo) + '%' + CHAR(39) 
	     
	    SET @comando = @comando + 
	        ' OR Convert (varchar(200),Valor_Campo_Ant) like ' + CHAR(39) + 
	        CONVERT(VARCHAR(200), @Valor_Campo) + '%' + CHAR(39) + ')' 
	     
	    SET @comando_Anterior = 1 
	END 
	--SELECT @Comando 
	EXEC (@Comando) 
	 
	IF (@Id_Campo_Log IS NOT NULL) 
	   AND @Id_Tipo_Operacao = 3 
	BEGIN 
	    UPDATE ImplantaLog.dbo.Campo_Log 
	    SET    ApresentaCampoExclusao = 'S' 
	    FROM   ImplantaLog.dbo.Campo_Log 
	    WHERE  Id_Campo_Log = @Id_Campo_Log 
	     
	    SET @Retorno_modo_Apresentacao = 1 
	END 
	 
	IF @Id_Tipo_Operacao IN (1, 2) 
	BEGIN 
	    DELETE #Resultado_Pesquisa 
	    FROM   #Resultado_Pesquisa t1, 
	           ImplantaLog.dbo.Campo_Log t2 
	    WHERE  t1.Id_Campo_log = t2.Id_Campo_Log 
	           AND t2.ApresentaCampo = 'N' 
	END 
	 
	IF @Id_Tipo_Operacao = 3 
	BEGIN 
	    DELETE #Resultado_Pesquisa 
	    FROM   #Resultado_Pesquisa t1, 
	           ImplantaLog.dbo.Campo_Log t2 
	    WHERE  t1.Id_Campo_log = t2.Id_Campo_Log 
	           AND t2.ApresentaCampoExclusao = 'N' 
	END 
	 
	IF @Id_Tipo_Operacao IN (1, 2) -- Somente será preenchido os campos variáveis para inclusão e alteração 
	BEGIN 
	    INSERT INTO #Cabecalho_Resultado (Nome_Campo, Nome_Titulo, Tipo_Campo) 
	    SELECT Nome_Campo_Cabecalho, 
	           Nome_Campo_Cabecalho, 
	           'V' 
	    FROM   ImplantaLog.dbo.Assunto_Tabela_Log t1, 
	           ImplantaLog.dbo.Cabecalho_Tabela_Log t2 
	    WHERE  t1.Id_Tabela = t2.Id_Tabela 
	           AND t1.Id_Assunto = @Id_assunto 
	    GROUP BY 
	           Ordem_Apresentacao, 
	           Nome_Campo_Cabecalho 
	    ORDER BY 
	           Ordem_Apresentacao 
	END 
	 
	INSERT INTO #Cabecalho_Resultado (Nome_Titulo, Tipo_Campo)  
	     VALUES ('Tabela', 'F') 
	SET @cab_Tabela = @@IDENTITY 
	IF @Id_Tipo_Operacao IN (1, 2) -- Somente para inclusão e alteração 
	BEGIN 
	    INSERT INTO #Cabecalho_Resultado (Nome_Titulo, Tipo_Campo)  
	         VALUES ('Campo', 'F') 
	    SET @cab_Campo = @@IDENTITY 
	END 
	 
	IF @Id_Tipo_Operacao = 2 -- Somente para alteração 
	BEGIN 
	    INSERT INTO #Cabecalho_Resultado (Nome_Titulo, Tipo_Campo)  
	         VALUES ('Conteúdo Anterior', 'F') 
	    SET @cab_Cont_Ant = @@IDENTITY 
	    INSERT INTO #Cabecalho_Resultado (Nome_Titulo, Tipo_Campo)  
	         VALUES ('Conteúdo Atual', 'F') 
	    SET @cab_Cont_Atual = @@IDENTITY 
	END 
	 
	IF @Id_Tipo_Operacao IN (1, 2) -- Somente para inclusão e alteração 
	BEGIN 
	    INSERT INTO #Cabecalho_Resultado (Nome_Titulo, Tipo_Campo)  
	         VALUES ('Data Atualização', 'F') 
	    SET @cab_data = @@IDENTITY 
	END 
	 
	IF @Id_Tipo_Operacao = 3 -- Somente para Exclusão 
	BEGIN 
	    INSERT INTO #Cabecalho_Resultado (Nome_Titulo, Tipo_Campo)  
	         VALUES ('Data Exclusão', 'F') 
	    SET @cab_data = @@IDENTITY 
	END 
	 
	INSERT INTO #Cabecalho_Resultado (Nome_Titulo, Tipo_Campo)  
	     VALUES ('Usuario', 'F') 
	SET @cab_Usuario = @@IDENTITY 
	IF @Id_Tipo_Operacao = 3 -- Campos Exclusão 
	BEGIN 
	    INSERT INTO #Cabecalho_Resultado (Nome_Campo, Nome_Titulo, Tipo_Campo,  
	           Id_chave_tabela) 
	    SELECT Nome_Campo, 
	           Nome_Titulo, 
	           'E', 
	           Id_Campo_Log 
	    FROM   ImplantaLog.dbo.Campo_Log t1, 
	           ImplantaLog.dbo.Assunto_Tabela_Log t2 
	    WHERE  t1.Id_Tabela = t2.Id_Tabela 
	           AND t2.Id_Assunto = @Id_Assunto 
	           AND ( 
	                   t1.ApresentaCampoExclusao IS NULL 
	                   OR t1.ApresentaCampoExclusao = 'S' 
	               ) 
	END 
	 
	           		 
	DECLARE cur_cabecalho       CURSOR   
	FOR 
	    SELECT Id_Resultado, 
	           Nome_Titulo      = CASE  
	                              WHEN Nome_Titulo IS NULL THEN SUBSTRING(Nome_Campo, 1, 100) 
	                              ELSE SUBSTRING(Nome_Titulo, 1, 100) 
	                         END, 
	           Tipo_Campo, 
	           Id_chave_tabela   
	    FROM   #Cabecalho_Resultado 
	    ORDER BY 
	           Id_Resultado 
	 
	OPEN cur_cabecalho 
	 
	FETCH NEXT FROM cur_cabecalho INTO @Id_Resultado,@Nome_Titulo,@Tipo_Campo,@Id_chave_tabela                                                                                                                                 
	SET @Qtde_Registro = 0 
	IF @Tipo_Campo = 'V' 
	BEGIN 
	    SET @Array_Id_Resultado = REPLICATE('0', 4 -LEN(CONVERT(VARCHAR(4), @Id_Resultado)))  
	        + CONVERT(VARCHAR(4), @Id_Resultado) 
	END 
	 
	WHILE @@FETCH_STATUS = 0 
	BEGIN 
	    SET @Qtde_Registro = @Qtde_Registro + 1 
	    IF @Qtde_Registro = 1 
	        SET @Campo1 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 2 
	        SET @Campo2 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 3 
	        SET @Campo3 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 4 
	        SET @Campo4 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 5 
	        SET @Campo5 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 6 
	        SET @Campo6 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 7 
	        SET @Campo7 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 8 
	        SET @Campo8 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 9 
	        SET @Campo9 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 10 
	        SET @Campo10 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 11 
	        SET @Campo11 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 12 
	        SET @Campo12 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 13 
	        SET @Campo13 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 14 
	        SET @Campo14 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 15 
	        SET @Campo15 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 16 
	        SET @Campo16 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 17 
	        SET @Campo17 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 18 
	        SET @Campo18 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 19 
	        SET @Campo19 = @Nome_Titulo 
	     
	    IF @Qtde_Registro = 20 
	        SET @Campo20 = @Nome_Titulo 
	     
	    FETCH NEXT FROM cur_cabecalho INTO @Id_Resultado,@Nome_Titulo,@Tipo_Campo, 
	    @Id_chave_tabela 
	    IF @Tipo_Campo = 'V' 
	    BEGIN 
	        SET @Array_Id_Resultado = @Array_Id_Resultado + REPLICATE('0', 4 -LEN(CONVERT(VARCHAR(4), @Id_Resultado)))  
	            + CONVERT(VARCHAR(4), @Id_Resultado) 
	    END 
	END 
	CLOSE cur_cabecalho 
	DEALLOCATE cur_cabecalho 
	 
	 
	INSERT INTO #Resultado (TipoRegistro, Campo1, Campo2, Campo3, Campo4, Campo5,  
	       Campo6, Campo7, Campo8, Campo9, Campo10, Campo11, Campo12, Campo13,  
	       Campo14, Campo15, Campo16, Campo17, Campo18, Campo19, Campo20)  
	     VALUES (1, @Campo1, @Campo2, @Campo3, @Campo4, @Campo5, @Campo6, @Campo7,  
	            @Campo8, @Campo9, @Campo10, @Campo11, @Campo12, @Campo13, @Campo14,  
	            @Campo15, @Campo16, @Campo17, @Campo18, @Campo19, @Campo20) 
	             
	 
	DECLARE cur_resultado         CURSOR   
	FOR 
	    SELECT Data_Atualizacao, 
	           Id_Banco_Dados, 
	           Id_Tabela, 
	           Id_Tipo_Operacao, 
	           Id_Usuario_Log, 
	           Id_Campo_log, 
	           Chave_Registro, 
	           Valor_Campo_Ant=CASE WHEN SQL_VARIANT_PROPERTY (Valor_Campo_Ant,'BASETYPE') = 'datetime' THEN CONVERT(CHAR(10),Valor_Campo_Ant,103) ELSE Valor_Campo_Ant END, 
	           Valor_Campo_Atual=CASE WHEN SQL_VARIANT_PROPERTY (Valor_Campo_Atual,'BASETYPE') = 'datetime' THEN CONVERT(CHAR(10),Valor_Campo_Atual,103) ELSE Valor_Campo_Atual END 
	    FROM   #Resultado_Pesquisa 
	    ORDER BY 
	           Id_Tabela, 
	           Chave_Registro      
	 
	OPEN cur_resultado 
	FETCH NEXT FROM cur_resultado INTO @Data_Atualizacao,@Id_Banco_Dados,@Id_Tabela, 
	@Id_Tipo_Operacao_res,@Id_Usuario_Log,@Id_Campo_log,@Chave_Registro,@Valor_Campo_Ant,@Valor_Campo_Atual  
	                                                                                                                                        
	SET @qtde_cabecalho_variavel = LEN(@Array_Id_Resultado) 
	SET @Campo1 = NULL  
	SET @Campo2 = NULL  
	SET @Campo3 = NULL  
	SET @Campo4 = NULL  
	SET @Campo5 = NULL  
	SET @Campo6 = NULL 
	SET @Campo7 = NULL  
	SET @Campo8 = NULL  
	SET @Campo9 = NULL  
	SET @Campo10 = NULL  
	SET @Campo11 = NULL  
	SET @Campo12 = NULL 
	SET @Campo13 = NULL  
	SET @Campo14 = NULL  
	SET @Campo15 = NULL  
	SET @Campo16 = NULL  
	SET @Campo17 = NULL  
	SET @Campo18 = NULL 
	SET @Campo19 = NULL  
	SET @Campo20 = NULL 
	SET @Chave_Registro_ant = '0' 
	WHILE @@FETCH_STATUS = 0 
	BEGIN 
	    SET @i = 1 
	    IF @Chave_Registro <> @Chave_Registro_ant 
	    BEGIN 
	        SET @Chave_Registro_ant = @Chave_Registro 
	        SET @Campo1 = NULL  
	        SET @Campo2 = NULL  
	        SET @Campo3 = NULL  
	        SET @Campo4 = NULL  
	        SET @Campo5 = NULL  
	        SET @Campo6 = NULL 
	        SET @Campo7 = NULL  
	        SET @Campo8 = NULL  
	        SET @Campo9 = NULL  
	        SET @Campo10 = NULL  
	        SET @Campo11 = NULL  
	        SET @Campo12 = NULL 
	        SET @Campo13 = NULL  
	        SET @Campo14 = NULL  
	        SET @Campo15 = NULL  
	        SET @Campo16 = NULL  
	        SET @Campo17 = NULL  
	        SET @Campo18 = NULL 
	        SET @Campo19 = NULL  
	        SET @Campo20 = NULL 
	        WHILE @i < @qtde_cabecalho_variavel 
	        BEGIN 
	            SET @Id_CabVariavel = SUBSTRING(@Array_Id_Resultado, @i, 4) 
	            SET @Id_Cabecalho = NULL 
	            SELECT @Id_Cabecalho = CASE  
	                                        WHEN Id_Cabecalho IS NULL THEN 0 
	                                        ELSE Id_Cabecalho 
	                                   END 
	            FROM   ImplantaLog.dbo.Cabecalho_Tabela_Log t1, 
	                   ImplantaLog.dbo.Assunto_Tabela_Log t2, 
	                   #Cabecalho_Resultado t3 
	            WHERE  t1.Id_Tabela = t2.Id_Tabela 
	                   AND t2.Id_Assunto = @Id_assunto 
	                   AND t1.Id_Tabela = @Id_Tabela 
	                   AND t1.Nome_Campo_Cabecalho COLLATE SQL_Latin1_General_CP1_CI_AS = t3.Nome_Campo 
	                   AND t3.Id_Resultado = @Id_CabVariavel 
	             
	            SET @comando = dbo.fc_monta_sql ( 
	                    @Id_Banco_Dados, 
	                    @Id_Cabecalho, 
	                    @Chave_Registro, 
	                    @Id_CabVariavel 
	                ) 
	             
	            SET @i = @i + 4 
	            SET @comando =  
	                'Insert into #Tab_Campo_Variavel (Id_CabVariavel,Campo_Variavel) '  
	                + @comando 
	                	 
	                	-- **** 
	            --SELECT @comando 
	            EXEC (@comando) 
	        END 
	    END 
 
	     
	    SELECT @Campo1 = CASE  
	                          WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                          ELSE Campo_Variavel 
	                     END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 1 
	     
	    SELECT @Campo2 = CASE  
	                          WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                          ELSE Campo_Variavel 
	                     END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 2 
	     
	    SELECT @Campo3 = CASE  
	                          WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                          ELSE Campo_Variavel 
	                     END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 3 
	     
	    SELECT @Campo4 = CASE  
	                          WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                          ELSE Campo_Variavel 
	                     END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 4 
	     
	    SELECT @Campo5 = CASE  
	                          WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                          ELSE Campo_Variavel 
	                     END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 5 
	     
	    SELECT @Campo6 = CASE  
	                          WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                          ELSE Campo_Variavel 
	                     END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 6 
	     
	    SELECT @Campo7 = CASE  
	                          WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                          ELSE Campo_Variavel 
	                     END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 7 
	     
	    SELECT @Campo8 = CASE  
	                          WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                          ELSE Campo_Variavel 
	                     END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 8 
	     
	    SELECT @Campo9 = CASE  
	                          WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                          ELSE Campo_Variavel 
	                     END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 9 
	     
	    SELECT @Campo10 = CASE  
	                           WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                           ELSE Campo_Variavel 
	                      END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 10 
	     
	    SELECT @Campo11 = CASE  
	                           WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                           ELSE Campo_Variavel 
	                      END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 11 
	     
	    SELECT @Campo12 = CASE  
	                           WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                           ELSE Campo_Variavel 
	                      END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 12 
	     
	    SELECT @Campo13 = CASE  
	                           WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                           ELSE Campo_Variavel 
	                      END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 13 
	     
	    SELECT @Campo14 = CASE  
	                           WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                           ELSE Campo_Variavel 
	                      END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 14 
	     
	    SELECT @Campo15 = CASE  
	                           WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                           ELSE Campo_Variavel 
	                      END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 15 
	     
	    SELECT @Campo16 = CASE  
	                           WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                           ELSE Campo_Variavel 
	                      END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 16 
	     
	    SELECT @Campo17 = CASE  
	                           WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                           ELSE Campo_Variavel 
	                      END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 17 
	     
	    SELECT @Campo18 = CASE  
	                           WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                           ELSE Campo_Variavel 
	                      END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 18 
	     
	    SELECT @Campo19 = CASE  
	                           WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                           ELSE Campo_Variavel 
	                      END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 19 
	     
	    SELECT @Campo20 = CASE  
	                           WHEN LEN(Campo_Variavel) > 100 THEN SUBSTRING(Campo_Variavel, 1, 100) 
	                           ELSE Campo_Variavel 
	                      END 
	    FROM   #Tab_Campo_Variavel 
	    WHERE  Id_CabVariavel = 20 
	     
	    DELETE  
	    FROM   #Tab_Campo_Variavel 
	     
	    SET @Campo_Aux = CONVERT(VARCHAR(10), @Data_Atualizacao, 103) + ' ' + CONVERT(VARCHAR(10), @Data_Atualizacao, 108) 
	 
	    IF @cab_data = 1 
	        SET @Campo1 = @Campo_Aux 
	     
	    IF @cab_data = 2 
	        SET @Campo2 = @Campo_Aux 
	     
	    IF @cab_data = 3 
	        SET @Campo3 = @Campo_Aux 
	     
	    IF @cab_data = 4 
	        SET @Campo4 = @Campo_Aux 
	     
	    IF @cab_data = 5 
	        SET @Campo5 = @Campo_Aux 
	     
	    IF @cab_data = 6 
	        SET @Campo6 = @Campo_Aux 
	     
	    IF @cab_data = 7 
	        SET @Campo7 = @Campo_Aux 
	     
	    IF @cab_data = 8 
	        SET @Campo8 = @Campo_Aux 
	     
	    IF @cab_data = 9 
	        SET @Campo9 = @Campo_Aux 
	     
	    IF @cab_data = 10 
	        SET @Campo10 = @Campo_Aux 
	     
	    IF @cab_data = 11 
	        SET @Campo11 = @Campo_Aux 
	     
	    IF @cab_data = 12 
	        SET @Campo12 = @Campo_Aux 
	     
	    IF @cab_data = 13 
	        SET @Campo13 = @Campo_Aux 
	     
	    IF @cab_data = 14 
	        SET @Campo14 = @Campo_Aux 
	     
	    IF @cab_data = 15 
	        SET @Campo15 = @Campo_Aux 
	     
	    IF @cab_data = 16 
	        SET @Campo16 = @Campo_Aux 
	     
	    IF @cab_data = 17 
	        SET @Campo17 = @Campo_Aux 
	     
	    IF @cab_data = 18 
	        SET @Campo18 = @Campo_Aux 
	     
	    IF @cab_data = 19 
	        SET @Campo19 = @Campo_Aux 
	     
	    IF @cab_data = 20 
	        SET @Campo20 = @Campo_Aux 
	     
	    SET @Campo_Aux = NULL 
	     
	    SELECT @Campo_Aux = Tabela 
	    FROM   ImplantaLog.dbo.Tabela_Log 
	    WHERE  Id_Tabela = @Id_Tabela 
	     
	    IF @cab_Tabela = 1 
	        SET @Campo1 = @Campo_Aux 
	     
	    IF @cab_Tabela = 2 
	        SET @Campo2 = @Campo_Aux 
	     
	    IF @cab_Tabela = 3 
	        SET @Campo3 = @Campo_Aux 
	     
	    IF @cab_Tabela = 4 
	        SET @Campo4 = @Campo_Aux 
	     
	    IF @cab_Tabela = 5 
	        SET @Campo5 = @Campo_Aux 
	     
	    IF @cab_Tabela = 6 
	        SET @Campo6 = @Campo_Aux 
	     
	    IF @cab_Tabela = 7 
	        SET @Campo7 = @Campo_Aux 
	     
	    IF @cab_Tabela = 8 
	        SET @Campo8 = @Campo_Aux 
	     
	    IF @cab_Tabela = 9 
	        SET @Campo9 = @Campo_Aux 
	     
	    IF @cab_Tabela = 10 
	        SET @Campo10 = @Campo_Aux 
	     
	    IF @cab_Tabela = 11 
	        SET @Campo11 = @Campo_Aux 
	     
	    IF @cab_Tabela = 12 
	        SET @Campo12 = @Campo_Aux 
	     
	    IF @cab_Tabela = 13 
	        SET @Campo13 = @Campo_Aux 
	     
	    IF @cab_Tabela = 14 
	        SET @Campo14 = @Campo_Aux 
	     
	    IF @cab_Tabela = 15 
	        SET @Campo15 = @Campo_Aux 
	     
	    IF @cab_Tabela = 16 
	        SET @Campo16 = @Campo_Aux 
	     
	    IF @cab_Tabela = 17 
	        SET @Campo17 = @Campo_Aux 
	     
	    IF @cab_Tabela = 18 
	        SET @Campo18 = @Campo_Aux 
	     
	    IF @cab_Tabela = 19 
	        SET @Campo19 = @Campo_Aux 
	     
	    IF @cab_Tabela = 20 
	        SET @Campo20 = @Campo_Aux 
	     
	    SET @Campo_Aux = NULL 
	    SELECT @Campo_Aux = SUBSTRING(Nome_Usuario, 1, 100) 
	    FROM   ImplantaLog.dbo.Usuario_log 
	    WHERE  Id_Usuario_log = @Id_Usuario_Log 
	     
	    IF @cab_Usuario = 1 
	        SET @Campo1 = @Campo_Aux 
	     
	    IF @cab_Usuario = 2 
	        SET @Campo2 = @Campo_Aux 
	     
	    IF @cab_Usuario = 3 
	        SET @Campo3 = @Campo_Aux 
	     
	    IF @cab_Usuario = 4 
	        SET @Campo4 = @Campo_Aux 
	     
	    IF @cab_Usuario = 5 
	        SET @Campo5 = @Campo_Aux 
	     
	    IF @cab_Usuario = 6 
	        SET @Campo6 = @Campo_Aux 
	     
	    IF @cab_Usuario = 7 
	        SET @Campo7 = @Campo_Aux 
	     
	    IF @cab_Usuario = 8 
	        SET @Campo8 = @Campo_Aux 
	     
	    IF @cab_Usuario = 9 
	        SET @Campo9 = @Campo_Aux 
	     
	    IF @cab_Usuario = 10 
	        SET @Campo10 = @Campo_Aux 
	     
	    IF @cab_Usuario = 11 
	        SET @Campo11 = @Campo_Aux 
	     
	    IF @cab_Usuario = 12 
	        SET @Campo12 = @Campo_Aux 
	     
	    IF @cab_Usuario = 13 
	        SET @Campo13 = @Campo_Aux 
	     
	    IF @cab_Usuario = 14 
	        SET @Campo14 = @Campo_Aux 
	     
	    IF @cab_Usuario = 15 
	        SET @Campo15 = @Campo_Aux 
	     
	    IF @cab_Usuario = 16 
	        SET @Campo16 = @Campo_Aux 
	     
	    IF @cab_Usuario = 17 
	        SET @Campo17 = @Campo_Aux 
	     
	    IF @cab_Usuario = 18 
	        SET @Campo18 = @Campo_Aux 
	     
	    IF @cab_Usuario = 19 
	        SET @Campo19 = @Campo_Aux 
	     
	    IF @cab_Usuario = 20 
	        SET @Campo20 = @Campo_Aux 
	     
	    SET @Campo_Aux = NULL 
	    SELECT @Campo_Aux = CASE  
	                             WHEN Nome_Titulo IS NULL THEN SUBSTRING(Nome_Campo, 1, 100) 
	                             ELSE SUBSTRING(Nome_Titulo, 1, 100) 
	                        END 
	    FROM   ImplantaLog.dbo.Campo_Log 
	    WHERE  Id_Campo_Log = @Id_Campo_log 
	     
	    IF @cab_Campo = 1 
	        SET @Campo1 = @Campo_Aux 
	     
	    IF @cab_Campo = 2 
	        SET @Campo2 = @Campo_Aux 
	     
	    IF @cab_Campo = 3 
	        SET @Campo3 = @Campo_Aux 
	     
	    IF @cab_Campo = 4 
	        SET @Campo4 = @Campo_Aux 
	     
	    IF @cab_Campo = 5 
	        SET @Campo5 = @Campo_Aux 
	     
	    IF @cab_Campo = 6 
	        SET @Campo6 = @Campo_Aux 
	     
	    IF @cab_Campo = 7 
	        SET @Campo7 = @Campo_Aux 
	     
	    IF @cab_Campo = 8 
	        SET @Campo8 = @Campo_Aux 
	     
	    IF @cab_Campo = 9 
	        SET @Campo9 = @Campo_Aux 
	     
	    IF @cab_Campo = 10 
	        SET @Campo10 = @Campo_Aux 
	     
	    IF @cab_Campo = 11 
	        SET @Campo11 = @Campo_Aux 
	     
	    IF @cab_Campo = 12 
	        SET @Campo12 = @Campo_Aux 
	     
	    IF @cab_Campo = 13 
	        SET @Campo13 = @Campo_Aux 
	     
	    IF @cab_Campo = 14 
	        SET @Campo14 = @Campo_Aux 
	     
	    IF @cab_Campo = 15 
	        SET @Campo15 = @Campo_Aux 
	     
	    IF @cab_Campo = 16 
	        SET @Campo16 = @Campo_Aux 
	     
	    IF @cab_Campo = 17 
	        SET @Campo17 = @Campo_Aux 
	     
	    IF @cab_Campo = 18 
	        SET @Campo18 = @Campo_Aux 
	     
	    IF @cab_Campo = 19 
	        SET @Campo19 = @Campo_Aux 
	     
	    IF @cab_Campo = 20 
	        SET @Campo20 = @Campo_Aux 
	     
	    SET @Campo_Aux = NULL 
	     
	    IF @Id_Tipo_Operacao IN (2, 3) -- Somente para alteração e exclusão 
	    BEGIN 
	        IF @Id_Tipo_Operacao = 3 -- Campos Exclusão 
	        BEGIN 
	            SELECT @cab_Cont_Ant = Id_Resultado 
	            FROM   #Cabecalho_Resultado 
	            WHERE  Id_chave_tabela = @Id_Campo_log 
	        END 
	         
	        SELECT @IdTipoDominio = IdTipoDominio 
	        FROM   ImplantaLog.dbo.Campo_Log 
	        WHERE  Id_Campo_Log = @Id_Campo_Log 
	         
	        EXEC dbo.sp_obtem_descricao_campo @IdTipoDominio, 
	             @Id_Campo_log, 
	             @Id_Banco_Dados, 
	             @Valor_Campo_Ant, 
	             @Campo_Aux OUTPUT 
	         
	        IF @cab_Cont_Ant = 1 
	            SET @Campo1 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 2 
	            SET @Campo2 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 3 
	            SET @Campo3 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 4 
	            SET @Campo4 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 5 
	            SET @Campo5 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 6 
	            SET @Campo6 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 7 
	            SET @Campo7 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 8 
	            SET @Campo8 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 9 
	            SET @Campo9 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 10 
	            SET @Campo10 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 11 
	            SET @Campo11 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 12 
	            SET @Campo12 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 13 
	            SET @Campo13 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 14 
	            SET @Campo14 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 15 
	            SET @Campo15 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 16 
	            SET @Campo16 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 17 
	            SET @Campo17 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 18 
	            SET @Campo18 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 19 
	            SET @Campo19 = @Campo_Aux 
	         
	        IF @cab_Cont_Ant = 20 
	            SET @Campo20 = @Campo_Aux 
	         
	        SET @Campo_Aux = NULL 
	    END 
	     
	    IF @Id_Tipo_Operacao = 2 -- Somente para alteração 
	    BEGIN 
	        EXEC dbo.sp_obtem_descricao_campo @IdTipoDominio, 
	             @Id_Campo_log, 
	             @Id_Banco_Dados, 
	             @Valor_Campo_Atual, 
	             @Campo_Aux OUTPUT 
	         
	        IF @cab_Cont_Atual = 1 
	            SET @Campo1 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 2 
	            SET @Campo2 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 3 
	            SET @Campo3 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 4 
	            SET @Campo4 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 5 
	            SET @Campo5 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 6 
	            SET @Campo6 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 7 
	            SET @Campo7 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 8 
	            SET @Campo8 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 9 
	            SET @Campo9 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 10 
	            SET @Campo10 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 11 
	            SET @Campo11 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 12 
	            SET @Campo12 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 13 
	            SET @Campo13 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 14 
	            SET @Campo14 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 15 
	            SET @Campo15 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 16 
	            SET @Campo16 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 17 
	            SET @Campo17 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 18 
	            SET @Campo18 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 19 
	            SET @Campo19 = @Campo_Aux 
	         
	        IF @cab_Cont_Atual = 20 
	            SET @Campo20 = @Campo_Aux 
	         
	        SET @Campo_Aux = NULL 
	    END 
	     
	    IF @Id_Tipo_Operacao IN (1, 2) -- Somente para inclusão e alteração 
	    BEGIN 
	        INSERT INTO #Resultado (TipoRegistro, Campo1, Campo2, Campo3, Campo4,  
	               Campo5, Campo6, Campo7, Campo8, Campo9, Campo10, Campo11,  
	               Campo12, Campo13, Campo14, Campo15, Campo16, Campo17, Campo18,  
	               Campo19, Campo20)  
	             VALUES (2, @Campo1, @Campo2, @Campo3, @Campo4, @Campo5, @Campo6,  
	                    @Campo7, @Campo8, @Campo9, @Campo10, @Campo11, @Campo12,  
	                    @Campo13, @Campo14, @Campo15, @Campo16, @Campo17, @Campo18,  
	                    @Campo19, @Campo20) 
	    END 
	 
	    FETCH NEXT FROM cur_resultado INTO @Data_Atualizacao,@Id_Banco_Dados,@Id_Tabela, 
	    @Id_Tipo_Operacao_Res, 
	    @Id_Usuario_Log,@Id_Campo_log,@Chave_Registro,@Valor_Campo_Ant,@Valor_Campo_Atual 
	    IF @Id_Tipo_Operacao = 3 
	       AND -- Somente para exclusão 
	           ( 
	               @Chave_Registro <> @Chave_Registro_ant 
	               OR @Chave_Registro IS NULL 
	           ) 
	    BEGIN 
	        INSERT INTO #Resultado (TipoRegistro, Campo1, Campo2, Campo3, Campo4,  
	               Campo5, Campo6, Campo7, Campo8, Campo9, Campo10, Campo11,  
	               Campo12, Campo13, Campo14, Campo15, Campo16, Campo17, Campo18,  
	               Campo19, Campo20)  
	             VALUES (2, @Campo1, @Campo2, @Campo3, @Campo4, @Campo5, @Campo6,  
	                    @Campo7, @Campo8, @Campo9, @Campo10, @Campo11, @Campo12,  
	                    @Campo13, @Campo14, @Campo15, @Campo16, @Campo17, @Campo18,  
	                    @Campo19, @Campo20) 
	    END 
	END 
	CLOSE cur_resultado 
	DEALLOCATE cur_resultado 
	 
		 
	IF @Id_Tipo_Operacao = 3 -- Somente para exclusão 
	BEGIN 
	    INSERT INTO #Resultado (TipoRegistro, Campo1, Campo2, Campo3, Campo4,  
	           Campo5, Campo6, Campo7, Campo8, Campo9, Campo10, Campo11, Campo12,  
	           Campo13, Campo14, Campo15, Campo16, Campo17, Campo18, Campo19,  
	           Campo20)  
	         VALUES (2, @Campo1, @Campo2, @Campo3, @Campo4, @Campo5, @Campo6, @Campo7,  
	                @Campo8, @Campo9, @Campo10, @Campo11, @Campo12, @Campo13, @Campo14,  
	                @Campo15, @Campo16, @Campo17, @Campo18, @Campo19, @Campo20) 
	END 
	 
	IF @Retorno_modo_Apresentacao = 1 
	BEGIN 
	    UPDATE ImplantaLog.dbo.Campo_Log 
	    SET    ApresentaCampoExclusao = 'N' 
	    FROM   ImplantaLog.dbo.Campo_Log 
	    WHERE  Id_Campo_Log = @Id_Campo_Log 
	END 
	 
	SELECT @Campo1 = campo1, 
	       @Campo2 = campo2, 
	       @Campo3 = campo3, 
	       @Campo4 = campo4, 
	       @Campo5 = campo5, 
	       @Campo6 = campo6, 
	       @Campo7 = campo7, 
	       @Campo8 = campo8, 
	       @Campo9 = campo9, 
	       @Campo10 = campo10, 
	       @Campo11 = campo11, 
	       @Campo12 = campo12, 
	       @Campo13 = campo13, 
	       @Campo14 = campo14, 
	       @Campo15 = campo15, 
	       @Campo16 = campo16, 
	       @Campo17 = campo17, 
	       @Campo18 = campo18, 
	       @Campo19 = campo19, 
	       @Campo20 = campo20 
	FROM   #Resultado 
	WHERE  TipoRegistro = 1 
	 
	SET @comando = 'Select ' + 
	    CASE  
	         WHEN @Campo1 IS NULL THEN ' ' 
	         ELSE 'Campo1 ' 
	    END + 
	    CASE  
	         WHEN @Campo2 IS NULL THEN ' ' 
	         ELSE ',Campo2 ' 
	    END + 
	    CASE  
	         WHEN @Campo3 IS NULL THEN ' ' 
	         ELSE ',Campo3 ' 
	    END + 
	    CASE  
	         WHEN @Campo4 IS NULL THEN ' ' 
	         ELSE ',Campo4 ' 
	    END + 
	    CASE  
	         WHEN @Campo5 IS NULL THEN ' ' 
	         ELSE ',Campo5 ' 
	    END + 
	    CASE  
	         WHEN @Campo6 IS NULL THEN ' ' 
	         ELSE ',Campo6 ' 
	    END + 
	    CASE  
	         WHEN @Campo7 IS NULL THEN ' ' 
	         ELSE ',Campo7 ' 
	    END + 
	    CASE  
	         WHEN @Campo8 IS NULL THEN ' ' 
	         ELSE ',Campo8 ' 
	    END + 
	    CASE  
	         WHEN @Campo9 IS NULL THEN ' ' 
	         ELSE ',Campo9 ' 
	    END + 
	    CASE  
	         WHEN @Campo10 IS NULL THEN ' ' 
	         ELSE ',Campo10 ' 
	    END + 
	    CASE  
	         WHEN @Campo11 IS NULL THEN ' ' 
	         ELSE ',Campo11 ' 
	    END + 
	    CASE  
	         WHEN @Campo12 IS NULL THEN ' ' 
	         ELSE ',Campo12 ' 
	    END + 
	    CASE  
	         WHEN @Campo13 IS NULL THEN ' ' 
	         ELSE ',Campo13 ' 
	    END + 
	    CASE  
	         WHEN @Campo14 IS NULL THEN ' ' 
	         ELSE ',Campo14 ' 
	    END + 
	    CASE  
	         WHEN @Campo15 IS NULL THEN ' ' 
	         ELSE ',Campo15 ' 
	    END + 
	    CASE  
	         WHEN @Campo16 IS NULL THEN ' ' 
	         ELSE ',Campo16 ' 
	    END + 
	    CASE  
	         WHEN @Campo17 IS NULL THEN ' ' 
	         ELSE ',Campo17 ' 
	    END + 
	    CASE  
	         WHEN @Campo18 IS NULL THEN ' ' 
	         ELSE ',Campo18 ' 
	    END + 
	    CASE  
	         WHEN @Campo19 IS NULL THEN ' ' 
	         ELSE ',Campo19 ' 
	    END + 
	    CASE  
	         WHEN @Campo20 IS NULL THEN ' ' 
	         ELSE ',Campo20 ' 
	    END + 
	    ' from #Resultado where Campo1 is not null' 
	 
	SET @comando = @comando + ' order by TipoRegistro, Campo1 ' 
 
	EXEC (@comando) 
