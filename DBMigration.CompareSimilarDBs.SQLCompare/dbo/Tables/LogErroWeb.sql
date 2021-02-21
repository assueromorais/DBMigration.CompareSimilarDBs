CREATE TABLE [dbo].[LogErroWeb] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [Erro]     VARCHAR (200) NULL,
    [Pagina]   VARCHAR (50)  NULL,
    [DataHora] DATETIME      NULL,
    CONSTRAINT [PK_LogErroWeb] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE TRIGGER [TrgLog_LogErroWeb] ON [Implanta_CRPAM].[dbo].[LogErroWeb] 
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
SET @TableName = 'LogErroWeb'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'Id : «' + RTRIM( ISNULL( CAST (Id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Erro : «' + RTRIM( ISNULL( CAST (Erro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Pagina : «' + RTRIM( ISNULL( CAST (Pagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHora : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHora, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'Id : «' + RTRIM( ISNULL( CAST (Id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Erro : «' + RTRIM( ISNULL( CAST (Erro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Pagina : «' + RTRIM( ISNULL( CAST (Pagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHora : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHora, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'Id : «' + RTRIM( ISNULL( CAST (Id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Erro : «' + RTRIM( ISNULL( CAST (Erro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Pagina : «' + RTRIM( ISNULL( CAST (Pagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHora : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHora, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'Id : «' + RTRIM( ISNULL( CAST (Id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Erro : «' + RTRIM( ISNULL( CAST (Erro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Pagina : «' + RTRIM( ISNULL( CAST (Pagina AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHora : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHora, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
