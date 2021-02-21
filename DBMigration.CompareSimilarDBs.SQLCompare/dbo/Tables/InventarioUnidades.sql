CREATE TABLE [dbo].[InventarioUnidades] (
    [IdInventarioUnidade] INT IDENTITY (1, 1) NOT NULL,
    [IdInventario]        INT NULL,
    [IdUnidade]           INT NULL,
    CONSTRAINT [PK_InventarioUnidades] PRIMARY KEY CLUSTERED ([IdInventarioUnidade] ASC),
    CONSTRAINT [FK_InventarioUnidades_InventarioPatrimonio] FOREIGN KEY ([IdInventario]) REFERENCES [dbo].[InventarioPatrimonio] ([IdInventario]),
    CONSTRAINT [FK_InventarioUnidades_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);


GO
CREATE TRIGGER [TrgLog_InventarioUnidades] ON [Implanta_CRPAM].[dbo].[InventarioUnidades] 
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
SET @TableName = 'InventarioUnidades'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdInventarioUnidade : «' + RTRIM( ISNULL( CAST (IdInventarioUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdInventarioUnidade : «' + RTRIM( ISNULL( CAST (IdInventarioUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdInventarioUnidade : «' + RTRIM( ISNULL( CAST (IdInventarioUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdInventarioUnidade : «' + RTRIM( ISNULL( CAST (IdInventarioUnidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidade : «' + RTRIM( ISNULL( CAST (IdUnidade AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
