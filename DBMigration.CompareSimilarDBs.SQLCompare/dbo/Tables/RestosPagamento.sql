CREATE TABLE [dbo].[RestosPagamento] (
    [IdRestosPagamento]  INT          IDENTITY (1, 1) NOT NULL,
    [IdRestosEmpenho]    INT          NOT NULL,
    [DataPgto]           DATETIME     NOT NULL,
    [ValorPgto]          MONEY        NOT NULL,
    [IdLancamento]       INT          NULL,
    [DataModificacao]    DATETIME     NOT NULL,
    [Historico]          TEXT         NULL,
    [IdFormaPagamento]   INT          NOT NULL,
    [NumeroPagamento]    INT          NOT NULL,
    [AnoExercicio]       SMALLINT     NOT NULL,
    [UsuarioResponsavel] VARCHAR (30) NULL,
    [ValorbaseCalculo]   MONEY        NULL,
    [CalculoTributo]     BIT          CONSTRAINT [DF__RestosPag__Calcu__39A368DE] DEFAULT ((0)) NOT NULL,
    [DataRefTributo]     DATETIME     NULL,
    [CustoFixo]          BIT          NULL,
    [IdRestosPagAnulado] INT          NULL,
    [RecalcularTributos] BIT          NULL,
    CONSTRAINT [PK_RestosPagamento] PRIMARY KEY NONCLUSTERED ([IdRestosPagamento] ASC),
    CONSTRAINT [FK_RestosPagamento_FormasPagamento] FOREIGN KEY ([IdFormaPagamento]) REFERENCES [dbo].[FormasPagamento] ([IdFormaPagamento]),
    CONSTRAINT [FK_RestosPagamento_Lancamentos] FOREIGN KEY ([IdLancamento]) REFERENCES [dbo].[Lancamentos] ([IdLancamento]),
    CONSTRAINT [FK_RestosPagamento_RestosEmpenho] FOREIGN KEY ([IdRestosEmpenho]) REFERENCES [dbo].[RestosEmpenho] ([IdRestosEmpenho]),
    CONSTRAINT [IX_RestosPagamentoAnoExercicioNumeroPagamento] UNIQUE NONCLUSTERED ([AnoExercicio] ASC, [NumeroPagamento] ASC)
);


GO
ALTER TABLE [dbo].[RestosPagamento] NOCHECK CONSTRAINT [FK_RestosPagamento_Lancamentos];

