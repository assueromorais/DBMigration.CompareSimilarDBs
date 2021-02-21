CREATE TABLE [dbo].[RotasPadroesPedagios] (
    [IdRota]    INT NOT NULL,
    [IdPedagio] INT NOT NULL,
    CONSTRAINT [PK_RotasPadroesPedagios] PRIMARY KEY CLUSTERED ([IdRota] ASC, [IdPedagio] ASC),
    CONSTRAINT [FK_RotasPadroesPedagios_Pedagios] FOREIGN KEY ([IdPedagio]) REFERENCES [dbo].[Pedagios] ([IdPedagio]),
    CONSTRAINT [FK_RotasPadroesPedagios_RotasPadroes] FOREIGN KEY ([IdRota]) REFERENCES [dbo].[RotasPadroes] ([IdRota])
);

