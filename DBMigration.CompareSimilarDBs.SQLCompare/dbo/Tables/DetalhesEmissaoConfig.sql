CREATE TABLE [dbo].[DetalhesEmissaoConfig] (
    [IdDetalheEmissaoConfig] INT            IDENTITY (1, 1) NOT NULL,
    [IdDetalheEmissao]       INT            NOT NULL,
    [CodMulta]               TINYINT        NULL,
    [ValorMulta]             MONEY          NULL,
    [CodJuros]               TINYINT        NULL,
    [ValorJuros]             MONEY          NULL,
    [AtualizacaoWeb]         VARCHAR (5000) NULL,
    CONSTRAINT [PK_DetalhesEmissaoConfig] PRIMARY KEY CLUSTERED ([IdDetalheEmissaoConfig] ASC),
    CONSTRAINT [FK_DetalhesEmissaoConfig_DetalhesEmissao] FOREIGN KEY ([IdDetalheEmissao]) REFERENCES [dbo].[DetalhesEmissao] ([IdDetalheEmissao])
);


GO
CREATE NONCLUSTERED INDEX [IX_DetalhesEmissaoConfig_IdDetahleEmissao]
    ON [dbo].[DetalhesEmissaoConfig]([IdDetalheEmissao] ASC);


GO
CREATE TRIGGER [TrgLog_DetalhesEmissaoConfig] ON [Implanta_CRPAM].[dbo].[DetalhesEmissaoConfig] 
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
SET @TableName = 'DetalhesEmissaoConfig'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDetalheEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdDetalheEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMulta : «' + RTRIM( ISNULL( CAST (CodMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodJuros : «' + RTRIM( ISNULL( CAST (CodJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDetalheEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdDetalheEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMulta : «' + RTRIM( ISNULL( CAST (CodMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodJuros : «' + RTRIM( ISNULL( CAST (CodJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDetalheEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdDetalheEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMulta : «' + RTRIM( ISNULL( CAST (CodMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodJuros : «' + RTRIM( ISNULL( CAST (CodJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDetalheEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdDetalheEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodMulta : «' + RTRIM( ISNULL( CAST (CodMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodJuros : «' + RTRIM( ISNULL( CAST (CodJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
