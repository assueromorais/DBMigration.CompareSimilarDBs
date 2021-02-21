CREATE TABLE [dbo].[TipoProcesso_TiposInscricao] (
    [IdTipoProcesso]  INT NOT NULL,
    [IdTipoInscricao] INT NOT NULL,
    CONSTRAINT [FK_TipoProcesso_TiposInscricao_TipoProcesso] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso]),
    CONSTRAINT [FK_TipoProcesso_TiposInscricao_TiposInscricao] FOREIGN KEY ([IdTipoInscricao]) REFERENCES [dbo].[TiposInscricao] ([IdTipoInscricao]),
    CONSTRAINT [UNQ_TipoProcesso_TiposInscricao] UNIQUE NONCLUSTERED ([IdTipoProcesso] ASC, [IdTipoInscricao] ASC)
);

