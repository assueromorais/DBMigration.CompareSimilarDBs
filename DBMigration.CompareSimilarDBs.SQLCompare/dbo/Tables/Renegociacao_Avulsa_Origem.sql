CREATE TABLE [dbo].[Renegociacao_Avulsa_Origem] (
    [IdRenegociacao]   INT          NOT NULL,
    [IdDebitoOrigem]   INT          NOT NULL,
    [DataRenegociacao] DATETIME     NOT NULL,
    [IdProfissional]   INT          NULL,
    [IdPessoaJuridica] INT          NULL,
    [IdPessoa]         INT          NULL,
    [ValorDevido]      MONEY        NULL,
    [ValorAtualizacao] MONEY        NULL,
    [ValorMulta]       MONEY        NULL,
    [ValorJuros]       MONEY        NULL,
    [ObsDebito]        VARCHAR (50) NULL,
    [Recred]           BIT          NULL,
    [UsuarioRen]       VARCHAR (30) NULL,
    [DepartamentoRen]  VARCHAR (60) NULL,
    CONSTRAINT [PK_Renegociacao_Avulsa_Origem_1] PRIMARY KEY CLUSTERED ([IdRenegociacao] ASC, [IdDebitoOrigem] ASC)
);

