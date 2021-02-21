CREATE TABLE [dbo].[SolicitacoesProcesso] (
    [IdSolicitacao]             INT      IDENTITY (1, 1) NOT NULL,
    [IdDocumento]               INT      NULL,
    [IdProcesso]                INT      NULL,
    [DataSolicitacao]           DATETIME NULL,
    [IdUsuarioSolicitante]      INT      NULL,
    [IdUsuarioResponsavel]      INT      NULL,
    [IdDepartamentoResponsavel] INT      NULL,
    [DataAtendimento]           DATETIME NULL,
    [SituacaoSolicitacao]       INT      NULL,
    CONSTRAINT [PK_SolicitacoesProcesso] PRIMARY KEY CLUSTERED ([IdSolicitacao] ASC),
    CONSTRAINT [FK_SolicitacoesProcesso_Departamentos] FOREIGN KEY ([IdDepartamentoResponsavel]) REFERENCES [dbo].[Departamentos] ([IdDepto]) NOT FOR REPLICATION,
    CONSTRAINT [FK_SolicitacoesProcesso_DocumentosSisdoc] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_SolicitacoesProcesso_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]) NOT FOR REPLICATION,
    CONSTRAINT [FK_SolicitacoesProcesso_Usuarios] FOREIGN KEY ([IdUsuarioSolicitante]) REFERENCES [dbo].[Usuarios] ([IdUsuario]) NOT FOR REPLICATION,
    CONSTRAINT [FK_SolicitacoesProcesso_Usuarios1] FOREIGN KEY ([IdUsuarioResponsavel]) REFERENCES [dbo].[Usuarios] ([IdUsuario]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[SolicitacoesProcesso] NOCHECK CONSTRAINT [FK_SolicitacoesProcesso_Departamentos];


GO
ALTER TABLE [dbo].[SolicitacoesProcesso] NOCHECK CONSTRAINT [FK_SolicitacoesProcesso_DocumentosSisdoc];


GO
ALTER TABLE [dbo].[SolicitacoesProcesso] NOCHECK CONSTRAINT [FK_SolicitacoesProcesso_Processos];


GO
ALTER TABLE [dbo].[SolicitacoesProcesso] NOCHECK CONSTRAINT [FK_SolicitacoesProcesso_Usuarios];


GO
ALTER TABLE [dbo].[SolicitacoesProcesso] NOCHECK CONSTRAINT [FK_SolicitacoesProcesso_Usuarios1];

