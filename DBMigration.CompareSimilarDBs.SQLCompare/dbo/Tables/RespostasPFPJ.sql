CREATE TABLE [dbo].[RespostasPFPJ] (
    [IdRespostaPFPJ]   INT      IDENTITY (1, 1) NOT NULL,
    [IdProfissional]   INT      NULL,
    [IdPessoaJuridica] INT      NULL,
    [IdPessoa]         INT      NULL,
    [IdPesquisa]       INT      NOT NULL,
    [Data_Resposta]    DATETIME NULL,
    [Observacoes]      TEXT     NULL,
    CONSTRAINT [PK_RespostasPFPJ] PRIMARY KEY CLUSTERED ([IdRespostaPFPJ] ASC),
    CONSTRAINT [FK_RespostasPFPJ_Pesquisa] FOREIGN KEY ([IdPesquisa]) REFERENCES [dbo].[Pesquisas] ([IdPesquisa]),
    CONSTRAINT [FK_RespostasPFPJ_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_RespostasPFPJ_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]) NOT FOR REPLICATION,
    CONSTRAINT [FK_RespostasPFPJ_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]) NOT FOR REPLICATION
);

