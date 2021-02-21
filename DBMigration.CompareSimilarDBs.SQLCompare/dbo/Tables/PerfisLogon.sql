CREATE TABLE [dbo].[PerfisLogon] (
    [IdPerfil]   INT          IDENTITY (1, 1) NOT NULL,
    [NomePerfil] VARCHAR (60) NOT NULL,
    CONSTRAINT [PK_PerfisLogon] PRIMARY KEY NONCLUSTERED ([IdPerfil] ASC)
);

