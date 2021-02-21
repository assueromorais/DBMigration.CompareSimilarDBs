CREATE TABLE [dbo].[Plenario] (
    [IdPlenario]         INT IDENTITY (1, 1) NOT NULL,
    [Ano]                INT NULL,
    [QuantidadeCadeiras] INT NULL,
    CONSTRAINT [PK_Plenario] PRIMARY KEY CLUSTERED ([IdPlenario] ASC)
);

