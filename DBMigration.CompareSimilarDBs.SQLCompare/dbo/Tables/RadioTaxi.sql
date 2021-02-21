CREATE TABLE [dbo].[RadioTaxi] (
    [IdRadioTaxi]       INT IDENTITY (1, 1) NOT NULL,
    [IdPessoa]          INT NULL,
    [ProximoNumVoucher] INT NULL,
    CONSTRAINT [PK_RadioTaxi] PRIMARY KEY CLUSTERED ([IdRadioTaxi] ASC),
    CONSTRAINT [FK_RadioTaxi_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);

