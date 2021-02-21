CREATE TABLE [dbo].[CentroCustosReceita] (
    [IdCentroCustoReceita]     INT          IDENTITY (1, 1) NOT NULL,
    [CodigoCentroCustoReceita] VARCHAR (8)  NOT NULL,
    [NomeCentroCustoReceita]   VARCHAR (40) NOT NULL,
    [IdPessoa]                 INT          NULL,
    CONSTRAINT [PK_CentroCustosReceita] PRIMARY KEY NONCLUSTERED ([IdCentroCustoReceita] ASC),
    CONSTRAINT [FK_CentroCustosReceita_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_CentroCustosReceita] ON [Implanta_CRPAM].[dbo].[CentroCustosReceita] 
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
SET @TableName = 'CentroCustosReceita'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCentroCustoReceita : «' + RTRIM( ISNULL( CAST (CodigoCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCentroCustoReceita : «' + RTRIM( ISNULL( CAST (NomeCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCentroCustoReceita : «' + RTRIM( ISNULL( CAST (CodigoCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCentroCustoReceita : «' + RTRIM( ISNULL( CAST (NomeCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCentroCustoReceita : «' + RTRIM( ISNULL( CAST (CodigoCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCentroCustoReceita : «' + RTRIM( ISNULL( CAST (NomeCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCentroCustoReceita : «' + RTRIM( ISNULL( CAST (CodigoCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCentroCustoReceita : «' + RTRIM( ISNULL( CAST (NomeCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
