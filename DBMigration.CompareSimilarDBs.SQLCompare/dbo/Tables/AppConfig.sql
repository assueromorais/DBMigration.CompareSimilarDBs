CREATE TABLE [dbo].[AppConfig] (
    [IdAppConfig]      INT            IDENTITY (1, 1) NOT NULL,
    [IdAppConfigGroup] INT            NOT NULL,
    [Chave]            VARCHAR (50)   NOT NULL,
    [Valor]            VARCHAR (1000) NULL,
    [TipoParametro]    VARCHAR (20)   NOT NULL,
    [Imagem]           VARBINARY (1)  NULL,
    [Rastreabilidade]  TEXT           NULL,
    [LAST_USER_INS]    VARCHAR (100)  NULL,
    [LAST_DT_INS]      DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([IdAppConfig] ASC)
);


GO
CREATE TRIGGER [TrgLog_AppConfig] ON [Implanta_CRPAM].[dbo].[AppConfig] 
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
SET @TableName = 'AppConfig'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAppConfig : «' + RTRIM( ISNULL( CAST (IdAppConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAppConfigGroup : «' + RTRIM( ISNULL( CAST (IdAppConfigGroup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Chave : «' + RTRIM( ISNULL( CAST (Chave AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoParametro : «' + RTRIM( ISNULL( CAST (TipoParametro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_USER_INS : «' + RTRIM( ISNULL( CAST (LAST_USER_INS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_DT_INS : «' + RTRIM( ISNULL( CONVERT (CHAR, LAST_DT_INS, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAppConfig : «' + RTRIM( ISNULL( CAST (IdAppConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAppConfigGroup : «' + RTRIM( ISNULL( CAST (IdAppConfigGroup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Chave : «' + RTRIM( ISNULL( CAST (Chave AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoParametro : «' + RTRIM( ISNULL( CAST (TipoParametro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_USER_INS : «' + RTRIM( ISNULL( CAST (LAST_USER_INS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_DT_INS : «' + RTRIM( ISNULL( CONVERT (CHAR, LAST_DT_INS, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAppConfig : «' + RTRIM( ISNULL( CAST (IdAppConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAppConfigGroup : «' + RTRIM( ISNULL( CAST (IdAppConfigGroup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Chave : «' + RTRIM( ISNULL( CAST (Chave AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoParametro : «' + RTRIM( ISNULL( CAST (TipoParametro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_USER_INS : «' + RTRIM( ISNULL( CAST (LAST_USER_INS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_DT_INS : «' + RTRIM( ISNULL( CONVERT (CHAR, LAST_DT_INS, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAppConfig : «' + RTRIM( ISNULL( CAST (IdAppConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAppConfigGroup : «' + RTRIM( ISNULL( CAST (IdAppConfigGroup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Chave : «' + RTRIM( ISNULL( CAST (Chave AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoParametro : «' + RTRIM( ISNULL( CAST (TipoParametro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_USER_INS : «' + RTRIM( ISNULL( CAST (LAST_USER_INS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_DT_INS : «' + RTRIM( ISNULL( CONVERT (CHAR, LAST_DT_INS, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
