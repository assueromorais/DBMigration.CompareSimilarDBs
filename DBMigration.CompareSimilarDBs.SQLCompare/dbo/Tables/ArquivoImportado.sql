CREATE TABLE [dbo].[ArquivoImportado] (
    [IdArquivo]          INT           IDENTITY (1, 1) NOT NULL,
    [IdExameOrdem]       INT           NOT NULL,
    [TipoArquivo]        INT           NOT NULL,
    [NomeOriginal]       VARCHAR (150) NULL,
    [DataImportacao]     DATETIME      NOT NULL,
    [UsuarioQueImportou] INT           NOT NULL,
    [QtdRegistros]       INT           NOT NULL,
    CONSTRAINT [PK_ArquivoImportado] PRIMARY KEY CLUSTERED ([IdArquivo] ASC),
    CONSTRAINT [FK_ArquivoImportado_ExameOrdem] FOREIGN KEY ([IdExameOrdem]) REFERENCES [dbo].[ExameOrdem] ([IdExame])
);


GO
CREATE TRIGGER [TrgLog_ArquivoImportado] ON [Implanta_CRPAM].[dbo].[ArquivoImportado] 
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
SET @TableName = 'ArquivoImportado'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdExameOrdem : «' + RTRIM( ISNULL( CAST (IdExameOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoArquivo : «' + RTRIM( ISNULL( CAST (TipoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeOriginal : «' + RTRIM( ISNULL( CAST (NomeOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioQueImportou : «' + RTRIM( ISNULL( CAST (UsuarioQueImportou AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdExameOrdem : «' + RTRIM( ISNULL( CAST (IdExameOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoArquivo : «' + RTRIM( ISNULL( CAST (TipoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeOriginal : «' + RTRIM( ISNULL( CAST (NomeOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioQueImportou : «' + RTRIM( ISNULL( CAST (UsuarioQueImportou AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdExameOrdem : «' + RTRIM( ISNULL( CAST (IdExameOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoArquivo : «' + RTRIM( ISNULL( CAST (TipoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeOriginal : «' + RTRIM( ISNULL( CAST (NomeOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioQueImportou : «' + RTRIM( ISNULL( CAST (UsuarioQueImportou AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdExameOrdem : «' + RTRIM( ISNULL( CAST (IdExameOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoArquivo : «' + RTRIM( ISNULL( CAST (TipoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeOriginal : «' + RTRIM( ISNULL( CAST (NomeOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| UsuarioQueImportou : «' + RTRIM( ISNULL( CAST (UsuarioQueImportou AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
