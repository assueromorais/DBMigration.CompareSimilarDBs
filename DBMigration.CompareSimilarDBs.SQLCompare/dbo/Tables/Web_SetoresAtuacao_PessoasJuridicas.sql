CREATE TABLE [dbo].[Web_SetoresAtuacao_PessoasJuridicas] (
    [IdWeb_SetorAtuacao_PessoaJuridica] INT            IDENTITY (1, 1) NOT NULL,
    [IdPessoaJuridica]                  INT            NOT NULL,
    [IdSetorAtuacao]                    INT            NOT NULL,
    [AtualizacaoWeb]                    VARCHAR (5000) NULL,
    [IndAtualizacao]                    BIT            NULL,
    [DataBaixa]                         DATETIME       NULL,
    [DataAtualizacao]                   DATETIME       NULL,
    CONSTRAINT [PK_Web_SetoresAtuacao_PessoasJuridicas] PRIMARY KEY CLUSTERED ([IdWeb_SetorAtuacao_PessoaJuridica] ASC)
);

