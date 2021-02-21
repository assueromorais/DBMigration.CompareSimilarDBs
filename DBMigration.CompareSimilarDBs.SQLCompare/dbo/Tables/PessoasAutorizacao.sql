CREATE TABLE [dbo].[PessoasAutorizacao] (
    [IdPessoaAutorizacao]     INT      NOT NULL,
    [DataValidadeAutorizacao] DATETIME NOT NULL,
    [PessoaAutorizacaoAtiva]  BIT      NOT NULL,
    CONSTRAINT [PK_PessoasAutorizacao] PRIMARY KEY CLUSTERED ([IdPessoaAutorizacao] ASC)
);

