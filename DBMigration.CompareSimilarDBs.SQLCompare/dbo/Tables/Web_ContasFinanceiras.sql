CREATE TABLE [dbo].[Web_ContasFinanceiras] (
    [IdContaFinanceira]     INT          IDENTITY (1, 1) NOT NULL,
    [IdCentroCustos]        INT          NULL,
    [CodigoContaFinanceira] VARCHAR (20) NULL,
    [NomeContaFinanceira]   VARCHAR (50) NULL,
    [TipoContaFinanceira]   VARCHAR (50) NULL,
    [Banco]                 VARCHAR (50) NULL,
    [Agencia]               VARCHAR (50) NULL,
    [ContaCorrente]         VARCHAR (50) NULL,
    [SaldoInicial]          MONEY        NULL,
    [DataSaldoInicial]      DATETIME     NULL,
    [ContaAtiva]            BIT          NULL,
    [IdCentroCustosReceita] INT          NULL
);

