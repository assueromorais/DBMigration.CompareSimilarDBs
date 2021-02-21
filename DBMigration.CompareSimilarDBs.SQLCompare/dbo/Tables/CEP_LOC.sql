CREATE TABLE [dbo].[CEP_LOC] (
    [CHAVE_LOCAL] INT         NOT NULL,
    [NOME_LOCAL]  CHAR (60)   NULL,
    [CEP8_LOCAL]  INT         NULL,
    [UF_LOCAL]    CHAR (2)    NULL,
    [TIPO_LOCAL]  CHAR (1)    NULL,
    [SIT_LOCAL]   INT         NULL,
    [SUBOR_LOCA]  INT         NULL,
    [DR_LOCAL]    CHAR (3)    NULL,
    [REOP_LOCAL]  CHAR (2)    NULL,
    [OPER_LOCAL]  INT         NULL,
    [DATA_LOCAL]  INT         NULL,
    [DDD_LOC]     VARCHAR (2) NULL,
    CONSTRAINT [PK_CEP_LOC] PRIMARY KEY NONCLUSTERED ([CHAVE_LOCAL] ASC)
);


GO
CREATE TRIGGER [TrgLog_CEP_LOC] ON [Implanta_CRPAM].[dbo].[CEP_LOC] 
FOR INSERT, UPDATE, DELETE 
AS 
DECLARE 	@CountI		Integer 
DECLARE 	@CountD		Integer 
DECLARE 	@TipoOperacao 	VARCHAR(9) 
DECLARE 	@TableName 	VARCHAR(50) 
DECLARE 	@Conteudo 	VARCHAR(3700) 
DECLARE 	@Conteudo2 	VARCHAR(3700) 
SELECT @CountI = COUNT(*) FROM INSERTED 
SELECT @CountD = COUNT(*) FROM DELETED 
SET @TipoOperacao = Null 
SET @Conteudo = Null 
SET @Conteudo2 = Null 
SET @TableName = 'CEP_LOC'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'CHAVE_LOCAL : «' + RTRIM( ISNULL( CAST (CHAVE_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NOME_LOCAL : «' + RTRIM( ISNULL( CAST (NOME_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP8_LOCAL : «' + RTRIM( ISNULL( CAST (CEP8_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF_LOCAL : «' + RTRIM( ISNULL( CAST (UF_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TIPO_LOCAL : «' + RTRIM( ISNULL( CAST (TIPO_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SIT_LOCAL : «' + RTRIM( ISNULL( CAST (SIT_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SUBOR_LOCA : «' + RTRIM( ISNULL( CAST (SUBOR_LOCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DR_LOCAL : «' + RTRIM( ISNULL( CAST (DR_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| REOP_LOCAL : «' + RTRIM( ISNULL( CAST (REOP_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OPER_LOCAL : «' + RTRIM( ISNULL( CAST (OPER_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA_LOCAL : «' + RTRIM( ISNULL( CAST (DATA_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DDD_LOC : «' + RTRIM( ISNULL( CAST (DDD_LOC AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'CHAVE_LOCAL : «' + RTRIM( ISNULL( CAST (CHAVE_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NOME_LOCAL : «' + RTRIM( ISNULL( CAST (NOME_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP8_LOCAL : «' + RTRIM( ISNULL( CAST (CEP8_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF_LOCAL : «' + RTRIM( ISNULL( CAST (UF_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TIPO_LOCAL : «' + RTRIM( ISNULL( CAST (TIPO_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SIT_LOCAL : «' + RTRIM( ISNULL( CAST (SIT_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SUBOR_LOCA : «' + RTRIM( ISNULL( CAST (SUBOR_LOCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DR_LOCAL : «' + RTRIM( ISNULL( CAST (DR_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| REOP_LOCAL : «' + RTRIM( ISNULL( CAST (REOP_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OPER_LOCAL : «' + RTRIM( ISNULL( CAST (OPER_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA_LOCAL : «' + RTRIM( ISNULL( CAST (DATA_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DDD_LOC : «' + RTRIM( ISNULL( CAST (DDD_LOC AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
   IF @Conteudo <> @Conteudo2 
   BEGIN 
		INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, Conteudo2, NomeBanco) 
		VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, @Conteudo2, DB_NAME()) 
   END 
END 
ELSE 
BEGIN 
   IF    @CountI    =    1 
	BEGIN 
		SET @TipoOperacao = 'Inclusão' 
		SELECT @Conteudo = 'CHAVE_LOCAL : «' + RTRIM( ISNULL( CAST (CHAVE_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NOME_LOCAL : «' + RTRIM( ISNULL( CAST (NOME_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP8_LOCAL : «' + RTRIM( ISNULL( CAST (CEP8_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF_LOCAL : «' + RTRIM( ISNULL( CAST (UF_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TIPO_LOCAL : «' + RTRIM( ISNULL( CAST (TIPO_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SIT_LOCAL : «' + RTRIM( ISNULL( CAST (SIT_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SUBOR_LOCA : «' + RTRIM( ISNULL( CAST (SUBOR_LOCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DR_LOCAL : «' + RTRIM( ISNULL( CAST (DR_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| REOP_LOCAL : «' + RTRIM( ISNULL( CAST (REOP_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OPER_LOCAL : «' + RTRIM( ISNULL( CAST (OPER_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA_LOCAL : «' + RTRIM( ISNULL( CAST (DATA_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DDD_LOC : «' + RTRIM( ISNULL( CAST (DDD_LOC AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'CHAVE_LOCAL : «' + RTRIM( ISNULL( CAST (CHAVE_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NOME_LOCAL : «' + RTRIM( ISNULL( CAST (NOME_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP8_LOCAL : «' + RTRIM( ISNULL( CAST (CEP8_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF_LOCAL : «' + RTRIM( ISNULL( CAST (UF_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TIPO_LOCAL : «' + RTRIM( ISNULL( CAST (TIPO_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SIT_LOCAL : «' + RTRIM( ISNULL( CAST (SIT_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SUBOR_LOCA : «' + RTRIM( ISNULL( CAST (SUBOR_LOCA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DR_LOCAL : «' + RTRIM( ISNULL( CAST (DR_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| REOP_LOCAL : «' + RTRIM( ISNULL( CAST (REOP_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OPER_LOCAL : «' + RTRIM( ISNULL( CAST (OPER_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA_LOCAL : «' + RTRIM( ISNULL( CAST (DATA_LOCAL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DDD_LOC : «' + RTRIM( ISNULL( CAST (DDD_LOC AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
