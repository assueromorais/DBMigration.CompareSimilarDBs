CREATE TABLE [dbo].[Solicitantes] (
    [IdSolicitante] INT IDENTITY (1, 1) NOT NULL,
    [IdPessoa]      INT NOT NULL,
    CONSTRAINT [PK_Solicitantes] PRIMARY KEY CLUSTERED ([IdSolicitante] ASC),
    CONSTRAINT [FK_Solicitantes_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);

