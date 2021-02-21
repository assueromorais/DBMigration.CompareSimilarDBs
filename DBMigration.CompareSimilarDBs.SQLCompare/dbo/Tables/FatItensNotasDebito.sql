CREATE TABLE [dbo].[FatItensNotasDebito] (
    [IdNotaDebito]     INT   NOT NULL,
    [IdItemNotaDebito] INT   NOT NULL,
    [IdItemProduto]    INT   NOT NULL,
    [IdTipoInclusao]   INT   NOT NULL,
    [Qtde]             REAL  NOT NULL,
    [ValorUnitario]    MONEY NULL,
    CONSTRAINT [PK_FatItensNotasDebito] PRIMARY KEY CLUSTERED ([IdNotaDebito] ASC, [IdItemNotaDebito] ASC),
    CONSTRAINT [FK_FatItensNotasDebito_FatNotasDebito] FOREIGN KEY ([IdNotaDebito]) REFERENCES [dbo].[FatNotasDebito] ([IdNotaDebito]),
    CONSTRAINT [FK_FatItensNotasDebito_FatProdutosEspeciais] FOREIGN KEY ([IdItemProduto]) REFERENCES [dbo].[FatProdutosEspeciais] ([IdProduto]),
    CONSTRAINT [FK_FatItensNotasDebito_FatTiposInclusao] FOREIGN KEY ([IdTipoInclusao]) REFERENCES [dbo].[FatTiposInclusao] ([IdTipoInclusao]),
    CONSTRAINT [FK_FatItensNotasDebito_Itens] FOREIGN KEY ([IdItemProduto]) REFERENCES [dbo].[Itens] ([IdItem])
);


GO
ALTER TABLE [dbo].[FatItensNotasDebito] NOCHECK CONSTRAINT [FK_FatItensNotasDebito_FatProdutosEspeciais];


GO
ALTER TABLE [dbo].[FatItensNotasDebito] NOCHECK CONSTRAINT [FK_FatItensNotasDebito_Itens];


GO
CREATE TRIGGER [TrgLog_FatItensNotasDebito] ON [Implanta_CRPAM].[dbo].[FatItensNotasDebito] 
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
SET @TableName = 'FatItensNotasDebito'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemNotaDebito : «' + RTRIM( ISNULL( CAST (IdItemNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemProduto : «' + RTRIM( ISNULL( CAST (IdItemProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInclusao : «' + RTRIM( ISNULL( CAST (IdTipoInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtde : «' + RTRIM( ISNULL( CAST (Qtde AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemNotaDebito : «' + RTRIM( ISNULL( CAST (IdItemNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemProduto : «' + RTRIM( ISNULL( CAST (IdItemProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInclusao : «' + RTRIM( ISNULL( CAST (IdTipoInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtde : «' + RTRIM( ISNULL( CAST (Qtde AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemNotaDebito : «' + RTRIM( ISNULL( CAST (IdItemNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemProduto : «' + RTRIM( ISNULL( CAST (IdItemProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInclusao : «' + RTRIM( ISNULL( CAST (IdTipoInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtde : «' + RTRIM( ISNULL( CAST (Qtde AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdNotaDebito : «' + RTRIM( ISNULL( CAST (IdNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemNotaDebito : «' + RTRIM( ISNULL( CAST (IdItemNotaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItemProduto : «' + RTRIM( ISNULL( CAST (IdItemProduto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoInclusao : «' + RTRIM( ISNULL( CAST (IdTipoInclusao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Qtde : «' + RTRIM( ISNULL( CAST (Qtde AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorUnitario : «' + RTRIM( ISNULL( CAST (ValorUnitario AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
