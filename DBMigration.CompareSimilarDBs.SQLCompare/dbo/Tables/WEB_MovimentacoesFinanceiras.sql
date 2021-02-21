CREATE TABLE [dbo].[WEB_MovimentacoesFinanceiras] (
    [IdMovimentacaoFinanceira] INT           IDENTITY (1, 1) NOT NULL,
    [IdContaOrigem]            INT           NULL,
    [IdContaDestino]           INT           NOT NULL,
    [DataTransacao]            DATETIME      NULL,
    [ValorPrevisto]            MONEY         NULL,
    [Historico]                VARCHAR (500) NULL,
    [IdUsuarioPCS]             INT           NULL,
    [IdUsuarioLogon]           INT           NULL,
    [IdCentroCusto]            INT           NULL,
    [IdCentroCustoReceita]     INT           NULL,
    [E_repasse]                BIT           CONSTRAINT [DF__WEB_Movim__E_rep__274F14EC] DEFAULT ((0)) NULL
);

