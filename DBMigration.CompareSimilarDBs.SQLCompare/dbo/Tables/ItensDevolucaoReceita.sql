CREATE TABLE [dbo].[ItensDevolucaoReceita] (
    [IdItemDevolucaoReceita]     INT           IDENTITY (1, 1) NOT NULL,
    [IdDevolucaoReceita]         INT           NULL,
    [IdTipoItemDevolucaoReceita] INT           NULL,
    [Numero]                     NVARCHAR (30) NULL,
    [ValorPagamento]             MONEY         NULL,
    [ValorRestituir]             MONEY         NULL,
    [DataPagamento]              DATETIME      NULL,
    CONSTRAINT [PK_ItemDevolucaoReceita] PRIMARY KEY CLUSTERED ([IdItemDevolucaoReceita] ASC),
    CONSTRAINT [FK_ItensDevolucaoReceita_DevolucoesReceita] FOREIGN KEY ([IdDevolucaoReceita]) REFERENCES [dbo].[DevolucoesReceita] ([IdDevolucaoReceita]),
    CONSTRAINT [FK_ItensDevolucaoReceita_TiposItemDevolucaoReceita] FOREIGN KEY ([IdTipoItemDevolucaoReceita]) REFERENCES [dbo].[TiposItemDevolucaoReceita] ([IdTipoItemDevolucaoReceita])
);


GO
CREATE TRIGGER [TrgLog_ItensDevolucaoReceita] ON [Implanta_CRPAM].[dbo].[ItensDevolucaoReceita] 
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
SET @TableName = 'ItensDevolucaoReceita'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItemDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdItemDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoItemDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdTipoItemDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagamento : «' + RTRIM( ISNULL( CAST (ValorPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorRestituir : «' + RTRIM( ISNULL( CAST (ValorRestituir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItemDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdItemDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoItemDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdTipoItemDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagamento : «' + RTRIM( ISNULL( CAST (ValorPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorRestituir : «' + RTRIM( ISNULL( CAST (ValorRestituir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdItemDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdItemDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoItemDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdTipoItemDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagamento : «' + RTRIM( ISNULL( CAST (ValorPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorRestituir : «' + RTRIM( ISNULL( CAST (ValorRestituir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItemDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdItemDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoItemDevolucaoReceita : «' + RTRIM( ISNULL( CAST (IdTipoItemDevolucaoReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPagamento : «' + RTRIM( ISNULL( CAST (ValorPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorRestituir : «' + RTRIM( ISNULL( CAST (ValorRestituir AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPagamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPagamento, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
