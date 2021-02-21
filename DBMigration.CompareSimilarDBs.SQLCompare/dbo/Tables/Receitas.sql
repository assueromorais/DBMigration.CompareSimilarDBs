CREATE TABLE [dbo].[Receitas] (
    [IdReceita]                 INT          IDENTITY (1, 1) NOT NULL,
    [NumeroReceita]             INT          NOT NULL,
    [AnoExercicio]              SMALLINT     NOT NULL,
    [DataReceita]               DATETIME     NULL,
    [IdConta]                   INT          NOT NULL,
    [IdCentroCustoReceita]      INT          NULL,
    [ValorReceita]              MONEY        NULL,
    [ValorCustoReceita]         MONEY        NOT NULL,
    [QtdReceita]                INT          NOT NULL,
    [NumeroDocumento]           INT          NULL,
    [IdContaBanco]              INT          NOT NULL,
    [ValorUnitario]             MONEY        NULL,
    [IdLancamento]              INT          NULL,
    [Historico]                 TEXT         NULL,
    [Estornado]                 BIT          NOT NULL,
    [DataImportacao]            DATETIME     NULL,
    [Origem]                    VARCHAR (60) NULL,
    [Conciliado]                BIT          NULL,
    [DataPrevisao]              DATETIME     NULL,
    [ValorPrevisao]             MONEY        NULL,
    [NumeroProcesso]            VARCHAR (20) NULL,
    [AgrupamentoContabilizacao] INT          NULL,
    [IdFormaPagamento]          INT          NULL,
    [CobrancaCompartilhada]     BIT          CONSTRAINT [DF__Receitas__Cobran__3378BB98] DEFAULT ((0)) NOT NULL,
    [IdWebReceita]              INT          NULL,
    [IdReceitaARealizar]        INT          NULL,
    [RegistraLog]               BIT          CONSTRAINT [DF__Receitas__Regist__3C2D639D] DEFAULT ('1') NULL,
    [IdItemDevolucaoReceita]    INT          NULL,
    CONSTRAINT [PK_Receitas] PRIMARY KEY NONCLUSTERED ([IdReceita] ASC),
    CONSTRAINT [FK_Receitas_CentroCustosReceita] FOREIGN KEY ([IdCentroCustoReceita]) REFERENCES [dbo].[CentroCustosReceita] ([IdCentroCustoReceita]),
    CONSTRAINT [FK_Receitas_FormasPagamento] FOREIGN KEY ([IdFormaPagamento]) REFERENCES [dbo].[FormasPagamento] ([IdFormaPagamento]),
    CONSTRAINT [FK_Receitas_ItensDevolucaoReceita] FOREIGN KEY ([IdItemDevolucaoReceita]) REFERENCES [dbo].[ItensDevolucaoReceita] ([IdItemDevolucaoReceita]),
    CONSTRAINT [FK_Receitas_Lancamentos] FOREIGN KEY ([IdLancamento]) REFERENCES [dbo].[Lancamentos] ([IdLancamento]),
    CONSTRAINT [FK_Receitas_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_Receitas_PlanoContas1] FOREIGN KEY ([IdContaBanco]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_Receitas_ReceitasARealizar] FOREIGN KEY ([IdReceitaARealizar]) REFERENCES [dbo].[ReceitasARealizar] ([IdReceitaARealizar]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Receitas_Web_Receitas] FOREIGN KEY ([IdWebReceita]) REFERENCES [dbo].[Web_Receitas] ([IdReceita]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[Receitas] NOCHECK CONSTRAINT [FK_Receitas_Lancamentos];


GO
CREATE NONCLUSTERED INDEX [IX_Receitas_IdContaBanco_IdConta]
    ON [dbo].[Receitas]([IdContaBanco] ASC, [IdConta] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Receitas_IdConta]
    ON [dbo].[Receitas]([IdConta] ASC);

