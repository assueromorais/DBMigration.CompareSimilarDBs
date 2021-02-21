CREATE TABLE [dbo].[SituacoesDocumento] (
    [IdSituacaoDocumento] INT          IDENTITY (1, 1) NOT NULL,
    [SituacaoDocumento]   VARCHAR (40) NOT NULL,
    [Desativado]          BIT          CONSTRAINT [DF_SituacoesDocumentoDesativado] DEFAULT ((0)) NULL,
    [VinculaProcesso]     BIT          DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_SituacoesDocumento] PRIMARY KEY CLUSTERED ([IdSituacaoDocumento] ASC)
);

