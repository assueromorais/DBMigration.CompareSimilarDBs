CREATE TABLE [dbo].[TiposPagamentos] (
    [IdTipoPagamento]      INT          IDENTITY (1, 1) NOT NULL,
    [TipoPagamento]        VARCHAR (60) NOT NULL,
    [ContaBanco]           BIT          NULL,
    [MostraDadosDocumento] BIT          NULL,
    [Ordem]                INT          NULL,
    [Ativo]                BIT          CONSTRAINT [DF__TiposPaga__Ativo__215A0B5D] DEFAULT ((1)) NULL,
    [Desativado]           BIT          CONSTRAINT [DF_TiposPagamentosDesativado] DEFAULT ((0)) NULL,
    [IdContaCorrente]      INT          NULL,
    CONSTRAINT [PK_TiposPagamentos] PRIMARY KEY CLUSTERED ([IdTipoPagamento] ASC),
    CONSTRAINT [FK_TiposPagamentos_ContasCorrente] FOREIGN KEY ([IdContaCorrente]) REFERENCES [dbo].[ContasCorrentes] ([IdContaCorrente])
);

