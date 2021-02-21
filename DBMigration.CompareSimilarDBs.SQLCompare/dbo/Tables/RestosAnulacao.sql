CREATE TABLE [dbo].[RestosAnulacao] (
    [IdRestosAnulacao]          INT          IDENTITY (1, 1) NOT NULL,
    [IdRestosEmpenho]           INT          NOT NULL,
    [IdContaCancelamentoRestos] INT          NOT NULL,
    [DataAnulacao]              DATETIME     NOT NULL,
    [ValorAnulacao]             MONEY        NOT NULL,
    [Historico]                 TEXT         NULL,
    [IdLancamento]              INT          NULL,
    [UsuarioResponsavel]        VARCHAR (30) NULL,
    [IdReceita]                 INT          NULL,
    CONSTRAINT [PK_RestosAnulacao] PRIMARY KEY CLUSTERED ([IdRestosAnulacao] ASC),
    CONSTRAINT [FK_RestosAnulacao_Lancamentos] FOREIGN KEY ([IdLancamento]) REFERENCES [dbo].[Lancamentos] ([IdLancamento]),
    CONSTRAINT [FK_RestosAnulacao_PlanoContas] FOREIGN KEY ([IdContaCancelamentoRestos]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_RestosAnulacao_RestosEmpenho] FOREIGN KEY ([IdRestosEmpenho]) REFERENCES [dbo].[RestosEmpenho] ([IdRestosEmpenho])
);


GO
ALTER TABLE [dbo].[RestosAnulacao] NOCHECK CONSTRAINT [FK_RestosAnulacao_Lancamentos];

