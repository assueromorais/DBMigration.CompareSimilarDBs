CREATE TABLE [dbo].[ArquivoSolicitacao] (
    [IdArquivoSolicitacao] INT           IDENTITY (1, 1) NOT NULL,
    [IdPreSolicitacao]     INT           NOT NULL,
    [NomeArquivo]          VARCHAR (60)  NULL,
    [Caminho]              VARCHAR (100) NULL,
    [Extensao]             VARCHAR (30)  NULL,
    [Tamanho]              INT           NULL,
    [DataEnvio]            DATETIME      NULL,
    CONSTRAINT [PK_ArquivoSolicitacao] PRIMARY KEY CLUSTERED ([IdArquivoSolicitacao] ASC),
    CONSTRAINT [FK_ArquivoSolicitacao_PreSolicitacoes] FOREIGN KEY ([IdPreSolicitacao]) REFERENCES [dbo].[PreSolicitacoes] ([IdPreSolicitacao])
);


GO
CREATE TRIGGER [TrgLog_ArquivoSolicitacao] ON [Implanta_CRPAM].[dbo].[ArquivoSolicitacao] 
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
SET @TableName = 'ArquivoSolicitacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivoSolicitacao : «' + RTRIM( ISNULL( CAST (IdArquivoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreSolicitacao : «' + RTRIM( ISNULL( CAST (IdPreSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Caminho : «' + RTRIM( ISNULL( CAST (Caminho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Extensao : «' + RTRIM( ISNULL( CAST (Extensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tamanho : «' + RTRIM( ISNULL( CAST (Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivoSolicitacao : «' + RTRIM( ISNULL( CAST (IdArquivoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreSolicitacao : «' + RTRIM( ISNULL( CAST (IdPreSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Caminho : «' + RTRIM( ISNULL( CAST (Caminho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Extensao : «' + RTRIM( ISNULL( CAST (Extensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tamanho : «' + RTRIM( ISNULL( CAST (Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdArquivoSolicitacao : «' + RTRIM( ISNULL( CAST (IdArquivoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreSolicitacao : «' + RTRIM( ISNULL( CAST (IdPreSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Caminho : «' + RTRIM( ISNULL( CAST (Caminho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Extensao : «' + RTRIM( ISNULL( CAST (Extensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tamanho : «' + RTRIM( ISNULL( CAST (Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivoSolicitacao : «' + RTRIM( ISNULL( CAST (IdArquivoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPreSolicitacao : «' + RTRIM( ISNULL( CAST (IdPreSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Caminho : «' + RTRIM( ISNULL( CAST (Caminho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Extensao : «' + RTRIM( ISNULL( CAST (Extensao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tamanho : «' + RTRIM( ISNULL( CAST (Tamanho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
