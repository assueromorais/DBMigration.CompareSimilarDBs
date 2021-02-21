CREATE TABLE [dbo].[RateioPagamentos] (
    [IdRateioPagamento]      INT   IDENTITY (1, 1) NOT NULL,
    [IdTipoRateioAssociacao] INT   NULL,
    [IdAssociacaoPagamento]  INT   NULL,
    [IdFormaPagamento]       INT   NULL,
    [Valor]                  MONEY NULL,
    CONSTRAINT [PK_RateioPagamentos] PRIMARY KEY NONCLUSTERED ([IdRateioPagamento] ASC)
);

