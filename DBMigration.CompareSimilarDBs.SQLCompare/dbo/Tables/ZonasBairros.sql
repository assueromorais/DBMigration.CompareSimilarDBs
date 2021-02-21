CREATE TABLE [dbo].[ZonasBairros] (
    [IdZona]   INT NOT NULL,
    [IdBairro] INT NOT NULL,
    CONSTRAINT [FkZonasBairrosBairros] FOREIGN KEY ([IdBairro]) REFERENCES [dbo].[Bairros] ([IdBairro]),
    CONSTRAINT [FkZonasBairrosZonas] FOREIGN KEY ([IdZona]) REFERENCES [dbo].[Zonas] ([IdZona])
);

