CREATE TABLE [dbo].[PedidosCedulaStatus] (
    [CodigoStatusPedido] SMALLINT     NOT NULL,
    [StatusPedido]       VARCHAR (50) NULL,
    CONSTRAINT [PK_PedidosCedulaStatus] PRIMARY KEY CLUSTERED ([CodigoStatusPedido] ASC)
);

