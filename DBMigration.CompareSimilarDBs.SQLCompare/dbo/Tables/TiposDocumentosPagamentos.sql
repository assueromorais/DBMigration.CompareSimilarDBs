CREATE TABLE [dbo].[TiposDocumentosPagamentos] (
    [IdTipoDocumentoPagamento]    INT           IDENTITY (1, 1) NOT NULL,
    [TipoDocumentoPagamento]      VARCHAR (100) NULL,
    [NotaFiscal]                  BIT           CONSTRAINT [DF__TiposDocu__NotaF__33EA8F88] DEFAULT ((0)) NOT NULL,
    [SiglaTipoDocumentoPagamento] VARCHAR (5)   NULL,
    [Ordem]                       INT           NULL,
    [Ativo]                       BIT           CONSTRAINT [DF__TiposDocu__Ativo__2065E724] DEFAULT ((1)) NULL,
    [DES]                         BIT           CONSTRAINT [DF__TiposDocume__DES__224E2F96] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TiposDocumentosPagamentos] PRIMARY KEY CLUSTERED ([IdTipoDocumentoPagamento] ASC)
);

