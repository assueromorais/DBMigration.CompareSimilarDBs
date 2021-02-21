CREATE TABLE [dbo].[PrePedidos] (
    [IdPrePedido]              INT           IDENTITY (1, 1) NOT NULL,
    [IdPedido]                 INT           NULL,
    [IdResponsavel]            INT           NOT NULL,
    [IdResponsavelAutorizador] INT           NULL,
    [IdUnidade]                INT           NULL,
    [DataPedido]               DATETIME      NOT NULL,
    [DataAutorizacao]          DATETIME      NULL,
    [Motivo]                   TEXT          NULL,
    [ValorEstimado]            MONEY         NULL,
    [idLocalEntrega]           INT           NULL,
    [IdFinalidadePedido]       INT           NULL,
    [AgrupadorAutorizacao]     VARCHAR (100) NULL,
    CONSTRAINT [PK_PrePedidos] PRIMARY KEY NONCLUSTERED ([IdPrePedido] ASC),
    CONSTRAINT [FK_PrePedidos_FinalidadePedido] FOREIGN KEY ([IdFinalidadePedido]) REFERENCES [dbo].[FinalidadePedido] ([IdFinalidadePedido]),
    CONSTRAINT [FK_PrePedidos_LocaisEntrega] FOREIGN KEY ([idLocalEntrega]) REFERENCES [dbo].[LocaisEntrega] ([IdLocalEntrega]),
    CONSTRAINT [FK_PrePedidos_Pedidos] FOREIGN KEY ([IdPedido]) REFERENCES [dbo].[Pedidos] ([IdPedido]) NOT FOR REPLICATION,
    CONSTRAINT [FK_PrePedidos_Responsaveis] FOREIGN KEY ([IdResponsavel]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]),
    CONSTRAINT [FK_PrePedidos_Responsaveis1] FOREIGN KEY ([IdResponsavelAutorizador]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]),
    CONSTRAINT [FK_PrePedidos_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);

