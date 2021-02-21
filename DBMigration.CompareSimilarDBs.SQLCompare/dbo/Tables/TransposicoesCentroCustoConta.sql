CREATE TABLE [dbo].[TransposicoesCentroCustoConta] (
    [IdTransposicao] INT         NOT NULL,
    [IdConta]        INT         NOT NULL,
    [IdCentroCusto]  INT         NOT NULL,
    [TipoMov]        INT         NOT NULL,
    [DataDotacao]    DATETIME    NOT NULL,
    [ValorDotacao]   MONEY       NOT NULL,
    [IdUsuario]      INT         NOT NULL,
    [SaldoDotacao]   MONEY       NULL,
    [Exercicio]      VARCHAR (4) NULL,
    [Historico]      TEXT        NULL,
    CONSTRAINT [FK_TransposicoesCentroCustoConta_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_TransposicoesCentroCustoConta_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [IX_TransposicoesCentroCustoContaTranspCCustoContaTipoMov] UNIQUE CLUSTERED ([IdTransposicao] ASC, [IdCentroCusto] ASC, [IdConta] ASC, [TipoMov] ASC, [Exercicio] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_TransposicoesCentroCustoConta_IdConta]
    ON [dbo].[TransposicoesCentroCustoConta]([IdConta] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TransposicoesCentroCustoConta_IdCentroCusto]
    ON [dbo].[TransposicoesCentroCustoConta]([IdCentroCusto] ASC);


GO
CREATE STATISTICS [STAT_TransposicoesCentroCustoConta_TipoMov_IdConta]
    ON [dbo].[TransposicoesCentroCustoConta]([TipoMov], [IdConta]);

