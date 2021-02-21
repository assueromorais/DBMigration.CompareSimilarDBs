/*Oc. 64821 - Victor*/ 

CREATE FUNCTION [dbo].[fc_obtem_descricao_campo]
(
	@IdTipoDominio   TINYINT,
	@Id_Campo_Log    SMALLINT,
	@id_Banco_Dados  SMALLINT,
	@valor_Campo     SQL_VARIANT
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @Descricao_campo   VARCHAR(128),
	        @Tabela            VARCHAR(100),
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
	        IF ISDATE(CONVERT(VARCHAR(128), @valor_Campo)) = 0
	        BEGIN
	            SET @Descricao_campo = CONVERT(VARCHAR(128), @valor_Campo)
	        END
	        ELSE
	        BEGIN
	            IF CONVERT(VARCHAR(128), @valor_Campo, 108) = '00'+char(58)+'00'+char(58)+'00'
	                SET @Descricao_campo = CONVERT(VARCHAR(128), @valor_Campo, 120)
	            ELSE
	                SET @Descricao_campo = CONVERT(VARCHAR(128), @valor_Campo, 103)
	        END
	    END
	    
	    IF @IdTipoDominio = 3
	    BEGIN
	        SELECT @Descricao_campo = Descricao
	        FROM   ImplantaLog.dbo.Dominio_Campo_Log
	        WHERE  Id_campo_Log = @Id_Campo_Log
	               AND Valor_Dominio = @valor_Campo
	    END
	END
	
	IF LEN(@Descricao_campo) > 100
	    SET @Descricao_campo = SUBSTRING(@Descricao_campo, 1, 100)
	
	RETURN (@Descricao_campo)
END
