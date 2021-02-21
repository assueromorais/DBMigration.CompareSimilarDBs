CREATE TABLE [dbo].[Atesto] (
    [IdAtesto]    INT      IDENTITY (1, 1) NOT NULL,
    [IdContrato]  INT      NULL,
    [DataAtesto]  DATETIME NULL,
    [NumParcela]  INT      NULL,
    [Observacoes] TEXT     NULL,
    CONSTRAINT [PK_Atesto] PRIMARY KEY CLUSTERED ([IdAtesto] ASC),
    CONSTRAINT [FK_Atesto_Contratos] FOREIGN KEY ([IdContrato]) REFERENCES [dbo].[Contratos] ([IdContrato])
);


GO
CREATE TRIGGER [TrgLog_Atesto] ON [Implanta_CRPAM].[dbo].[Atesto] 
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
SET @TableName = 'Atesto'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAtesto : «' + RTRIM( ISNULL( CAST (IdAtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtesto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtesto, 113 ),'Nulo'))+'» '
                         + '| NumParcela : «' + RTRIM( ISNULL( CAST (NumParcela AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAtesto : «' + RTRIM( ISNULL( CAST (IdAtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtesto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtesto, 113 ),'Nulo'))+'» '
                         + '| NumParcela : «' + RTRIM( ISNULL( CAST (NumParcela AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAtesto : «' + RTRIM( ISNULL( CAST (IdAtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtesto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtesto, 113 ),'Nulo'))+'» '
                         + '| NumParcela : «' + RTRIM( ISNULL( CAST (NumParcela AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAtesto : «' + RTRIM( ISNULL( CAST (IdAtesto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtesto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtesto, 113 ),'Nulo'))+'» '
                         + '| NumParcela : «' + RTRIM( ISNULL( CAST (NumParcela AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
