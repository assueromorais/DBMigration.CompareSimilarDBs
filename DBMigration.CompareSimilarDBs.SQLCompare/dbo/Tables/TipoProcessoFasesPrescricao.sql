CREATE TABLE [dbo].[TipoProcessoFasesPrescricao] (
    [IdTipoProcessoFasePrescricao] INT         IDENTITY (1, 1) NOT NULL,
    [IdFase]                       INT         NULL,
    [IdTipoProcesso]               INT         NULL,
    [Qtd]                          INT         NULL,
    [Criterio]                     VARCHAR (5) NULL,
    CONSTRAINT [PK_TipoProcessoFasesPrescricao] PRIMARY KEY CLUSTERED ([IdTipoProcessoFasePrescricao] ASC),
    CONSTRAINT [FK_TipoProcessoFasesPrescricao_Fases] FOREIGN KEY ([IdFase]) REFERENCES [dbo].[Fases] ([IdFase]),
    CONSTRAINT [FK_TipoProcessoFasesPrescricao_TipoProcesso] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso])
);

