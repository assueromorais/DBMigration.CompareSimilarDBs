CREATE TABLE [dbo].[Processos_ProcessosLista1] (
    [IdProcesso]       INT NULL,
    [IdProcessoLista1] INT NULL,
    CONSTRAINT [FK_Processos_ProcessosLista1_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]),
    CONSTRAINT [FK_Processos_ProcessosLista1_ProcessosLista1] FOREIGN KEY ([IdProcessoLista1]) REFERENCES [dbo].[ProcessosLista1] ([IdProcessoLista1])
);

