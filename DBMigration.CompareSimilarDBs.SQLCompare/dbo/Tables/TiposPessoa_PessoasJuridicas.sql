CREATE TABLE [dbo].[TiposPessoa_PessoasJuridicas] (
    [IdPessoaJuridica] INT            NOT NULL,
    [IdTipoPessoa]     INT            NOT NULL,
    [AtualizacaoWeb]   VARCHAR (8000) NULL,
    CONSTRAINT [PK_TiposPessoa_PessoasJuridicas] PRIMARY KEY CLUSTERED ([IdPessoaJuridica] ASC, [IdTipoPessoa] ASC),
    CONSTRAINT [FK_TiposPessoa_PessoasJuridicas_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]) NOT FOR REPLICATION,
    CONSTRAINT [FK_TiposPessoa_PessoasJuridicas_TiposPessoa] FOREIGN KEY ([IdTipoPessoa]) REFERENCES [dbo].[TiposPessoa] ([IdTipoPessoa]) NOT FOR REPLICATION
);

