CREATE TABLE [dbo].[DespachosExpediente] (
    [IdDespachoExpediente] INT           IDENTITY (1, 1) NOT NULL,
    [IdCentroCustoReceita] INT           NULL,
    [IdResponsavel]        INT           NULL,
    [NumProcesso]          NVARCHAR (15) NULL,
    [Volume]               NVARCHAR (15) NULL,
    [DataEnvio]            DATETIME      NULL,
    CONSTRAINT [PK_DespachoExpediente] PRIMARY KEY CLUSTERED ([IdDespachoExpediente] ASC),
    CONSTRAINT [FK_DespachosExpediente_CentroCustosReceita] FOREIGN KEY ([IdCentroCustoReceita]) REFERENCES [dbo].[CentroCustosReceita] ([IdCentroCustoReceita]),
    CONSTRAINT [FK_DespachosExpediente_Pessoas] FOREIGN KEY ([IdResponsavel]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);


GO
CREATE TRIGGER [TrgLog_DespachosExpediente] ON [Implanta_CRPAM].[dbo].[DespachosExpediente] 
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
SET @TableName = 'DespachosExpediente'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDespachoExpediente : «' + RTRIM( ISNULL( CAST (IdDespachoExpediente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDespachoExpediente : «' + RTRIM( ISNULL( CAST (IdDespachoExpediente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDespachoExpediente : «' + RTRIM( ISNULL( CAST (IdDespachoExpediente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDespachoExpediente : «' + RTRIM( ISNULL( CAST (IdDespachoExpediente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavel : «' + RTRIM( ISNULL( CAST (IdResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
