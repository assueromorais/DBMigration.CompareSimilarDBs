CREATE TABLE [dbo].[MensagensEmail] (
    [IdMesagem]      INT           IDENTITY (1, 1) NOT NULL,
    [idSistema]      INT           NULL,
    [idFuncao]       INT           NULL,
    [idTipoMensagem] INT           NULL,
    [Assunto]        VARCHAR (100) NULL,
    [Corpo]          TEXT          NULL,
    [UsuarioEmail]   VARCHAR (100) NULL,
    [SenhaEmail]     VARCHAR (30)  NULL
);


GO
CREATE TRIGGER [TrgLog_MensagensEmail] ON [Implanta_CRPAM].[dbo].[MensagensEmail] 
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
SET @TableName = 'MensagensEmail'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMesagem : «' + RTRIM( ISNULL( CAST (IdMesagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idSistema : «' + RTRIM( ISNULL( CAST (idSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idFuncao : «' + RTRIM( ISNULL( CAST (idFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idTipoMensagem : «' + RTRIM( ISNULL( CAST (idTipoMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmail : «' + RTRIM( ISNULL( CAST (UsuarioEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmail : «' + RTRIM( ISNULL( CAST (SenhaEmail AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMesagem : «' + RTRIM( ISNULL( CAST (IdMesagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idSistema : «' + RTRIM( ISNULL( CAST (idSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idFuncao : «' + RTRIM( ISNULL( CAST (idFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idTipoMensagem : «' + RTRIM( ISNULL( CAST (idTipoMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmail : «' + RTRIM( ISNULL( CAST (UsuarioEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmail : «' + RTRIM( ISNULL( CAST (SenhaEmail AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMesagem : «' + RTRIM( ISNULL( CAST (IdMesagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idSistema : «' + RTRIM( ISNULL( CAST (idSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idFuncao : «' + RTRIM( ISNULL( CAST (idFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idTipoMensagem : «' + RTRIM( ISNULL( CAST (idTipoMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmail : «' + RTRIM( ISNULL( CAST (UsuarioEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmail : «' + RTRIM( ISNULL( CAST (SenhaEmail AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMesagem : «' + RTRIM( ISNULL( CAST (IdMesagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idSistema : «' + RTRIM( ISNULL( CAST (idSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idFuncao : «' + RTRIM( ISNULL( CAST (idFuncao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idTipoMensagem : «' + RTRIM( ISNULL( CAST (idTipoMensagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioEmail : «' + RTRIM( ISNULL( CAST (UsuarioEmail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaEmail : «' + RTRIM( ISNULL( CAST (SenhaEmail AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
