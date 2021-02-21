/*Oc. 64821 - ZeMario*/  
 
CREATE PROCEDURE [dbo].[sp_obtem_descricao_campo] ( 
    @IdTipoDominio    TINYINT, 
    @Id_Campo_Log     SMALLINT, 
    @id_Banco_Dados   SMALLINT, 
    @valor_Campo      SQL_VARIANT, 
    @Descricao_campo  VARCHAR(100) OUTPUT 
) 
AS 
BEGIN 
	DECLARE @Tabela            VARCHAR(100), 
	        @Nome_Campo        VARCHAR(128), 
	        @Nome_Banco_Dados  VARCHAR(200), 
	        @comando           VARCHAR(3000), 
	        @Id_Tabela         SMALLINT, 
	        @Nome_Campo_Chave  VARCHAR(128) 
	 
	IF @valor_Campo IS NOT NULL 
	    
	BEGIN 
	    IF @IdTipoDominio = 1 
	       OR @IdTipoDominio IS NULL 
	    BEGIN 
	        IF ISDATE(CONVERT(VARCHAR(100), @valor_Campo)) = 0 
	            SET @Descricao_campo = CONVERT(VARCHAR(100), @valor_Campo) 
	        ELSE 
	        BEGIN 
	            IF CONVERT(VARCHAR(8), @valor_Campo, 108) = '00' + CHAR(58) + 
	               '00' + CHAR(58) + '00' 
	                SET @Descricao_campo = CONVERT(VARCHAR(20), @valor_Campo, 120) 
	            ELSE 
	                SET @Descricao_campo = CONVERT(VARCHAR(20), @valor_Campo, 103) 
	        END 
	    END 
	     
	    IF @IdTipoDominio = 2 
	    BEGIN 
	        CREATE TABLE #Tab_Campo_Variavel 
	        ( 
	        	Campo_variavel VARCHAR(100) 
	        ) 
	        SELECT @Nome_Banco_Dados = Nome_Banco_Dados 
	        FROM   ImplantaLog.dbo.Banco_Dados_Log 
	        WHERE  id_Banco_Dados = @id_Banco_Dados 
	         
	        SELECT @Nome_Campo = Nome_Campo, 
	               @Tabela = Tabela, 
	               @Nome_Campo_Chave = Nome_Campo_Pesquisa 
	        FROM   ImplantaLog.dbo.Tabela_Dominio_Campo_Log t1, 
	               ImplantaLog.dbo.Tabela_Log t2 
	        WHERE  Id_Campo_Log = @Id_Campo_Log 
	               AND t1.Id_Tabela = t2.Id_Tabela 
	         
	        SET @Comando =  
	            'Insert into #Tab_Campo_Variavel Select Campo_Variavel= Substring ( '  
	            + @Nome_Campo + ',1,100) from ' + @Nome_Banco_Dados + '.dbo.' + 
	            @Tabela  
	            + ' where ' + @Nome_Campo_Chave + '=' + CONVERT(VARCHAR(128), @valor_Campo) 
	         
	        EXEC (@Comando) 
	        SELECT @Descricao_campo = Campo_Variavel 
	        FROM   #Tab_Campo_Variavel 
	         
	        DROP TABLE #Tab_Campo_Variavel 
	    END 
	     
	    IF @IdTipoDominio = 3 
	    BEGIN 
	        SELECT @Descricao_campo = Descricao 
	        FROM   ImplantaLog.dbo.Dominio_Campo_Log 
	        WHERE  Id_campo_Log = @Id_Campo_Log 
	               AND CONVERT(VARCHAR(100), Valor_Dominio) = CONVERT(VARCHAR(100), @valor_Campo) 
	    END 
	END  
	 
	 
	IF ISNUMERIC(@Descricao_campo) = 1 
	    SET @Descricao_campo = REPLACE (@Descricao_campo, '.', ',') 
	 
	RETURN 
END
