CREATE TABLE [dbo].[PrevisoesPagamentosSG] (
    [IdPrevisaoPagamento] INT         IDENTITY (1, 1) NOT NULL,
    [TipoDonoPrevisao]    VARCHAR (2) NOT NULL,
    [IdDonoPrevisao]      INT         NOT NULL,
    [AnoPrevisao]         VARCHAR (4) NULL,
    [DataPrevisao]        DATETIME    NULL,
    [ValorPrevisao]       MONEY       NULL,
    [IdEmpenho]           INT         NULL,
    [IdPagamento]         INT         NULL,
    CONSTRAINT [PK_PrevisoesPagamentosSG] PRIMARY KEY CLUSTERED ([IdPrevisaoPagamento] ASC)
);

