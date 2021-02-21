CREATE TABLE [dbo].[TarifasTaxas] (
    [IdTarifaTaxa] INT          IDENTITY (1, 1) NOT NULL,
    [TarifaTaxa]   VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_TarifasTaxas] PRIMARY KEY CLUSTERED ([IdTarifaTaxa] ASC)
);

