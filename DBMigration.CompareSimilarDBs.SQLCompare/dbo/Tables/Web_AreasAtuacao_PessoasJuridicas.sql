CREATE TABLE [dbo].[Web_AreasAtuacao_PessoasJuridicas] (
    [IdWeb_AreaAtuacao_PessoaJuridica] INT            IDENTITY (1, 1) NOT NULL,
    [IdAreaAtuacao]                    INT            NOT NULL,
    [IdPessoaJuridica]                 INT            NOT NULL,
    [AtualizacaoWeb]                   VARCHAR (5000) NULL,
    [IndAtualizacao]                   BIT            NULL,
    [DataBaixa]                        DATETIME       NULL,
    [DataAtualizacao]                  DATETIME       NULL,
    CONSTRAINT [PK_Web_AreasAtuacao_PessoasJuridicas] PRIMARY KEY CLUSTERED ([IdWeb_AreaAtuacao_PessoaJuridica] ASC)
);

