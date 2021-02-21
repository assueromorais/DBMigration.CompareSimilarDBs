CREATE TABLE [dbo].[Web_TiposPessoa_PessoasJuridicas] (
    [IdWeb_TipoPessoa_PessoaJuridica] INT            IDENTITY (1, 1) NOT NULL,
    [IdPessoaJuridica]                INT            NOT NULL,
    [IdTipoPessoa]                    INT            NOT NULL,
    [AtualizacaoWeb]                  VARCHAR (5000) NULL,
    [IndAtualizacao]                  BIT            NULL,
    [DataBaixa]                       DATETIME       NULL,
    [DataAtualizacao]                 DATETIME       NULL,
    CONSTRAINT [PK_Web_TiposPessoa_PessoasJuridicas] PRIMARY KEY CLUSTERED ([IdWeb_TipoPessoa_PessoaJuridica] ASC)
);

