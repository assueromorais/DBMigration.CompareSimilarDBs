CREATE TABLE [dbo].[PenalizacaoFornecedor] (
    [IdPenalizacaoFornecedor] INT      IDENTITY (1, 1) NOT NULL,
    [IdTipoPenalizacao]       INT      NOT NULL,
    [IdFornecedor]            INT      NOT NULL,
    [DtInicio]                DATETIME NOT NULL,
    [DtFim]                   DATETIME NULL,
    [DtFimIndeterminada]      BIT      CONSTRAINT [DF_PenalizacaoFornecedor_DtFimIndeterminada] DEFAULT ((0)) NOT NULL,
    [Motivo]                  TEXT     NULL,
    CONSTRAINT [PK_PenalizacaoFornecedor] PRIMARY KEY CLUSTERED ([IdPenalizacaoFornecedor] ASC),
    CONSTRAINT [FK_PenalizacaoFornecedor_Pessoas] FOREIGN KEY ([IdFornecedor]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_PenalizacaoFornecedor_TipoPenalizacao] FOREIGN KEY ([IdTipoPenalizacao]) REFERENCES [dbo].[TipoPenalizacao] ([IdTipoPenalizacao])
);

