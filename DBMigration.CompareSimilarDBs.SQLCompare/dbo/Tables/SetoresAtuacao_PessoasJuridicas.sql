CREATE TABLE [dbo].[SetoresAtuacao_PessoasJuridicas] (
    [IdPessoaJuridica] INT            NOT NULL,
    [IdSetorAtuacao]   INT            NOT NULL,
    [AtualizacaoWeb]   VARCHAR (8000) NULL,
    CONSTRAINT [PK_SetoresAtuacao_PessoasJuridicas] PRIMARY KEY CLUSTERED ([IdPessoaJuridica] ASC, [IdSetorAtuacao] ASC),
    CONSTRAINT [FK_SetoresAtuacao_PessoasJuridicas_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]) NOT FOR REPLICATION,
    CONSTRAINT [FK_SetoresAtuacao_PessoasJuridicas_SetoresAtuacao] FOREIGN KEY ([IdSetorAtuacao]) REFERENCES [dbo].[SetoresAtuacao] ([IdSetorAtuacao]) NOT FOR REPLICATION
);

