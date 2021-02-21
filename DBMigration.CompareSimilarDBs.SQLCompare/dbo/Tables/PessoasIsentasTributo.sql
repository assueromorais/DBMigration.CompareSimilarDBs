CREATE TABLE [dbo].[PessoasIsentasTributo] (
    [IdPessoaIsentaTributo] INT      IDENTITY (1, 1) NOT NULL,
    [IdPessoa]              INT      NOT NULL,
    [PeriodoInicial]        DATETIME NOT NULL,
    [PeriodoFinal]          DATETIME NULL,
    CONSTRAINT [PK_PessoasInsentasTributo] PRIMARY KEY CLUSTERED ([IdPessoaIsentaTributo] ASC),
    CONSTRAINT [FK_PessoasInsentasTributo_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);

