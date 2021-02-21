CREATE TABLE [dbo].[DocumentosRelacionados] (
    [IdDocumento1] INT NOT NULL,
    [IdDocumento2] INT NOT NULL,
    CONSTRAINT [PK_DocumentosRelacionados] PRIMARY KEY CLUSTERED ([IdDocumento1] ASC, [IdDocumento2] ASC),
    CONSTRAINT [FK_DocumentosRelacionados_DocumentosSisdoc] FOREIGN KEY ([IdDocumento1]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DocumentosRelacionados_DocumentosSisdoc1] FOREIGN KEY ([IdDocumento2]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_DocumentosRelacionados] ON [Implanta_CRPAM].[dbo].[DocumentosRelacionados] 
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
SET @TableName = 'DocumentosRelacionados'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDocumento1 : «' + RTRIM( ISNULL( CAST (IdDocumento1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento2 : «' + RTRIM( ISNULL( CAST (IdDocumento2 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDocumento1 : «' + RTRIM( ISNULL( CAST (IdDocumento1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento2 : «' + RTRIM( ISNULL( CAST (IdDocumento2 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDocumento1 : «' + RTRIM( ISNULL( CAST (IdDocumento1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento2 : «' + RTRIM( ISNULL( CAST (IdDocumento2 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDocumento1 : «' + RTRIM( ISNULL( CAST (IdDocumento1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento2 : «' + RTRIM( ISNULL( CAST (IdDocumento2 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
