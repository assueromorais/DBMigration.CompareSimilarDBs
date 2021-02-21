CREATE TABLE [dbo].[Historicos] (
    [CodHistorico] INT           NOT NULL,
    [Historico]    VARCHAR (255) NOT NULL,
    CONSTRAINT [PK_Historicos] PRIMARY KEY NONCLUSTERED ([CodHistorico] ASC)
);


GO
CREATE TRIGGER [TrgLog_Historicos] ON [Implanta_CRPAM].[dbo].[Historicos] 
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
SET @TableName = 'Historicos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'CodHistorico : «' + RTRIM( ISNULL( CAST (CodHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'CodHistorico : «' + RTRIM( ISNULL( CAST (CodHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'CodHistorico : «' + RTRIM( ISNULL( CAST (CodHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'CodHistorico : «' + RTRIM( ISNULL( CAST (CodHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
