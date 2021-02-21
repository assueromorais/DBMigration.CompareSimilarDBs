CREATE TABLE [dbo].[CursosEventosOferecidos] (
    [IdCursoEventoOferecido] INT         IDENTITY (1, 1) NOT NULL,
    [IdPessoa]               INT         NULL,
    [IdCurso]                INT         NOT NULL,
    [Duracao]                INT         NULL,
    [UnidadeDuracao]         VARCHAR (1) NULL,
    [Observacoes]            TEXT        NULL,
    CONSTRAINT [PK_CursosEventosOferecidos] PRIMARY KEY CLUSTERED ([IdCursoEventoOferecido] ASC),
    CONSTRAINT [FK_CursosEventosOferecidos_CursosEventos] FOREIGN KEY ([IdCurso]) REFERENCES [dbo].[CursosEventos] ([IdCursoEvento]),
    CONSTRAINT [FK_CursosEventosOferecidos_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_CursosEventosOferecidos] ON [Implanta_CRPAM].[dbo].[CursosEventosOferecidos] 
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
SET @TableName = 'CursosEventosOferecidos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCursoEventoOferecido : «' + RTRIM( ISNULL( CAST (IdCursoEventoOferecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCurso : «' + RTRIM( ISNULL( CAST (IdCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Duracao : «' + RTRIM( ISNULL( CAST (Duracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeDuracao : «' + RTRIM( ISNULL( CAST (UnidadeDuracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCursoEventoOferecido : «' + RTRIM( ISNULL( CAST (IdCursoEventoOferecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCurso : «' + RTRIM( ISNULL( CAST (IdCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Duracao : «' + RTRIM( ISNULL( CAST (Duracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeDuracao : «' + RTRIM( ISNULL( CAST (UnidadeDuracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCursoEventoOferecido : «' + RTRIM( ISNULL( CAST (IdCursoEventoOferecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCurso : «' + RTRIM( ISNULL( CAST (IdCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Duracao : «' + RTRIM( ISNULL( CAST (Duracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeDuracao : «' + RTRIM( ISNULL( CAST (UnidadeDuracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCursoEventoOferecido : «' + RTRIM( ISNULL( CAST (IdCursoEventoOferecido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCurso : «' + RTRIM( ISNULL( CAST (IdCurso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Duracao : «' + RTRIM( ISNULL( CAST (Duracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UnidadeDuracao : «' + RTRIM( ISNULL( CAST (UnidadeDuracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
