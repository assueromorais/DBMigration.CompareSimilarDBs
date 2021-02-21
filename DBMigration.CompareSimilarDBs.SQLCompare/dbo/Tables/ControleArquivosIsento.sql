CREATE TABLE [dbo].[ControleArquivosIsento] (
    [IdArquivo]      INT          IDENTITY (1, 1) NOT NULL,
    [NomeArquivo]    VARCHAR (50) NULL,
    [DataGeracao]    DATETIME     NOT NULL,
    [AnoCalendario]  VARCHAR (4)  NULL,
    [TipoMidia]      VARCHAR (2)  NULL,
    [TipoDeclaracao] VARCHAR (2)  NULL,
    [PessoasArquivo] TEXT         NULL,
    CONSTRAINT [PK_ControleArquivosIsento] PRIMARY KEY CLUSTERED ([IdArquivo] ASC)
);


GO
CREATE TRIGGER [TrgLog_ControleArquivosIsento] ON [Implanta_CRPAM].[dbo].[ControleArquivosIsento] 
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
SET @TableName = 'ControleArquivosIsento'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| AnoCalendario : «' + RTRIM( ISNULL( CAST (AnoCalendario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMidia : «' + RTRIM( ISNULL( CAST (TipoMidia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDeclaracao : «' + RTRIM( ISNULL( CAST (TipoDeclaracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| AnoCalendario : «' + RTRIM( ISNULL( CAST (AnoCalendario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMidia : «' + RTRIM( ISNULL( CAST (TipoMidia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDeclaracao : «' + RTRIM( ISNULL( CAST (TipoDeclaracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| AnoCalendario : «' + RTRIM( ISNULL( CAST (AnoCalendario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMidia : «' + RTRIM( ISNULL( CAST (TipoMidia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDeclaracao : «' + RTRIM( ISNULL( CAST (TipoDeclaracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| AnoCalendario : «' + RTRIM( ISNULL( CAST (AnoCalendario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMidia : «' + RTRIM( ISNULL( CAST (TipoMidia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDeclaracao : «' + RTRIM( ISNULL( CAST (TipoDeclaracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
