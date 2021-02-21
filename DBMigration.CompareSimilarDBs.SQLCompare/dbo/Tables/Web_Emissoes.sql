CREATE TABLE [dbo].[Web_Emissoes] (
    [IdWeb_Emissoes]   INT            IDENTITY (1, 1) NOT NULL,
    [IdEmissao]        INT            NOT NULL,
    [IdProfissional]   INT            NULL,
    [IdPessoaJuridica] INT            NULL,
    [Nome]             VARCHAR (120)  NULL,
    [RegistroConselho] VARCHAR (20)   NULL,
    [AtualizacaoWeb]   VARCHAR (5000) NULL,
    [IndAtualizacao]   BIT            NULL,
    [DataBaixa]        DATETIME       NULL,
    [IdPessoa]         INT            NULL,
    [RegistraLog]      BIT            CONSTRAINT [DF__Emissoes__Regist__052FA09F_WEB] DEFAULT ((1)) NULL,
    [CPF_CNPJ]         VARCHAR (14)   NULL,
    [Endereco]         VARCHAR (300)  NULL,
    [NomeBairro]       VARCHAR (50)   NULL,
    [NomeCidade]       VARCHAR (50)   NULL,
    [SiglaUF]          VARCHAR (2)    NULL,
    [CaixaPostal]      VARCHAR (15)   NULL,
    [CEP]              VARCHAR (8)    NULL
);

