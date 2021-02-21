CREATE TABLE [dbo].[LoteEnvio] (
    [IdLoteEnvio]    INT          IDENTITY (1, 1) NOT NULL,
    [DataCriacao]    DATETIME     NULL,
    [Usuario]        VARCHAR (50) NULL,
    [DataEnvio]      DATETIME     NULL,
    [SituacaoLote]   VARCHAR (50) NULL,
    [IdDepartamento] INT          NULL,
    [IdUsuario]      INT          NULL
);


GO
CREATE TRIGGER [TrgLog_LoteEnvio] ON [Implanta_CRPAM].[dbo].[LoteEnvio] 
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
SET @TableName = 'LoteEnvio'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLoteEnvio : «' + RTRIM( ISNULL( CAST (IdLoteEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» '
                         + '| SituacaoLote : «' + RTRIM( ISNULL( CAST (SituacaoLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLoteEnvio : «' + RTRIM( ISNULL( CAST (IdLoteEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» '
                         + '| SituacaoLote : «' + RTRIM( ISNULL( CAST (SituacaoLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLoteEnvio : «' + RTRIM( ISNULL( CAST (IdLoteEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» '
                         + '| SituacaoLote : «' + RTRIM( ISNULL( CAST (SituacaoLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLoteEnvio : «' + RTRIM( ISNULL( CAST (IdLoteEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCriacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCriacao, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEnvio, 113 ),'Nulo'))+'» '
                         + '| SituacaoLote : «' + RTRIM( ISNULL( CAST (SituacaoLote AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
