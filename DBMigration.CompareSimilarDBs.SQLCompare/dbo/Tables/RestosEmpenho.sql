CREATE TABLE [dbo].[RestosEmpenho] (
    [IdRestosEmpenho]    INT          IDENTITY (1, 1) NOT NULL,
    [IdConta]            INT          NOT NULL,
    [IdPessoa]           INT          NOT NULL,
    [NumeroEmpenho]      INT          NOT NULL,
    [AnoExercicio]       INT          NOT NULL,
    [DataEmpenho]        DATETIME     NOT NULL,
    [SaldoEmpenho]       MONEY        NOT NULL,
    [ValorEmpenho]       MONEY        NOT NULL,
    [NumeroProcesso]     VARCHAR (20) NULL,
    [Historico]          TEXT         NULL,
    [DataModificacao]    DATETIME     NOT NULL,
    [IdContaDebito]      INT          NULL,
    [APagar]             MONEY        NOT NULL,
    [IdLancamento]       INT          NULL,
    [UsuarioResponsavel] VARCHAR (30) NULL,
    [IdEmpenho]          INT          NULL,
    [IdContaPluri]       INT          NULL,
    [IdContaDebitoPluri] INT          NULL,
    CONSTRAINT [PK_RestosEmpenho] PRIMARY KEY NONCLUSTERED ([IdRestosEmpenho] ASC),
    CONSTRAINT [FK_RestosEmpenho_Empenhos] FOREIGN KEY ([IdEmpenho]) REFERENCES [dbo].[Empenhos] ([IdEmpenho]),
    CONSTRAINT [FK_RestosEmpenho_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_RestosEmpenho_PlanoContas1] FOREIGN KEY ([IdContaDebito]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [RestosEmpenho_Lancamentos] FOREIGN KEY ([IdLancamento]) REFERENCES [dbo].[Lancamentos] ([IdLancamento])
);


GO
CREATE NONCLUSTERED INDEX [IX_RestosEmpenho_IdConta_IdContaDebito]
    ON [dbo].[RestosEmpenho]([IdConta] ASC, [IdContaDebito] ASC);

