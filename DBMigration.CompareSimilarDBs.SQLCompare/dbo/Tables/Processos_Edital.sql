CREATE TABLE [dbo].[Processos_Edital] (
    [IdProcesso]  INT NOT NULL,
    [IdDocumento] INT NOT NULL,
    CONSTRAINT [FK_Processos_edital_DocumentosSisdoc] FOREIGN KEY ([IdDocumento]) REFERENCES [dbo].[DocumentosSisdoc] ([IdDocumento]),
    CONSTRAINT [FK_Processos_edital_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso])
);

