CREATE TABLE [dbo].[ArquivosSerasa] (
    [IdArquivoSerasa]     INT           IDENTITY (1, 1) NOT NULL,
    [DataGeracao]         DATETIME      NULL,
    [UsuarioGeracao]      VARCHAR (100) NULL,
    [DepartamentoGeracao] VARCHAR (100) NULL,
    CONSTRAINT [PK_ArquivosSerasa_IdArquivoSerasa] PRIMARY KEY CLUSTERED ([IdArquivoSerasa] ASC)
);


GO
CREATE TRIGGER [TrgLog_ArquivosSerasa] ON [Implanta_CRPAM].[dbo].[ArquivosSerasa] 
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
SET @TableName = 'ArquivosSerasa'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivoSerasa : «' + RTRIM( ISNULL( CAST (IdArquivoSerasa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| UsuarioGeracao : «' + RTRIM( ISNULL( CAST (UsuarioGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoGeracao : «' + RTRIM( ISNULL( CAST (DepartamentoGeracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivoSerasa : «' + RTRIM( ISNULL( CAST (IdArquivoSerasa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| UsuarioGeracao : «' + RTRIM( ISNULL( CAST (UsuarioGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoGeracao : «' + RTRIM( ISNULL( CAST (DepartamentoGeracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdArquivoSerasa : «' + RTRIM( ISNULL( CAST (IdArquivoSerasa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| UsuarioGeracao : «' + RTRIM( ISNULL( CAST (UsuarioGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoGeracao : «' + RTRIM( ISNULL( CAST (DepartamentoGeracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivoSerasa : «' + RTRIM( ISNULL( CAST (IdArquivoSerasa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| UsuarioGeracao : «' + RTRIM( ISNULL( CAST (UsuarioGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoGeracao : «' + RTRIM( ISNULL( CAST (DepartamentoGeracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
