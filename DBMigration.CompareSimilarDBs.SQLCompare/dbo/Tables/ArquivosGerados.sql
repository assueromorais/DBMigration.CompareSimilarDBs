CREATE TABLE [dbo].[ArquivosGerados] (
    [IdArquivoGerado]  INT          IDENTITY (1, 1) NOT NULL,
    [NomeArquivo]      VARCHAR (15) NULL,
    [CodigoBanco]      VARCHAR (3)  NULL,
    [NumProfissionais] INT          NULL,
    [NumRegistros]     INT          NULL,
    [DataGeracao]      DATETIME     NULL,
    [CriterioSelecao]  TEXT         NULL,
    CONSTRAINT [PK_ArquivosGerados] PRIMARY KEY CLUSTERED ([IdArquivoGerado] ASC)
);


GO
CREATE TRIGGER [TrgLog_ArquivosGerados] ON [Implanta_CRPAM].[dbo].[ArquivosGerados] 
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
SET @TableName = 'ArquivosGerados'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivoGerado : «' + RTRIM( ISNULL( CAST (IdArquivoGerado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumProfissionais : «' + RTRIM( ISNULL( CAST (NumProfissionais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumRegistros : «' + RTRIM( ISNULL( CAST (NumRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivoGerado : «' + RTRIM( ISNULL( CAST (IdArquivoGerado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumProfissionais : «' + RTRIM( ISNULL( CAST (NumProfissionais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumRegistros : «' + RTRIM( ISNULL( CAST (NumRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdArquivoGerado : «' + RTRIM( ISNULL( CAST (IdArquivoGerado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumProfissionais : «' + RTRIM( ISNULL( CAST (NumProfissionais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumRegistros : «' + RTRIM( ISNULL( CAST (NumRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivoGerado : «' + RTRIM( ISNULL( CAST (IdArquivoGerado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumProfissionais : «' + RTRIM( ISNULL( CAST (NumProfissionais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumRegistros : «' + RTRIM( ISNULL( CAST (NumRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
