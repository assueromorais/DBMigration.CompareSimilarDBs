CREATE TABLE [dbo].[Criterios] (
    [IdCriterios] INT            IDENTITY (1, 1) NOT NULL,
    [Descricao]   VARCHAR (50)   NOT NULL,
    [Origem]      VARCHAR (50)   NOT NULL,
    [Categoria]   VARCHAR (50)   NOT NULL,
    [Tipo]        INT            NULL,
    [CA]          VARCHAR (50)   NULL,
    [SQL]         VARCHAR (4000) NULL,
    [Ordem]       VARCHAR (255)  NULL,
    CONSTRAINT [PK_Criterios] PRIMARY KEY CLUSTERED ([IdCriterios] ASC)
);


GO
CREATE TRIGGER [TrgLog_Criterios] ON [Implanta_CRPAM].[dbo].[Criterios] 
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
SET @TableName = 'Criterios'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCriterios : «' + RTRIM( ISNULL( CAST (IdCriterios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Categoria : «' + RTRIM( ISNULL( CAST (Categoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CA : «' + RTRIM( ISNULL( CAST (CA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SQL : «' + RTRIM( ISNULL( CAST (SQL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCriterios : «' + RTRIM( ISNULL( CAST (IdCriterios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Categoria : «' + RTRIM( ISNULL( CAST (Categoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CA : «' + RTRIM( ISNULL( CAST (CA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SQL : «' + RTRIM( ISNULL( CAST (SQL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCriterios : «' + RTRIM( ISNULL( CAST (IdCriterios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Categoria : «' + RTRIM( ISNULL( CAST (Categoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CA : «' + RTRIM( ISNULL( CAST (CA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SQL : «' + RTRIM( ISNULL( CAST (SQL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCriterios : «' + RTRIM( ISNULL( CAST (IdCriterios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Categoria : «' + RTRIM( ISNULL( CAST (Categoria AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CA : «' + RTRIM( ISNULL( CAST (CA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SQL : «' + RTRIM( ISNULL( CAST (SQL AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
