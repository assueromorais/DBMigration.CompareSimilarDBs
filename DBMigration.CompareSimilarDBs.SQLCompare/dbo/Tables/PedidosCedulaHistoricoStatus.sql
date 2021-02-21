CREATE TABLE [dbo].[PedidosCedulaHistoricoStatus] (
    [NumeroPedido]       INT      NOT NULL,
    [CodigoStatusPedido] SMALLINT NOT NULL,
    [DataStatusPedido]   DATETIME NOT NULL,
    CONSTRAINT [PK_PedidosCedulaHistoricoStatus] PRIMARY KEY CLUSTERED ([NumeroPedido] ASC, [CodigoStatusPedido] ASC, [DataStatusPedido] ASC),
    CONSTRAINT [FK_PedidosCedulaHistoricoStatus_PedidosCedulaIdentidadeProfissional] FOREIGN KEY ([NumeroPedido]) REFERENCES [dbo].[PedidosCedulaIdentidadeProfissional] ([NumeroPedido])
);

