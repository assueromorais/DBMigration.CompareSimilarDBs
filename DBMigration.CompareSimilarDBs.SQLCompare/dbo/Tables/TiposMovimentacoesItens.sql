CREATE TABLE [dbo].[TiposMovimentacoesItens] (
    [IdTipoMovimentacao] INT          IDENTITY (1, 1) NOT NULL,
    [TipoMovimentacao]   VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_TiposMovimentacoesItens] PRIMARY KEY NONCLUSTERED ([IdTipoMovimentacao] ASC)
);

