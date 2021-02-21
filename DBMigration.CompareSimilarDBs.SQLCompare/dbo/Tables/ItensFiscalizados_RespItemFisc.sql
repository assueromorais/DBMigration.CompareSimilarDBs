CREATE TABLE [dbo].[ItensFiscalizados_RespItemFisc] (
    [IdItensFiscalizados] INT NOT NULL,
    [IdRespItemFisc]      INT NOT NULL,
    CONSTRAINT [PK_ItensFiscalizados_RespItemFisc] PRIMARY KEY CLUSTERED ([IdItensFiscalizados] ASC, [IdRespItemFisc] ASC),
    CONSTRAINT [FK_ItensFiscalizados_RespItemFisc_ItensPossiveisFiscalizacao] FOREIGN KEY ([IdItensFiscalizados]) REFERENCES [dbo].[ItensPossiveisFiscalizacao] ([IdItemFiscalizacao]),
    CONSTRAINT [FK_ItensFiscalizados_RespItemFisc_RespPossiveisFiscalizacao] FOREIGN KEY ([IdRespItemFisc]) REFERENCES [dbo].[RespPossiveisFiscalizacao] ([IdRespltemFiscaliz])
);


GO
CREATE TRIGGER [TrgLog_ItensFiscalizados_RespItemFisc] ON [Implanta_CRPAM].[dbo].[ItensFiscalizados_RespItemFisc] 
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
SET @TableName = 'ItensFiscalizados_RespItemFisc'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItensFiscalizados : «' + RTRIM( ISNULL( CAST (IdItensFiscalizados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRespItemFisc : «' + RTRIM( ISNULL( CAST (IdRespItemFisc AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItensFiscalizados : «' + RTRIM( ISNULL( CAST (IdItensFiscalizados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRespItemFisc : «' + RTRIM( ISNULL( CAST (IdRespItemFisc AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdItensFiscalizados : «' + RTRIM( ISNULL( CAST (IdItensFiscalizados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRespItemFisc : «' + RTRIM( ISNULL( CAST (IdRespItemFisc AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItensFiscalizados : «' + RTRIM( ISNULL( CAST (IdItensFiscalizados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRespItemFisc : «' + RTRIM( ISNULL( CAST (IdRespItemFisc AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
