CREATE TABLE [dbo].[HistoricoStatusPassagem] (
    [IdHistoricoStatusPassagem] INT           IDENTITY (1, 1) NOT NULL,
    [IdPassagemAereaEmitida]    INT           NULL,
    [Data]                      DATETIME      NULL,
    [IdStatusPassagem]          INT           NULL,
    [Usuario]                   VARCHAR (120) NULL,
    CONSTRAINT [PK_HistoricoStatusPassagem] PRIMARY KEY CLUSTERED ([IdHistoricoStatusPassagem] ASC),
    CONSTRAINT [FK_HistoricoStatusPassagem_PassagensAereasEmitidas] FOREIGN KEY ([IdPassagemAereaEmitida]) REFERENCES [dbo].[PassagensAereasEmitidas] ([IdPassagemAereaEmitida]),
    CONSTRAINT [FK_HistoricoStatusPassagem_StatusPassagem] FOREIGN KEY ([IdStatusPassagem]) REFERENCES [dbo].[StatusPassagem] ([IdStatusPassagem])
);


GO
CREATE TRIGGER [TrgLog_HistoricoStatusPassagem] ON [Implanta_CRPAM].[dbo].[HistoricoStatusPassagem] 
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
SET @TableName = 'HistoricoStatusPassagem'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistoricoStatusPassagem : «' + RTRIM( ISNULL( CAST (IdHistoricoStatusPassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPassagemAereaEmitida : «' + RTRIM( ISNULL( CAST (IdPassagemAereaEmitida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdStatusPassagem : «' + RTRIM( ISNULL( CAST (IdStatusPassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistoricoStatusPassagem : «' + RTRIM( ISNULL( CAST (IdHistoricoStatusPassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPassagemAereaEmitida : «' + RTRIM( ISNULL( CAST (IdPassagemAereaEmitida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdStatusPassagem : «' + RTRIM( ISNULL( CAST (IdStatusPassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistoricoStatusPassagem : «' + RTRIM( ISNULL( CAST (IdHistoricoStatusPassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPassagemAereaEmitida : «' + RTRIM( ISNULL( CAST (IdPassagemAereaEmitida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdStatusPassagem : «' + RTRIM( ISNULL( CAST (IdStatusPassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistoricoStatusPassagem : «' + RTRIM( ISNULL( CAST (IdHistoricoStatusPassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPassagemAereaEmitida : «' + RTRIM( ISNULL( CAST (IdPassagemAereaEmitida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdStatusPassagem : «' + RTRIM( ISNULL( CAST (IdStatusPassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
