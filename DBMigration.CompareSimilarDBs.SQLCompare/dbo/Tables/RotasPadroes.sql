CREATE TABLE [dbo].[RotasPadroes] (
    [IdRota]           INT           IDENTITY (1, 1) NOT NULL,
    [IdSiglaUFOrigem]  INT           NOT NULL,
    [IdCidadeOrigem]   INT           NOT NULL,
    [IdSiglaUFDestino] INT           NOT NULL,
    [IdCidadeDestino]  INT           NOT NULL,
    [DistanciaKM]      INT           NULL,
    [Fonte]            VARCHAR (255) NULL,
    CONSTRAINT [PK_Rotas] PRIMARY KEY CLUSTERED ([IdRota] ASC),
    CONSTRAINT [FK_Rotas_Cidades] FOREIGN KEY ([IdCidadeOrigem]) REFERENCES [dbo].[Cidades] ([IdCidade]),
    CONSTRAINT [FK_Rotas_Cidades1] FOREIGN KEY ([IdCidadeDestino]) REFERENCES [dbo].[Cidades] ([IdCidade])
);

