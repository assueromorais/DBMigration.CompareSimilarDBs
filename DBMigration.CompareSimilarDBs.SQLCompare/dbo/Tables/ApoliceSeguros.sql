CREATE TABLE [dbo].[ApoliceSeguros] (
    [IdApoliceSeguro] INT      IDENTITY (1, 1) NOT NULL,
    [IdContrato]      INT      NULL,
    [TipoApolice]     CHAR (1) NOT NULL,
    [InicioVigencia]  DATETIME NOT NULL,
    [FimVigencia]     DATETIME NOT NULL,
    PRIMARY KEY CLUSTERED ([IdApoliceSeguro] ASC),
    CONSTRAINT [FK_ApoliceSeguros_IdContrato] FOREIGN KEY ([IdContrato]) REFERENCES [dbo].[Contratos] ([IdContrato])
);


GO
CREATE TRIGGER [TrgLog_ApoliceSeguros] ON [Implanta_CRPAM].[dbo].[ApoliceSeguros] 
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
SET @TableName = 'ApoliceSeguros'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdApoliceSeguro : «' + RTRIM( ISNULL( CAST (IdApoliceSeguro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoApolice : «' + RTRIM( ISNULL( CAST (TipoApolice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, InicioVigencia, 113 ),'Nulo'))+'» '
                         + '| FimVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, FimVigencia, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdApoliceSeguro : «' + RTRIM( ISNULL( CAST (IdApoliceSeguro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoApolice : «' + RTRIM( ISNULL( CAST (TipoApolice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, InicioVigencia, 113 ),'Nulo'))+'» '
                         + '| FimVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, FimVigencia, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdApoliceSeguro : «' + RTRIM( ISNULL( CAST (IdApoliceSeguro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoApolice : «' + RTRIM( ISNULL( CAST (TipoApolice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, InicioVigencia, 113 ),'Nulo'))+'» '
                         + '| FimVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, FimVigencia, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdApoliceSeguro : «' + RTRIM( ISNULL( CAST (IdApoliceSeguro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoApolice : «' + RTRIM( ISNULL( CAST (TipoApolice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InicioVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, InicioVigencia, 113 ),'Nulo'))+'» '
                         + '| FimVigencia : «' + RTRIM( ISNULL( CONVERT (CHAR, FimVigencia, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
