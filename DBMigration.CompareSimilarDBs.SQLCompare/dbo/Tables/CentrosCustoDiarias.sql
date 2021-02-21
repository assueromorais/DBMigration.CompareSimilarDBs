CREATE TABLE [dbo].[CentrosCustoDiarias] (
    [IdCentroCustoDiaria] INT           IDENTITY (1, 1) NOT NULL,
    [IdDiariaIndenizacao] INT           NOT NULL,
    [CentroCusto]         VARCHAR (50)  NULL,
    [Valor]               MONEY         NULL,
    [CentroCustoStr]      VARCHAR (300) NULL,
    [CentroCustoCodigo]   VARCHAR (300) NULL,
    CONSTRAINT [PK_CentrosCustoDiarias] PRIMARY KEY CLUSTERED ([IdCentroCustoDiaria] ASC),
    CONSTRAINT [FK_CentrosCustoDiarias_PassagensAereasEmitidas] FOREIGN KEY ([IdDiariaIndenizacao]) REFERENCES [dbo].[DiariasIndenizacoes] ([IdDiariaIndenizacao])
);


GO
CREATE TRIGGER [TrgLog_CentrosCustoDiarias] ON [Implanta_CRPAM].[dbo].[CentrosCustoDiarias] 
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
SET @TableName = 'CentrosCustoDiarias'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCentroCustoDiaria : «' + RTRIM( ISNULL( CAST (IdCentroCustoDiaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDiariaIndenizacao : «' + RTRIM( ISNULL( CAST (IdDiariaIndenizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCusto : «' + RTRIM( ISNULL( CAST (CentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoStr : «' + RTRIM( ISNULL( CAST (CentroCustoStr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoCodigo : «' + RTRIM( ISNULL( CAST (CentroCustoCodigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCentroCustoDiaria : «' + RTRIM( ISNULL( CAST (IdCentroCustoDiaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDiariaIndenizacao : «' + RTRIM( ISNULL( CAST (IdDiariaIndenizacao AS VARCHAR(3500)),'Nulo'))+'» '
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
		SELECT @Conteudo = 'IdCentroCustoDiaria : «' + RTRIM( ISNULL( CAST (IdCentroCustoDiaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDiariaIndenizacao : «' + RTRIM( ISNULL( CAST (IdDiariaIndenizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCusto : «' + RTRIM( ISNULL( CAST (CentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoStr : «' + RTRIM( ISNULL( CAST (CentroCustoStr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoCodigo : «' + RTRIM( ISNULL( CAST (CentroCustoCodigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCentroCustoDiaria : «' + RTRIM( ISNULL( CAST (IdCentroCustoDiaria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDiariaIndenizacao : «' + RTRIM( ISNULL( CAST (IdDiariaIndenizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCusto : «' + RTRIM( ISNULL( CAST (CentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoStr : «' + RTRIM( ISNULL( CAST (CentroCustoStr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CentroCustoCodigo : «' + RTRIM( ISNULL( CAST (CentroCustoCodigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
