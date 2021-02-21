CREATE TABLE [dbo].[DigitalizacoesFTP] (
    [IdDigitalizacoesFTP] INT           IDENTITY (1, 1) NOT NULL,
    [Servidor]            VARCHAR (100) NOT NULL,
    [Porta]               INT           NOT NULL,
    [Usuario]             VARCHAR (50)  NOT NULL,
    [Senha]               VARCHAR (50)  NOT NULL,
    [Diretorio]           VARCHAR (50)  NOT NULL,
    [Proxy]               TEXT          NULL,
    CONSTRAINT [PK_DigitalizacoesFTP] PRIMARY KEY CLUSTERED ([IdDigitalizacoesFTP] ASC)
);


GO
CREATE TRIGGER [TrgLog_DigitalizacoesFTP] ON [Implanta_CRPAM].[dbo].[DigitalizacoesFTP] 
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
SET @TableName = 'DigitalizacoesFTP'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDigitalizacoesFTP : «' + RTRIM( ISNULL( CAST (IdDigitalizacoesFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Servidor : «' + RTRIM( ISNULL( CAST (Servidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Porta : «' + RTRIM( ISNULL( CAST (Porta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Senha : «' + RTRIM( ISNULL( CAST (Senha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Diretorio : «' + RTRIM( ISNULL( CAST (Diretorio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDigitalizacoesFTP : «' + RTRIM( ISNULL( CAST (IdDigitalizacoesFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Servidor : «' + RTRIM( ISNULL( CAST (Servidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Porta : «' + RTRIM( ISNULL( CAST (Porta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Senha : «' + RTRIM( ISNULL( CAST (Senha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Diretorio : «' + RTRIM( ISNULL( CAST (Diretorio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDigitalizacoesFTP : «' + RTRIM( ISNULL( CAST (IdDigitalizacoesFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Servidor : «' + RTRIM( ISNULL( CAST (Servidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Porta : «' + RTRIM( ISNULL( CAST (Porta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Senha : «' + RTRIM( ISNULL( CAST (Senha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Diretorio : «' + RTRIM( ISNULL( CAST (Diretorio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDigitalizacoesFTP : «' + RTRIM( ISNULL( CAST (IdDigitalizacoesFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Servidor : «' + RTRIM( ISNULL( CAST (Servidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Porta : «' + RTRIM( ISNULL( CAST (Porta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Senha : «' + RTRIM( ISNULL( CAST (Senha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Diretorio : «' + RTRIM( ISNULL( CAST (Diretorio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
