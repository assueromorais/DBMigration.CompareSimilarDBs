CREATE TABLE [dbo].[Documentos] (
    [IdDonoDoc]       INT           NOT NULL,
    [TipoDonoDoc]     CHAR (1)      NOT NULL,
    [IdTipoDocumento] INT           NOT NULL,
    [TituloDoc]       VARCHAR (150) NULL,
    [CaminhoDoc]      VARCHAR (250) NULL,
    [Observacao]      TEXT          NULL,
    CONSTRAINT [FK_Documentos_Contratos] FOREIGN KEY ([IdDonoDoc]) REFERENCES [dbo].[Contratos] ([IdContrato]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Documentos_Licitacoes] FOREIGN KEY ([IdDonoDoc]) REFERENCES [dbo].[Licitacoes] ([IdLicitacao]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[Documentos] NOCHECK CONSTRAINT [FK_Documentos_Contratos];


GO
ALTER TABLE [dbo].[Documentos] NOCHECK CONSTRAINT [FK_Documentos_Licitacoes];


GO
CREATE TRIGGER [TrgLog_Documentos] ON [Implanta_CRPAM].[dbo].[Documentos] 
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
SET @TableName = 'Documentos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDonoDoc : «' + RTRIM( ISNULL( CAST (IdDonoDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDonoDoc : «' + RTRIM( ISNULL( CAST (TipoDonoDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloDoc : «' + RTRIM( ISNULL( CAST (TituloDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoDoc : «' + RTRIM( ISNULL( CAST (CaminhoDoc AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDonoDoc : «' + RTRIM( ISNULL( CAST (IdDonoDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDonoDoc : «' + RTRIM( ISNULL( CAST (TipoDonoDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloDoc : «' + RTRIM( ISNULL( CAST (TituloDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoDoc : «' + RTRIM( ISNULL( CAST (CaminhoDoc AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDonoDoc : «' + RTRIM( ISNULL( CAST (IdDonoDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDonoDoc : «' + RTRIM( ISNULL( CAST (TipoDonoDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloDoc : «' + RTRIM( ISNULL( CAST (TituloDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoDoc : «' + RTRIM( ISNULL( CAST (CaminhoDoc AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDonoDoc : «' + RTRIM( ISNULL( CAST (IdDonoDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDonoDoc : «' + RTRIM( ISNULL( CAST (TipoDonoDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumento : «' + RTRIM( ISNULL( CAST (IdTipoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloDoc : «' + RTRIM( ISNULL( CAST (TituloDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoDoc : «' + RTRIM( ISNULL( CAST (CaminhoDoc AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
