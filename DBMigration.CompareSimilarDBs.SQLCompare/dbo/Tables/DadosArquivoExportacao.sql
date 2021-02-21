CREATE TABLE [dbo].[DadosArquivoExportacao] (
    [IdDadosArqExp] INT          IDENTITY (1, 1) NOT NULL,
    [NomeTabela]    VARCHAR (35) NULL,
    [NomeCampo]     VARCHAR (40) NULL,
    [DominioNum]    INT          NULL,
    [DominioAlfa]   VARCHAR (50) NULL,
    CONSTRAINT [PK_DadosArquivoExportacao] PRIMARY KEY CLUSTERED ([IdDadosArqExp] ASC)
);


GO
CREATE TRIGGER [TrgLog_DadosArquivoExportacao] ON [Implanta_CRPAM].[dbo].[DadosArquivoExportacao] 
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
SET @TableName = 'DadosArquivoExportacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDadosArqExp : «' + RTRIM( ISNULL( CAST (IdDadosArqExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DominioNum : «' + RTRIM( ISNULL( CAST (DominioNum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DominioAlfa : «' + RTRIM( ISNULL( CAST (DominioAlfa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDadosArqExp : «' + RTRIM( ISNULL( CAST (IdDadosArqExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DominioNum : «' + RTRIM( ISNULL( CAST (DominioNum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DominioAlfa : «' + RTRIM( ISNULL( CAST (DominioAlfa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDadosArqExp : «' + RTRIM( ISNULL( CAST (IdDadosArqExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DominioNum : «' + RTRIM( ISNULL( CAST (DominioNum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DominioAlfa : «' + RTRIM( ISNULL( CAST (DominioAlfa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDadosArqExp : «' + RTRIM( ISNULL( CAST (IdDadosArqExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCampo : «' + RTRIM( ISNULL( CAST (NomeCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DominioNum : «' + RTRIM( ISNULL( CAST (DominioNum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DominioAlfa : «' + RTRIM( ISNULL( CAST (DominioAlfa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
