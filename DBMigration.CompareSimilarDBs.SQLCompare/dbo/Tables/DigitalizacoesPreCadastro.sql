CREATE TABLE [dbo].[DigitalizacoesPreCadastro] (
    [IdDigitalizacaoPreCadastro] INT IDENTITY (1, 1) NOT NULL,
    [IdPessoa]                   INT NOT NULL,
    [IdControleDigitalizacoes]   INT NOT NULL,
    CONSTRAINT [PK_DigitalizacoesPreCadastro] PRIMARY KEY CLUSTERED ([IdDigitalizacaoPreCadastro] ASC),
    CONSTRAINT [FK_DigitalizacoesPreCadastro_IdControleDigitalizacoes] FOREIGN KEY ([IdControleDigitalizacoes]) REFERENCES [dbo].[ControleDigitalizacoes] ([IdControleDigitalizacoes]),
    CONSTRAINT [FK_DigitalizacoesPreCadastro_IdPessoa] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);


GO
CREATE TRIGGER [TrgLog_DigitalizacoesPreCadastro] ON [Implanta_CRPAM].[dbo].[DigitalizacoesPreCadastro] 
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
SET @TableName = 'DigitalizacoesPreCadastro'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDigitalizacaoPreCadastro : «' + RTRIM( ISNULL( CAST (IdDigitalizacaoPreCadastro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDigitalizacaoPreCadastro : «' + RTRIM( ISNULL( CAST (IdDigitalizacaoPreCadastro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDigitalizacaoPreCadastro : «' + RTRIM( ISNULL( CAST (IdDigitalizacaoPreCadastro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDigitalizacaoPreCadastro : «' + RTRIM( ISNULL( CAST (IdDigitalizacaoPreCadastro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleDigitalizacoes : «' + RTRIM( ISNULL( CAST (IdControleDigitalizacoes AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
