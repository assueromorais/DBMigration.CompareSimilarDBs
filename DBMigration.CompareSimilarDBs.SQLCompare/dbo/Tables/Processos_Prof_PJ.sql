CREATE TABLE [dbo].[Processos_Prof_PJ] (
    [IdProcessos_Prof_PJ] INT IDENTITY (1, 1) NOT NULL,
    [IdProfissional]      INT NULL,
    [IdPessoaJuridica]    INT NULL,
    [IdProcesso]          INT NOT NULL,
    [IdPessoa]            INT NULL,
    CONSTRAINT [PK_EntidProfiss_Processos] PRIMARY KEY CLUSTERED ([IdProcessos_Prof_PJ] ASC),
    CONSTRAINT [FK_EntidProfiss_Processos_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_EntidProfiss_Processos_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]),
    CONSTRAINT [FK_EntidProfiss_Processos_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_Processos_Prof_Pj_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);

