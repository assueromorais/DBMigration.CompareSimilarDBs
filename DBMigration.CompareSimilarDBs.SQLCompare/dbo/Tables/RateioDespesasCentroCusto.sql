CREATE TABLE [dbo].[RateioDespesasCentroCusto] (
    [IdRateio]      INT  NOT NULL,
    [IdCentroCusto] INT  NOT NULL,
    [Percentual]    REAL NOT NULL,
    CONSTRAINT [PK_RateioCentroCusto] PRIMARY KEY CLUSTERED ([IdRateio] ASC, [IdCentroCusto] ASC),
    CONSTRAINT [FK_RateioDespesasCentroCusto_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_RateioDespesasCentroCusto_Distribuicoes] FOREIGN KEY ([IdRateio]) REFERENCES [dbo].[RateioDespesas] ([IdRateio])
);

