CREATE TABLE [dbo].[MovimentoFinanceiro] (
    [IdMovimentoFinanceiro]           INT          IDENTITY (1, 1) NOT NULL,
    [IdContaOrigem]                   INT          NOT NULL,
    [IdContaDestino]                  INT          NOT NULL,
    [IdTipoMovimentoFinanceiro]       INT          NOT NULL,
    [IdFormaPagamento]                INT          NULL,
    [IdLancamento]                    INT          NULL,
    [IdLancamentoDevolucao]           INT          NULL,
    [DataMovimentoFinanceiro]         DATETIME     NULL,
    [ValorMovimentoFinanceiro]        MONEY        NULL,
    [Historico]                       TEXT         NULL,
    [NumeroMovimentoFinanceiro]       INT          NOT NULL,
    [AnoExercicio]                    SMALLINT     NOT NULL,
    [NumeroProcesso]                  VARCHAR (20) NULL,
    [DataImportacao]                  DATETIME     NULL,
    [Origem]                          VARCHAR (60) NULL,
    [IdCentroCusto]                   INT          NULL,
    [DataDevolucao]                   DATETIME     NULL,
    [IdTributoPagamento]              INT          NULL,
    [DataPrevista]                    DATETIME     NULL,
    [ValorPrevisto]                   MONEY        NULL,
    [IdPessoaPrevisao]                INT          NULL,
    [TipoImportacao]                  VARCHAR (10) NULL,
    [IdRateioPagamento]               INT          NULL,
    [IdProjetoMovimentacaoFinanceira] INT          NULL,
    CONSTRAINT [PK_MovimentoFinanceiro] PRIMARY KEY CLUSTERED ([IdMovimentoFinanceiro] ASC),
    CONSTRAINT [FK_MovimentoFinanceiro_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_MovimentoFinanceiro_FormasPagamento] FOREIGN KEY ([IdFormaPagamento]) REFERENCES [dbo].[FormasPagamento] ([IdFormaPagamento]),
    CONSTRAINT [FK_MovimentoFinanceiro_Lancamentos] FOREIGN KEY ([IdLancamento]) REFERENCES [dbo].[Lancamentos] ([IdLancamento]),
    CONSTRAINT [FK_MovimentoFinanceiro_Lancamentos1] FOREIGN KEY ([IdLancamentoDevolucao]) REFERENCES [dbo].[Lancamentos] ([IdLancamento]),
    CONSTRAINT [FK_MovimentoFinanceiro_PlanoContas] FOREIGN KEY ([IdContaOrigem]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_MovimentoFinanceiro_PlanoContas1] FOREIGN KEY ([IdContaDestino]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_MovimentoFinanceiro_ProjetosMovimentacoesFinanceiras] FOREIGN KEY ([IdProjetoMovimentacaoFinanceira]) REFERENCES [dbo].[ProjetosMovimentacoesFinanceiras] ([IdProjetoMovimentacaoFinanceira]),
    CONSTRAINT [FK_MovimentoFinanceiro_TiposMovimentoFinanceiro] FOREIGN KEY ([IdTipoMovimentoFinanceiro]) REFERENCES [dbo].[TiposMovimentoFinanceiro] ([IdTipoMovimentoFinanceiro]),
    CONSTRAINT [FK_MovimentoFinanceiro_TributosPagamento] FOREIGN KEY ([IdTributoPagamento]) REFERENCES [dbo].[TributosPagamento] ([IdTributosPagamento]) NOT FOR REPLICATION,
    CONSTRAINT [IX_MovimentoFinanceiroAnoExercicioNumeroMoviento] UNIQUE NONCLUSTERED ([AnoExercicio] ASC, [NumeroMovimentoFinanceiro] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_MovimentoFinanceiro_IdContaOrigem]
    ON [dbo].[MovimentoFinanceiro]([IdContaOrigem] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MovimentoFinanceiro_IdContaDestino_IdContaOrigem]
    ON [dbo].[MovimentoFinanceiro]([IdContaDestino] ASC, [IdContaOrigem] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MovimentoFinanceiro_IdCentroCusto]
    ON [dbo].[MovimentoFinanceiro]([IdCentroCusto] ASC);


GO
CREATE TRIGGER [TrgLog_MovimentoFinanceiro] ON [Implanta_CRPAM].[dbo].[MovimentoFinanceiro] 
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
SET @TableName = 'MovimentoFinanceiro'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaOrigem : «' + RTRIM( ISNULL( CAST (IdContaOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDestino : «' + RTRIM( ISNULL( CAST (IdContaDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdTipoMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoDevolucao : «' + RTRIM( ISNULL( CAST (IdLancamentoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| ValorMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (ValorMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (NumeroMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDevolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucao, 113 ),'Nulo'))+'» '
                         + '| IdTributoPagamento : «' + RTRIM( ISNULL( CAST (IdTributoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevista : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevista, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisto : «' + RTRIM( ISNULL( CAST (ValorPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPrevisao : «' + RTRIM( ISNULL( CAST (IdPessoaPrevisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImportacao : «' + RTRIM( ISNULL( CAST (TipoImportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRateioPagamento : «' + RTRIM( ISNULL( CAST (IdRateioPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProjetoMovimentacaoFinanceira : «' + RTRIM( ISNULL( CAST (IdProjetoMovimentacaoFinanceira AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaOrigem : «' + RTRIM( ISNULL( CAST (IdContaOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDestino : «' + RTRIM( ISNULL( CAST (IdContaDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdTipoMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoDevolucao : «' + RTRIM( ISNULL( CAST (IdLancamentoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| ValorMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (ValorMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (NumeroMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDevolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucao, 113 ),'Nulo'))+'» '
                         + '| IdTributoPagamento : «' + RTRIM( ISNULL( CAST (IdTributoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevista : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevista, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisto : «' + RTRIM( ISNULL( CAST (ValorPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPrevisao : «' + RTRIM( ISNULL( CAST (IdPessoaPrevisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImportacao : «' + RTRIM( ISNULL( CAST (TipoImportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRateioPagamento : «' + RTRIM( ISNULL( CAST (IdRateioPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProjetoMovimentacaoFinanceira : «' + RTRIM( ISNULL( CAST (IdProjetoMovimentacaoFinanceira AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaOrigem : «' + RTRIM( ISNULL( CAST (IdContaOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDestino : «' + RTRIM( ISNULL( CAST (IdContaDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdTipoMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoDevolucao : «' + RTRIM( ISNULL( CAST (IdLancamentoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| ValorMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (ValorMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (NumeroMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDevolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucao, 113 ),'Nulo'))+'» '
                         + '| IdTributoPagamento : «' + RTRIM( ISNULL( CAST (IdTributoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevista : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevista, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisto : «' + RTRIM( ISNULL( CAST (ValorPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPrevisao : «' + RTRIM( ISNULL( CAST (IdPessoaPrevisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImportacao : «' + RTRIM( ISNULL( CAST (TipoImportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRateioPagamento : «' + RTRIM( ISNULL( CAST (IdRateioPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProjetoMovimentacaoFinanceira : «' + RTRIM( ISNULL( CAST (IdProjetoMovimentacaoFinanceira AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaOrigem : «' + RTRIM( ISNULL( CAST (IdContaOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaDestino : «' + RTRIM( ISNULL( CAST (IdContaDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdTipoMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoDevolucao : «' + RTRIM( ISNULL( CAST (IdLancamentoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataMovimentoFinanceiro : «' + RTRIM( ISNULL( CONVERT (CHAR, DataMovimentoFinanceiro, 113 ),'Nulo'))+'» '
                         + '| ValorMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (ValorMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (NumeroMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDevolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucao, 113 ),'Nulo'))+'» '
                         + '| IdTributoPagamento : «' + RTRIM( ISNULL( CAST (IdTributoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevista : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevista, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisto : «' + RTRIM( ISNULL( CAST (ValorPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaPrevisao : «' + RTRIM( ISNULL( CAST (IdPessoaPrevisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImportacao : «' + RTRIM( ISNULL( CAST (TipoImportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRateioPagamento : «' + RTRIM( ISNULL( CAST (IdRateioPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProjetoMovimentacaoFinanceira : «' + RTRIM( ISNULL( CAST (IdProjetoMovimentacaoFinanceira AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
