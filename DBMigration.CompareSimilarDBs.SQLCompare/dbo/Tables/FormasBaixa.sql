CREATE TABLE [dbo].[FormasBaixa] (
    [IdFormaBaixa] INT          IDENTITY (1, 1) NOT NULL,
    [FormaBaixa]   VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_FormasBaixa] PRIMARY KEY NONCLUSTERED ([IdFormaBaixa] ASC)
);


GO
CREATE TRIGGER [TrgLog_FormasBaixa] ON [Implanta_CRPAM].[dbo].[FormasBaixa] 
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
SET @TableName = 'FormasBaixa'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdFormaBaixa : «' + RTRIM( ISNULL( CAST (IdFormaBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaBaixa : «' + RTRIM( ISNULL( CAST (FormaBaixa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdFormaBaixa : «' + RTRIM( ISNULL( CAST (IdFormaBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaBaixa : «' + RTRIM( ISNULL( CAST (FormaBaixa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdFormaBaixa : «' + RTRIM( ISNULL( CAST (IdFormaBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaBaixa : «' + RTRIM( ISNULL( CAST (FormaBaixa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdFormaBaixa : «' + RTRIM( ISNULL( CAST (IdFormaBaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaBaixa : «' + RTRIM( ISNULL( CAST (FormaBaixa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
