CREATE TABLE [dbo].[PessoasProfissoes] (
    [IdPessoaProfissao] INT IDENTITY (1, 1) NOT NULL,
    [IdPessoa]          INT NOT NULL,
    [IdProfissao]       INT NOT NULL,
    CONSTRAINT [PK_PessoaProfissao] PRIMARY KEY CLUSTERED ([IdPessoaProfissao] ASC),
    CONSTRAINT [FK_PessoasProfissoes_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_PessoasProfissoes_Profissoes] FOREIGN KEY ([IdProfissao]) REFERENCES [dbo].[Profissoes] ([IdProfissao])
);

