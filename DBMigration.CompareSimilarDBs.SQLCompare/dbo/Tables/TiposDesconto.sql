CREATE TABLE [dbo].[TiposDesconto] (
    [IdTipoDesconto] INT          IDENTITY (1, 1) NOT NULL,
    [TipoDesconto]   VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_TiposDesconto] PRIMARY KEY CLUSTERED ([IdTipoDesconto] ASC)
);

