CREATE TABLE [dbo].[ListaComprasGeradas] (
    [IdListaCompraGerada] INT      IDENTITY (1, 1) NOT NULL,
    [DataHoraGeracao]     DATETIME NOT NULL,
    CONSTRAINT [PK_ListaComprasGeradas] PRIMARY KEY CLUSTERED ([IdListaCompraGerada] ASC)
);


GO
CREATE TRIGGER [TrgLog_ListaComprasGeradas] ON [Implanta_CRPAM].[dbo].[ListaComprasGeradas] 
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
SET @TableName = 'ListaComprasGeradas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdListaCompraGerada : «' + RTRIM( ISNULL( CAST (IdListaCompraGerada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHoraGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraGeracao, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdListaCompraGerada : «' + RTRIM( ISNULL( CAST (IdListaCompraGerada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHoraGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraGeracao, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdListaCompraGerada : «' + RTRIM( ISNULL( CAST (IdListaCompraGerada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHoraGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraGeracao, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdListaCompraGerada : «' + RTRIM( ISNULL( CAST (IdListaCompraGerada AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataHoraGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataHoraGeracao, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
