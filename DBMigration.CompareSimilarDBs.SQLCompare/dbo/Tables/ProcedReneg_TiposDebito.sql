CREATE TABLE [dbo].[ProcedReneg_TiposDebito] (
    [IdProcedReneg] INT NOT NULL,
    [IdTipoDebito]  INT NOT NULL,
    CONSTRAINT [PK_ProcedReneg_TiposDebito] PRIMARY KEY CLUSTERED ([IdProcedReneg] ASC, [IdTipoDebito] ASC),
    CONSTRAINT [FK_ProcedReneg_TiposDebito_ProcedReneg] FOREIGN KEY ([IdProcedReneg]) REFERENCES [dbo].[ProcedimentosRenegociacao] ([IdProcedRenegociacao]),
    CONSTRAINT [FK_ProcedReneg_TiposDebito_TiposDebito] FOREIGN KEY ([IdTipoDebito]) REFERENCES [dbo].[TiposDebito] ([IdTipoDebito])
);

