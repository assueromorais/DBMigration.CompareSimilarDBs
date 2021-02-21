CREATE TABLE [dbo].[Reavaliacoes] (
    [IdValorAtual]                 INT              IDENTITY (1, 1) NOT NULL,
    [IdEstadoConservacao]          INT              NOT NULL,
    [IdItem]                       INT              NOT NULL,
    [TipoBem]                      VARCHAR (1)      NOT NULL,
    [DataReavaliacao]              DATETIME         NOT NULL,
    [Valor]                        MONEY            NOT NULL,
    [ValorModPatrimonio]           MONEY            NOT NULL,
    [HistoricoReavaliacao]         TEXT             NULL,
    [TipoReavaliacao]              VARCHAR (1)      NULL,
    [IdConta]                      INT              NULL,
    [IdLancamentoMCASP]            UNIQUEIDENTIFIER NULL,
    [QtdMesesDepreciacaoAcumulada] INT              NULL,
    CONSTRAINT [PK_Reavaliacoes] PRIMARY KEY NONCLUSTERED ([IdValorAtual] ASC),
    CONSTRAINT [FK_Reavaliacoes_EstadosConservacao] FOREIGN KEY ([IdEstadoConservacao]) REFERENCES [dbo].[EstadosConservacao] ([IdEstadoConservacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Reavaliacoes_ItensImoveis] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[ItensImoveis] ([IdItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Reavaliacoes_ItensMoveis] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[ItensMoveis] ([IdItem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Reavaliacoes_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
ALTER TABLE [dbo].[Reavaliacoes] NOCHECK CONSTRAINT [FK_Reavaliacoes_ItensImoveis];


GO
ALTER TABLE [dbo].[Reavaliacoes] NOCHECK CONSTRAINT [FK_Reavaliacoes_ItensMoveis];

