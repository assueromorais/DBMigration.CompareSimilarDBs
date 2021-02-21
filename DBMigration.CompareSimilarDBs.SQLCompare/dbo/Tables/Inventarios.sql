CREATE TABLE [dbo].[Inventarios] (
    [IdInventario]   INT        IDENTITY (1, 1) NOT NULL,
    [IdSubItem]      INT        NOT NULL,
    [DataContagem]   DATETIME   NOT NULL,
    [QtdContagem]    FLOAT (53) NULL,
    [QtdSistema]     FLOAT (53) NULL,
    [DataGeracao]    DATETIME   NULL,
    [IdAlmoxarifado] INT        NULL,
    CONSTRAINT [PK_Inventarios] PRIMARY KEY NONCLUSTERED ([IdInventario] ASC),
    CONSTRAINT [FK_Inventarios_Almoxarifados] FOREIGN KEY ([IdAlmoxarifado]) REFERENCES [dbo].[Almoxarifados] ([IdAlmoxarifado]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Inventarios_SubItens] FOREIGN KEY ([IdSubItem]) REFERENCES [dbo].[SubItens] ([IdSubItem])
);


GO
CREATE TRIGGER [TrgLog_Inventarios] ON [Implanta_CRPAM].[dbo].[Inventarios] 
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
SET @TableName = 'Inventarios'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContagem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContagem, 113 ),'Nulo'))+'» '
                         + '| QtdContagem : «' + RTRIM( ISNULL( CAST (QtdContagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdSistema : «' + RTRIM( ISNULL( CAST (QtdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContagem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContagem, 113 ),'Nulo'))+'» '
                         + '| QtdContagem : «' + RTRIM( ISNULL( CAST (QtdContagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdSistema : «' + RTRIM( ISNULL( CAST (QtdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContagem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContagem, 113 ),'Nulo'))+'» '
                         + '| QtdContagem : «' + RTRIM( ISNULL( CAST (QtdContagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdSistema : «' + RTRIM( ISNULL( CAST (QtdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataContagem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataContagem, 113 ),'Nulo'))+'» '
                         + '| QtdContagem : «' + RTRIM( ISNULL( CAST (QtdContagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdSistema : «' + RTRIM( ISNULL( CAST (QtdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
