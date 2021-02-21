CREATE TABLE [dbo].[EmpenhosSG] (
    [IdEmpenhoSG]     INT         IDENTITY (1, 1) NOT NULL,
    [TipoDonoEmpenho] VARCHAR (2) NOT NULL,
    [IdDonoEmpenho]   INT         NOT NULL,
    [IdEmpenho]       INT         NULL,
    [IdRestosEmpenho] INT         NULL,
    [IdPagamento]     INT         NULL,
    [IdEmpenhoMCASP]  INT         NULL,
    CONSTRAINT [PK_EmpenhosSG] PRIMARY KEY CLUSTERED ([IdEmpenhoSG] ASC),
    FOREIGN KEY ([IdEmpenhoMCASP]) REFERENCES [dbo].[EmpenhosMCASP] ([IdEmpenhoMCASP])
);


GO
CREATE TRIGGER [TrgLog_EmpenhosSG] ON [Implanta_CRPAM].[dbo].[EmpenhosSG] 
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
SET @TableName = 'EmpenhosSG'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEmpenhoSG : «' + RTRIM( ISNULL( CAST (IdEmpenhoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDonoEmpenho : «' + RTRIM( ISNULL( CAST (TipoDonoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDonoEmpenho : «' + RTRIM( ISNULL( CAST (IdDonoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosEmpenho : «' + RTRIM( ISNULL( CAST (IdRestosEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEmpenhoSG : «' + RTRIM( ISNULL( CAST (IdEmpenhoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDonoEmpenho : «' + RTRIM( ISNULL( CAST (TipoDonoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDonoEmpenho : «' + RTRIM( ISNULL( CAST (IdDonoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosEmpenho : «' + RTRIM( ISNULL( CAST (IdRestosEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEmpenhoSG : «' + RTRIM( ISNULL( CAST (IdEmpenhoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDonoEmpenho : «' + RTRIM( ISNULL( CAST (TipoDonoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDonoEmpenho : «' + RTRIM( ISNULL( CAST (IdDonoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosEmpenho : «' + RTRIM( ISNULL( CAST (IdRestosEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEmpenhoSG : «' + RTRIM( ISNULL( CAST (IdEmpenhoSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDonoEmpenho : «' + RTRIM( ISNULL( CAST (TipoDonoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDonoEmpenho : «' + RTRIM( ISNULL( CAST (IdDonoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosEmpenho : «' + RTRIM( ISNULL( CAST (IdRestosEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
