CREATE TABLE [dbo].[Processos_SituacoesProcesso] (
    [IdProcesso_SitProcesso] INT      IDENTITY (1, 1) NOT NULL,
    [IdProcesso]             INT      NOT NULL,
    [IdSituacaoProcFis]      INT      NOT NULL,
    [DataSituacao]           DATETIME NULL,
    CONSTRAINT [PK_Processos_SituacoesProcesso] PRIMARY KEY CLUSTERED ([IdProcesso_SitProcesso] ASC),
    CONSTRAINT [FK_Processos_SituacoesProcesso_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]),
    CONSTRAINT [FK_Processos_SituacoesProcesso_SituacoesProcesso] FOREIGN KEY ([IdSituacaoProcFis]) REFERENCES [dbo].[SituacoesProcFis] ([IdSituacaoProcFis])
);

