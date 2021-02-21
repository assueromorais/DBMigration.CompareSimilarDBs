CREATE TABLE [dbo].[Processos_Sessao] (
    [IDProcessos_Sessao] INT IDENTITY (1, 1) NOT NULL,
    [IDSessao]           INT NOT NULL,
    [IDProcesso]         INT NOT NULL,
    [Removido]           BIT NULL,
    CONSTRAINT [PK_Processos_Sessao] PRIMARY KEY CLUSTERED ([IDProcessos_Sessao] ASC),
    CONSTRAINT [FK_Processos_Sessao_Processos] FOREIGN KEY ([IDProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]),
    CONSTRAINT [FK_Processos_Sessao_Sessao] FOREIGN KEY ([IDSessao]) REFERENCES [dbo].[Secao] ([IdSecao])
);

