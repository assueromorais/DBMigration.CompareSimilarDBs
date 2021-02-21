CREATE TABLE [dbo].[InventarioPatInconsistencias] (
    [IdInventarioPatInconsistencia] INT IDENTITY (1, 1) NOT NULL,
    [IdInventario]                  INT NULL,
    [IdItem]                        INT NULL,
    [IdUnidadeIndicada]             INT NULL,
    [IdResponsavelIndicado]         INT NULL,
    [IdUnidadeReal]                 INT NULL,
    [IdResponsavelReal]             INT NULL,
    CONSTRAINT [PK_InventarioPatInconsistencias] PRIMARY KEY CLUSTERED ([IdInventarioPatInconsistencia] ASC),
    CONSTRAINT [FK_InventarioPatInconsistencias_InventarioPatrimonio] FOREIGN KEY ([IdInventario]) REFERENCES [dbo].[InventarioPatrimonio] ([IdInventario]),
    CONSTRAINT [FK_InventarioPatInconsistencias_ItensMoveis] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[ItensMoveis] ([IdItem]),
    CONSTRAINT [FK_InventarioPatInconsistencias_Responsaveis1] FOREIGN KEY ([IdResponsavelIndicado]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]),
    CONSTRAINT [FK_InventarioPatInconsistencias_Responsaveis2] FOREIGN KEY ([IdResponsavelReal]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]),
    CONSTRAINT [FK_InventarioPatInconsistencias_Unidades1] FOREIGN KEY ([IdUnidadeIndicada]) REFERENCES [dbo].[Unidades] ([IdUnidade]),
    CONSTRAINT [FK_InventarioPatInconsistencias_Unidades2] FOREIGN KEY ([IdUnidadeReal]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);


GO
CREATE TRIGGER [TrgLog_InventarioPatInconsistencias] ON [Implanta_CRPAM].[dbo].[InventarioPatInconsistencias] 
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
SET @TableName = 'InventarioPatInconsistencias'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdInventarioPatInconsistencia : «' + RTRIM( ISNULL( CAST (IdInventarioPatInconsistencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeIndicada : «' + RTRIM( ISNULL( CAST (IdUnidadeIndicada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelIndicado : «' + RTRIM( ISNULL( CAST (IdResponsavelIndicado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeReal : «' + RTRIM( ISNULL( CAST (IdUnidadeReal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelReal : «' + RTRIM( ISNULL( CAST (IdResponsavelReal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdInventarioPatInconsistencia : «' + RTRIM( ISNULL( CAST (IdInventarioPatInconsistencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeIndicada : «' + RTRIM( ISNULL( CAST (IdUnidadeIndicada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelIndicado : «' + RTRIM( ISNULL( CAST (IdResponsavelIndicado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeReal : «' + RTRIM( ISNULL( CAST (IdUnidadeReal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelReal : «' + RTRIM( ISNULL( CAST (IdResponsavelReal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdInventarioPatInconsistencia : «' + RTRIM( ISNULL( CAST (IdInventarioPatInconsistencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeIndicada : «' + RTRIM( ISNULL( CAST (IdUnidadeIndicada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelIndicado : «' + RTRIM( ISNULL( CAST (IdResponsavelIndicado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeReal : «' + RTRIM( ISNULL( CAST (IdUnidadeReal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelReal : «' + RTRIM( ISNULL( CAST (IdResponsavelReal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdInventarioPatInconsistencia : «' + RTRIM( ISNULL( CAST (IdInventarioPatInconsistencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdInventario : «' + RTRIM( ISNULL( CAST (IdInventario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeIndicada : «' + RTRIM( ISNULL( CAST (IdUnidadeIndicada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelIndicado : «' + RTRIM( ISNULL( CAST (IdResponsavelIndicado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUnidadeReal : «' + RTRIM( ISNULL( CAST (IdUnidadeReal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelReal : «' + RTRIM( ISNULL( CAST (IdResponsavelReal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
