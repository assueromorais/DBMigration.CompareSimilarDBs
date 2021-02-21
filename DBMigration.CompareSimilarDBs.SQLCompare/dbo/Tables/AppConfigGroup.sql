CREATE TABLE [dbo].[AppConfigGroup] (
    [IdAppConfigGroup] INT           IDENTITY (1, 1) NOT NULL,
    [Descricao]        VARCHAR (40)  NOT NULL,
    [Sigla]            VARCHAR (10)  NULL,
    [LAST_USER_INS]    VARCHAR (100) NULL,
    [LAST_DT_INS]      DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([IdAppConfigGroup] ASC)
);


GO
CREATE TRIGGER [TrgLog_AppConfigGroup] ON [Implanta_CRPAM].[dbo].[AppConfigGroup] 
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
SET @TableName = 'AppConfigGroup'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAppConfigGroup : «' + RTRIM( ISNULL( CAST (IdAppConfigGroup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sigla : «' + RTRIM( ISNULL( CAST (Sigla AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_USER_INS : «' + RTRIM( ISNULL( CAST (LAST_USER_INS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_DT_INS : «' + RTRIM( ISNULL( CONVERT (CHAR, LAST_DT_INS, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAppConfigGroup : «' + RTRIM( ISNULL( CAST (IdAppConfigGroup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sigla : «' + RTRIM( ISNULL( CAST (Sigla AS VARCHAR(3500)),'Nulo'))+'» '
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
		SELECT @Conteudo = 'IdAppConfigGroup : «' + RTRIM( ISNULL( CAST (IdAppConfigGroup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sigla : «' + RTRIM( ISNULL( CAST (Sigla AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_USER_INS : «' + RTRIM( ISNULL( CAST (LAST_USER_INS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_DT_INS : «' + RTRIM( ISNULL( CONVERT (CHAR, LAST_DT_INS, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAppConfigGroup : «' + RTRIM( ISNULL( CAST (IdAppConfigGroup AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sigla : «' + RTRIM( ISNULL( CAST (Sigla AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_USER_INS : «' + RTRIM( ISNULL( CAST (LAST_USER_INS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LAST_DT_INS : «' + RTRIM( ISNULL( CONVERT (CHAR, LAST_DT_INS, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
