CREATE TABLE [dbo].[Cartorios] (
    [IdCartorio] INT          IDENTITY (1, 1) NOT NULL,
    [Cartorio]   VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_Cartorios] PRIMARY KEY NONCLUSTERED ([IdCartorio] ASC)
);


GO
CREATE TRIGGER [TrgLog_Cartorios] ON [Implanta_CRPAM].[dbo].[Cartorios] 
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
SET @TableName = 'Cartorios'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCartorio : «' + RTRIM( ISNULL( CAST (IdCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cartorio : «' + RTRIM( ISNULL( CAST (Cartorio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCartorio : «' + RTRIM( ISNULL( CAST (IdCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cartorio : «' + RTRIM( ISNULL( CAST (Cartorio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCartorio : «' + RTRIM( ISNULL( CAST (IdCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cartorio : «' + RTRIM( ISNULL( CAST (Cartorio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCartorio : «' + RTRIM( ISNULL( CAST (IdCartorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cartorio : «' + RTRIM( ISNULL( CAST (Cartorio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
