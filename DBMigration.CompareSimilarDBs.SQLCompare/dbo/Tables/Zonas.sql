CREATE TABLE [dbo].[Zonas] (
    [IdZona]    INT          IDENTITY (1, 1) NOT NULL,
    [Descricao] VARCHAR (40) NOT NULL,
    [IdCidade]  INT          NULL,
    CONSTRAINT [PK_Zonas] PRIMARY KEY CLUSTERED ([IdZona] ASC),
    CONSTRAINT [FkZonasCidades] FOREIGN KEY ([IdCidade]) REFERENCES [dbo].[Cidades] ([IdCidade])
);

