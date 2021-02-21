/*Oc. 64821 - Victor*/ 

CREATE FUNCTION [dbo].[fc_converte_log_Obtem_chave]
(
	@Id_Tabela  SMALLINT,
	@Conteudo   VARCHAR(3000)
)
RETURNS SQL_VARIANT
AS
BEGIN
	DECLARE @posicaoInicial           SMALLINT,
	        @posicaoFinal             SMALLINT,
	        @Chave_Registro           VARCHAR(128),
	        @Id_Campo_Log_Chave       SMALLINT,
	        @Nome_Campo_chave         VARCHAR(128),
	        @cont_chave               SMALLINT,
	        @Chave_Registro_Retorno   SQL_VARIANT,
	        @posicaoCampo             SMALLINT
	
	DECLARE cur_monta_chave_Pesquisa  CURSOR  
	FOR
	    SELECT Id_Campo_Log,
	           LTRIM                  (Nome_Campo)
	    FROM   ImplantaLog.dbo.Campo_Log
	    WHERE  Chave = 1
	           AND Id_Tabela = @Id_Tabela
	
	OPEN cur_monta_chave_Pesquisa
	FETCH NEXT FROM cur_monta_chave_Pesquisa INTO @Id_Campo_Log_Chave, @Nome_Campo_chave                                      
	SET @cont_chave = 1
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    SET @posicaoCampo = CHARINDEX(@Nome_Campo_chave, @Conteudo, 1)
	    IF @posicaoCampo = 0
	        BREAK
	    
	    SET @posicaoInicial = CHARINDEX(CHAR(58) + ' «', @Conteudo, @posicaoCampo) 
	        + 3
	    
	    SET @posicaoFinal = CHARINDEX('»', @Conteudo, @posicaoCampo)
	    IF @posicaoFinal < @posicaoInicial
	        BREAK
	    
	    IF @cont_chave = 1
	        SET @Chave_Registro = SUBSTRING(@Conteudo, @posicaoInicial, @posicaoFinal -@posicaoInicial)
	    
	    IF @cont_chave > 1
	        SET @Chave_Registro = @Chave_Registro + ';' + SUBSTRING(@Conteudo, @posicaoInicial, @posicaoFinal -@posicaoInicial)
	    
	    FETCH NEXT FROM cur_monta_chave_Pesquisa INTO @Id_Campo_Log_Chave, @Nome_Campo_chave
	    IF @@FETCH_STATUS = 0
	        SET @cont_chave = @cont_chave + 1
	END
	CLOSE cur_monta_chave_Pesquisa
	DEALLOCATE cur_monta_chave_Pesquisa
	IF @Chave_Registro IS NOT NULL
	BEGIN
	    IF @cont_chave > 1
	        SET @Chave_Registro = @Chave_Registro + ';'
	    
	    IF ISNUMERIC(@Chave_Registro) = 1
	        SET @Chave_Registro_Retorno = CONVERT(INT, @Chave_Registro)
	    ELSE
	        SET @Chave_Registro_Retorno = @Chave_Registro
	END
	
	RETURN (@Chave_Registro_Retorno)
END
