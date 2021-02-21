CREATE TABLE [dbo].[VencimentosParcela] (
    [IdVencimentoParcela]   INT         IDENTITY (1, 1) NOT NULL,
    [IdParcelaRenegociacao] INT         NULL,
    [NumeroParcela]         VARCHAR (2) NULL,
    [DataVencimentoParcela] DATETIME    NULL,
    CONSTRAINT [PK_VencimentosParcela] PRIMARY KEY NONCLUSTERED ([IdVencimentoParcela] ASC)
);

