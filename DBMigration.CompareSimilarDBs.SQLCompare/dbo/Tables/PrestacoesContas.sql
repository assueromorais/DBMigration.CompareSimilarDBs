CREATE TABLE [dbo].[PrestacoesContas] (
    [IdMovimentoFinanceiro] INT NOT NULL,
    [IdPagamento]           INT NOT NULL,
    CONSTRAINT [PK_PrestacoesContas] PRIMARY KEY NONCLUSTERED ([IdMovimentoFinanceiro] ASC, [IdPagamento] ASC),
    CONSTRAINT [FK_PrestacoesContas_MovimentoFinanceiro] FOREIGN KEY ([IdMovimentoFinanceiro]) REFERENCES [dbo].[MovimentoFinanceiro] ([IdMovimentoFinanceiro]),
    CONSTRAINT [FK_PrestacoesContas_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento])
);

