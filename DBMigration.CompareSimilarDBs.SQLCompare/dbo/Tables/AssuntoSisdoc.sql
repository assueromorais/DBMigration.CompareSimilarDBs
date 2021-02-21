CREATE TABLE [dbo].[AssuntoSisdoc] (
    [IdAssunto]       INT           IDENTITY (1, 1) NOT NULL,
    [Assunto]         VARCHAR (255) NOT NULL,
    [Codigo]          VARCHAR (10)  NULL,
    [IdTipoDocumento] INT           NULL,
    [IdTipoDebito]    INT           NULL,
    PRIMARY KEY CLUSTERED ([IdAssunto] ASC),
    CONSTRAINT [FK_AssuntoSisdoc_IdTipoDebito] FOREIGN KEY ([IdTipoDebito]) REFERENCES [dbo].[TiposDebito] ([IdTipoDebito]),
    CONSTRAINT [FK_AssuntoSisdoc_IdTipoDocumento] FOREIGN KEY ([IdTipoDocumento]) REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento])
);


GO
CREATE TRIGGER [TrgLog_AssuntoSisdoc] ON [Implanta_CRPAM].[dbo].[AssuntoSisdoc] 
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
SET @TableName = 'AssuntoSisdoc'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAssunto : «' + RTRIM( ISNULL( CAST (IdAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAssunto : «' + RTRIM( ISNULL( CAST (IdAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAssunto : «' + RTRIM( ISNULL( CAST (IdAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAssunto : «' + RTRIM( ISNULL( CAST (IdAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
