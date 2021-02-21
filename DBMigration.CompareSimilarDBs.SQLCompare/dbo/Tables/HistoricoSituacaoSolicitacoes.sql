CREATE TABLE [dbo].[HistoricoSituacaoSolicitacoes] (
    [IdHistoricoSituacaoSolicitacao] INT      IDENTITY (1, 1) NOT NULL,
    [IdSolicitacaoViagem]            INT      NOT NULL,
    [IdUsuario]                      INT      NOT NULL,
    [IdPessoaPassageiro]             INT      NOT NULL,
    [IdSituacaoSolicitacao]          INT      NOT NULL,
    [Data]                           DATETIME NOT NULL,
    [Observacao]                     TEXT     NULL,
    CONSTRAINT [PK_HistoricoSituacaoSolicitacoes] PRIMARY KEY CLUSTERED ([IdHistoricoSituacaoSolicitacao] ASC),
    CONSTRAINT [FK_HistoricoSituacaoSolicitacoes_Pessoas] FOREIGN KEY ([IdPessoaPassageiro]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_HistoricoSituacaoSolicitacoes_SolicitacoesViagem] FOREIGN KEY ([IdSolicitacaoViagem]) REFERENCES [dbo].[SolicitacoesViagem] ([IdSolicitacaoViagem]),
    CONSTRAINT [FK_HistoricoSituacaoSolicitacoes_Usuarios] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);


GO
CREATE TRIGGER [TrgLog_HistoricoSituacaoSolicitacoes] ON [Implanta_CRPAM].[dbo].[HistoricoSituacaoSolicitacoes] 
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
SET @TableName = 'HistoricoSituacaoSolicitacoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistoricoSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdHistoricoSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPassageiro : «' + RTRIM( ISNULL( CAST (IdPessoaPassageiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistoricoSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdHistoricoSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPassageiro : «' + RTRIM( ISNULL( CAST (IdPessoaPassageiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistoricoSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdHistoricoSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPassageiro : «' + RTRIM( ISNULL( CAST (IdPessoaPassageiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistoricoSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdHistoricoSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPassageiro : «' + RTRIM( ISNULL( CAST (IdPessoaPassageiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoSolicitacao : «' + RTRIM( ISNULL( CAST (IdSituacaoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
