CREATE TABLE [dbo].[Modulos] (
    [IdModulo]  INT          IDENTITY (1, 1) NOT NULL,
    [IdSistema] INT          NOT NULL,
    [Modulo]    VARCHAR (60) NOT NULL,
    [Descricao] TEXT         NULL,
    CONSTRAINT [PK_Modulos] PRIMARY KEY CLUSTERED ([IdModulo] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Modulos_Sistemas] FOREIGN KEY ([IdSistema]) REFERENCES [dbo].[Sistemas] ([IdSistema])
);


GO
CREATE TRIGGER [TrgLog_Modulos] ON [Implanta_CRPAM].[dbo].[Modulos] 
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
SET @TableName = 'Modulos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdModulo : «' + RTRIM( ISNULL( CAST (IdModulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modulo : «' + RTRIM( ISNULL( CAST (Modulo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdModulo : «' + RTRIM( ISNULL( CAST (IdModulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modulo : «' + RTRIM( ISNULL( CAST (Modulo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdModulo : «' + RTRIM( ISNULL( CAST (IdModulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modulo : «' + RTRIM( ISNULL( CAST (Modulo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdModulo : «' + RTRIM( ISNULL( CAST (IdModulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modulo : «' + RTRIM( ISNULL( CAST (Modulo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
