CREATE TABLE [dbo].[PreEmpenhos] (
    [IdPreEmpenho]       INT          IDENTITY (1, 1) NOT NULL,
    [NumeroPreEmpenho]   INT          NOT NULL,
    [AnoExercicio]       INT          NOT NULL,
    [IdConta]            INT          NOT NULL,
    [IdEmpenho]          INT          NULL,
    [DataPreEmpenho]     DATETIME     NOT NULL,
    [DataValidade]       DATETIME     NULL,
    [ValorPreEmpenho]    MONEY        NOT NULL,
    [Valor]              MONEY        NOT NULL,
    [NumProcesso]        VARCHAR (20) NULL,
    [Historico]          TEXT         NULL,
    [SaldoConta]         MONEY        NOT NULL,
    [UsuarioResponsavel] VARCHAR (30) NULL,
    CONSTRAINT [PK_PreEmpenhos] PRIMARY KEY NONCLUSTERED ([IdPreEmpenho] ASC),
    CONSTRAINT [FK_PreEmpenhos_Empenhos] FOREIGN KEY ([IdEmpenho]) REFERENCES [dbo].[Empenhos] ([IdEmpenho]),
    CONSTRAINT [FK_PreEmpenhos_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
ALTER TABLE [dbo].[PreEmpenhos] NOCHECK CONSTRAINT [FK_PreEmpenhos_Empenhos];


GO
ALTER TABLE [dbo].[PreEmpenhos] NOCHECK CONSTRAINT [FK_PreEmpenhos_PlanoContas];

