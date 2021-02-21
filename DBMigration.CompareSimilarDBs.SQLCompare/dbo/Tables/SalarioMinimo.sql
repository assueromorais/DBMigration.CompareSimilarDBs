CREATE TABLE [dbo].[SalarioMinimo] (
    [IdSalarioMinimo] INT      IDENTITY (1, 1) NOT NULL,
    [Data]            DATETIME NOT NULL,
    [Valor]           MONEY    NOT NULL,
    CONSTRAINT [PK_SalarioMinimo] PRIMARY KEY CLUSTERED ([IdSalarioMinimo] ASC)
);

