CREATE TABLE [dbo].[DominiosArquivoExportacao] (
    [IdDominioArqExp]   INT IDENTITY (1, 1) NOT NULL,
    [IdDadosArqExp]     INT NOT NULL,
    [IdCampoExportacao] INT NOT NULL,
    [IdDominioSiscafw]  INT NOT NULL,
    CONSTRAINT [PK_DominiosArquivoExportacao] PRIMARY KEY CLUSTERED ([IdDominioArqExp] ASC),
    CONSTRAINT [FK_DominiosArquivoExportacao_CamposArquivoExportacao] FOREIGN KEY ([IdCampoExportacao]) REFERENCES [dbo].[CamposArquivoExportacao] ([IdCampoExportacao]),
    CONSTRAINT [FK_DominiosArquivoExportacao_DadosArquivoExportacao] FOREIGN KEY ([IdDadosArqExp]) REFERENCES [dbo].[DadosArquivoExportacao] ([IdDadosArqExp])
);


GO
CREATE TRIGGER [TrgLog_DominiosArquivoExportacao] ON [Implanta_CRPAM].[dbo].[DominiosArquivoExportacao] 
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
SET @TableName = 'DominiosArquivoExportacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDominioArqExp : «' + RTRIM( ISNULL( CAST (IdDominioArqExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDadosArqExp : «' + RTRIM( ISNULL( CAST (IdDadosArqExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCampoExportacao : «' + RTRIM( ISNULL( CAST (IdCampoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDominioSiscafw : «' + RTRIM( ISNULL( CAST (IdDominioSiscafw AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDominioArqExp : «' + RTRIM( ISNULL( CAST (IdDominioArqExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDadosArqExp : «' + RTRIM( ISNULL( CAST (IdDadosArqExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCampoExportacao : «' + RTRIM( ISNULL( CAST (IdCampoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDominioSiscafw : «' + RTRIM( ISNULL( CAST (IdDominioSiscafw AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDominioArqExp : «' + RTRIM( ISNULL( CAST (IdDominioArqExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDadosArqExp : «' + RTRIM( ISNULL( CAST (IdDadosArqExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCampoExportacao : «' + RTRIM( ISNULL( CAST (IdCampoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDominioSiscafw : «' + RTRIM( ISNULL( CAST (IdDominioSiscafw AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDominioArqExp : «' + RTRIM( ISNULL( CAST (IdDominioArqExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDadosArqExp : «' + RTRIM( ISNULL( CAST (IdDadosArqExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCampoExportacao : «' + RTRIM( ISNULL( CAST (IdCampoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDominioSiscafw : «' + RTRIM( ISNULL( CAST (IdDominioSiscafw AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
