CREATE TABLE [dbo].[LancamentosExtratosIds] (
    [IdLancamentoExtrato] INT         NULL,
    [IdFormaPagamento]    INT         NULL,
    [IdReceita]           INT         NULL,
    [IdRelacaoCredito]    INT         NULL,
    [Transacao]           VARCHAR (3) NULL,
    CONSTRAINT [FK_LancamentosExtratosIds_FormasPagamento] FOREIGN KEY ([IdFormaPagamento]) REFERENCES [dbo].[FormasPagamento] ([IdFormaPagamento]),
    CONSTRAINT [FK_LancamentosExtratosIds_LancamentosExtratos] FOREIGN KEY ([IdLancamentoExtrato]) REFERENCES [dbo].[LancamentosExtratos] ([IdLancamentoExtrato]),
    CONSTRAINT [FK_LancamentosExtratosIds_Receitas] FOREIGN KEY ([IdReceita]) REFERENCES [dbo].[Receitas] ([IdReceita]),
    CONSTRAINT [FK_LancamentosExtratosIds_RelacoesCreditos] FOREIGN KEY ([IdRelacaoCredito]) REFERENCES [dbo].[RelacoesCreditos] ([IdRelacaoCredito])
);


GO
CREATE TRIGGER [TrgLog_LancamentosExtratosIds] ON [Implanta_CRPAM].[dbo].[LancamentosExtratosIds] 
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
SET @TableName = 'LancamentosExtratosIds'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLancamentoExtrato : «' + RTRIM( ISNULL( CAST (IdLancamentoExtrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelacaoCredito : «' + RTRIM( ISNULL( CAST (IdRelacaoCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Transacao : «' + RTRIM( ISNULL( CAST (Transacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLancamentoExtrato : «' + RTRIM( ISNULL( CAST (IdLancamentoExtrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelacaoCredito : «' + RTRIM( ISNULL( CAST (IdRelacaoCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Transacao : «' + RTRIM( ISNULL( CAST (Transacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLancamentoExtrato : «' + RTRIM( ISNULL( CAST (IdLancamentoExtrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelacaoCredito : «' + RTRIM( ISNULL( CAST (IdRelacaoCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Transacao : «' + RTRIM( ISNULL( CAST (Transacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLancamentoExtrato : «' + RTRIM( ISNULL( CAST (IdLancamentoExtrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelacaoCredito : «' + RTRIM( ISNULL( CAST (IdRelacaoCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Transacao : «' + RTRIM( ISNULL( CAST (Transacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
