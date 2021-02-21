CREATE TABLE [dbo].[SubAreasPagamento] (
    [IdSubAreasPagamento] INT      IDENTITY (1, 1) NOT NULL,
    [IdPagamento]         INT      NULL,
    [IdCentroCusto]       INT      NULL,
    [IdSubArea]           INT      NULL,
    [DataEvento]          DATETIME NULL,
    [ValorEvento]         MONEY    NULL,
    [IdRestosPagamento]   INT      NULL,
    CONSTRAINT [PK_SubAreasPagamento] PRIMARY KEY CLUSTERED ([IdSubAreasPagamento] ASC),
    CONSTRAINT [FK_SubAreasPagamento_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_SubAreasPagamento_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_SubAreasPagamento_RestosPagamento] FOREIGN KEY ([IdRestosPagamento]) REFERENCES [dbo].[RestosPagamento] ([IdRestosPagamento]),
    CONSTRAINT [FK_SubAreasPagamento_SubAreas] FOREIGN KEY ([IdSubArea]) REFERENCES [dbo].[SubAreas] ([IdSubArea])
);

