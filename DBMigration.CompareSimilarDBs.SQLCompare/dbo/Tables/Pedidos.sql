CREATE TABLE [dbo].[Pedidos] (
    [IdPedido]           INT      IDENTITY (1, 1) NOT NULL,
    [IdResponsavel]      INT      NOT NULL,
    [IdUnidade]          INT      NULL,
    [DataPedido]         DATETIME NOT NULL,
    [Motivo]             TEXT     NULL,
    [ValorEstimado]      MONEY    NULL,
    [IdLocalEntrega]     INT      NULL,
    [IdFinalidadePedido] INT      NULL,
    CONSTRAINT [PK_Pedidos] PRIMARY KEY NONCLUSTERED ([IdPedido] ASC),
    CONSTRAINT [FK_Pedidos_FinalidadePedido] FOREIGN KEY ([IdFinalidadePedido]) REFERENCES [dbo].[FinalidadePedido] ([IdFinalidadePedido]),
    CONSTRAINT [FK_Pedidos_LocaisEntrega] FOREIGN KEY ([IdLocalEntrega]) REFERENCES [dbo].[LocaisEntrega] ([IdLocalEntrega]),
    CONSTRAINT [FK_Pedidos_Responsaveis] FOREIGN KEY ([IdResponsavel]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]),
    CONSTRAINT [FK_Pedidos_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);

