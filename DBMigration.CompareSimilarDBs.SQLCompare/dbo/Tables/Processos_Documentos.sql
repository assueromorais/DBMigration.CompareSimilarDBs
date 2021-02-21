CREATE TABLE [dbo].[Processos_Documentos] (
    [IdProcesso]      INT NOT NULL,
    [IdDocumento]     INT NOT NULL,
    [IdProcessoFases] INT NULL,
    [IdTramitacao]    INT NULL,
    CONSTRAINT [FK_IdTramitacao_Processos_Documentos_Tramitacoes] FOREIGN KEY ([IdTramitacao]) REFERENCES [dbo].[Tramitacoes] ([IdTramitacao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Processo_Fases1] FOREIGN KEY ([IdProcessoFases]) REFERENCES [dbo].[Processo_Fases] ([IdProcessoFases]),
    CONSTRAINT [FK_Processos_documentos_DocumentosSisdoc] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]),
    CONSTRAINT [FK_Processos_documentos_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso])
);


GO
ALTER TABLE [dbo].[Processos_Documentos] NOCHECK CONSTRAINT [FK_IdTramitacao_Processos_Documentos_Tramitacoes];

