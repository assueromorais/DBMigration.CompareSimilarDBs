CREATE TABLE [dbo].[TiposDiarias] (
    [IdTipoDiaria] INT          IDENTITY (1, 1) NOT NULL,
    [TipoDiaria]   VARCHAR (60) NULL,
    CONSTRAINT [PK_TiposDiarias] PRIMARY KEY CLUSTERED ([IdTipoDiaria] ASC),
    CONSTRAINT [IX_TiposDiarias] UNIQUE NONCLUSTERED ([TipoDiaria] ASC)
);

