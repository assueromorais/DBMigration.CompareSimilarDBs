CREATE TABLE [dbo].[TiposAcrescimo] (
    [IdTipoAcrescimo] INT          IDENTITY (1, 1) NOT NULL,
    [TipoAcrescimo]   VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_TiposAcrescimo] PRIMARY KEY CLUSTERED ([IdTipoAcrescimo] ASC)
);

