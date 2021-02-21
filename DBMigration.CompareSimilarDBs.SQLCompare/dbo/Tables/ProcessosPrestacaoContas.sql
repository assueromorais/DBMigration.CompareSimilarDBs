CREATE TABLE [dbo].[ProcessosPrestacaoContas] (
    [IdProcessosPrestacaoConta]   INT IDENTITY (1, 1) NOT NULL,
    [IdProcessoSolicitacaoViagem] INT NOT NULL,
    [IdItemPrestacaoContas]       INT NOT NULL,
    [Apresentado]                 BIT NULL,
    [Dispensado]                  BIT NULL,
    CONSTRAINT [PK_ProcessosPrestacaoContas] PRIMARY KEY CLUSTERED ([IdProcessosPrestacaoConta] ASC),
    CONSTRAINT [FK_ProcessosPrestacaoContas_ItensPrestacaoContas] FOREIGN KEY ([IdItemPrestacaoContas]) REFERENCES [dbo].[ItensPrestacaoContas] ([IdItemPrestacaoContas]),
    CONSTRAINT [FK_ProcessosPrestacaoContas_ProcessosSolicitacaoViagem] FOREIGN KEY ([IdProcessoSolicitacaoViagem]) REFERENCES [dbo].[ProcessosSolicitacaoViagem] ([IdProcessoSolicitacaoViagem])
);

