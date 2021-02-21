CREATE TABLE [dbo].[ControleArquivosReceitaCONFEACREA] (
    [IdControleArquivo]   INT          IDENTITY (1, 1) NOT NULL,
    [NomeArquivoOriginal] VARCHAR (50) NULL,
    [DataImportacao]      DATETIME     NULL,
    [QtdRegistros]        INT          NULL,
    [QtdRecusados]        INT          NULL,
    CONSTRAINT [PK_ControleArquivosReceitaCONFEACREA] PRIMARY KEY CLUSTERED ([IdControleArquivo] ASC)
);


GO
CREATE TRIGGER [TrgLog_ControleArquivosReceitaCONFEACREA] ON [Implanta_CRPAM].[dbo].[ControleArquivosReceitaCONFEACREA] 
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
SET @TableName = 'ControleArquivosReceitaCONFEACREA'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdControleArquivo : «' + RTRIM( ISNULL( CAST (IdControleArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoOriginal : «' + RTRIM( ISNULL( CAST (NomeArquivoOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRecusados : «' + RTRIM( ISNULL( CAST (QtdRecusados AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdControleArquivo : «' + RTRIM( ISNULL( CAST (IdControleArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoOriginal : «' + RTRIM( ISNULL( CAST (NomeArquivoOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRecusados : «' + RTRIM( ISNULL( CAST (QtdRecusados AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdControleArquivo : «' + RTRIM( ISNULL( CAST (IdControleArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoOriginal : «' + RTRIM( ISNULL( CAST (NomeArquivoOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRecusados : «' + RTRIM( ISNULL( CAST (QtdRecusados AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdControleArquivo : «' + RTRIM( ISNULL( CAST (IdControleArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoOriginal : «' + RTRIM( ISNULL( CAST (NomeArquivoOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRecusados : «' + RTRIM( ISNULL( CAST (QtdRecusados AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
