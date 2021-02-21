CREATE TABLE [dbo].[AlertaEmpenho] (
    [IdAlertaEmpenho]                  INT IDENTITY (1, 1) NOT NULL,
    [IdPessoaSolicitacaoViagem]        INT NULL,
    [IdDespesaPessoaSolicitacaoViagem] INT NULL,
    [IdPessoa]                         INT NULL,
    [IdSituacaoAlertaEmpenho]          INT NULL,
    CONSTRAINT [PK_AlertaEmpenho] PRIMARY KEY NONCLUSTERED ([IdAlertaEmpenho] ASC),
    CONSTRAINT [FK_AlertaEmpenho_DespesasReembolsosPessoasSolicitacoesViagem] FOREIGN KEY ([IdDespesaPessoaSolicitacaoViagem]) REFERENCES [dbo].[DespesasReembolsosPessoasSolicitacoesViagem] ([IdDespesaPessoaSolicitacaoViagem]),
    CONSTRAINT [FK_AlertaEmpenho_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_AlertaEmpenho_PessoasSolicitacoesViagem] FOREIGN KEY ([IdPessoaSolicitacaoViagem]) REFERENCES [dbo].[PessoasSolicitacoesViagem] ([IdPessoaSolicitacaoViagem]),
    CONSTRAINT [FK_AlertaEmpenho_SituacoesAlertaEmpenho] FOREIGN KEY ([IdSituacaoAlertaEmpenho]) REFERENCES [dbo].[SituacoesAlertaEmpenho] ([IdSituacaoAlertaEmpenho])
);


GO
CREATE TRIGGER [TrgLog_AlertaEmpenho] ON [Implanta_CRPAM].[dbo].[AlertaEmpenho] 
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
SET @TableName = 'AlertaEmpenho'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAlertaEmpenho : «' + RTRIM( ISNULL( CAST (IdAlertaEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDespesaPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdDespesaPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAlertaEmpenho : «' + RTRIM( ISNULL( CAST (IdSituacaoAlertaEmpenho AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAlertaEmpenho : «' + RTRIM( ISNULL( CAST (IdAlertaEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDespesaPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdDespesaPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAlertaEmpenho : «' + RTRIM( ISNULL( CAST (IdSituacaoAlertaEmpenho AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAlertaEmpenho : «' + RTRIM( ISNULL( CAST (IdAlertaEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDespesaPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdDespesaPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAlertaEmpenho : «' + RTRIM( ISNULL( CAST (IdSituacaoAlertaEmpenho AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAlertaEmpenho : «' + RTRIM( ISNULL( CAST (IdAlertaEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDespesaPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdDespesaPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoAlertaEmpenho : «' + RTRIM( ISNULL( CAST (IdSituacaoAlertaEmpenho AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
