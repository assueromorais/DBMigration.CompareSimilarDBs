CREATE TABLE [dbo].[TipoProcesso_Departamento] (
    [IdTipoProcesso] INT NOT NULL,
    [idDepartamento] INT NOT NULL,
    CONSTRAINT [FK_TipoProcesso_Departamento] FOREIGN KEY ([idDepartamento]) REFERENCES [dbo].[Departamentos] ([IdDepto]),
    CONSTRAINT [FK_TipoProcesso_TipoProcesso] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso])
);

