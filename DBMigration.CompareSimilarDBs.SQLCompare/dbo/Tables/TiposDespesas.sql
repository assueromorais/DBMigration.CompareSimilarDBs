CREATE TABLE [dbo].[TiposDespesas] (
    [IdTipoDespesa]                       INT          IDENTITY (1, 1) NOT NULL,
    [TipoDespesa]                         VARCHAR (50) NULL,
    [IdConta]                             INT          NULL,
    [Fixo]                                BIT          CONSTRAINT [DF_TiposDespesas_FIxo] DEFAULT ((0)) NULL,
    [CalculaValor]                        BIT          DEFAULT ((1)) NULL,
    [DiariasAuxilioRendimentoAnual]       BIT          DEFAULT ((0)) NULL,
    [VerbasIndenizatoriasRendimentoAnual] BIT          DEFAULT ((0)) NULL,
    [QtdeLimiteMes]                       INT          NULL,
    [InformarValorManualmente]            BIT          NULL,
    [InformaQtdeSolicitacao]              BIT          DEFAULT ((1)) NULL,
    [BloqueioLimiteDespesas]              BIT          DEFAULT ((0)) NULL,
    [InformaPeriodoSolicitacao]           BIT          NULL,
    CONSTRAINT [PK_TiposDespesas] PRIMARY KEY CLUSTERED ([IdTipoDespesa] ASC),
    CONSTRAINT [FK_TiposDespesas_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);

