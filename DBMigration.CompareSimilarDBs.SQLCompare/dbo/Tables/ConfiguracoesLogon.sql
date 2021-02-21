CREATE TABLE [dbo].[ConfiguracoesLogon] (
    [ServidorAtualizacao]  VARCHAR (50) NULL,
    [IntervaloAtualizacao] VARCHAR (3)  NULL,
    [UltimaVerificao]      DATETIME     NULL
);


GO
CREATE TRIGGER [TrgLog_ConfiguracoesLogon] ON [Implanta_CRPAM].[dbo].[ConfiguracoesLogon] 
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
SET @TableName = 'ConfiguracoesLogon'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'ServidorAtualizacao : «' + RTRIM( ISNULL( CAST (ServidorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntervaloAtualizacao : «' + RTRIM( ISNULL( CAST (IntervaloAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaVerificao : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaVerificao, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'ServidorAtualizacao : «' + RTRIM( ISNULL( CAST (ServidorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntervaloAtualizacao : «' + RTRIM( ISNULL( CAST (IntervaloAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaVerificao : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaVerificao, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'ServidorAtualizacao : «' + RTRIM( ISNULL( CAST (ServidorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntervaloAtualizacao : «' + RTRIM( ISNULL( CAST (IntervaloAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaVerificao : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaVerificao, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'ServidorAtualizacao : «' + RTRIM( ISNULL( CAST (ServidorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IntervaloAtualizacao : «' + RTRIM( ISNULL( CAST (IntervaloAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaVerificao : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaVerificao, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
