CREATE TABLE [dbo].[DetalheArquivosReceitaCONFEACREA] (
    [IdDetalheArquivo]  INT IDENTITY (1, 1) NOT NULL,
    [IdControleArquivo] INT NULL,
    [IdReceita]         INT NULL,
    CONSTRAINT [PK_DetalheArquivosReceitaCONFEACREA] PRIMARY KEY CLUSTERED ([IdDetalheArquivo] ASC),
    CONSTRAINT [FK_DetalheArquivosReceitaCONFEACREA_ControleArquivosReceitaCONFEACREA] FOREIGN KEY ([IdControleArquivo]) REFERENCES [dbo].[ControleArquivosReceitaCONFEACREA] ([IdControleArquivo]),
    CONSTRAINT [FK_DetalheArquivosReceitaCONFEACREA_Receitas] FOREIGN KEY ([IdReceita]) REFERENCES [dbo].[Receitas] ([IdReceita])
);


GO
CREATE TRIGGER [TrgLog_DetalheArquivosReceitaCONFEACREA] ON [Implanta_CRPAM].[dbo].[DetalheArquivosReceitaCONFEACREA] 
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
SET @TableName = 'DetalheArquivosReceitaCONFEACREA'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDetalheArquivo : «' + RTRIM( ISNULL( CAST (IdDetalheArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivo : «' + RTRIM( ISNULL( CAST (IdControleArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDetalheArquivo : «' + RTRIM( ISNULL( CAST (IdDetalheArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivo : «' + RTRIM( ISNULL( CAST (IdControleArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDetalheArquivo : «' + RTRIM( ISNULL( CAST (IdDetalheArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivo : «' + RTRIM( ISNULL( CAST (IdControleArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDetalheArquivo : «' + RTRIM( ISNULL( CAST (IdDetalheArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivo : «' + RTRIM( ISNULL( CAST (IdControleArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
