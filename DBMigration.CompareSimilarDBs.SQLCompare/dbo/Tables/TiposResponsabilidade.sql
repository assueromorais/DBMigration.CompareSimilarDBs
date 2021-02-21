CREATE TABLE [dbo].[TiposResponsabilidade] (
    [IdTipoResponsabilidade] INT          IDENTITY (1, 1) NOT NULL,
    [TipoResponsabilidade]   VARCHAR (40) NOT NULL,
    CONSTRAINT [PK_TiposResponsabilidade] PRIMARY KEY CLUSTERED ([IdTipoResponsabilidade] ASC)
);

