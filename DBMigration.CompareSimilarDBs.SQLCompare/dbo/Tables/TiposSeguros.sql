CREATE TABLE [dbo].[TiposSeguros] (
    [IdTipoSeguro] INT          IDENTITY (1, 1) NOT NULL,
    [TipoSeguro]   VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_TiposSeguros] PRIMARY KEY CLUSTERED ([IdTipoSeguro] ASC)
);

