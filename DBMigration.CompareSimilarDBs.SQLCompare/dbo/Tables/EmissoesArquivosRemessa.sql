CREATE TABLE [dbo].[EmissoesArquivosRemessa] (
    [IdEmissaoArquivoRemessa] INT           IDENTITY (1, 1) NOT NULL,
    [IdEmissaoConfig]         INT           NULL,
    [Data]                    DATETIME      CONSTRAINT [DF_EmissoesArquivosRemessa_DataGeracao] DEFAULT (getdate()) NOT NULL,
    [Usuario]                 VARCHAR (35)  CONSTRAINT [DF_EmissoesArquivoRemessa_Usuario] DEFAULT (host_name()) NOT NULL,
    [NomeArquivo]             VARCHAR (255) NOT NULL,
    [Tamanho]                 INT           NOT NULL,
    [Arquivo]                 IMAGE         NOT NULL,
    CONSTRAINT [PK_EmissoesArquivosRemessa] PRIMARY KEY CLUSTERED ([IdEmissaoArquivoRemessa] ASC),
    CONSTRAINT [FK_EmissoesArquivosRemessa_EmissaoConfig] FOREIGN KEY ([IdEmissaoConfig]) REFERENCES [dbo].[EmissoesConfig] ([IdEmissaoConfig])
);


GO
CREATE TRIGGER [TrgLog_EmissoesArquivosRemessa] ON [Implanta_CRPAM].[dbo].[EmissoesArquivosRemessa] 
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
SET @TableName = 'EmissoesArquivosRemessa'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEmissaoArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdEmissaoArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tamanho : «' + RTRIM( ISNULL( CAST (Tamanho AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEmissaoArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdEmissaoArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tamanho : «' + RTRIM( ISNULL( CAST (Tamanho AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEmissaoArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdEmissaoArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tamanho : «' + RTRIM( ISNULL( CAST (Tamanho AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEmissaoArquivoRemessa : «' + RTRIM( ISNULL( CAST (IdEmissaoArquivoRemessa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tamanho : «' + RTRIM( ISNULL( CAST (Tamanho AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
