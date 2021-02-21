CREATE TABLE [dbo].[PercentuaisBandeirasCartoes] (
    [IdPercentualBandeiraCartao] INT      IDENTITY (1, 1) NOT NULL,
    [IdBandeiraCartao]           INT      NOT NULL,
    [DataPercentual]             DATETIME NOT NULL,
    [Percentual]                 MONEY    NOT NULL,
    [FaixaParcelasInicio]        INT      NULL,
    [FaixaParcelasFim]           INT      NULL,
    CONSTRAINT [PK_ValoresBandeirasCartoes] PRIMARY KEY CLUSTERED ([IdPercentualBandeiraCartao] ASC),
    CONSTRAINT [FK_PercentuaisBandeirasCartoes_BandeirasCartoes] FOREIGN KEY ([IdBandeiraCartao]) REFERENCES [dbo].[BandeirasCartoes] ([IdBandeiraCartao])
);

