CREATE TABLE [dbo].[Modalidades] (
    [IdModalidade]        INT          IDENTITY (1, 1) NOT NULL,
    [Modalidade]          VARCHAR (50) NOT NULL,
    [PrefixoLicitacao]    VARCHAR (6)  NULL,
    [SufixoLicitacao]     VARCHAR (6)  NULL,
    [IncrementoLicitacao] INT          NULL,
    CONSTRAINT [PK_Modalidades] PRIMARY KEY CLUSTERED ([IdModalidade] ASC)
);


GO
CREATE TRIGGER [TrgLog_Modalidades] ON [Implanta_CRPAM].[dbo].[Modalidades] 
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
SET @TableName = 'Modalidades'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdModalidade : «' + RTRIM( ISNULL( CAST (IdModalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modalidade : «' + RTRIM( ISNULL( CAST (Modalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoLicitacao : «' + RTRIM( ISNULL( CAST (PrefixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoLicitacao : «' + RTRIM( ISNULL( CAST (SufixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoLicitacao : «' + RTRIM( ISNULL( CAST (IncrementoLicitacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdModalidade : «' + RTRIM( ISNULL( CAST (IdModalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modalidade : «' + RTRIM( ISNULL( CAST (Modalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoLicitacao : «' + RTRIM( ISNULL( CAST (PrefixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoLicitacao : «' + RTRIM( ISNULL( CAST (SufixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoLicitacao : «' + RTRIM( ISNULL( CAST (IncrementoLicitacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdModalidade : «' + RTRIM( ISNULL( CAST (IdModalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modalidade : «' + RTRIM( ISNULL( CAST (Modalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoLicitacao : «' + RTRIM( ISNULL( CAST (PrefixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoLicitacao : «' + RTRIM( ISNULL( CAST (SufixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoLicitacao : «' + RTRIM( ISNULL( CAST (IncrementoLicitacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdModalidade : «' + RTRIM( ISNULL( CAST (IdModalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modalidade : «' + RTRIM( ISNULL( CAST (Modalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoLicitacao : «' + RTRIM( ISNULL( CAST (PrefixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoLicitacao : «' + RTRIM( ISNULL( CAST (SufixoLicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoLicitacao : «' + RTRIM( ISNULL( CAST (IncrementoLicitacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
