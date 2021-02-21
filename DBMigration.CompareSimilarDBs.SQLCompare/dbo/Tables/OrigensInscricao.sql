CREATE TABLE [dbo].[OrigensInscricao] (
    [IdOrigemInscricao] INT           IDENTITY (1, 1) NOT NULL,
    [OrigemInscricao]   VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_OrigensInscricao] PRIMARY KEY CLUSTERED ([IdOrigemInscricao] ASC)
);


GO
CREATE TRIGGER [TrgLog_OrigensInscricao] ON [Implanta_CRPAM].[dbo].[OrigensInscricao] 
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
SET @TableName = 'OrigensInscricao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdOrigemInscricao : «' + RTRIM( ISNULL( CAST (IdOrigemInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrigemInscricao : «' + RTRIM( ISNULL( CAST (OrigemInscricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdOrigemInscricao : «' + RTRIM( ISNULL( CAST (IdOrigemInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrigemInscricao : «' + RTRIM( ISNULL( CAST (OrigemInscricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdOrigemInscricao : «' + RTRIM( ISNULL( CAST (IdOrigemInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrigemInscricao : «' + RTRIM( ISNULL( CAST (OrigemInscricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdOrigemInscricao : «' + RTRIM( ISNULL( CAST (IdOrigemInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrigemInscricao : «' + RTRIM( ISNULL( CAST (OrigemInscricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
