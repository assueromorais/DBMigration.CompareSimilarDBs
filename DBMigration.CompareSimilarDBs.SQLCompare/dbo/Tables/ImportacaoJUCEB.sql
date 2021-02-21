CREATE TABLE [dbo].[ImportacaoJUCEB] (
    [IdImportacao]   INT          IDENTITY (1, 1) NOT NULL,
    [DataImportcao]  DATETIME     NOT NULL,
    [UsuarioCriacao] VARCHAR (50) NOT NULL,
    [NomeArquivoEmp] VARCHAR (50) NULL,
    [NomeArquivoSoc] VARCHAR (50) NULL,
    CONSTRAINT [PK_ImportacaoJUCEB] PRIMARY KEY CLUSTERED ([IdImportacao] ASC)
);


GO
CREATE TRIGGER [TrgLog_ImportacaoJUCEB] ON [Implanta_CRPAM].[dbo].[ImportacaoJUCEB] 
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
SET @TableName = 'ImportacaoJUCEB'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdImportacao : «' + RTRIM( ISNULL( CAST (IdImportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportcao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportcao, 113 ),'Nulo'))+'» '
                         + '| UsuarioCriacao : «' + RTRIM( ISNULL( CAST (UsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoEmp : «' + RTRIM( ISNULL( CAST (NomeArquivoEmp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoSoc : «' + RTRIM( ISNULL( CAST (NomeArquivoSoc AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdImportacao : «' + RTRIM( ISNULL( CAST (IdImportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportcao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportcao, 113 ),'Nulo'))+'» '
                         + '| UsuarioCriacao : «' + RTRIM( ISNULL( CAST (UsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoEmp : «' + RTRIM( ISNULL( CAST (NomeArquivoEmp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoSoc : «' + RTRIM( ISNULL( CAST (NomeArquivoSoc AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdImportacao : «' + RTRIM( ISNULL( CAST (IdImportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportcao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportcao, 113 ),'Nulo'))+'» '
                         + '| UsuarioCriacao : «' + RTRIM( ISNULL( CAST (UsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoEmp : «' + RTRIM( ISNULL( CAST (NomeArquivoEmp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoSoc : «' + RTRIM( ISNULL( CAST (NomeArquivoSoc AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdImportacao : «' + RTRIM( ISNULL( CAST (IdImportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportcao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportcao, 113 ),'Nulo'))+'» '
                         + '| UsuarioCriacao : «' + RTRIM( ISNULL( CAST (UsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoEmp : «' + RTRIM( ISNULL( CAST (NomeArquivoEmp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoSoc : «' + RTRIM( ISNULL( CAST (NomeArquivoSoc AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
