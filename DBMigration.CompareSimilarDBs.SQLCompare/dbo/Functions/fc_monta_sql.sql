/*Oc. 64821 - Victor*/ 

CREATE FUNCTION [dbo].[fc_monta_sql]
(
	@Id_Banco_Dados  SMALLINT,
	@Id_Cabecalho    SMALLINT,
	@chave_pesquisa  SQL_VARIANT,
	@Id_CabVariavel  VARCHAR(4)
)
RETURNS VARCHAR(3000)
AS
BEGIN
	DECLARE @comando             VARCHAR(3000),
	        @Nome_Banco_Dados    VARCHAR(200),
	        @Campo_Resultado     VARCHAR(20),
	        @Tabela              VARCHAR(50),
	        @Nome_Campo_Retorno  VARCHAR(128),
	        @Nome_Campo_Chave    VARCHAR(128),
	        @Id_Tabela           SMALLINT,
	        @i                   SMALLINT,
	        @y                   SMALLINT
	
	SELECT @Nome_Banco_Dados = Nome_Banco_Dados
	FROM   ImplantaLog.dbo.Banco_Dados_Log
	WHERE  id_Banco_Dados = @id_Banco_Dados
	
	SELECT @Id_Tabela = t1.Id_Tabela,
	       @Comando = RTRIM(Comando) + ' Where '
	FROM   ImplantaLog.dbo.Cabecalho_Tabela_Log t1
	WHERE  t1.Id_Cabecalho = @Id_Cabecalho
	
	SET @Comando = SUBSTRING(@Comando, 1, 6) + ' ' + @Id_CabVariavel + ', ' +
	    SUBSTRING(@Comando, 7, 3000)
	
	SET @Comando = REPLACE(@Comando, '@Nome_Banco_Dados', @Nome_Banco_Dados)
	DECLARE cur_monta_chave_Pesquisa CURSOR  
	FOR
	    SELECT Nome_Campo
	    FROM   ImplantaLog.dbo.Campo_Log
	    WHERE  Id_Tabela = @Id_Tabela
	           AND Chave = 1
	
	OPEN cur_monta_chave_Pesquisa
	FETCH NEXT FROM cur_monta_chave_Pesquisa INTO @Nome_Campo_chave
	SET @i = 1
	SET @y = 0
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    SET @y = CHARINDEX(';', CONVERT(VARCHAR(100), @chave_pesquisa), @i) - 1
	    IF @y < 0
	        SET @y = 100
	    
	    SET @Comando = @Comando + ' ' + @Nome_Campo_chave + ' = '
	    IF ISNUMERIC(SUBSTRING(CONVERT(VARCHAR(100), @chave_pesquisa), @i, @y)) 
	       = 0
	        SET @Comando = @Comando + CHAR(39)
	    
	    SET @Comando = @Comando + SUBSTRING(CONVERT(VARCHAR(100), @chave_pesquisa), @i, @y)
	    IF ISNUMERIC(SUBSTRING(CONVERT(VARCHAR(100), @chave_pesquisa), @i, @y)) 
	       = 0
	        SET @Comando = @Comando + CHAR(39)
	    
	    FETCH NEXT FROM cur_monta_chave_Pesquisa INTO @Nome_Campo_chave
	    SET @i = @y + 1
	    IF @@FETCH_STATUS = 0
	        SET @Comando = @Comando + ' and '
	END
	CLOSE cur_monta_chave_Pesquisa
	DEALLOCATE cur_monta_chave_Pesquisa
	RETURN (@comando)
END
