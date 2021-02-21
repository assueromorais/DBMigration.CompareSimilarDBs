CREATE TABLE [dbo].[Locks] (
    [NomeTabela] VARCHAR (70) NOT NULL,
    [IdUsuario]  INT          NOT NULL,
    [HoraLock]   DATETIME     NOT NULL,
    [IdSistema]  INT          NOT NULL,
    [IdRegistro] INT          NOT NULL
);


GO
CREATE TRIGGER [TrgLog_Locks] ON [Implanta_CRPAM].[dbo].[Locks] 
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
SET @TableName = 'Locks'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HoraLock : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraLock, 113 ),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRegistro : «' + RTRIM( ISNULL( CAST (IdRegistro AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HoraLock : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraLock, 113 ),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRegistro : «' + RTRIM( ISNULL( CAST (IdRegistro AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HoraLock : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraLock, 113 ),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRegistro : «' + RTRIM( ISNULL( CAST (IdRegistro AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'NomeTabela : «' + RTRIM( ISNULL( CAST (NomeTabela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HoraLock : «' + RTRIM( ISNULL( CONVERT (CHAR, HoraLock, 113 ),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRegistro : «' + RTRIM( ISNULL( CAST (IdRegistro AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
