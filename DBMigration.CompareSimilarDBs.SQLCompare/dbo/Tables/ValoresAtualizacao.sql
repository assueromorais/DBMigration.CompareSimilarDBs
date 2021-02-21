CREATE TABLE [dbo].[ValoresAtualizacao] (
    [IdValorAtualizacao]      INT           IDENTITY (1, 1) NOT NULL,
    [IdCampoTabela]           INT           NOT NULL,
    [NovoValor]               VARCHAR (200) NOT NULL,
    [NovoIdCampo]             VARCHAR (100) NOT NULL,
    [Versao]                  INT           NOT NULL,
    [IdValorAgrupadorDetalhe] INT           NULL,
    [IndicativoPagamento]     INT           NULL,
    [TipoPessoa]              INT           NULL,
    [DetalheObrigatorio]      BIT           NULL,
    CONSTRAINT [Pk_ValoresAtualizacao] PRIMARY KEY CLUSTERED ([IdValorAtualizacao] ASC),
    CONSTRAINT [FL_003] FOREIGN KEY ([IdCampoTabela]) REFERENCES [dbo].[CamposTabelaPadronizacao] ([IdCampoTabela]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FL_004] FOREIGN KEY ([IdValorAgrupadorDetalhe]) REFERENCES [dbo].[ValoresAtualizacao] ([IdValorAtualizacao])
);

