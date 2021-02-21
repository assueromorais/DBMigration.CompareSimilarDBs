CREATE TABLE [dbo].[TipoAfastamento] (
    [IdTipoAfastamento] INT           IDENTITY (1, 1) NOT NULL,
    [TipoAfastamento]   NVARCHAR (50) NULL,
    CONSTRAINT [PK_TipoAfastamento] PRIMARY KEY CLUSTERED ([IdTipoAfastamento] ASC)
);

