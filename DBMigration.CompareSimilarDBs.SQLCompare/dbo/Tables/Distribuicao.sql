CREATE TABLE [dbo].[Distribuicao] (
    [IdDistribuicao] INT      IDENTITY (1, 1) NOT NULL,
    [IdRelator]      INT      NULL,
    [Data]           DATETIME NOT NULL,
    [IdProcessoFase] INT      NULL,
    [DataFim]        DATETIME NULL,
    [IdInstrutor]    INT      NULL,
    CONSTRAINT [PK_Distribuicao] PRIMARY KEY CLUSTERED ([IdDistribuicao] ASC),
    CONSTRAINT [FK_Distribuicao_Processo_Fases] FOREIGN KEY ([IdProcessoFase]) REFERENCES [dbo].[Processo_Fases] ([IdProcessoFases]),
    CONSTRAINT [FK_Distribuicao_Profissionais] FOREIGN KEY ([IdRelator]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
CREATE TRIGGER [TrgLog_Distribuicao] ON [Implanta_CRPAM].[dbo].[Distribuicao] 
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
SET @TableName = 'Distribuicao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDistribuicao : «' + RTRIM( ISNULL( CAST (IdDistribuicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelator : «' + RTRIM( ISNULL( CAST (IdRelator AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdProcessoFase : «' + RTRIM( ISNULL( CAST (IdProcessoFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| IdInstrutor : «' + RTRIM( ISNULL( CAST (IdInstrutor AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDistribuicao : «' + RTRIM( ISNULL( CAST (IdDistribuicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelator : «' + RTRIM( ISNULL( CAST (IdRelator AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdProcessoFase : «' + RTRIM( ISNULL( CAST (IdProcessoFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| IdInstrutor : «' + RTRIM( ISNULL( CAST (IdInstrutor AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDistribuicao : «' + RTRIM( ISNULL( CAST (IdDistribuicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelator : «' + RTRIM( ISNULL( CAST (IdRelator AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdProcessoFase : «' + RTRIM( ISNULL( CAST (IdProcessoFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| IdInstrutor : «' + RTRIM( ISNULL( CAST (IdInstrutor AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDistribuicao : «' + RTRIM( ISNULL( CAST (IdDistribuicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelator : «' + RTRIM( ISNULL( CAST (IdRelator AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdProcessoFase : «' + RTRIM( ISNULL( CAST (IdProcessoFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» '
                         + '| IdInstrutor : «' + RTRIM( ISNULL( CAST (IdInstrutor AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
