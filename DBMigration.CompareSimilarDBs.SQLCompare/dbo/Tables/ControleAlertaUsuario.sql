CREATE TABLE [dbo].[ControleAlertaUsuario] (
    [IdControleAlertaUsuario] INT          IDENTITY (1, 1) NOT NULL,
    [IdUsuario]               INT          NOT NULL,
    [TipoControle]            VARCHAR (30) NULL,
    [DataAlerta]              DATETIME     NULL,
    CONSTRAINT [PK_ControleAlertaUsuario] PRIMARY KEY CLUSTERED ([IdControleAlertaUsuario] ASC),
    CONSTRAINT [FK_ControleAlertaUsuario_Usuario] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);


GO
CREATE TRIGGER [TrgLog_ControleAlertaUsuario] ON [Implanta_CRPAM].[dbo].[ControleAlertaUsuario] 
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
SET @TableName = 'ControleAlertaUsuario'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdControleAlertaUsuario : «' + RTRIM( ISNULL( CAST (IdControleAlertaUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoControle : «' + RTRIM( ISNULL( CAST (TipoControle AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAlerta : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlerta, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdControleAlertaUsuario : «' + RTRIM( ISNULL( CAST (IdControleAlertaUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoControle : «' + RTRIM( ISNULL( CAST (TipoControle AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAlerta : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlerta, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdControleAlertaUsuario : «' + RTRIM( ISNULL( CAST (IdControleAlertaUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoControle : «' + RTRIM( ISNULL( CAST (TipoControle AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAlerta : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlerta, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdControleAlertaUsuario : «' + RTRIM( ISNULL( CAST (IdControleAlertaUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoControle : «' + RTRIM( ISNULL( CAST (TipoControle AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAlerta : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAlerta, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
