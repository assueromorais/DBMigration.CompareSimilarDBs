CREATE TABLE [dbo].[ConfigCentroCustosReceita] (
    [IdConfigCentroCustosReceita] INT      IDENTITY (1, 1) NOT NULL,
    [IdCentroCustoReceita]        INT      NOT NULL,
    [DataInicio]                  DATETIME NULL,
    [DataFim]                     DATETIME NULL,
    CONSTRAINT [PK_ConfigCentroCustosReceita] PRIMARY KEY CLUSTERED ([IdConfigCentroCustosReceita] ASC),
    CONSTRAINT [FK_ConfigCentroCustosReceita_CentroCustosReceita] FOREIGN KEY ([IdCentroCustoReceita]) REFERENCES [dbo].[CentroCustosReceita] ([IdCentroCustoReceita]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_ConfigCentroCustosReceita] ON [Implanta_CRPAM].[dbo].[ConfigCentroCustosReceita] 
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
SET @TableName = 'ConfigCentroCustosReceita'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfigCentroCustosReceita : «' + RTRIM( ISNULL( CAST (IdConfigCentroCustosReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConfigCentroCustosReceita : «' + RTRIM( ISNULL( CAST (IdConfigCentroCustosReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConfigCentroCustosReceita : «' + RTRIM( ISNULL( CAST (IdConfigCentroCustosReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfigCentroCustosReceita : «' + RTRIM( ISNULL( CAST (IdConfigCentroCustosReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCustoReceita : «' + RTRIM( ISNULL( CAST (IdCentroCustoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicio, 113 ),'Nulo'))+'» '
                         + '| DataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFim, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
