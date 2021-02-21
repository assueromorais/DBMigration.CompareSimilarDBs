CREATE TABLE [dbo].[WEB_EnvioDocumentacao] (
    [IdEnvioDocumentacao] INT      IDENTITY (1, 1) NOT NULL,
    [IdUsuarioSubSecao]   INT      NULL,
    [DataEnvio]           DATETIME NULL,
    CONSTRAINT [PK_WEB_EnvioDocumentacao] PRIMARY KEY CLUSTERED ([IdEnvioDocumentacao] ASC)
);

