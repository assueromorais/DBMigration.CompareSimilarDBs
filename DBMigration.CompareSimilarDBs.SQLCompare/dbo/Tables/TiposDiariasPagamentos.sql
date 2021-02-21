CREATE TABLE [dbo].[TiposDiariasPagamentos] (
    [IdTiposDiariasPagamentos] INT   IDENTITY (1, 1) NOT NULL,
    [IdPagamento]              INT   NOT NULL,
    [IdTipoDiaria]             INT   NOT NULL,
    [ValorTipoDiaria]          MONEY NOT NULL,
    CONSTRAINT [PK_TiposDiariasPagamentos] PRIMARY KEY CLUSTERED ([IdTiposDiariasPagamentos] ASC),
    CONSTRAINT [FK_TiposDiariasPagamentos_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_TiposDiariasPagamentos_TiposDiarias] FOREIGN KEY ([IdTipoDiaria]) REFERENCES [dbo].[TiposDiarias] ([IdTipoDiaria])
);

