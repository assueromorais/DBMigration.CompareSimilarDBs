CREATE TABLE [dbo].[Fed_AverbacoesCNS] (
    [IdtAver]      INT           NOT NULL,
    [IdtSoci]      INT           NOT NULL,
    [CodiTipoAver] INT           NOT NULL,
    [DscTipoAver]  VARCHAR (100) NULL,
    [DataAver]     DATETIME      NULL,
    [ArqAver]      VARCHAR (100) NULL
);


GO
CREATE TRIGGER [TrgLog_Fed_AverbacoesCNS] ON [Implanta_CRPAM].[dbo].[Fed_AverbacoesCNS] 
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
SET @TableName = 'Fed_AverbacoesCNS'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdtAver : «' + RTRIM( ISNULL( CAST (IdtAver AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdtSoci : «' + RTRIM( ISNULL( CAST (IdtSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodiTipoAver : «' + RTRIM( ISNULL( CAST (CodiTipoAver AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DscTipoAver : «' + RTRIM( ISNULL( CAST (DscTipoAver AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAver : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAver, 113 ),'Nulo'))+'» '
                         + '| ArqAver : «' + RTRIM( ISNULL( CAST (ArqAver AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdtAver : «' + RTRIM( ISNULL( CAST (IdtAver AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdtSoci : «' + RTRIM( ISNULL( CAST (IdtSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodiTipoAver : «' + RTRIM( ISNULL( CAST (CodiTipoAver AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DscTipoAver : «' + RTRIM( ISNULL( CAST (DscTipoAver AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAver : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAver, 113 ),'Nulo'))+'» '
                         + '| ArqAver : «' + RTRIM( ISNULL( CAST (ArqAver AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdtAver : «' + RTRIM( ISNULL( CAST (IdtAver AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdtSoci : «' + RTRIM( ISNULL( CAST (IdtSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodiTipoAver : «' + RTRIM( ISNULL( CAST (CodiTipoAver AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DscTipoAver : «' + RTRIM( ISNULL( CAST (DscTipoAver AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAver : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAver, 113 ),'Nulo'))+'» '
                         + '| ArqAver : «' + RTRIM( ISNULL( CAST (ArqAver AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdtAver : «' + RTRIM( ISNULL( CAST (IdtAver AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdtSoci : «' + RTRIM( ISNULL( CAST (IdtSoci AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodiTipoAver : «' + RTRIM( ISNULL( CAST (CodiTipoAver AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DscTipoAver : «' + RTRIM( ISNULL( CAST (DscTipoAver AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAver : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAver, 113 ),'Nulo'))+'» '
                         + '| ArqAver : «' + RTRIM( ISNULL( CAST (ArqAver AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
