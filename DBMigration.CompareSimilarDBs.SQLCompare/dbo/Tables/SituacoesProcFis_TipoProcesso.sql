CREATE TABLE [dbo].[SituacoesProcFis_TipoProcesso] (
    [IdTipoProcessoSituacao] INT IDENTITY (1, 1) NOT NULL,
    [IdTipoProcesso]         INT NOT NULL,
    [IdSituacaoProcFis]      INT NOT NULL,
    CONSTRAINT [FK_SituacoesProcFis_TipoProcesso_ST] FOREIGN KEY ([IdSituacaoProcFis]) REFERENCES [dbo].[SituacoesProcFis] ([IdSituacaoProcFis]),
    CONSTRAINT [FK_SituacoesProcFis_TipoProcesso_TP] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso])
);

