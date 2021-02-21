CREATE TABLE [dbo].[FasesLicitacoes] (
    [IdLicitacao]    INT      NOT NULL,
    [IdFase]         INT      NOT NULL,
    [Ordem]          INT      NULL,
    [DataInicio]     DATETIME NULL,
    [DataFim]        DATETIME NULL,
    [IdResponsavel]  INT      NULL,
    [PrevisaoInicio] DATETIME NOT NULL,
    [PrevisaoFim]    DATETIME NOT NULL,
    CONSTRAINT [PK_FasesLicitacoes] PRIMARY KEY CLUSTERED ([IdLicitacao] ASC, [IdFase] ASC),
    CONSTRAINT [FK_FasesLicitacoes_Fases] FOREIGN KEY ([IdFase]) REFERENCES [dbo].[Fases] ([IdFase]) NOT FOR REPLICATION,
    CONSTRAINT [FK_FasesLicitacoes_Licitacoes] FOREIGN KEY ([IdLicitacao]) REFERENCES [dbo].[Licitacoes] ([IdLicitacao]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_FasesLicitacoes] ON [Implanta_CRPAM].[dbo].[FasesLicitacoes] 
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
SET @TableName = 'FasesLicitacoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFase : «' + RTRIM( ISNULL( CAST (IdFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrevisaoInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, PrevisaoInicio, 113 ),'Nulo'))+'» '
                         + '| PrevisaoFim : «' + RTRIM( ISNULL( CONVERT (CHAR, PrevisaoFim, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFase : «' + RTRIM( ISNULL( CAST (IdFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrevisaoInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, PrevisaoInicio, 113 ),'Nulo'))+'» '
                         + '| PrevisaoFim : «' + RTRIM( ISNULL( CONVERT (CHAR, PrevisaoFim, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFase : «' + RTRIM( ISNULL( CAST (IdFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrevisaoInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, PrevisaoInicio, 113 ),'Nulo'))+'» '
                         + '| PrevisaoFim : «' + RTRIM( ISNULL( CONVERT (CHAR, PrevisaoFim, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLicitacao : «' + RTRIM( ISNULL( CAST (IdLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFase : «' + RTRIM( ISNULL( CAST (IdFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrevisaoInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, PrevisaoInicio, 113 ),'Nulo'))+'» '
                         + '| PrevisaoFim : «' + RTRIM( ISNULL( CONVERT (CHAR, PrevisaoFim, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
