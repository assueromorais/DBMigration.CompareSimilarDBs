CREATE TABLE [dbo].[ItensListaComprasGeradas] (
    [IdItemListaCompraGerada] INT   IDENTITY (1, 1) NOT NULL,
    [IdListaCompraGerada]     INT   NOT NULL,
    [IdItem]                  INT   NOT NULL,
    [Quantidade]              REAL  NOT NULL,
    [IdSolicitacao]           INT   NOT NULL,
    [ValorEstimado]           MONEY NULL,
    CONSTRAINT [PK_ItensListaComprasGeradas] PRIMARY KEY CLUSTERED ([IdItemListaCompraGerada] ASC),
    CONSTRAINT [FK_ItensListaComprasGeradas_Itens] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[Itens] ([IdItem]),
    CONSTRAINT [FK_ItensListaComprasGeradas_ListaComprasGeradas] FOREIGN KEY ([IdListaCompraGerada]) REFERENCES [dbo].[ListaComprasGeradas] ([IdListaCompraGerada]),
    CONSTRAINT [FK_ItensListaComprasGeradas_Solicitacoes] FOREIGN KEY ([IdSolicitacao]) REFERENCES [dbo].[Solicitacoes] ([IdSolicitacao])
);


GO
CREATE TRIGGER [TrgLog_ItensListaComprasGeradas] ON [Implanta_CRPAM].[dbo].[ItensListaComprasGeradas] 
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
SET @TableName = 'ItensListaComprasGeradas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItemListaCompraGerada : «' + RTRIM( ISNULL( CAST (IdItemListaCompraGerada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdListaCompraGerada : «' + RTRIM( ISNULL( CAST (IdListaCompraGerada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Quantidade : «' + RTRIM( ISNULL( CAST (Quantidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacao : «' + RTRIM( ISNULL( CAST (IdSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstimado : «' + RTRIM( ISNULL( CAST (ValorEstimado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItemListaCompraGerada : «' + RTRIM( ISNULL( CAST (IdItemListaCompraGerada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdListaCompraGerada : «' + RTRIM( ISNULL( CAST (IdListaCompraGerada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Quantidade : «' + RTRIM( ISNULL( CAST (Quantidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacao : «' + RTRIM( ISNULL( CAST (IdSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstimado : «' + RTRIM( ISNULL( CAST (ValorEstimado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdItemListaCompraGerada : «' + RTRIM( ISNULL( CAST (IdItemListaCompraGerada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdListaCompraGerada : «' + RTRIM( ISNULL( CAST (IdListaCompraGerada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Quantidade : «' + RTRIM( ISNULL( CAST (Quantidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacao : «' + RTRIM( ISNULL( CAST (IdSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstimado : «' + RTRIM( ISNULL( CAST (ValorEstimado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItemListaCompraGerada : «' + RTRIM( ISNULL( CAST (IdItemListaCompraGerada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdListaCompraGerada : «' + RTRIM( ISNULL( CAST (IdListaCompraGerada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Quantidade : «' + RTRIM( ISNULL( CAST (Quantidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacao : «' + RTRIM( ISNULL( CAST (IdSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorEstimado : «' + RTRIM( ISNULL( CAST (ValorEstimado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
