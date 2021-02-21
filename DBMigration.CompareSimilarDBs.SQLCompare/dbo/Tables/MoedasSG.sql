CREATE TABLE [dbo].[MoedasSG] (
    [IdMoedaSG]      INT          IDENTITY (1, 1) NOT NULL,
    [MoedaSG]        VARCHAR (20) NOT NULL,
    [Simbolo]        VARCHAR (5)  NULL,
    [FatorConversao] FLOAT (53)   NULL,
    CONSTRAINT [PK_MoedasSG] PRIMARY KEY NONCLUSTERED ([IdMoedaSG] ASC)
);


GO
CREATE TRIGGER [TrgLog_MoedasSG] ON [Implanta_CRPAM].[dbo].[MoedasSG] 
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
SET @TableName = 'MoedasSG'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMoedaSG : «' + RTRIM( ISNULL( CAST (IdMoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MoedaSG : «' + RTRIM( ISNULL( CAST (MoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Simbolo : «' + RTRIM( ISNULL( CAST (Simbolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatorConversao : «' + RTRIM( ISNULL( CAST (FatorConversao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMoedaSG : «' + RTRIM( ISNULL( CAST (IdMoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MoedaSG : «' + RTRIM( ISNULL( CAST (MoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Simbolo : «' + RTRIM( ISNULL( CAST (Simbolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatorConversao : «' + RTRIM( ISNULL( CAST (FatorConversao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMoedaSG : «' + RTRIM( ISNULL( CAST (IdMoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MoedaSG : «' + RTRIM( ISNULL( CAST (MoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Simbolo : «' + RTRIM( ISNULL( CAST (Simbolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatorConversao : «' + RTRIM( ISNULL( CAST (FatorConversao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMoedaSG : «' + RTRIM( ISNULL( CAST (IdMoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MoedaSG : «' + RTRIM( ISNULL( CAST (MoedaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Simbolo : «' + RTRIM( ISNULL( CAST (Simbolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatorConversao : «' + RTRIM( ISNULL( CAST (FatorConversao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
