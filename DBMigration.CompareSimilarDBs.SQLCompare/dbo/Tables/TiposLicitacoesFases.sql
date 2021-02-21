CREATE TABLE [dbo].[TiposLicitacoesFases] (
    [IdTipoLicitacao]     INT NOT NULL,
    [IdFase]              INT NOT NULL,
    [IdResponsavel]       INT NOT NULL,
    [QtdDiasPrevistos]    INT NOT NULL,
    [Ordem]               INT NULL,
    [IdTipoLicitacaoFase] INT IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_TiposLicitacoesFases] PRIMARY KEY CLUSTERED ([IdTipoLicitacao] ASC, [IdFase] ASC),
    CONSTRAINT [FK_TiposLicitacoesFases_Fases] FOREIGN KEY ([IdFase]) REFERENCES [dbo].[Fases] ([IdFase]) NOT FOR REPLICATION,
    CONSTRAINT [FK_TiposLicitacoesFases_Responsaveis] FOREIGN KEY ([IdResponsavel]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]) NOT FOR REPLICATION
);

