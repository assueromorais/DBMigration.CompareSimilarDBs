CREATE TABLE [dbo].[RateioDespesas] (
    [IdRateio]   INT          IDENTITY (1, 1) NOT NULL,
    [CodRateio]  INT          NULL,
    [NomeRateio] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_RateioDespesas] PRIMARY KEY CLUSTERED ([IdRateio] ASC)
);

