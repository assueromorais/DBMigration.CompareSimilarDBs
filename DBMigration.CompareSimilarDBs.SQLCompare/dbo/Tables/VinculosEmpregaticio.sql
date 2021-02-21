CREATE TABLE [dbo].[VinculosEmpregaticio] (
    [IdVinculoEmpregaticio] INT           IDENTITY (1, 1) NOT NULL,
    [VinculoEmpregaticio]   VARCHAR (100) NULL,
    [Desativado]            BIT           CONSTRAINT [DF_VinculosEmpregaticioDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_VinculosEmpregaticio] PRIMARY KEY CLUSTERED ([IdVinculoEmpregaticio] ASC)
);

