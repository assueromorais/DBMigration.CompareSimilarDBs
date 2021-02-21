CREATE TABLE [dbo].[SituacoesMovimentacao] (
    [IdSituacaoMovimentacao] INT           IDENTITY (1, 1) NOT NULL,
    [SituacaoMovimentacao]   VARCHAR (100) NULL,
    CONSTRAINT [PK_SituacoesMovimentacao] PRIMARY KEY NONCLUSTERED ([IdSituacaoMovimentacao] ASC)
);

