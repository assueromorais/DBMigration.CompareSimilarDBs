CREATE TABLE [dbo].[PedidosCedulaIdentidadeProfissional] (
    [NumeroPedido]            INT           IDENTITY (1, 1) NOT NULL,
    [IdProfissional]          INT           NULL,
    [CodigoStatusPedidoAtual] SMALLINT      NULL,
    [DataStatusPedidoAtual]   DATETIME      NULL,
    [DataSolicitacao]         DATETIME      NULL,
    [NotaFiscal]              VARCHAR (25)  NULL,
    [DataEmissãoNotaFiscal]   DATETIME      NULL,
    [UsuarioWeb]              VARCHAR (200) NULL,
    CONSTRAINT [PK_PedidosCedulaIdentidadeProfissional] PRIMARY KEY CLUSTERED ([NumeroPedido] ASC),
    CONSTRAINT [FK_PedidosCedulaIdentidadeProfissional_PedidosCedulaStatus] FOREIGN KEY ([CodigoStatusPedidoAtual]) REFERENCES [dbo].[PedidosCedulaStatus] ([CodigoStatusPedido]),
    CONSTRAINT [FK_PedidosCedulaIdentidadeProfissional_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);

