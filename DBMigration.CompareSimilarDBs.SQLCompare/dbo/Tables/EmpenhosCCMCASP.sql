CREATE TABLE [dbo].[EmpenhosCCMCASP] (
    [IdEmpenhoCCMCASP] INT              IDENTITY (1, 1) NOT NULL,
    [IdEmpenhoMCASP]   INT              NOT NULL,
    [IdCentroCusto]    UNIQUEIDENTIFIER NOT NULL,
    [IdEmpenho]        UNIQUEIDENTIFIER NOT NULL,
    [Codigo]           VARCHAR (30)     NULL,
    [Nome]             VARCHAR (100)    NOT NULL,
    [Valor]            NUMERIC (18, 2)  DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([IdEmpenhoCCMCASP] ASC),
    FOREIGN KEY ([IdEmpenhoMCASP]) REFERENCES [dbo].[EmpenhosMCASP] ([IdEmpenhoMCASP])
);


GO
CREATE TRIGGER [TrgLog_EmpenhosCCMCASP] ON [Implanta_CRPAM].[dbo].[EmpenhosCCMCASP] 
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
SET @TableName = 'EmpenhosCCMCASP'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEmpenhoCCMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoCCMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEmpenhoCCMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoCCMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEmpenhoCCMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoCCMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEmpenhoCCMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoCCMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
