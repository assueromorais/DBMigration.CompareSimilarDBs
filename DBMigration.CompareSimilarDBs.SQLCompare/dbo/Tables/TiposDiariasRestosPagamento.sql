CREATE TABLE [dbo].[TiposDiariasRestosPagamento] (
    [IdTiposDiariasRestosPagamento] INT   IDENTITY (1, 1) NOT NULL,
    [IdRestosPagamento]             INT   NOT NULL,
    [IdTipoDiaria]                  INT   NOT NULL,
    [ValorTipoDiaria]               MONEY DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([IdTiposDiariasRestosPagamento] ASC),
    FOREIGN KEY ([IdRestosPagamento]) REFERENCES [dbo].[RestosPagamento] ([IdRestosPagamento]),
    FOREIGN KEY ([IdTipoDiaria]) REFERENCES [dbo].[TiposDiarias] ([IdTipoDiaria])
);

