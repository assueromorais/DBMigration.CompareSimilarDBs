CREATE TABLE [dbo].[ImagemEmissao] (
    [IdImagemEmissao]  INT   IDENTITY (1, 1) NOT NULL,
    [IdDetalheEmissao] INT   NOT NULL,
    [Boleto]           IMAGE NOT NULL,
    [BoletoVerso]      IMAGE NULL,
    CONSTRAINT [PK_ImagemEmissao] PRIMARY KEY CLUSTERED ([IdImagemEmissao] ASC),
    CONSTRAINT [FK_ImagemEmissao_DetalhesEmissao] FOREIGN KEY ([IdDetalheEmissao]) REFERENCES [dbo].[DetalhesEmissao] ([IdDetalheEmissao])
);


GO
CREATE TRIGGER [TrgLog_ImagemEmissao] ON [Implanta_CRPAM].[dbo].[ImagemEmissao] 
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
SET @TableName = 'ImagemEmissao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdImagemEmissao : «' + RTRIM( ISNULL( CAST (IdImagemEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdImagemEmissao : «' + RTRIM( ISNULL( CAST (IdImagemEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdImagemEmissao : «' + RTRIM( ISNULL( CAST (IdImagemEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdImagemEmissao : «' + RTRIM( ISNULL( CAST (IdImagemEmissao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDetalheEmissao : «' + RTRIM( ISNULL( CAST (IdDetalheEmissao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
