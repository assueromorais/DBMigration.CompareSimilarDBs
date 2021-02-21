CREATE TABLE [dbo].[Solicitacoes] (
    [IdSolicitacao]          INT          IDENTITY (1, 1) NOT NULL,
    [Descricao]              TEXT         NULL,
    [DataSolicitacao]        DATETIME     NOT NULL,
    [DataPrazo]              DATETIME     NULL,
    [Quantidade]             REAL         NULL,
    [IdResponsavel]          INT          NOT NULL,
    [IdItem]                 INT          NULL,
    [IdUnidade]              INT          NULL,
    [Justificativa]          TEXT         NULL,
    [NumeroProtocolo]        VARCHAR (20) NULL,
    [ValorEstimado]          MONEY        NULL,
    [IdResponsavelComprador] INT          NULL,
    CONSTRAINT [PK_Solicitacoes] PRIMARY KEY CLUSTERED ([IdSolicitacao] ASC),
    CONSTRAINT [FK_Solicitacoes_Responsaveis] FOREIGN KEY ([IdResponsavelComprador]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel])
);

