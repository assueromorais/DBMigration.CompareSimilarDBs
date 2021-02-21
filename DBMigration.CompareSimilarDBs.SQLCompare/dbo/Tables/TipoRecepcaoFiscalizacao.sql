CREATE TABLE [dbo].[TipoRecepcaoFiscalizacao] (
    [IdTipoRecepcaoFiscalizacao] INT          IDENTITY (1, 1) NOT NULL,
    [TipoRecepcaoFiscalizacao]   VARCHAR (30) NULL,
    [Desativado]                 BIT          CONSTRAINT [DF_TipoRecepcaoFiscalizacaoDesativado] DEFAULT ((0)) NULL
);

