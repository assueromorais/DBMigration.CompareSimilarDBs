CREATE TABLE [dbo].[SaldosIniciais] (
    [IdConta]   INT      NOT NULL,
    [DataSaldo] DATETIME NOT NULL,
    [Saldo]     MONEY    NOT NULL,
    CONSTRAINT [PK_SaldosIniciais] PRIMARY KEY NONCLUSTERED ([IdConta] ASC, [DataSaldo] ASC),
    CONSTRAINT [FK_SaldosIniciais_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);

