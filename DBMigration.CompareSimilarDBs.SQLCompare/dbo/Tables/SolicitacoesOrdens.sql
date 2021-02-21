CREATE TABLE [dbo].[SolicitacoesOrdens] (
    [IdSolicitacao] INT NOT NULL,
    [IdOrdem]       INT NOT NULL,
    CONSTRAINT [PK_SolicitacoesOrdens] PRIMARY KEY CLUSTERED ([IdSolicitacao] ASC, [IdOrdem] ASC),
    CONSTRAINT [FK_SolicitacoesOrdens_Ordens] FOREIGN KEY ([IdOrdem]) REFERENCES [dbo].[Ordens] ([IdOrdem]) NOT FOR REPLICATION,
    CONSTRAINT [FK_SolicitacoesOrdens_Solicitacoes] FOREIGN KEY ([IdSolicitacao]) REFERENCES [dbo].[Solicitacoes] ([IdSolicitacao]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[SolicitacoesOrdens] NOCHECK CONSTRAINT [FK_SolicitacoesOrdens_Ordens];


GO
ALTER TABLE [dbo].[SolicitacoesOrdens] NOCHECK CONSTRAINT [FK_SolicitacoesOrdens_Solicitacoes];

