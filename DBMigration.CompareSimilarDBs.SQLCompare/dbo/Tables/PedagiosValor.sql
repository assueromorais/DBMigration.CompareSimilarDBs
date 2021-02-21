CREATE TABLE [dbo].[PedagiosValor] (
    [IdPedagioValor]     INT      IDENTITY (1, 1) NOT NULL,
    [IdPedagio]          INT      NULL,
    [IdCategoriaVeiculo] INT      NULL,
    [Data]               DATETIME NULL,
    [Valor]              MONEY    NULL,
    CONSTRAINT [PK_PedagiosValor] PRIMARY KEY CLUSTERED ([IdPedagioValor] ASC),
    CONSTRAINT [FK_PedagiosValor_CategoriasVeiculo] FOREIGN KEY ([IdCategoriaVeiculo]) REFERENCES [dbo].[CategoriasVeiculo] ([IdCategoriaVeiculo]),
    CONSTRAINT [FK_PedagiosValor_Pedagios] FOREIGN KEY ([IdPedagio]) REFERENCES [dbo].[Pedagios] ([IdPedagio])
);

