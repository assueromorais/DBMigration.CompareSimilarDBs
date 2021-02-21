CREATE TABLE [dbo].[ItensPedidos] (
    [IdItensPedido] INT        IDENTITY (1, 1) NOT NULL,
    [IdPedido]      INT        NOT NULL,
    [IdItem]        INT        NOT NULL,
    [Qtd]           FLOAT (53) NULL,
    CONSTRAINT [PK_ItensPedidos] PRIMARY KEY NONCLUSTERED ([IdItensPedido] ASC),
    CONSTRAINT [FK_ItensPedidos_Itens] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[Itens] ([IdItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ItensPedidos_Pedidos] FOREIGN KEY ([IdPedido]) REFERENCES [dbo].[Pedidos] ([IdPedido]) NOT FOR REPLICATION
);


GO
CREATE NONCLUSTERED INDEX [IX_ItensPedidosIdItemQtd]
    ON [dbo].[ItensPedidos]([IdItem] ASC, [Qtd] ASC);


GO
CREATE TRIGGER [TrgLog_ItensPedidos] ON [Implanta_CRPAM].[dbo].[ItensPedidos] 
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
SET @TableName = 'ItensPedidos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdItensPedido : «' + RTRIM( ISNULL( CAST (IdItensPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPedido : «' + RTRIM( ISNULL( CAST (IdPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdItensPedido : «' + RTRIM( ISNULL( CAST (IdItensPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPedido : «' + RTRIM( ISNULL( CAST (IdPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdItensPedido : «' + RTRIM( ISNULL( CAST (IdItensPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPedido : «' + RTRIM( ISNULL( CAST (IdPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdItensPedido : «' + RTRIM( ISNULL( CAST (IdItensPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPedido : «' + RTRIM( ISNULL( CAST (IdPedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtd : «' + RTRIM( ISNULL( CAST (Qtd AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
