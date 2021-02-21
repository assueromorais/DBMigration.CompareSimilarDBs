CREATE TABLE [dbo].[TransposicoesConta] (
    [IdTransposicao] INT      NOT NULL,
    [IdConta]        INT      NOT NULL,
    [TipoMov]        INT      NOT NULL,
    [DataDotacao]    DATETIME NOT NULL,
    [ValorDotacao]   MONEY    NOT NULL,
    [IdUsuario]      INT      NOT NULL,
    [SaldoDotacao]   MONEY    NULL,
    [Historico]      TEXT     NULL,
    CONSTRAINT [FK_TransposicoesConta_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
CREATE NONCLUSTERED INDEX [IX_TransposicoesConta_IdConta]
    ON [dbo].[TransposicoesConta]([IdConta] ASC);


GO
CREATE STATISTICS [STAT_TransposicoesConta_TipoMov_IdConta]
    ON [dbo].[TransposicoesConta]([TipoMov], [IdConta]);

