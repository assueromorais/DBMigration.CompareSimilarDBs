CREATE TABLE [dbo].[Processos_Fiscalizacoes] (
    [IdProcessoFiscalizacao] INT IDENTITY (1, 1) NOT NULL,
    [IdProcesso]             INT NULL,
    [IdFiscalizacao]         INT NULL,
    CONSTRAINT [PK_Processos_Fiscalizacoes] PRIMARY KEY CLUSTERED ([IdProcessoFiscalizacao] ASC),
    CONSTRAINT [FK_Processos_Fiscalizacoes_Fiscalizacao] FOREIGN KEY ([IdFiscalizacao]) REFERENCES [dbo].[Fiscalizacoes] ([IdFiscalizacao]),
    CONSTRAINT [FK_Processos_Fiscalizacoes_Processo] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso])
);

