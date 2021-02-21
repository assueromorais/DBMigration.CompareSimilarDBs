CREATE TABLE [dbo].[InstituicoesOcorrenciaJuridica] (
    [IdOcorrPJSitOcorr]    INT      IDENTITY (1, 1) NOT NULL,
    [IdOcorrenciaPesJurid] INT      NULL,
    [IdSituacaoOcorrencia] INT      NULL,
    [DataRegistroSituacao] DATETIME NULL,
    [DataSituacao]         DATETIME NULL,
    [Observacoes]          TEXT     NULL,
    CONSTRAINT [PK_InstituicoesOcorrenciaJuridica] PRIMARY KEY CLUSTERED ([IdOcorrPJSitOcorr] ASC)
);


GO
CREATE TRIGGER [TrgLog_InstituicoesOcorrenciaJuridica] ON [Implanta_CRPAM].[dbo].[InstituicoesOcorrenciaJuridica] 
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
SET @TableName = 'InstituicoesOcorrenciaJuridica'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdOcorrPJSitOcorr : «' + RTRIM( ISNULL( CAST (IdOcorrPJSitOcorr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOcorrenciaPesJurid : «' + RTRIM( ISNULL( CAST (IdOcorrenciaPesJurid AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoOcorrencia : «' + RTRIM( ISNULL( CAST (IdSituacaoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRegistroSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRegistroSituacao, 113 ),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdOcorrPJSitOcorr : «' + RTRIM( ISNULL( CAST (IdOcorrPJSitOcorr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOcorrenciaPesJurid : «' + RTRIM( ISNULL( CAST (IdOcorrenciaPesJurid AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoOcorrencia : «' + RTRIM( ISNULL( CAST (IdSituacaoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRegistroSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRegistroSituacao, 113 ),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdOcorrPJSitOcorr : «' + RTRIM( ISNULL( CAST (IdOcorrPJSitOcorr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOcorrenciaPesJurid : «' + RTRIM( ISNULL( CAST (IdOcorrenciaPesJurid AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoOcorrencia : «' + RTRIM( ISNULL( CAST (IdSituacaoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRegistroSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRegistroSituacao, 113 ),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdOcorrPJSitOcorr : «' + RTRIM( ISNULL( CAST (IdOcorrPJSitOcorr AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOcorrenciaPesJurid : «' + RTRIM( ISNULL( CAST (IdOcorrenciaPesJurid AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoOcorrencia : «' + RTRIM( ISNULL( CAST (IdSituacaoOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRegistroSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRegistroSituacao, 113 ),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
