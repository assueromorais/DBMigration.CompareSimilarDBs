CREATE TABLE [dbo].[LocaisExameOrdem] (
    [IdLocalExame] INT           IDENTITY (1, 1) NOT NULL,
    [IdExame]      INT           NOT NULL,
    [IdPessoa]     INT           NOT NULL,
    [MaxInscritos] INT           NOT NULL,
    [TipoProva]    INT           NULL,
    [CodigoLocal]  VARCHAR (3)   NULL,
    [NomeLocal]    VARCHAR (100) NULL,
    CONSTRAINT [PK_LocaisExameOrdem] PRIMARY KEY CLUSTERED ([IdLocalExame] ASC),
    CONSTRAINT [FK_LocaisExameOrdem_ExameOrdem] FOREIGN KEY ([IdExame]) REFERENCES [dbo].[ExameOrdem] ([IdExame]),
    CONSTRAINT [FK_LocaisExameOrdem_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);


GO
CREATE TRIGGER [TrgLog_LocaisExameOrdem] ON [Implanta_CRPAM].[dbo].[LocaisExameOrdem] 
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
SET @TableName = 'LocaisExameOrdem'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLocalExame : «' + RTRIM( ISNULL( CAST (IdLocalExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdExame : «' + RTRIM( ISNULL( CAST (IdExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MaxInscritos : «' + RTRIM( ISNULL( CAST (MaxInscritos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoProva : «' + RTRIM( ISNULL( CAST (TipoProva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoLocal : «' + RTRIM( ISNULL( CAST (CodigoLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeLocal : «' + RTRIM( ISNULL( CAST (NomeLocal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLocalExame : «' + RTRIM( ISNULL( CAST (IdLocalExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdExame : «' + RTRIM( ISNULL( CAST (IdExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MaxInscritos : «' + RTRIM( ISNULL( CAST (MaxInscritos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoProva : «' + RTRIM( ISNULL( CAST (TipoProva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoLocal : «' + RTRIM( ISNULL( CAST (CodigoLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeLocal : «' + RTRIM( ISNULL( CAST (NomeLocal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLocalExame : «' + RTRIM( ISNULL( CAST (IdLocalExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdExame : «' + RTRIM( ISNULL( CAST (IdExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MaxInscritos : «' + RTRIM( ISNULL( CAST (MaxInscritos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoProva : «' + RTRIM( ISNULL( CAST (TipoProva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoLocal : «' + RTRIM( ISNULL( CAST (CodigoLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeLocal : «' + RTRIM( ISNULL( CAST (NomeLocal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLocalExame : «' + RTRIM( ISNULL( CAST (IdLocalExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdExame : «' + RTRIM( ISNULL( CAST (IdExame AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MaxInscritos : «' + RTRIM( ISNULL( CAST (MaxInscritos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoProva : «' + RTRIM( ISNULL( CAST (TipoProva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoLocal : «' + RTRIM( ISNULL( CAST (CodigoLocal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeLocal : «' + RTRIM( ISNULL( CAST (NomeLocal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
