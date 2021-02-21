CREATE TABLE [dbo].[DocumentosFixos] (
    [IdDocumentoFixo] INT           IDENTITY (1, 1) NOT NULL,
    [Titulo]          VARCHAR (150) NULL,
    [Documento]       TEXT          NULL,
    CONSTRAINT [PK_DocumentosFixos] PRIMARY KEY CLUSTERED ([IdDocumentoFixo] ASC)
);


GO
CREATE TRIGGER [TrgLog_DocumentosFixos] ON [Implanta_CRPAM].[dbo].[DocumentosFixos] 
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
SET @TableName = 'DocumentosFixos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDocumentoFixo : «' + RTRIM( ISNULL( CAST (IdDocumentoFixo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Titulo : «' + RTRIM( ISNULL( CAST (Titulo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDocumentoFixo : «' + RTRIM( ISNULL( CAST (IdDocumentoFixo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Titulo : «' + RTRIM( ISNULL( CAST (Titulo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDocumentoFixo : «' + RTRIM( ISNULL( CAST (IdDocumentoFixo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Titulo : «' + RTRIM( ISNULL( CAST (Titulo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDocumentoFixo : «' + RTRIM( ISNULL( CAST (IdDocumentoFixo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Titulo : «' + RTRIM( ISNULL( CAST (Titulo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
