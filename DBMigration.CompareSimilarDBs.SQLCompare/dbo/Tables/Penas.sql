CREATE TABLE [dbo].[Penas] (
    [IdPena]     INT          IDENTITY (1, 1) NOT NULL,
    [NomePena]   VARCHAR (30) NULL,
    [Desativado] BIT          CONSTRAINT [DF_PenasDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Pena] PRIMARY KEY CLUSTERED ([IdPena] ASC)
);

