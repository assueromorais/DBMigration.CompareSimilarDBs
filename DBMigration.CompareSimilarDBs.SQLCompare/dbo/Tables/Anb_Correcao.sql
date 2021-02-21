CREATE TABLE [dbo].[Anb_Correcao] (
    [IdCorrecao]      INT            NOT NULL,
    [Descricao]       VARCHAR (300)  NOT NULL,
    [DataCriacao]     DATETIME       NOT NULL,
    [NotaExplicativa] VARCHAR (1000) NULL,
    [ComandoSql]      VARCHAR (1000) NULL,
    [Ativa]           CHAR (1)       NOT NULL,
    [OrigemAnalise]   CHAR (1)       NOT NULL,
    CONSTRAINT [PK_Anb_Correcao] PRIMARY KEY CLUSTERED ([IdCorrecao] ASC)
);


GO
CREATE TRIGGER [TrgLog_Anb_Correcao] ON [Implanta_CRPAM].[dbo].[Anb_Correcao] 
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
SET @TableName = 'Anb_Correcao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCorrecao : «' + RTRIM( ISNULL( CAST (IdCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| NotaExplicativa : «' + RTRIM( ISNULL( CAST (NotaExplicativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComandoSql : «' + RTRIM( ISNULL( CAST (ComandoSql AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ativa : «' + RTRIM( ISNULL( CAST (Ativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrigemAnalise : «' + RTRIM( ISNULL( CAST (OrigemAnalise AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCorrecao : «' + RTRIM( ISNULL( CAST (IdCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| NotaExplicativa : «' + RTRIM( ISNULL( CAST (NotaExplicativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComandoSql : «' + RTRIM( ISNULL( CAST (ComandoSql AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ativa : «' + RTRIM( ISNULL( CAST (Ativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrigemAnalise : «' + RTRIM( ISNULL( CAST (OrigemAnalise AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCorrecao : «' + RTRIM( ISNULL( CAST (IdCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| NotaExplicativa : «' + RTRIM( ISNULL( CAST (NotaExplicativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComandoSql : «' + RTRIM( ISNULL( CAST (ComandoSql AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ativa : «' + RTRIM( ISNULL( CAST (Ativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrigemAnalise : «' + RTRIM( ISNULL( CAST (OrigemAnalise AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCorrecao : «' + RTRIM( ISNULL( CAST (IdCorrecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| NotaExplicativa : «' + RTRIM( ISNULL( CAST (NotaExplicativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComandoSql : «' + RTRIM( ISNULL( CAST (ComandoSql AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ativa : «' + RTRIM( ISNULL( CAST (Ativa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrigemAnalise : «' + RTRIM( ISNULL( CAST (OrigemAnalise AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
