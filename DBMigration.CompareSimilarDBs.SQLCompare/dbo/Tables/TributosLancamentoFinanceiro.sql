CREATE TABLE [dbo].[TributosLancamentoFinanceiro] (
    [IdTributoLancamentoFinanceiro] INT      IDENTITY (1, 1) NOT NULL,
    [IdPagamento]                   INT      NULL,
    [IdTributo]                     INT      NOT NULL,
    [ValorTributo]                  MONEY    NOT NULL,
    [IdRestosPagamento]             INT      NULL,
    [DataPrev]                      DATETIME NULL,
    CONSTRAINT [PK_TributosLancamentoFinanceiro] PRIMARY KEY CLUSTERED ([IdTributoLancamentoFinanceiro] ASC),
    CONSTRAINT [FK_TributosLancamentoFinanceiro_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_TributosLancamentoFinanceiro_Tributos] FOREIGN KEY ([IdTributo]) REFERENCES [dbo].[Tributos] ([IdTributo])
);

