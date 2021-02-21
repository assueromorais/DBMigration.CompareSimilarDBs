CREATE TABLE [dbo].[LotesTramitacoes] (
    [IdLoteTramitacao]      INT      IDENTITY (1, 1) NOT NULL,
    [DataLote]              DATETIME NULL,
    [IdDepartamento]        INT      NULL,
    [IdUsuario]             INT      NULL,
    [DataRecebeu]           DATETIME NULL,
    [IdDepartamentoCriacao] INT      NULL,
    [IdUsuarioCriacao]      INT      NULL,
    [IdDepartamentoRecebeu] INT      NULL,
    [IdUsuarioRecebeu]      INT      NULL,
    [DataPrevisao]          DATETIME NULL,
    CONSTRAINT [PK_LotesTramitacoes] PRIMARY KEY CLUSTERED ([IdLoteTramitacao] ASC)
);


GO
CREATE TRIGGER [TrgLog_LotesTramitacoes] ON [Implanta_CRPAM].[dbo].[LotesTramitacoes] 
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
SET @TableName = 'LotesTramitacoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLoteTramitacao : «' + RTRIM( ISNULL( CAST (IdLoteTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLote : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLote, 113 ),'Nulo'))+'» '
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecebeu : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebeu, 113 ),'Nulo'))+'» '
                         + '| IdDepartamentoCriacao : «' + RTRIM( ISNULL( CAST (IdDepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamentoRecebeu : «' + RTRIM( ISNULL( CAST (IdDepartamentoRecebeu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioRecebeu : «' + RTRIM( ISNULL( CAST (IdUsuarioRecebeu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevisao, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLoteTramitacao : «' + RTRIM( ISNULL( CAST (IdLoteTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLote : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLote, 113 ),'Nulo'))+'» '
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecebeu : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebeu, 113 ),'Nulo'))+'» '
                         + '| IdDepartamentoCriacao : «' + RTRIM( ISNULL( CAST (IdDepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamentoRecebeu : «' + RTRIM( ISNULL( CAST (IdDepartamentoRecebeu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioRecebeu : «' + RTRIM( ISNULL( CAST (IdUsuarioRecebeu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevisao, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLoteTramitacao : «' + RTRIM( ISNULL( CAST (IdLoteTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLote : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLote, 113 ),'Nulo'))+'» '
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecebeu : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebeu, 113 ),'Nulo'))+'» '
                         + '| IdDepartamentoCriacao : «' + RTRIM( ISNULL( CAST (IdDepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamentoRecebeu : «' + RTRIM( ISNULL( CAST (IdDepartamentoRecebeu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioRecebeu : «' + RTRIM( ISNULL( CAST (IdUsuarioRecebeu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevisao, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLoteTramitacao : «' + RTRIM( ISNULL( CAST (IdLoteTramitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLote : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLote, 113 ),'Nulo'))+'» '
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecebeu : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebeu, 113 ),'Nulo'))+'» '
                         + '| IdDepartamentoCriacao : «' + RTRIM( ISNULL( CAST (IdDepartamentoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamentoRecebeu : «' + RTRIM( ISNULL( CAST (IdDepartamentoRecebeu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioRecebeu : «' + RTRIM( ISNULL( CAST (IdUsuarioRecebeu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevisao, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
