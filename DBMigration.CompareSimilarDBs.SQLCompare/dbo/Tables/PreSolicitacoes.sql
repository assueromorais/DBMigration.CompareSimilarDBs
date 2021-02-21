CREATE TABLE [dbo].[PreSolicitacoes] (
    [IdPreSolicitacao]         INT            IDENTITY (1, 1) NOT NULL,
    [IdSolicitacao]            INT            NULL,
    [Descricao]                TEXT           NOT NULL,
    [DataSolicitacao]          DATETIME       NOT NULL,
    [DataPrazo]                DATETIME       NULL,
    [Quantidade]               INT            NULL,
    [IdResponsavel]            INT            NOT NULL,
    [IdResponsavelAutorizador] INT            NULL,
    [MotivoCancelamento]       TEXT           NULL,
    [DataCancelamento]         DATETIME       NULL,
    [DataAutorizacao]          DATETIME       NULL,
    [Justificativa]            VARCHAR (4000) NULL,
    [ValorEstimado]            MONEY          NULL,
    [IdUnidade]                INT            NULL,
    CONSTRAINT [PK_PreSolicitacoes] PRIMARY KEY CLUSTERED ([IdPreSolicitacao] ASC),
    CONSTRAINT [FK_PreSolicitacoes_Responsaveis] FOREIGN KEY ([IdResponsavel]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]),
    CONSTRAINT [FK_PreSolicitacoes_Responsaveis1] FOREIGN KEY ([IdResponsavelAutorizador]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]),
    CONSTRAINT [FK_PreSolicitacoes_Solicitacoes] FOREIGN KEY ([IdSolicitacao]) REFERENCES [dbo].[Solicitacoes] ([IdSolicitacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_PreSolicitacoes_Unidades] FOREIGN KEY ([IdUnidade]) REFERENCES [dbo].[Unidades] ([IdUnidade])
);


GO
ALTER TABLE [dbo].[PreSolicitacoes] NOCHECK CONSTRAINT [FK_PreSolicitacoes_Solicitacoes];

