CREATE PROCEDURE [dbo].[sp_converte_log_1] 
	@datainicio DATETIME, 
	@datatermino DATETIME 
AS 
	DECLARE @comando               VARCHAR(3000), 
	        @Data                  DATETIME, 
	        @NomeBanco             VARCHAR(200), 
	        @Sistema               VARCHAR(128), 
	        @Usuario               VARCHAR(128), 
	        @Tabela                VARCHAR(50), 
	        @TipoOperacao          VARCHAR(9), 
	        @Conteudo              VARCHAR(3000), 
	        @Conteudo2             VARCHAR(3000), 
	        @Id_Banco_Dados        SMALLINT, 
	        @Id_sistema            SMALLINT, 
	        @Id_Usuario_Log        SMALLINT, 
	        @Id_Tipo_Operacao      SMALLINT, 
	        @Id_Tabela             SMALLINT, 
	        @Erro                  SMALLINT, 
	        @Id_Campo_Log_Chave    SMALLINT, 
	        @Nome_Campo_chave      VARCHAR(128), 
	        @Chave_Registro        SQL_VARIANT, 
	        @Valor_Campo_Ant       SQL_VARIANT, 
	        @Valor_Campo_Atual     SQL_VARIANT, 
	        @posicaoInicial        INT, 
	        @posicaoFinal          INT, 
	        @posicaoInicial_2      INT, 
	        @posicaoFinal_2        INT, 
	        @Id_log                INT, 
	        @tam_conteudo          SMALLINT, 
	        @i                     SMALLINT, 
	        @Campo_Conteudo        SQL_VARIANT, 
	        @Campo_Conteudo2       SQL_VARIANT, 
	        @Nome_Campo_Conteudo   VARCHAR(128), 
	        @Data_Ant              DATETIME, 
	        @posicaoInicial_campo  SMALLINT, 
	        @posicaoFinal_campo    SMALLINT, 
	        @Id_Campo_Log          SMALLINT 
	 
	SET DATEFORMAT dmy 
	 
	SET @datainicio = CONVERT(DATETIME, (CONVERT(VARCHAR(10), @DataInicio, 103) + ' 00' + CHAR(58) + '00' + CHAR(58) + '00'))	         
	SET @datatermino = CONVERT(DATETIME, (CONVERT(VARCHAR(10), @datatermino, 103) + ' 23' + CHAR(58) + '59' + CHAR(58) + '58'))	         
	 
	IF NOT EXISTS ( 
	       SELECT 1 
	       FROM   sys.tables 
	       WHERE  NAME = 'Erro_Conversao_Log' 
	   ) 
	BEGIN 
	    CREATE TABLE Erro_Conversao_Log 
	    ( 
	    	DATA          DATETIME, 
	    	Sistema       VARCHAR(128), 
	    	Usuario       VARCHAR(128), 
	    	Tabela        VARCHAR(50), 
	    	TipoOperacao  VARCHAR(9), 
	    	MsgErro       VARCHAR(100) 
	    ) 
	END 
	 
	 
	 
	DECLARE cur_converte  CURSOR   
	FOR 
	    SELECT DATA, 
	           NomeBanco= ISNULL(NomeBanco,DB_NAME()), 
	           Sistema, 
	           Usuario, 
	           Tabela, 
	           TipoOperacao, 
	           Conteudo, 
	           Conteudo2   
	    FROM   Implantalog.dbo.Log 
	    WHERE  DATA BETWEEN @datainicio AND @datatermino 
	    ORDER BY 
	           DATA 
	 
	OPEN cur_converte 
	FETCH NEXT FROM cur_converte INTO @Data, @NomeBanco, @Sistema, @Usuario, @Tabela, @TipoOperacao, @Conteudo, @Conteudo2                                                 
	SET @Data_Ant = GETDATE() 
	WHILE @@FETCH_STATUS = 0 
	BEGIN 
	    SET @Erro = 0 
	     
	    SELECT @Id_Banco_Dados = id_Banco_Dados 
	    FROM   ImplantaLog.dbo.Banco_Dados_Log 
	    WHERE  Nome_Banco_Dados = @NomeBanco 
	     
	    IF @Id_Banco_Dados IS NULL 
	    BEGIN 
	        INSERT INTO ImplantaLog.dbo.Banco_Dados_Log ( Nome_Banco_Dados ) VALUES ( @NomeBanco ) 
	        SET @Id_Banco_Dados = @@IDENTITY 
	    END 
	     
	    SELECT @Id_sistema = Id_Sistema 
	    FROM   ImplantaLog.dbo.Sistema_Log 
	    WHERE  Sistema = @Sistema 
	     
	    IF @Id_sistema IS NULL 
	    BEGIN 
	        INSERT INTO ImplantaLog.dbo.Sistema_Log ( Sistema ) VALUES ( @Sistema ) 
	        SET @Id_sistema = @@IDENTITY 
	    END 
	     
	    SELECT @Id_Usuario_Log = Id_Usuario_Log 
	    FROM   ImplantaLog.dbo.Usuario_log 
	    WHERE  Nome_Usuario = @Usuario 
	     
	    IF @Id_Usuario_Log IS NULL 
	    BEGIN 
	        INSERT INTO ImplantaLog.dbo.Usuario_log ( Nome_Usuario ) VALUES ( @Usuario ) 
	        SET @Id_Usuario_Log = @@IDENTITY 
	    END 
	     
	    SET @Id_Tipo_Operacao = CASE  
	                                 WHEN @TipoOperacao = 'Inclusão' THEN 1 
	                                 WHEN @TipoOperacao = 'Alteração' THEN 2 
	                                 WHEN @TipoOperacao = 'Exclusão' THEN 3 
	                            END 
	     
	    SELECT @Id_Tabela = Id_Tabela 
	    FROM   ImplantaLog.dbo.Tabela_Log 
	    WHERE  Tabela = @Tabela	 
	     
	    IF @Id_Tabela IS NULL 
	    BEGIN 
	        INSERT INTO ImplantaLog.dbo.Erro_Conversao_Log VALUES ( @Data, @Sistema, @Usuario, @Tabela, @TipoOperacao, 'Tabela não existe no banco' ) 
	        SET @Erro = 1 
	    END 
	     
	    SELECT TOP 1 @Id_Campo_Log_Chave = Id_Campo_Log 
	    FROM   ImplantaLog.dbo.Campo_Log 
	    WHERE  Chave = 1 
	           AND Id_Tabela = @Id_Tabela 
	     
	    IF @Id_Campo_Log_Chave IS NULL 
	    BEGIN 
	        INSERT INTO ImplantaLog.dbo.Erro_Conversao_Log VALUES ( @Data, @Sistema, @Usuario, @Tabela, @TipoOperacao, 'Campo chave não encontrado' ) 
	        SET @Erro = 1 
	    END 
	     
	    IF @Erro = 0 
	       AND NOT EXISTS ( 
	               SELECT 1 
	               FROM   ImplantaLog.dbo.Campo_Log 
	               WHERE  Chave = 1 
	                      AND Id_Tabela = @Id_Tabela 
	           ) 
	    BEGIN 
	        INSERT INTO ImplantaLog.dbo.Erro_Conversao_Log VALUES ( @Data, @Sistema, @Usuario, @Tabela, @TipoOperacao, 'Tabela sem campo chave' ) 
	        SET @Erro = 1 
	    END 
	     
	    IF @Erro = 0 
	    BEGIN 
	        SET @Chave_Registro = ImplantaLog.dbo.fc_converte_log_Obtem_chave (@Id_Tabela, @Conteudo)  
	         
	        IF @Chave_Registro IS NULL 
	        BEGIN 
	            INSERT INTO ImplantaLog.dbo.Erro_Conversao_Log VALUES ( @Data, @Sistema, @Usuario, @Tabela, @TipoOperacao, 'Campo chave não encontrado' ) 
	            SET @Erro = 1 
	        END 
	    END 
	     
	    IF @Erro = 0 
	       AND @Id_Tipo_Operacao = 1 
	    BEGIN 
	        INSERT INTO ImplantaLog.dbo.Log_Aplicacao ( Data_Atualizacao, Id_Banco_Dados, Id_sistema, Id_Tabela, Id_Tipo_Operacao, Id_Usuario_Log ) VALUES ( @Data, @Id_Banco_Dados,  
	               @Id_sistema, @Id_Tabela, @Id_Tipo_Operacao, @Id_Usuario_Log ) 
	        SET @Id_log = @@IDENTITY 
	         
	        INSERT INTO ImplantaLog.dbo.Log_Aplicacao_Detalhe ( Id_log, Id_Campo_log, Chave_Registro ) VALUES ( @Id_log, @Id_Campo_Log_Chave, @Chave_Registro ) 
	    END 
	     
	    -- Inicio rotina tratamento Alteração 
	     
	    IF @Erro = 0 
	       AND @Id_Tipo_Operacao = 2 
	    BEGIN 
	        SET @tam_conteudo = LEN(@Conteudo) 
	        SET @i = 1 
	        SET @posicaoInicial = 1 
	        SET @posicaoFinal = 1 
	        SET @posicaoInicial_2 = 1 
	        SET @posicaoFinal_2 = 1 
	         
	        SET @posicaoInicial_campo = 1 
	        SET @posicaoFinal_campo = CHARINDEX('' + CHAR(58) + ' «', @Conteudo, @posicaoInicial)  
	         
	        IF @posicaoInicial_campo < @posicaoFinal_campo 
	        BEGIN 
	            SET @Nome_Campo_Conteudo = LTRIM(SUBSTRING(@Conteudo, @posicaoInicial_campo, @posicaoFinal_campo - @posicaoInicial_campo)) 
	        END 
	         
	        WHILE @i < @tam_conteudo 
	        BEGIN 
	            SET @posicaoInicial = CHARINDEX(' «', @Conteudo, @posicaoInicial) + 2 
	            SET @posicaoFinal = CHARINDEX('» ', @Conteudo, @posicaoFinal) 
	             
	            SET @posicaoInicial_2 = CHARINDEX(' «', @Conteudo2, @posicaoInicial_2) + 2 
	            SET @posicaoFinal_2 = CHARINDEX('» ', @Conteudo2, @posicaoFinal_2) 
	             
	            IF @posicaoFinal = 0 
	               OR @posicaoFinal_2 = 0 
	                BREAK 
	             
	            IF @posicaoInicial < @posicaoFinal 
	            BEGIN 
	                SET @Campo_Conteudo = SUBSTRING(@Conteudo, @posicaoInicial, @posicaoFinal -@posicaoInicial) 
	            END 
	             
	            IF @posicaoInicial_2 < @posicaoFinal_2 
	            BEGIN 
	                SET @Campo_Conteudo2 = SUBSTRING(@Conteudo2, @posicaoInicial_2, @posicaoFinal_2 -@posicaoInicial_2) 
	            END 
	             
	            SET @Valor_Campo_Atual = @Campo_Conteudo2 
	            SET @Valor_Campo_Ant = @Campo_Conteudo 
	             
	            IF @Campo_Conteudo <> @Campo_Conteudo2 
	            BEGIN 
	                IF CONVERT(VARCHAR(128), @Campo_Conteudo) <> '.' 
	                   AND ISNUMERIC(CONVERT(VARCHAR(128), @Campo_Conteudo)) = 1 
	                   AND LEN(CONVERT(VARCHAR(128), @Campo_Conteudo)) < 10 
	                BEGIN 
	                    IF ASCII(LEFT(CONVERT(VARCHAR(128), @Campo_Conteudo), 1)) IN (9, 10, 11, 12, 13, 36, 43, 44, 45, 46, 128, 160, 162, 163, 164, 165) 
	                       OR ASCII(RIGHT(CONVERT(VARCHAR(128), @Campo_Conteudo), 1)) IN (9, 10, 11, 12, 13, 36, 43, 44, 45, 46, 128, 160, 162, 163, 164, 165) 
	                        SET @Valor_Campo_Ant = NULL 
	                    ELSE  
	                    IF CHARINDEX('E', CONVERT(VARCHAR(20), @Campo_Conteudo), 1) > 0 
	                        SET @Valor_Campo_Ant = CONVERT(VARCHAR(20), @Campo_Conteudo) 
	                    ELSE 
	                    IF CHARINDEX('.', CONVERT(VARCHAR(20), @Campo_Conteudo), 1) = 0 
	                       AND CHARINDEX(',', CONVERT(VARCHAR(20), @Campo_Conteudo), 1) = 0 
	                        SET @Valor_Campo_Ant = CONVERT(INT, @Campo_Conteudo) 
	                    ELSE 
	                        SET @Valor_Campo_Ant = CONVERT(FLOAT, REPLACE (CONVERT(VARCHAR(20), @Campo_Conteudo), ',', '.')) 
	                END 
	                 
	                IF CONVERT(VARCHAR(128), @Campo_Conteudo2) <> '.' 
	                   AND ISNUMERIC(CONVERT(VARCHAR(128), @Campo_Conteudo2)) = 1 
	                   AND LEN(CONVERT(VARCHAR(128), @Campo_Conteudo2)) < 10 
	                BEGIN 
	                    IF ASCII(LEFT(CONVERT(VARCHAR(128), @Campo_Conteudo2), 1)) IN (9, 10, 11, 12, 13, 36, 43, 44, 45, 46, 128, 160, 162, 163, 164, 165) 
	                       OR ASCII(RIGHT(CONVERT(VARCHAR(128), @Campo_Conteudo2), 1)) IN (9, 10, 11, 12, 13, 36, 43, 44, 45, 46, 128, 160, 162, 163, 164, 165) 
	                        SET @Valor_Campo_Atual = NULL 
	                    ELSE  
	                    IF CHARINDEX('E', CONVERT(VARCHAR(20), @Campo_Conteudo2), 1) > 0 
	                        SET @Valor_Campo_Atual = CONVERT(VARCHAR(20), @Campo_Conteudo2) 
	                    ELSE 
	                    IF CHARINDEX('.', CONVERT(VARCHAR(20), @Campo_Conteudo2), 1) = 0 
	                       AND CHARINDEX(',', CONVERT(VARCHAR(20), @Campo_Conteudo2), 1) = 0 
	                        SET @Valor_Campo_Atual = CONVERT(INT, @Campo_Conteudo2) 
	                    ELSE 
	                        SET @Valor_Campo_Atual = CONVERT(FLOAT, REPLACE (CONVERT(VARCHAR(20), @Campo_Conteudo2), ',', '.')) 
	                END 
	                 
	                IF ISDATE(CONVERT(VARCHAR(128), @Campo_Conteudo)) = 1 
	                BEGIN 
	                    SET @Valor_Campo_Ant = CONVERT(DATETIME, @Campo_Conteudo) 
	                END 
	                 
	                IF ISDATE(CONVERT(VARCHAR(128), @Campo_Conteudo2)) = 1 
	                BEGIN 
	                    SET @Valor_Campo_Atual = CONVERT(DATETIME, @Campo_Conteudo2) 
	                END 
	                 
	                IF RTRIM(LTRIM(CONVERT(VARCHAR(128), @Campo_Conteudo))) = 'Nulo' 
	                BEGIN 
	                    SET @Valor_Campo_Ant = NULL 
	                END 
	                 
	                IF RTRIM(LTRIM(CONVERT(VARCHAR(128), @Campo_Conteudo2))) = 'Nulo' 
	                BEGIN 
	                    SET @Valor_Campo_Atual = NULL 
	                END 
	                 
	                 
	                SET @Id_Campo_Log = NULL 
	                 
	                SELECT @Id_Campo_Log = Id_Campo_Log 
	                FROM   ImplantaLog.dbo.Campo_Log 
	                WHERE  Id_Tabela = @Id_Tabela 
	                       AND Nome_Campo = @Nome_Campo_Conteudo 
	                 
	                IF @Id_Campo_Log IS NULL 
	                BEGIN 
	                    INSERT INTO ImplantaLog.dbo.Erro_Conversao_Log VALUES ( @Data, @Sistema, @Usuario, @Tabela, @TipoOperacao, 'Tabela' + CHAR(58) + '' + CONVERT(VARCHAR(20), @Id_Tabela) + 
	                           '  Campo' + CHAR(58) + ' ' + 
	                           @Nome_Campo_Conteudo + ' não encontrado' ) 
	                    SET @Erro = 1 
	                END 
	                 
	                IF @Erro = 0 
	                BEGIN 
	                    IF @Data <> @Data_Ant 
	                    BEGIN 
	                        INSERT INTO ImplantaLog.dbo.Log_Aplicacao ( Data_Atualizacao, Id_Banco_Dados, Id_sistema, Id_Tabela, Id_Tipo_Operacao, Id_Usuario_Log ) VALUES ( @Data,  
	                               @Id_Banco_Dados, @Id_sistema, @Id_Tabela, @Id_Tipo_Operacao, @Id_Usuario_Log ) 
	                        SET @Id_log = @@IDENTITY 
	                         
	                        SET @Data_Ant = @Data 
	                    END 
	                     
	                    INSERT INTO ImplantaLog.dbo.Log_Aplicacao_Detalhe ( Id_log, Id_Campo_log, Chave_Registro, Valor_Campo_Ant, Valor_Campo_Atual ) VALUES ( @Id_log, @Id_Campo_log,  
	                           @Chave_Registro, @Valor_Campo_Ant, @Valor_Campo_Atual ) 
	                END 
	            END 
	             
	            SET @posicaoInicial_campo = CHARINDEX(' |', @Conteudo, @posicaoFinal) + 2 
	            SET @posicaoFinal_campo = CHARINDEX('' + CHAR(58) + ' «', @Conteudo, @posicaoInicial) 
	             
	            IF @posicaoInicial_campo < @posicaoFinal_campo 
	            BEGIN 
	                SET @Nome_Campo_Conteudo = LTRIM(SUBSTRING(@Conteudo, @posicaoInicial_campo, @posicaoFinal_campo - @posicaoInicial_campo)) 
	            END 
	             
	            SET @posicaoFinal = @posicaoFinal + 1 
	            SET @posicaoFinal_2 = @posicaoFinal_2 + 1 
	        END 
	    END 
	     
	    -- Inicio rotina tratamento Exclusão 
	    IF @Erro = 0 
	       AND @Id_Tipo_Operacao = 3 
	    BEGIN 
	        SET @tam_conteudo = LEN(@Conteudo) 
	        SET @i = 1 
	        SET @posicaoInicial = 1 
	        SET @posicaoFinal = 1 
	        SET @posicaoInicial_campo = 1 
	        SET @posicaoFinal_campo = CHARINDEX('' + CHAR(58) + ' «', @Conteudo, @posicaoInicial)  
	         
	        IF @posicaoInicial_campo < @posicaoFinal_campo 
	        BEGIN 
	            SET @Nome_Campo_Conteudo = LTRIM(SUBSTRING(@Conteudo, @posicaoInicial_campo, @posicaoFinal_campo - @posicaoInicial_campo)) 
	        END 
	         
	        WHILE @i < @tam_conteudo 
	        BEGIN 
	            SET @posicaoInicial = CHARINDEX('«', @Conteudo, @posicaoInicial) + 1 
	            SET @posicaoFinal = CHARINDEX('»', @Conteudo, @posicaoFinal) 
	             
	            IF @posicaoFinal = 0 
	                BREAK 
	             
	            IF @posicaoInicial < @posicaoFinal 
	            BEGIN 
	                SET @Campo_Conteudo = SUBSTRING(@Conteudo, @posicaoInicial, @posicaoFinal -@posicaoInicial) 
	            END 
	             
	            --Select @Data,@Tabela,@Conteudo,@Nome_Campo_Conteudo, @Campo_Conteudo 
	             
	            SET @Id_Campo_Log = NULL 
	             
	            SELECT @Id_Campo_Log = Id_Campo_Log 
	            FROM   ImplantaLog.dbo.Campo_Log 
	            WHERE  Id_Tabela = @Id_Tabela 
	                   AND Nome_Campo = @Nome_Campo_Conteudo 
	             
	            IF @Id_Campo_Log IS NULL 
	            BEGIN 
	                INSERT INTO ImplantaLog.dbo.Erro_Conversao_Log VALUES ( @Data, @Sistema, @Usuario, @Tabela, @TipoOperacao, 'Tabela' + CHAR(58) + '' + CONVERT(VARCHAR(20), @Id_Tabela) + 
	                       '  Campo' + CHAR(58) + ' ' + @Nome_Campo_Conteudo  
	                       + ' não encontrado' ) 
	                SET @Erro = 1 
	            END 
	             
	            SET @Valor_Campo_Atual = @Campo_Conteudo 
	            IF CONVERT(VARCHAR(128), @Campo_Conteudo) <> '.' 
	               AND ISNUMERIC(CONVERT(VARCHAR(128), @Campo_Conteudo)) = 1 
	               AND LEN(CONVERT(VARCHAR(128), @Campo_Conteudo)) < 10 
	            BEGIN 
	                IF ASCII(LEFT(CONVERT(VARCHAR(128), @Campo_Conteudo), 1)) IN (9, 10, 11, 12, 13, 36, 43, 44, 45, 46, 128, 160, 162, 163, 164, 165) 
	                   OR ASCII(RIGHT(CONVERT(VARCHAR(128), @Campo_Conteudo), 1)) IN (9, 10, 11, 12, 13, 36, 43, 44, 45, 46, 128, 160, 162, 163, 164, 165) 
	                    SET @Valor_Campo_Ant = NULL 
	                ELSE 
	                IF CHARINDEX('E', CONVERT(VARCHAR(20), @Campo_Conteudo), 1) > 0 
	                    SET @Valor_Campo_Ant = CONVERT(VARCHAR(20), @Campo_Conteudo) 
	                ELSE					 
	                IF CHARINDEX('.', CONVERT(VARCHAR(20), @Campo_Conteudo), 1) = 0 
	                   AND CHARINDEX(',', CONVERT(VARCHAR(20), @Campo_Conteudo), 1) = 0 
	                    SET @Valor_Campo_Ant = CONVERT(INT, @Campo_Conteudo) 
	                ELSE 
	                    SET @Valor_Campo_Ant = CONVERT(FLOAT, REPLACE (CONVERT(VARCHAR(20), @Campo_Conteudo), ',', '.')) 
	            END 
	             
	            IF ISDATE(CONVERT(VARCHAR(128), @Campo_Conteudo)) = 1 
	                SET @Valor_Campo_Ant = CONVERT(DATETIME, @Campo_Conteudo) 
	             
	            IF RTRIM(LTRIM(CONVERT(VARCHAR(128), @Campo_Conteudo))) = 'Nulo' 
	                SET @Valor_Campo_Ant = NULL 
	             
	            IF @Erro = 0 
	            BEGIN 
	                IF @Data <> @Data_Ant 
	                BEGIN 
	                    INSERT INTO ImplantaLog.dbo.Log_Aplicacao ( Data_Atualizacao, Id_Banco_Dados, Id_sistema, Id_Tabela, Id_Tipo_Operacao, Id_Usuario_Log ) VALUES ( @Data, @Id_Banco_Dados,  
	                           @Id_sistema, @Id_Tabela, @Id_Tipo_Operacao, @Id_Usuario_Log ) 
	                    SET @Id_log = @@IDENTITY 
	                     
	                    SET @Data_Ant = @Data 
	                END 
	                 
	                INSERT INTO ImplantaLog.dbo.Log_Aplicacao_Detalhe ( Id_log, Id_Campo_log, Chave_Registro, Valor_Campo_Ant ) VALUES ( @Id_log, @Id_Campo_log, @Chave_Registro, @Valor_Campo_Ant ) 
	            END 
	             
	            SET @posicaoFinal = @posicaoFinal + 1 
	             
	            SET @posicaoInicial_campo = CHARINDEX(' |', @Conteudo, @posicaoFinal) + 2 
	            SET @posicaoFinal_campo = CHARINDEX('' + CHAR(58) + ' «', @Conteudo, @posicaoInicial) 
	             
	            IF @posicaoFinal_campo = 0 
	                BREAK 
	             
	            IF @posicaoInicial_campo < @posicaoFinal_campo 
	            BEGIN 
	                SET @Nome_Campo_Conteudo = LTRIM(SUBSTRING(@Conteudo, @posicaoInicial_campo, @posicaoFinal_campo - @posicaoInicial_campo)) 
	            END 
	        END 
	    END 
	        
	     
	    FETCH NEXT FROM cur_converte INTO @Data,@NomeBanco,@Sistema,@Usuario,@Tabela,@TipoOperacao, 
	    @Conteudo,@Conteudo2 
	END 
	 
	CLOSE cur_converte 
	DEALLOCATE cur_converte 
	 
 
