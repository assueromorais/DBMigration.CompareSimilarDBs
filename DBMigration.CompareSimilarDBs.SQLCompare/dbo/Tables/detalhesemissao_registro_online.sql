CREATE TABLE [dbo].[detalhesemissao_registro_online] (
    [id]               NUMERIC (19)  IDENTITY (1, 1) NOT NULL,
    [iddetalheemissao] INT           NOT NULL,
    [data]             DATETIME      NOT NULL,
    [requisicao]       VARCHAR (MAX) NULL,
    [retorno]          VARCHAR (MAX) NULL,
    [observacao]       VARCHAR (MAX) NULL,
    [situacao]         VARCHAR (100) NULL,
    [tipo]             VARCHAR (100) NULL,
    [sistema]          VARCHAR (255) NULL,
    CONSTRAINT [pk_emissoesconfig_registro_online] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [detalhesemissao_registro_online_fk0] FOREIGN KEY ([iddetalheemissao]) REFERENCES [dbo].[DetalhesEmissao] ([IdDetalheEmissao])
);


GO
CREATE TRIGGER [TrgLog_detalhesemissao_registro_online] ON [Implanta_CRPAM].[dbo].[detalhesemissao_registro_online] 
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
SET @TableName = 'detalhesemissao_registro_online'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'id : «' + RTRIM( ISNULL( CAST (id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| iddetalheemissao : «' + RTRIM( ISNULL( CAST (iddetalheemissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| data : «' + RTRIM( ISNULL( CONVERT (CHAR, data, 113 ),'Nulo'))+'» '
                         + '| requisicao : «' + RTRIM( ISNULL( CAST (requisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| retorno : «' + RTRIM( ISNULL( CAST (retorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| observacao : «' + RTRIM( ISNULL( CAST (observacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| situacao : «' + RTRIM( ISNULL( CAST (situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| tipo : «' + RTRIM( ISNULL( CAST (tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| sistema : «' + RTRIM( ISNULL( CAST (sistema AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'id : «' + RTRIM( ISNULL( CAST (id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| iddetalheemissao : «' + RTRIM( ISNULL( CAST (iddetalheemissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| data : «' + RTRIM( ISNULL( CONVERT (CHAR, data, 113 ),'Nulo'))+'» '
                         + '| requisicao : «' + RTRIM( ISNULL( CAST (requisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| retorno : «' + RTRIM( ISNULL( CAST (retorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| observacao : «' + RTRIM( ISNULL( CAST (observacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| situacao : «' + RTRIM( ISNULL( CAST (situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| tipo : «' + RTRIM( ISNULL( CAST (tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| sistema : «' + RTRIM( ISNULL( CAST (sistema AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'id : «' + RTRIM( ISNULL( CAST (id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| iddetalheemissao : «' + RTRIM( ISNULL( CAST (iddetalheemissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| data : «' + RTRIM( ISNULL( CONVERT (CHAR, data, 113 ),'Nulo'))+'» '
                         + '| requisicao : «' + RTRIM( ISNULL( CAST (requisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| retorno : «' + RTRIM( ISNULL( CAST (retorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| observacao : «' + RTRIM( ISNULL( CAST (observacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| situacao : «' + RTRIM( ISNULL( CAST (situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| tipo : «' + RTRIM( ISNULL( CAST (tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| sistema : «' + RTRIM( ISNULL( CAST (sistema AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'id : «' + RTRIM( ISNULL( CAST (id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| iddetalheemissao : «' + RTRIM( ISNULL( CAST (iddetalheemissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| data : «' + RTRIM( ISNULL( CONVERT (CHAR, data, 113 ),'Nulo'))+'» '
                         + '| requisicao : «' + RTRIM( ISNULL( CAST (requisicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| retorno : «' + RTRIM( ISNULL( CAST (retorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| observacao : «' + RTRIM( ISNULL( CAST (observacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| situacao : «' + RTRIM( ISNULL( CAST (situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| tipo : «' + RTRIM( ISNULL( CAST (tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| sistema : «' + RTRIM( ISNULL( CAST (sistema AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
