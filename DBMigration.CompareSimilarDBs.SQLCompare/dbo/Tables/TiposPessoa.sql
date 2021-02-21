CREATE TABLE [dbo].[TiposPessoa] (
    [IdTipoPessoa]           INT          IDENTITY (1, 1) NOT NULL,
    [TipoPessoa]             VARCHAR (25) NOT NULL,
    [Desativado]             BIT          CONSTRAINT [DF_TiposPessoaDesativado] DEFAULT ((0)) NULL,
    [E_Funcionario]          BIT          NULL,
    [E_Fiscal]               BIT          NULL,
    [MTAviao]                BIT          NULL,
    [MTCarroAlugado]         BIT          NULL,
    [MTCarroProprio]         BIT          NULL,
    [MTOnibus]               BIT          NULL,
    [MTOutros]               BIT          NULL,
    [PercentualAdiantamento] MONEY        NULL,
    [ReservaHospedagem]      BIT          NULL,
    [Sispad]                 BIT          NULL,
    [SolicitaVoucher]        BIT          NULL,
    [E_Conselheiro]          BIT          NULL,
    CONSTRAINT [PK_TiposPessoa] PRIMARY KEY CLUSTERED ([IdTipoPessoa] ASC)
);

