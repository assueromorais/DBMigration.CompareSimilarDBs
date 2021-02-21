CREATE TABLE [dbo].[SituacoesPFPJ] (
    [IdSituacaoPFPJ]         INT          IDENTITY (1, 1) NOT NULL,
    [IdSituacaoRetorno]      INT          NULL,
    [NomeSituacao]           VARCHAR (50) NOT NULL,
    [IndicativoPagamento]    BIT          NOT NULL,
    [PercentualDesconto]     FLOAT (53)   NULL,
    [Sincroniza]             BIT          CONSTRAINT [DF__Situacoes__Sincr__5F9EF494] DEFAULT ((0)) NULL,
    [VisualizarSituacao]     BIT          CONSTRAINT [DF__SITUACOES__Visua__7306CEC3] DEFAULT ((1)) NULL,
    [TrocaSituacaoDebAberto] BIT          CONSTRAINT [DF__Situacoes__Troca__3ACC9741] DEFAULT ((1)) NOT NULL,
    [ValidadeSituacao]       FLOAT (53)   NULL,
    [UnidadeValidade]        VARCHAR (1)  NULL,
    [CancelarDebito]         BIT          CONSTRAINT [DF__Situacoes__Cance__466AC924] DEFAULT ((0)) NULL,
    [Desativado]             BIT          CONSTRAINT [DF_SituacoesPFPJDesativado] DEFAULT ((0)) NULL,
    [Inadimplentes]          BIT          CONSTRAINT [DF__Situacoes__Inadi__40B3B846] DEFAULT ((0)) NULL,
    [Cor]                    VARCHAR (20) NULL,
    [SituacaoPF]             BIT          DEFAULT ((1)) NOT NULL,
    [ExibeAlertaAssistente]  BIT          DEFAULT ((0)) NOT NULL,
    [IdSerasaSituacao]       INT          NULL,
    [InibirRegistrosWeb]     BIT          CONSTRAINT [DEF_SituacoesPFPJ_InibirRegistrosWeb] DEFAULT ((0)) NOT NULL,
    [ExigeDetalhe]           BIT          NULL,
    CONSTRAINT [PK_SituacoesPFPJ] PRIMARY KEY CLUSTERED ([IdSituacaoPFPJ] ASC),
    CONSTRAINT [FK_SituacoesPFPJ_IdSerasaSituacao] FOREIGN KEY ([IdSerasaSituacao]) REFERENCES [dbo].[SerasaSituacoes] ([IdSerasaSituacao]),
    CONSTRAINT [FK_SituacoesPFPJ_SituacoesPFPJ] FOREIGN KEY ([IdSituacaoRetorno]) REFERENCES [dbo].[SituacoesPFPJ] ([IdSituacaoPFPJ])
);


GO
CREATE NONCLUSTERED INDEX [IndDescricaoSituacao]
    ON [dbo].[SituacoesPFPJ]([NomeSituacao] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ID_SituacoesPFPJ_NomeSituacoes_TipoPessoa]
    ON [dbo].[SituacoesPFPJ]([NomeSituacao] ASC, [SituacaoPF] ASC);

