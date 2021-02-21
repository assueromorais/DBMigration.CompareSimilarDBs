CREATE TABLE [dbo].[Anb_Sistemas_VersaoProduto] (
    [IdSistema]       INT      NOT NULL,
    [IdVersaoProduto] SMALLINT NOT NULL,
    CONSTRAINT [PK_Anb_Sistemas_VersaoProduto] PRIMARY KEY CLUSTERED ([IdSistema] ASC, [IdVersaoProduto] ASC),
    CONSTRAINT [FK_Anb_Sistemas_VersaoProduto_Anb_VersaoProduto] FOREIGN KEY ([IdVersaoProduto]) REFERENCES [dbo].[Anb_VersaoProduto] ([IdVersaoProduto]),
    CONSTRAINT [FK_Anb_Sistemas_VersaoProduto_Sistemas] FOREIGN KEY ([IdSistema]) REFERENCES [dbo].[Sistemas] ([IdSistema])
);


GO
CREATE TRIGGER [TrgLog_Anb_Sistemas_VersaoProduto] ON [Implanta_CRPAM].[dbo].[Anb_Sistemas_VersaoProduto] 
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
SET @TableName = 'Anb_Sistemas_VersaoProduto'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdVersaoProduto : «' + RTRIM( ISNULL( CAST (IdVersaoProduto AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdVersaoProduto : «' + RTRIM( ISNULL( CAST (IdVersaoProduto AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdVersaoProduto : «' + RTRIM( ISNULL( CAST (IdVersaoProduto AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdVersaoProduto : «' + RTRIM( ISNULL( CAST (IdVersaoProduto AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
