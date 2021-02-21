CREATE TABLE [dbo].[ListaContatos] (
    [IdListaContatos] INT           IDENTITY (1, 1) NOT NULL,
    [NomeContato]     VARCHAR (100) NOT NULL,
    [Cargo]           VARCHAR (40)  NULL,
    [Observacao]      TEXT          NULL,
    [EnderecoEMail]   VARCHAR (90)  NOT NULL,
    [EnderecoEMail2]  VARCHAR (90)  NULL,
    CONSTRAINT [PK_ListaContatos] PRIMARY KEY CLUSTERED ([IdListaContatos] ASC)
);


GO
CREATE TRIGGER [TrgLog_ListaContatos] ON [Implanta_CRPAM].[dbo].[ListaContatos] 
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
SET @TableName = 'ListaContatos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdListaContatos : «' + RTRIM( ISNULL( CAST (IdListaContatos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContato : «' + RTRIM( ISNULL( CAST (NomeContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoEMail : «' + RTRIM( ISNULL( CAST (EnderecoEMail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoEMail2 : «' + RTRIM( ISNULL( CAST (EnderecoEMail2 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdListaContatos : «' + RTRIM( ISNULL( CAST (IdListaContatos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContato : «' + RTRIM( ISNULL( CAST (NomeContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoEMail : «' + RTRIM( ISNULL( CAST (EnderecoEMail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoEMail2 : «' + RTRIM( ISNULL( CAST (EnderecoEMail2 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdListaContatos : «' + RTRIM( ISNULL( CAST (IdListaContatos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContato : «' + RTRIM( ISNULL( CAST (NomeContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoEMail : «' + RTRIM( ISNULL( CAST (EnderecoEMail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoEMail2 : «' + RTRIM( ISNULL( CAST (EnderecoEMail2 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdListaContatos : «' + RTRIM( ISNULL( CAST (IdListaContatos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContato : «' + RTRIM( ISNULL( CAST (NomeContato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoEMail : «' + RTRIM( ISNULL( CAST (EnderecoEMail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EnderecoEMail2 : «' + RTRIM( ISNULL( CAST (EnderecoEMail2 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
