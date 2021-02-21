CREATE TABLE [dbo].[Indices] (
    [IdIndice]        INT      NOT NULL,
    [Data]            DATETIME NOT NULL,
    [Valor]           MONEY    NULL,
    [Id]              INT      IDENTITY (1, 1) NOT NULL,
    [DataAtualizacao] DATETIME NULL,
    CONSTRAINT [PK_Indices] PRIMARY KEY CLUSTERED ([IdIndice] ASC, [Data] ASC)
);


GO
CREATE TRIGGER [TrgLog_Indices] ON [Implanta_CRPAM].[dbo].[Indices] 
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
SET @TableName = 'Indices'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdIndice : «' + RTRIM( ISNULL( CAST (IdIndice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Id : «' + RTRIM( ISNULL( CAST (Id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdIndice : «' + RTRIM( ISNULL( CAST (IdIndice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Id : «' + RTRIM( ISNULL( CAST (Id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdIndice : «' + RTRIM( ISNULL( CAST (IdIndice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Id : «' + RTRIM( ISNULL( CAST (Id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdIndice : «' + RTRIM( ISNULL( CAST (IdIndice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Id : «' + RTRIM( ISNULL( CAST (Id AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAtualizacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
