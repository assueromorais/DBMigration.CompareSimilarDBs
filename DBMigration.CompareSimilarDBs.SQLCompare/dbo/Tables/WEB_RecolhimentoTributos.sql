CREATE TABLE [dbo].[WEB_RecolhimentoTributos] (
    [IdRecolhimento]       INT           IDENTITY (1, 1) NOT NULL,
    [IdTributoWeb]         INT           NOT NULL,
    [DataPrevista]         DATETIME      NULL,
    [ValorPrevisto]        MONEY         NULL,
    [IdContaFinanceira]    INT           NULL,
    [DataEfetiva]          DATETIME      NULL,
    [ValorEfetivo]         MONEY         NULL,
    [Historico]            VARCHAR (500) NULL,
    [IdCentroCusto]        INT           NULL,
    [IdCentroCustoReceita] INT           NULL
);

