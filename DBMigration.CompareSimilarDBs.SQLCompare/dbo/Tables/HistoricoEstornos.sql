CREATE TABLE [dbo].[HistoricoEstornos] (
    [IdHistoricoEstorno]    INT      IDENTITY (1, 1) NOT NULL,
    [IdUsuario]             INT      NULL,
    [IdConfigGeracaoDebito] INT      NULL,
    [DataGeracao]           DATETIME NULL,
    [CriteriosGeracao]      TEXT     NULL,
    [DataEstorno]           DATETIME NULL,
    [QtdeProfissionais]     INT      NULL,
    [QtdeDebitosExcluidos]  INT      NULL,
    CONSTRAINT [PK_HistoricoEstornos] PRIMARY KEY CLUSTERED ([IdHistoricoEstorno] ASC)
);


GO
CREATE TRIGGER [TrgLog_HistoricoEstornos] ON [Implanta_CRPAM].[dbo].[HistoricoEstornos] 
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
SET @TableName = 'HistoricoEstornos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistoricoEstorno : «' + RTRIM( ISNULL( CAST (IdHistoricoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| DataEstorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEstorno, 113 ),'Nulo'))+'» '
                         + '| QtdeProfissionais : «' + RTRIM( ISNULL( CAST (QtdeProfissionais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeDebitosExcluidos : «' + RTRIM( ISNULL( CAST (QtdeDebitosExcluidos AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistoricoEstorno : «' + RTRIM( ISNULL( CAST (IdHistoricoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| DataEstorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEstorno, 113 ),'Nulo'))+'» '
                         + '| QtdeProfissionais : «' + RTRIM( ISNULL( CAST (QtdeProfissionais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeDebitosExcluidos : «' + RTRIM( ISNULL( CAST (QtdeDebitosExcluidos AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistoricoEstorno : «' + RTRIM( ISNULL( CAST (IdHistoricoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| DataEstorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEstorno, 113 ),'Nulo'))+'» '
                         + '| QtdeProfissionais : «' + RTRIM( ISNULL( CAST (QtdeProfissionais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeDebitosExcluidos : «' + RTRIM( ISNULL( CAST (QtdeDebitosExcluidos AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistoricoEstorno : «' + RTRIM( ISNULL( CAST (IdHistoricoEstorno AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| DataEstorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEstorno, 113 ),'Nulo'))+'» '
                         + '| QtdeProfissionais : «' + RTRIM( ISNULL( CAST (QtdeProfissionais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeDebitosExcluidos : «' + RTRIM( ISNULL( CAST (QtdeDebitosExcluidos AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
