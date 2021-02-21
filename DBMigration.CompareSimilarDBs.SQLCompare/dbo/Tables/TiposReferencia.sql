CREATE TABLE [dbo].[TiposReferencia] (
    [IdTipoReferencia] INT       NOT NULL,
    [TipoReferencia]   CHAR (40) NOT NULL,
    CONSTRAINT [PK_TiposReferencia] PRIMARY KEY CLUSTERED ([IdTipoReferencia] ASC)
);

