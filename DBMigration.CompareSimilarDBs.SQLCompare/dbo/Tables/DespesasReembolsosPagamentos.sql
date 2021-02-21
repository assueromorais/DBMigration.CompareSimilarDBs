CREATE TABLE [dbo].[DespesasReembolsosPagamentos] (
    [IdDespesaPessoaSolicitacaoViagem] INT NOT NULL,
    [IdPagamento]                      INT NOT NULL,
    [QtdDevolucao]                     INT NULL,
    [bCriouEmpenho]                    BIT NULL,
    CONSTRAINT [PK_PessoasSolicitacoesViagemPagamentos] PRIMARY KEY CLUSTERED ([IdDespesaPessoaSolicitacaoViagem] ASC, [IdPagamento] ASC),
    CONSTRAINT [FK_PessoasSolicitacoesViagemPagamentos_DespesasReembolsosPessoasSolicitacoesViagem] FOREIGN KEY ([IdDespesaPessoaSolicitacaoViagem]) REFERENCES [dbo].[DespesasReembolsosPessoasSolicitacoesViagem] ([IdDespesaPessoaSolicitacaoViagem]),
    CONSTRAINT [FK_PessoasSolicitacoesViagemPagamentos_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento])
);


GO
CREATE TRIGGER [TrgLog_DespesasReembolsosPagamentos] ON [Implanta_CRPAM].[dbo].[DespesasReembolsosPagamentos] 
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
SET @TableName = 'DespesasReembolsosPagamentos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDespesaPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdDespesaPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDevolucao : «' + RTRIM( ISNULL( CAST (QtdDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bCriouEmpenho IS NULL THEN ' bCriouEmpenho : «Nulo» '
                                              WHEN  bCriouEmpenho = 0 THEN ' bCriouEmpenho : «Falso» '
                                              WHEN  bCriouEmpenho = 1 THEN ' bCriouEmpenho : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdDespesaPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdDespesaPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDevolucao : «' + RTRIM( ISNULL( CAST (QtdDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bCriouEmpenho IS NULL THEN ' bCriouEmpenho : «Nulo» '
                                              WHEN  bCriouEmpenho = 0 THEN ' bCriouEmpenho : «Falso» '
                                              WHEN  bCriouEmpenho = 1 THEN ' bCriouEmpenho : «Verdadeiro» '
                                    END  FROM INSERTED 
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
		SELECT @Conteudo = 'IdDespesaPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdDespesaPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDevolucao : «' + RTRIM( ISNULL( CAST (QtdDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bCriouEmpenho IS NULL THEN ' bCriouEmpenho : «Nulo» '
                                              WHEN  bCriouEmpenho = 0 THEN ' bCriouEmpenho : «Falso» '
                                              WHEN  bCriouEmpenho = 1 THEN ' bCriouEmpenho : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDespesaPessoaSolicitacaoViagem : «' + RTRIM( ISNULL( CAST (IdDespesaPessoaSolicitacaoViagem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDevolucao : «' + RTRIM( ISNULL( CAST (QtdDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  bCriouEmpenho IS NULL THEN ' bCriouEmpenho : «Nulo» '
                                              WHEN  bCriouEmpenho = 0 THEN ' bCriouEmpenho : «Falso» '
                                              WHEN  bCriouEmpenho = 1 THEN ' bCriouEmpenho : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
