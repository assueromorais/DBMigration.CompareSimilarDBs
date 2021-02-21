CREATE TABLE [dbo].[ProcessosCompServSolicitacoes] (
    [IdProcesso]    INT NOT NULL,
    [IdSolicitacao] INT NOT NULL,
    CONSTRAINT [PK_ProcessosCompServSolicitacoes] PRIMARY KEY CLUSTERED ([IdProcesso] ASC, [IdSolicitacao] ASC),
    CONSTRAINT [FK_ProcessosCompServSolicitacoes_ProcessosCompServ] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[ProcessosCompServ] ([IdProcesso]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ProcessosCompServSolicitacoes_Solicitacoes] FOREIGN KEY ([IdSolicitacao]) REFERENCES [dbo].[Solicitacoes] ([IdSolicitacao]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[ProcessosCompServSolicitacoes] NOCHECK CONSTRAINT [FK_ProcessosCompServSolicitacoes_ProcessosCompServ];


GO
ALTER TABLE [dbo].[ProcessosCompServSolicitacoes] NOCHECK CONSTRAINT [FK_ProcessosCompServSolicitacoes_Solicitacoes];

