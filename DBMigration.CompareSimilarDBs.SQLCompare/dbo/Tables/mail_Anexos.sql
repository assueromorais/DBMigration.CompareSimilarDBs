CREATE TABLE [dbo].[mail_Anexos] (
    [IdAnexo]    INT            IDENTITY (1, 1) NOT NULL,
    [IdMensagem] INT            NULL,
    [Nome]       VARCHAR (8000) NULL,
    [Extensao]   VARCHAR (8000) NULL,
    [ContentID]  VARCHAR (250)  NULL,
    [Anexo]      IMAGE          NULL,
    CONSTRAINT [PK_mail_Anexos] PRIMARY KEY CLUSTERED ([IdAnexo] ASC),
    CONSTRAINT [FK_mail_Anexos_IdMensagem] FOREIGN KEY ([IdMensagem]) REFERENCES [dbo].[mail_Mensagens] ([IdMensagem])
);


GO
CREATE TRIGGER [TrgLog_mail_Anexos] ON [Implanta_CRPAM].[dbo].[mail_Anexos] 
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
SET @TableName = 'mail_Anexos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAnexo : «' + RTRIM( ISNULL( CAST (IdAnexo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Extensao : «' + RTRIM( ISNULL( CAST (Extensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContentID : «' + RTRIM( ISNULL( CAST (ContentID AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAnexo : «' + RTRIM( ISNULL( CAST (IdAnexo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Extensao : «' + RTRIM( ISNULL( CAST (Extensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContentID : «' + RTRIM( ISNULL( CAST (ContentID AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAnexo : «' + RTRIM( ISNULL( CAST (IdAnexo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Extensao : «' + RTRIM( ISNULL( CAST (Extensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContentID : «' + RTRIM( ISNULL( CAST (ContentID AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAnexo : «' + RTRIM( ISNULL( CAST (IdAnexo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Extensao : «' + RTRIM( ISNULL( CAST (Extensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContentID : «' + RTRIM( ISNULL( CAST (ContentID AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
