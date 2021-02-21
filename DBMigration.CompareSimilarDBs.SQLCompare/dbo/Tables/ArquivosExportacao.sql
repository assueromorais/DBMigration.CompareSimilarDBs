CREATE TABLE [dbo].[ArquivosExportacao] (
    [IdArquivoExportacao] INT            IDENTITY (1, 1) NOT NULL,
    [NomeArquivo]         VARCHAR (20)   NOT NULL,
    [TamanhoRegArq]       INT            NOT NULL,
    [Sequencial]          INT            CONSTRAINT [DF__ArquivosE__Seque__7341684E] DEFAULT ((0)) NOT NULL,
    [DataUltimaGeracao]   DATETIME       NULL,
    [Path]                VARCHAR (255)  NULL,
    [Agendamento]         VARCHAR (50)   NULL,
    [Criterio]            VARCHAR (2000) NULL,
    [TipoConfig]          INT            NULL,
    CONSTRAINT [PK_ArquivosExportacao] PRIMARY KEY CLUSTERED ([IdArquivoExportacao] ASC)
);


GO
CREATE TRIGGER [TrgLog_ArquivosExportacao] ON [Implanta_CRPAM].[dbo].[ArquivosExportacao] 
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
SET @TableName = 'ArquivosExportacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoRegArq : «' + RTRIM( ISNULL( CAST (TamanhoRegArq AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencial : «' + RTRIM( ISNULL( CAST (Sequencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaGeracao, 113 ),'Nulo'))+'» '
                         + '| Path : «' + RTRIM( ISNULL( CAST (Path AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agendamento : «' + RTRIM( ISNULL( CAST (Agendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Criterio : «' + RTRIM( ISNULL( CAST (Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoConfig : «' + RTRIM( ISNULL( CAST (TipoConfig AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoRegArq : «' + RTRIM( ISNULL( CAST (TamanhoRegArq AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencial : «' + RTRIM( ISNULL( CAST (Sequencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaGeracao, 113 ),'Nulo'))+'» '
                         + '| Path : «' + RTRIM( ISNULL( CAST (Path AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agendamento : «' + RTRIM( ISNULL( CAST (Agendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Criterio : «' + RTRIM( ISNULL( CAST (Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoConfig : «' + RTRIM( ISNULL( CAST (TipoConfig AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoRegArq : «' + RTRIM( ISNULL( CAST (TamanhoRegArq AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencial : «' + RTRIM( ISNULL( CAST (Sequencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaGeracao, 113 ),'Nulo'))+'» '
                         + '| Path : «' + RTRIM( ISNULL( CAST (Path AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agendamento : «' + RTRIM( ISNULL( CAST (Agendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Criterio : «' + RTRIM( ISNULL( CAST (Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoConfig : «' + RTRIM( ISNULL( CAST (TipoConfig AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TamanhoRegArq : «' + RTRIM( ISNULL( CAST (TamanhoRegArq AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Sequencial : «' + RTRIM( ISNULL( CAST (Sequencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaGeracao, 113 ),'Nulo'))+'» '
                         + '| Path : «' + RTRIM( ISNULL( CAST (Path AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agendamento : «' + RTRIM( ISNULL( CAST (Agendamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Criterio : «' + RTRIM( ISNULL( CAST (Criterio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoConfig : «' + RTRIM( ISNULL( CAST (TipoConfig AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
