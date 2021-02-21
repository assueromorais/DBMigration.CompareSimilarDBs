CREATE TABLE [dbo].[InfoCadastralTipoProcesso] (
    [IdInfoCadastralTipoProcesso] INT IDENTITY (1, 1) NOT NULL,
    [IdTipoProcesso]              INT NOT NULL,
    CONSTRAINT [PK_InfoCadastralTipoProcesso] PRIMARY KEY CLUSTERED ([IdInfoCadastralTipoProcesso] ASC),
    CONSTRAINT [FK_InfoCadastralTipoProcesso] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso]) ON DELETE CASCADE
);


GO
CREATE TRIGGER [TrgLog_InfoCadastralTipoProcesso] ON [Implanta_CRPAM].[dbo].[InfoCadastralTipoProcesso] 
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
SET @TableName = 'InfoCadastralTipoProcesso'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdInfoCadastralTipoProcesso : «' + RTRIM( ISNULL( CAST (IdInfoCadastralTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdInfoCadastralTipoProcesso : «' + RTRIM( ISNULL( CAST (IdInfoCadastralTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdInfoCadastralTipoProcesso : «' + RTRIM( ISNULL( CAST (IdInfoCadastralTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdInfoCadastralTipoProcesso : «' + RTRIM( ISNULL( CAST (IdInfoCadastralTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
