CREATE TABLE [dbo].[CursosAtribuicoes] (
    [IdCursoAtribuicao] INT           IDENTITY (1, 1) NOT NULL,
    [IdCursoEvento]     INT           NULL,
    [Codigo]            VARCHAR (2)   NULL,
    [Descricao]         VARCHAR (180) NULL,
    PRIMARY KEY CLUSTERED ([IdCursoAtribuicao] ASC),
    CONSTRAINT [FK_CursosAtribuicoes_IdCursoEvento] FOREIGN KEY ([IdCursoEvento]) REFERENCES [dbo].[CursosEventos] ([IdCursoEvento])
);


GO
CREATE TRIGGER [TrgLog_CursosAtribuicoes] ON [Implanta_CRPAM].[dbo].[CursosAtribuicoes] 
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
SET @TableName = 'CursosAtribuicoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCursoAtribuicao : «' + RTRIM( ISNULL( CAST (IdCursoAtribuicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCursoEvento : «' + RTRIM( ISNULL( CAST (IdCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCursoAtribuicao : «' + RTRIM( ISNULL( CAST (IdCursoAtribuicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCursoEvento : «' + RTRIM( ISNULL( CAST (IdCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCursoAtribuicao : «' + RTRIM( ISNULL( CAST (IdCursoAtribuicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCursoEvento : «' + RTRIM( ISNULL( CAST (IdCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCursoAtribuicao : «' + RTRIM( ISNULL( CAST (IdCursoAtribuicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCursoEvento : «' + RTRIM( ISNULL( CAST (IdCursoEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
