CREATE TABLE [dbo].[Profissionais_ListaDocumentos] (
    [idProfissionais_ListaDocumento] INT      IDENTITY (1, 1) NOT NULL,
    [IdListaDocumento]               INT      NOT NULL,
    [IdProfissional]                 INT      NOT NULL,
    [DataEntrega]                    DATETIME NULL,
    [Recebido]                       BIT      NULL,
    CONSTRAINT [PK_Profissionais_ListaDocumentos] PRIMARY KEY CLUSTERED ([idProfissionais_ListaDocumento] ASC),
    CONSTRAINT [FK_Profissionais_ListaDocumentos_ListaDocumentos] FOREIGN KEY ([IdListaDocumento]) REFERENCES [dbo].[ListaDocumentos] ([IdListaDocumento]),
    CONSTRAINT [FK_Profissionais_ListaDocumentos_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
ALTER TABLE [dbo].[Profissionais_ListaDocumentos] NOCHECK CONSTRAINT [FK_Profissionais_ListaDocumentos_ListaDocumentos];


GO
ALTER TABLE [dbo].[Profissionais_ListaDocumentos] NOCHECK CONSTRAINT [FK_Profissionais_ListaDocumentos_Profissionais];

