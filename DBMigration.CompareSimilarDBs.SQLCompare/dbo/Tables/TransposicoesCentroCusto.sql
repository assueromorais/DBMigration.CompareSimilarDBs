CREATE TABLE [dbo].[TransposicoesCentroCusto] (
    [IdTransposicao] INT      NOT NULL,
    [IdCentroCusto]  INT      NOT NULL,
    [TipoMov]        INT      NOT NULL,
    [DataDotacao]    DATETIME NOT NULL,
    [ValorDotacao]   MONEY    NOT NULL,
    [IdUsuario]      INT      NOT NULL,
    [SaldoDotacao]   MONEY    NULL,
    [Historico]      TEXT     NULL,
    CONSTRAINT [FK_TransposicoesCentroCusto_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto])
);

