CREATE TABLE [dbo].[PessoasAutorizacaoSolicitacoesViagem] (
    [IdSolicitacaoViagem]        INT      NOT NULL,
    [IdPessoaAutorizacao]        INT      NOT NULL,
    [DataSolicitacaoAutorizacao] DATETIME NOT NULL,
    [DataAutorizacao]            DATETIME NULL,
    CONSTRAINT [PK_PessoasAutorizacaoSolicitacoesViagem] PRIMARY KEY CLUSTERED ([IdSolicitacaoViagem] ASC, [IdPessoaAutorizacao] ASC),
    CONSTRAINT [FK_PessoasAutorizacaoSolicitacoesViagem_PessoasAutorizacao] FOREIGN KEY ([IdPessoaAutorizacao]) REFERENCES [dbo].[PessoasAutorizacao] ([IdPessoaAutorizacao]),
    CONSTRAINT [FK_PessoasAutorizacaoSolicitacoesViagem_SolicitacoesViagem] FOREIGN KEY ([IdSolicitacaoViagem]) REFERENCES [dbo].[SolicitacoesViagem] ([IdSolicitacaoViagem])
);

