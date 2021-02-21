CREATE TABLE [dbo].[TiposEntidades] (
    [IdTipoEntidade]   INT          IDENTITY (1, 1) NOT NULL,
    [NomeTipoEntidade] VARCHAR (30) NULL,
    CONSTRAINT [PK_TiposEntidades] PRIMARY KEY NONCLUSTERED ([IdTipoEntidade] ASC)
);

