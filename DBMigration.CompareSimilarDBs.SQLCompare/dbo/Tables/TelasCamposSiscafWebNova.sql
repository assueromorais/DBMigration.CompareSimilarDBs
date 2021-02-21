CREATE TABLE [dbo].[TelasCamposSiscafWebNova] (
    [Id]             INT          IDENTITY (1, 1) NOT NULL,
    [NomeTela]       VARCHAR (50) NULL,
    [NomeCampo]      VARCHAR (50) NULL,
    [AliasNomeCampo] VARCHAR (50) NULL,
    [Indice]         INT          NULL,
    CONSTRAINT [TelasCamposSiscafweb_pkNova] PRIMARY KEY CLUSTERED ([Id] ASC)
);

