CREATE TABLE [dbo].[EstadosConservacao] (
    [IdEstadoConservacao] INT          IDENTITY (1, 1) NOT NULL,
    [EstadoConservacao]   VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_EstadosConservacao] PRIMARY KEY NONCLUSTERED ([IdEstadoConservacao] ASC)
);


GO
CREATE TRIGGER [TrgLog_EstadosConservacao] ON [Implanta_CRPAM].[dbo].[EstadosConservacao] 
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
SET @TableName = 'EstadosConservacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEstadoConservacao : «' + RTRIM( ISNULL( CAST (IdEstadoConservacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstadoConservacao : «' + RTRIM( ISNULL( CAST (EstadoConservacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEstadoConservacao : «' + RTRIM( ISNULL( CAST (IdEstadoConservacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstadoConservacao : «' + RTRIM( ISNULL( CAST (EstadoConservacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEstadoConservacao : «' + RTRIM( ISNULL( CAST (IdEstadoConservacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstadoConservacao : «' + RTRIM( ISNULL( CAST (EstadoConservacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEstadoConservacao : «' + RTRIM( ISNULL( CAST (IdEstadoConservacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EstadoConservacao : «' + RTRIM( ISNULL( CAST (EstadoConservacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
