CREATE TABLE [dbo].[Web_CapitaisSocial] (
    [IdWeb_CapitalSocial] INT            IDENTITY (1, 1) NOT NULL,
    [IdCapitalSocial]     INT            NOT NULL,
    [IdPessoaJuridica]    INT            NULL,
    [CapitalSocial]       MONEY          NULL,
    [Data]                DATETIME       NULL,
    [QtdeCotas]           FLOAT (53)     NULL,
    [AtualizacaoWeb]      VARCHAR (5000) NULL,
    [IndAtualizacao]      BIT            NULL,
    [DataBaixa]           DATETIME       NULL,
    [DataAtualizacao]     DATETIME       NULL,
    CONSTRAINT [PK_Web_CapitalSocial] PRIMARY KEY CLUSTERED ([IdWeb_CapitalSocial] ASC)
);

