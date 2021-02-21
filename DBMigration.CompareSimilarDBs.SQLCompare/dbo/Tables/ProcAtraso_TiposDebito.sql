CREATE TABLE [dbo].[ProcAtraso_TiposDebito] (
    [IdTipoDebito]         INT NOT NULL,
    [IdProcedimentoAtraso] INT NOT NULL,
    CONSTRAINT [PK_ProcAtraso_TiposDebito] PRIMARY KEY CLUSTERED ([IdTipoDebito] ASC, [IdProcedimentoAtraso] ASC),
    CONSTRAINT [FK_ProcAtraso_TiposDebito_ProcedimentosAtraso] FOREIGN KEY ([IdProcedimentoAtraso]) REFERENCES [dbo].[ProcedimentosAtraso] ([IdProcedimentoAtraso]),
    CONSTRAINT [FK_ProcAtraso_TiposDebito_TiposDebito] FOREIGN KEY ([IdTipoDebito]) REFERENCES [dbo].[TiposDebito] ([IdTipoDebito])
);

