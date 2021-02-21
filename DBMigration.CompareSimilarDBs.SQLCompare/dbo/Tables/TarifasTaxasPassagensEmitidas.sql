CREATE TABLE [dbo].[TarifasTaxasPassagensEmitidas] (
    [IdTarifaTaxaPassagemEmitida] INT          IDENTITY (1, 1) NOT NULL,
    [IdPassagemAereaEmitida]      INT          NULL,
    [IdPassagemRodoviariaEmitida] INT          NULL,
    [IdTarifaTaxa]                INT          NOT NULL,
    [ValorTarifaTaxa]             MONEY        NULL,
    [ValorDesconto]               MONEY        CONSTRAINT [DF_TarifasTaxasPassagensEmitidas_ValorDesconto] DEFAULT ((0)) NULL,
    [IdPagamento]                 INT          NULL,
    [StatusTarifaTaxa]            VARCHAR (50) NULL,
    [IdProcessoSolicitacaoViagem] INT          NULL,
    [TipoDesconto]                CHAR (1)     NULL,
    CONSTRAINT [PK_TarifasTaxasPassagensEmitidas] PRIMARY KEY CLUSTERED ([IdTarifaTaxaPassagemEmitida] ASC),
    CONSTRAINT [FK_TarifasTaxasPassagensEmitidas_IdProcessoSolicitacaoViagem] FOREIGN KEY ([IdProcessoSolicitacaoViagem]) REFERENCES [dbo].[ProcessosSolicitacaoViagem] ([IdProcessoSolicitacaoViagem]),
    CONSTRAINT [FK_TarifasTaxasPassagensEmitidas_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_TarifasTaxasPassagensEmitidas_PassagensAereasEmitidas] FOREIGN KEY ([IdPassagemAereaEmitida]) REFERENCES [dbo].[PassagensAereasEmitidas] ([IdPassagemAereaEmitida]),
    CONSTRAINT [FK_TarifasTaxasPassagensEmitidas_PassagensRodoviariasEmitidas] FOREIGN KEY ([IdPassagemRodoviariaEmitida]) REFERENCES [dbo].[PassagensRodoviariasEmitidas] ([IdPassagemRodoviariaEmitida]),
    CONSTRAINT [FK_TarifasTaxasPassagensEmitidas_TarifasTaxas] FOREIGN KEY ([IdTarifaTaxa]) REFERENCES [dbo].[TarifasTaxas] ([IdTarifaTaxa])
);

