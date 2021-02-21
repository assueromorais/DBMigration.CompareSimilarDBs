CREATE TABLE [dbo].[TiposItemDevolucaoReceitaConta] (
    [IdTipoItemDevolucaoReceita] INT NOT NULL,
    [IdConta]                    INT NOT NULL,
    CONSTRAINT [PK_TiposItemDevolucaoReceitaConta] PRIMARY KEY CLUSTERED ([IdTipoItemDevolucaoReceita] ASC, [IdConta] ASC),
    CONSTRAINT [FK_TiposItemDevolucaoReceitaConta_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_TiposItemDevolucaoReceitaConta_TiposItemDevolucaoReceita] FOREIGN KEY ([IdTipoItemDevolucaoReceita]) REFERENCES [dbo].[TiposItemDevolucaoReceita] ([IdTipoItemDevolucaoReceita])
);

