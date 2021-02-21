CREATE TABLE [dbo].[TiposItemDevolucaoReceita] (
    [IdTipoItemDevolucaoReceita] INT              IDENTITY (1, 1) NOT NULL,
    [TipoItemDevolucaoReceita]   NVARCHAR (25)    NULL,
    [IdConta]                    INT              NULL,
    [IdPlanoContaMCASP]          UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_TipoItemDevolucaoReceita] PRIMARY KEY CLUSTERED ([IdTipoItemDevolucaoReceita] ASC),
    CONSTRAINT [FK_TiposItemDevolucaoReceita_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);

