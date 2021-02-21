CREATE TABLE [dbo].[PessoasJuridicasPorte] (
    [IdPorte]            INT          IDENTITY (1, 1) NOT NULL,
    [IdPessoaJuridica]   INT          NOT NULL,
    [DataCadastro]       DATETIME     NOT NULL,
    [CalculaPorte]       BIT          CONSTRAINT [DF_PessoasJuridicasPorte_CalculaPorte] DEFAULT ((0)) NOT NULL,
    [QtdFunc]            INT          NULL,
    [Potencia]           INT          NULL,
    [Porte]              VARCHAR (20) NULL,
    [DataSalarioMinimo]  DATETIME     NULL,
    [ValorSalarioMinimo] MONEY        NULL,
    [DataCapitalSocial]  DATETIME     NULL,
    [ValorCapitalSocial] MONEY        NULL,
    CONSTRAINT [PK_PessoasJuridicasPorte] PRIMARY KEY CLUSTERED ([IdPorte] ASC),
    CONSTRAINT [FK_PessoasJuridicasPorte_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica])
);

