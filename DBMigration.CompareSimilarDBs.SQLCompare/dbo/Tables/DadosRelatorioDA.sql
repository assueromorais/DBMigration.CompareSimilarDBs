CREATE TABLE [dbo].[DadosRelatorioDA] (
    [IdDadoRelatorioDA]    INT          IDENTITY (1, 1) NOT NULL,
    [NumeroControle]       VARCHAR (50) NULL,
    [Situacao]             INT          NULL,
    [DataSituacao]         DATETIME     NULL,
    [Resolvido]            BIT          CONSTRAINT [DEF_DadosRelatorioDA_Resolvido] DEFAULT ((0)) NOT NULL,
    [DataResolveu]         DATETIME     NULL,
    [UsuarioResolveu]      VARCHAR (60) NULL,
    [DepartamentoResolveu] VARCHAR (60) NULL,
    CONSTRAINT [PK_DadosRelatorioDA_IdDadoRelatorioDA] PRIMARY KEY CLUSTERED ([IdDadoRelatorioDA] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_DadosRelatorioDA_NumeroControle]
    ON [dbo].[DadosRelatorioDA]([NumeroControle] ASC);


GO
CREATE TRIGGER [TrgLog_DadosRelatorioDA] ON [Implanta_CRPAM].[dbo].[DadosRelatorioDA] 
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
SET @TableName = 'DadosRelatorioDA'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDadoRelatorioDA : «' + RTRIM( ISNULL( CAST (IdDadoRelatorioDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroControle : «' + RTRIM( ISNULL( CAST (NumeroControle AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Resolvido IS NULL THEN ' Resolvido : «Nulo» '
                                              WHEN  Resolvido = 0 THEN ' Resolvido : «Falso» '
                                              WHEN  Resolvido = 1 THEN ' Resolvido : «Verdadeiro» '
                                    END 
                         + '| DataResolveu : «' + RTRIM( ISNULL( CONVERT (CHAR, DataResolveu, 113 ),'Nulo'))+'» '
                         + '| UsuarioResolveu : «' + RTRIM( ISNULL( CAST (UsuarioResolveu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoResolveu : «' + RTRIM( ISNULL( CAST (DepartamentoResolveu AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDadoRelatorioDA : «' + RTRIM( ISNULL( CAST (IdDadoRelatorioDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroControle : «' + RTRIM( ISNULL( CAST (NumeroControle AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Resolvido IS NULL THEN ' Resolvido : «Nulo» '
                                              WHEN  Resolvido = 0 THEN ' Resolvido : «Falso» '
                                              WHEN  Resolvido = 1 THEN ' Resolvido : «Verdadeiro» '
                                    END 
                         + '| DataResolveu : «' + RTRIM( ISNULL( CONVERT (CHAR, DataResolveu, 113 ),'Nulo'))+'» '
                         + '| UsuarioResolveu : «' + RTRIM( ISNULL( CAST (UsuarioResolveu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoResolveu : «' + RTRIM( ISNULL( CAST (DepartamentoResolveu AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDadoRelatorioDA : «' + RTRIM( ISNULL( CAST (IdDadoRelatorioDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroControle : «' + RTRIM( ISNULL( CAST (NumeroControle AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Resolvido IS NULL THEN ' Resolvido : «Nulo» '
                                              WHEN  Resolvido = 0 THEN ' Resolvido : «Falso» '
                                              WHEN  Resolvido = 1 THEN ' Resolvido : «Verdadeiro» '
                                    END 
                         + '| DataResolveu : «' + RTRIM( ISNULL( CONVERT (CHAR, DataResolveu, 113 ),'Nulo'))+'» '
                         + '| UsuarioResolveu : «' + RTRIM( ISNULL( CAST (UsuarioResolveu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoResolveu : «' + RTRIM( ISNULL( CAST (DepartamentoResolveu AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDadoRelatorioDA : «' + RTRIM( ISNULL( CAST (IdDadoRelatorioDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroControle : «' + RTRIM( ISNULL( CAST (NumeroControle AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSituacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSituacao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Resolvido IS NULL THEN ' Resolvido : «Nulo» '
                                              WHEN  Resolvido = 0 THEN ' Resolvido : «Falso» '
                                              WHEN  Resolvido = 1 THEN ' Resolvido : «Verdadeiro» '
                                    END 
                         + '| DataResolveu : «' + RTRIM( ISNULL( CONVERT (CHAR, DataResolveu, 113 ),'Nulo'))+'» '
                         + '| UsuarioResolveu : «' + RTRIM( ISNULL( CAST (UsuarioResolveu AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoResolveu : «' + RTRIM( ISNULL( CAST (DepartamentoResolveu AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
