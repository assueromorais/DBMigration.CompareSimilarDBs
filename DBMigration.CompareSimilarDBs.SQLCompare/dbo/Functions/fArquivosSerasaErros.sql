/*Oc nº 111946*/

CREATE FUNCTION [dbo].[fArquivosSerasaErros]
(
	@Erros VARCHAR(250)
)
RETURNS VARCHAR(8000)

BEGIN
	DECLARE @Retorno    VARCHAR(8000),
	        @Descricao  VARCHAR(250)
	
	SET @Retorno = ''
	DECLARE crCodigos CURSOR FAST_FORWARD READ_ONLY 
	FOR
	    SELECT Descricao
	    FROM   ArquivosSerasaErros
	    WHERE  @Erros LIKE '%' + Codigo + '%' 
	
	OPEN crCodigos 
	
	FETCH FROM crCodigos INTO @Descricao
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    SET @Retorno = @Retorno + @Descricao + '; '
	    
	    FETCH FROM crCodigos INTO @Descricao
	END
	
	CLOSE crCodigos 
	DEALLOCATE crCodigos
	
	IF @Retorno <> ''
	    SET @Retorno = SUBSTRING(@Retorno, 1, LEN(@Retorno) - 1)
	
	RETURN @Retorno
END
