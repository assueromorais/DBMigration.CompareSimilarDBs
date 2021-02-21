CREATE TABLE [dbo].[AcervoTecnico_Documentos] (
    [IdAcervoTecnicoDocumento] INT IDENTITY (1, 1) NOT NULL,
    [IdAcervoTecnico]          INT NULL,
    [IdDocumento]              INT NULL,
    CONSTRAINT [PK_AcervoTecnicoDocumentos] PRIMARY KEY CLUSTERED ([IdAcervoTecnicoDocumento] ASC),
    CONSTRAINT [FK_AcervoTecnico_Documentos_Acervo] FOREIGN KEY ([IdAcervoTecnico]) REFERENCES [dbo].[AcervoTecnico] ([IdAcervoTecnico]),
    CONSTRAINT [FK_AcervoTecnico_Documentos_Documento] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento])
);


GO
CREATE TRIGGER [TrgLog_AcervoTecnico_Documentos] ON [Implanta_CRPAM].[dbo].[AcervoTecnico_Documentos] 
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
SET @TableName = 'AcervoTecnico_Documentos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAcervoTecnicoDocumento : «' + RTRIM( ISNULL( CAST (IdAcervoTecnicoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcervoTecnico : «' + RTRIM( ISNULL( CAST (IdAcervoTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAcervoTecnicoDocumento : «' + RTRIM( ISNULL( CAST (IdAcervoTecnicoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcervoTecnico : «' + RTRIM( ISNULL( CAST (IdAcervoTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAcervoTecnicoDocumento : «' + RTRIM( ISNULL( CAST (IdAcervoTecnicoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcervoTecnico : «' + RTRIM( ISNULL( CAST (IdAcervoTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAcervoTecnicoDocumento : «' + RTRIM( ISNULL( CAST (IdAcervoTecnicoDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAcervoTecnico : «' + RTRIM( ISNULL( CAST (IdAcervoTecnico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
