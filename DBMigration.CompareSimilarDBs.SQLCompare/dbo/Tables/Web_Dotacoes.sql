CREATE TABLE [dbo].[Web_Dotacoes] (
    [Identificador] INT      IDENTITY (1, 1) NOT NULL,
    [IdConta]       INT      NULL,
    [Valor]         MONEY    NULL,
    [IdCentroCusto] INT      NULL,
    [DataDotacao]   DATETIME NULL,
    [Analitica]     BIT      NULL
);

