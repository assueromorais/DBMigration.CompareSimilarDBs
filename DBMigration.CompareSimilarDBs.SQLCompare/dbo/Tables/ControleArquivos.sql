CREATE TABLE [dbo].[ControleArquivos] (
    [IdArquivo]      INT          IDENTITY (1, 1) NOT NULL,
    [NomeArquivo]    VARCHAR (50) NULL,
    [DataGeracao]    DATETIME     NULL,
    [QtdRegistros]   INT          NULL,
    [NSA]            INT          NULL,
    [TipoArquivo]    CHAR (2)     NULL,
    [IdBancoExtrato] INT          NULL,
    CONSTRAINT [PK_ControleArquivos] PRIMARY KEY CLUSTERED ([IdArquivo] ASC),
    CONSTRAINT [FK_ControleArquivos_Bancos] FOREIGN KEY ([IdBancoExtrato]) REFERENCES [dbo].[Bancos] ([IdBanco])
);


GO
CREATE TRIGGER [TrgLog_ControleArquivos] ON [Implanta_CRPAM].[dbo].[ControleArquivos] 
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
SET @TableName = 'ControleArquivos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NSA : «' + RTRIM( ISNULL( CAST (NSA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoArquivo : «' + RTRIM( ISNULL( CAST (TipoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoExtrato : «' + RTRIM( ISNULL( CAST (IdBancoExtrato AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NSA : «' + RTRIM( ISNULL( CAST (NSA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoArquivo : «' + RTRIM( ISNULL( CAST (TipoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoExtrato : «' + RTRIM( ISNULL( CAST (IdBancoExtrato AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NSA : «' + RTRIM( ISNULL( CAST (NSA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoArquivo : «' + RTRIM( ISNULL( CAST (TipoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoExtrato : «' + RTRIM( ISNULL( CAST (IdBancoExtrato AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NSA : «' + RTRIM( ISNULL( CAST (NSA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoArquivo : «' + RTRIM( ISNULL( CAST (TipoArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBancoExtrato : «' + RTRIM( ISNULL( CAST (IdBancoExtrato AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
