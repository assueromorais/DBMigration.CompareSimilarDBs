CREATE TABLE [dbo].[NiveisAutorizacao] (
    [IdNivelAutorizacao]    INT           IDENTITY (1, 1) NOT NULL,
    [DescricaoNivel]        NVARCHAR (50) NULL,
    [IdSistema]             INT           NULL,
    [IdSituacaoSolicitacao] INT           NULL,
    CONSTRAINT [PK_NiveisAutorizacao] PRIMARY KEY CLUSTERED ([IdNivelAutorizacao] ASC),
    CONSTRAINT [FK_NiveisAutorizacao_Sistemas] FOREIGN KEY ([IdSistema]) REFERENCES [dbo].[Sistemas] ([IdSistema]),
    CONSTRAINT [FK_NiveisAutorizacao_SituacoesSolicitacao] FOREIGN KEY ([IdSituacaoSolicitacao]) REFERENCES [dbo].[SituacoesSolicitacao] ([IdSituacaoSolicitacao])
);


GO
CREATE TRIGGER [TrgLog_NiveisAutorizacao] ON [Implanta_CRPAM].[dbo].[NiveisAutorizacao] 
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
SET @TableName = 'NiveisAutorizacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdNivelAutorizacao : «' + RTRIM( ISNULL( CAST (IdNivelAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdNivelAutorizacao : «' + RTRIM( ISNULL( CAST (IdNivelAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdNivelAutorizacao : «' + RTRIM( ISNULL( CAST (IdNivelAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdNivelAutorizacao : «' + RTRIM( ISNULL( CAST (IdNivelAutorizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
