CREATE TABLE [dbo].[PrevisoesPagamento] (
    [IdPagamento]              INT          NOT NULL,
    [IdContaCredito]           INT          NULL,
    [IdTipoDocumentoPagamento] INT          NULL,
    [NumDocumento]             VARCHAR (20) NULL,
    [IdPrevisaoPagamento]      INT          IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_PrevisoesPagamento] PRIMARY KEY CLUSTERED ([IdPrevisaoPagamento] ASC),
    CONSTRAINT [FK_PrevisoesPagamento_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_PrevisoesPagamento_PlanoContas] FOREIGN KEY ([IdContaCredito]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_PrevisoesPagamento_TiposDocumentosPagamentos] FOREIGN KEY ([IdTipoDocumentoPagamento]) REFERENCES [dbo].[TiposDocumentosPagamentos] ([IdTipoDocumentoPagamento])
);

