CREATE TABLE [dbo].[CentrosCustoPassagens] (
    [IdCentroCustoPassagem]  INT           IDENTITY (1, 1) NOT NULL,
    [IdPassagemAereaEmitida] INT           NOT NULL,
    [CentroCusto]            VARCHAR (50)  NULL,
    [Valor]                  MONEY         NULL,
    [CentroCustoStr]         VARCHAR (300) NULL,
    [CentroCustoCodigo]      VARCHAR (100) NULL,
    CONSTRAINT [PK_CentrosCustoPassagens] PRIMARY KEY CLUSTERED ([IdCentroCustoPassagem] ASC),
    CONSTRAINT [FK_CentrosCustoPassagens_PassagensAereasEmitidas] FOREIGN KEY ([IdPassagemAereaEmitida]) REFERENCES [dbo].[PassagensAereasEmitidas] ([IdPassagemAereaEmitida])
);


GO
CREATE TRIGGER [TrgLog_CentrosCustoPassagens] ON [Implanta_CRPAM].[dbo].[CentrosCustoPassagens] 
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
SET @TableName = 'CentrosCustoPassagens'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCentroCustoPassagem : «' + RTRIM( ISNULL( CAST (IdCentroCustoPassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPassagemAereaEmitida : «' + RTRIM( ISNULL( CAST (IdPassagemAereaEmitida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCusto : «' + RTRIM( ISNULL( CAST (CentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoStr : «' + RTRIM( ISNULL( CAST (CentroCustoStr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoCodigo : «' + RTRIM( ISNULL( CAST (CentroCustoCodigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCentroCustoPassagem : «' + RTRIM( ISNULL( CAST (IdCentroCustoPassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPassagemAereaEmitida : «' + RTRIM( ISNULL( CAST (IdPassagemAereaEmitida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCusto : «' + RTRIM( ISNULL( CAST (CentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoStr : «' + RTRIM( ISNULL( CAST (CentroCustoStr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoCodigo : «' + RTRIM( ISNULL( CAST (CentroCustoCodigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCentroCustoPassagem : «' + RTRIM( ISNULL( CAST (IdCentroCustoPassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPassagemAereaEmitida : «' + RTRIM( ISNULL( CAST (IdPassagemAereaEmitida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCusto : «' + RTRIM( ISNULL( CAST (CentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoStr : «' + RTRIM( ISNULL( CAST (CentroCustoStr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoCodigo : «' + RTRIM( ISNULL( CAST (CentroCustoCodigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCentroCustoPassagem : «' + RTRIM( ISNULL( CAST (IdCentroCustoPassagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPassagemAereaEmitida : «' + RTRIM( ISNULL( CAST (IdPassagemAereaEmitida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCusto : «' + RTRIM( ISNULL( CAST (CentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoStr : «' + RTRIM( ISNULL( CAST (CentroCustoStr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoCodigo : «' + RTRIM( ISNULL( CAST (CentroCustoCodigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
