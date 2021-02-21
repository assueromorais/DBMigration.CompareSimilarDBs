CREATE TABLE [dbo].[TiposDebito] (
    [IdTipoDebito]                INT          IDENTITY (1, 1) NOT NULL,
    [NomeDebito]                  VARCHAR (25) NOT NULL,
    [SiglaDebito]                 VARCHAR (10) NULL,
    [PercentualRepasse]           FLOAT (53)   NULL,
    [ExclusivoProcesso]           BIT          NULL,
    [CodTipoDebito]               INT          NULL,
    [UsoAdimplente]               BIT          CONSTRAINT [DF__TiposDebi__UsoAd__5B9199EA] DEFAULT ((1)) NULL,
    [DiasVencimento]              INT          NULL,
    [ValorPadrao]                 MONEY        NULL,
    [Desativado]                  BIT          CONSTRAINT [DF_TiposDebitoDesativado] DEFAULT ((0)) NULL,
    [PrioridadeBaixaPgto]         INT          NULL,
    [DebitoDeEstagiario]          BIT          NULL,
    [UtilizarPgtoDuplicado]       BIT          DEFAULT ((0)) NOT NULL,
    [UsoDividaAtiva]              BIT          DEFAULT ((0)) NOT NULL,
    [QtdAnosRef_Pra_Menos]        INT          NULL,
    [QtdAnosRef_Pra_Mais]         INT          NULL,
    [IsentoDeEncargosParaEmissao] BIT          CONSTRAINT [DF_TiposDebito_IsentoDeEncargosParaEmissao] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TiposDebito] PRIMARY KEY CLUSTERED ([IdTipoDebito] ASC)
);

