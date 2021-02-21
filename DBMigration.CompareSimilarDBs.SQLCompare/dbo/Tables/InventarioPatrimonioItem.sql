CREATE TABLE [dbo].[InventarioPatrimonioItem] (
    [IdInventario]      INT NOT NULL,
    [IdItemMovel]       INT NOT NULL,
    [IdMovimentacaoBem] INT NULL,
    CONSTRAINT [PK_InventarioPatrimonioItem] PRIMARY KEY CLUSTERED ([IdInventario] ASC, [IdItemMovel] ASC),
    CONSTRAINT [FK_InventarioPatrimonioItem_InventarioPatrimonio] FOREIGN KEY ([IdInventario]) REFERENCES [dbo].[InventarioPatrimonio] ([IdInventario]),
    CONSTRAINT [FK_InventarioPatrimonioItem_ItensMoveis] FOREIGN KEY ([IdItemMovel]) REFERENCES [dbo].[ItensMoveis] ([IdItem]),
    CONSTRAINT [FK_InventarioPatrimonioItem_MovimentacoesBens] FOREIGN KEY ([IdMovimentacaoBem]) REFERENCES [dbo].[MovimentacoesBens] ([IdMovimentacaoBem]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_InventarioPatrimonioItem] ON [Implanta_CRPAM].[dbo].[InventarioPatrimonioItem] 
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
SET @TableName = 'InventarioPatrimonioItem'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemMovel : «' + RTRIM( ISNULL( CAST (IdItemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemMovel : «' + RTRIM( ISNULL( CAST (IdItemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemMovel : «' + RTRIM( ISNULL( CAST (IdItemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemMovel : «' + RTRIM( ISNULL( CAST (IdItemMovel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentacaoBem : «' + RTRIM( ISNULL( CAST (IdMovimentacaoBem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
