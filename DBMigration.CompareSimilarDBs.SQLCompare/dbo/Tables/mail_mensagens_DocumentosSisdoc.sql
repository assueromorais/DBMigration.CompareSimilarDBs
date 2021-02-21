CREATE TABLE [dbo].[mail_mensagens_DocumentosSisdoc] (
    [IdMensagem]          INT          NOT NULL,
    [IdDocumento]         INT          NOT NULL,
    [DataVinculo]         DATETIME     CONSTRAINT [DEF_mail_mensagens_DocumentosSisdoc_DataVinculo] DEFAULT (getdate()) NOT NULL,
    [UsuarioVinculo]      VARCHAR (60) NULL,
    [DepartamentoVinculo] VARCHAR (60) NULL,
    CONSTRAINT [PK_mail_mensagens_DocumentosSisdoc] PRIMARY KEY CLUSTERED ([IdMensagem] ASC, [IdDocumento] ASC),
    CONSTRAINT [FK_mail_mensagens_DocumentosSisdoc_IdDocumento] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]),
    CONSTRAINT [FK_mail_mensagens_DocumentosSisdoc_IdMensagem] FOREIGN KEY ([IdMensagem]) REFERENCES [dbo].[mail_Mensagens] ([IdMensagem])
);


GO
CREATE TRIGGER [TrgLog_mail_mensagens_DocumentosSisdoc] ON [Implanta_CRPAM].[dbo].[mail_mensagens_DocumentosSisdoc] 
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
SET @TableName = 'mail_mensagens_DocumentosSisdoc'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVinculo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVinculo, 113 ),'Nulo'))+'» '
                         + '| UsuarioVinculo : «' + RTRIM( ISNULL( CAST (UsuarioVinculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoVinculo : «' + RTRIM( ISNULL( CAST (DepartamentoVinculo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVinculo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVinculo, 113 ),'Nulo'))+'» '
                         + '| UsuarioVinculo : «' + RTRIM( ISNULL( CAST (UsuarioVinculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoVinculo : «' + RTRIM( ISNULL( CAST (DepartamentoVinculo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVinculo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVinculo, 113 ),'Nulo'))+'» '
                         + '| UsuarioVinculo : «' + RTRIM( ISNULL( CAST (UsuarioVinculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoVinculo : «' + RTRIM( ISNULL( CAST (DepartamentoVinculo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMensagem : «' + RTRIM( ISNULL( CAST (IdMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVinculo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVinculo, 113 ),'Nulo'))+'» '
                         + '| UsuarioVinculo : «' + RTRIM( ISNULL( CAST (UsuarioVinculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoVinculo : «' + RTRIM( ISNULL( CAST (DepartamentoVinculo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
