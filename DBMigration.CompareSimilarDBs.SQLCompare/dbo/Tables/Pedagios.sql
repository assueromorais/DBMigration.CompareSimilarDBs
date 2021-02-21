CREATE TABLE [dbo].[Pedagios] (
    [IdPedagio]  INT           IDENTITY (1, 1) NOT NULL,
    [Localidade] VARCHAR (255) NULL,
    CONSTRAINT [PK_Pedagios] PRIMARY KEY CLUSTERED ([IdPedagio] ASC)
);

