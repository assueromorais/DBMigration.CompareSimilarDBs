CREATE TABLE [dbo].[TiposDocumentosAssuntos] (
    [IdTipoDocumentoAssunto] INT IDENTITY (1, 1) NOT NULL,
    [IdTipoDocumento]        INT NULL,
    [IdAssunto]              INT NULL,
    PRIMARY KEY CLUSTERED ([IdTipoDocumentoAssunto] ASC),
    CONSTRAINT [FK_TiposDocumentosAssuntos_IdAssunto] FOREIGN KEY ([IdAssunto]) REFERENCES [dbo].[AssuntoSisdoc] ([IdAssunto]),
    CONSTRAINT [FK_TiposDocumentosAssuntos_IdTipoDocumento] FOREIGN KEY ([IdTipoDocumento]) REFERENCES [dbo].[TiposDocumentos] ([IdTipoDocumento])
);

