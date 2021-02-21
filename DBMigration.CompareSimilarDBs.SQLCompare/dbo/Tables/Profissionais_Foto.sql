CREATE TABLE [dbo].[Profissionais_Foto] (
    [IdProfissional]      INT   NOT NULL,
    [Foto]                IMAGE NOT NULL,
    [Assinatura]          IMAGE NULL,
    [Digital]             IMAGE NULL,
    [IdProfissionaisFoto] INT   IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_Profissionais_Foto] PRIMARY KEY CLUSTERED ([IdProfissionaisFoto] ASC),
    CONSTRAINT [FK_Profissionais_Foto_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]) ON DELETE CASCADE
);

