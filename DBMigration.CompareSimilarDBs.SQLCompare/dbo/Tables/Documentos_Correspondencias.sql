CREATE TABLE [dbo].[Documentos_Correspondencias] (
    [IdDocumento]       INT NOT NULL,
    [IdCorrespondencia] INT NOT NULL,
    CONSTRAINT [PK_Correspondencia_DocSisdoc] PRIMARY KEY CLUSTERED ([IdCorrespondencia] ASC, [IdDocumento] ASC),
    CONSTRAINT [FK_Documentos_Correspondencias_Correspodencias] FOREIGN KEY ([IdCorrespondencia]) REFERENCES [dbo].[Correspondencias] ([IdCorrespondencia]),
    CONSTRAINT [FK_Documentos_Correspondencias_DocumentosSisdoc] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento])
);


GO
CREATE TRIGGER [TrgLog_Documentos_Correspondencias] ON [Implanta_CRPAM].[dbo].[Documentos_Correspondencias] 
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
SET @TableName = 'Documentos_Correspondencias'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrespondencia : «' + RTRIM( ISNULL( CAST (IdCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrespondencia : «' + RTRIM( ISNULL( CAST (IdCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrespondencia : «' + RTRIM( ISNULL( CAST (IdCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDocumento : «' + RTRIM( ISNULL( CAST (IdDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCorrespondencia : «' + RTRIM( ISNULL( CAST (IdCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
