CREATE TABLE [dbo].[SetoresAtuacao_Pessoas] (
    [IdSetorAtuacao] INT NOT NULL,
    [IdPessoa]       INT NOT NULL,
    CONSTRAINT [PK_SetoresAtuacao_Pessoas] PRIMARY KEY CLUSTERED ([IdSetorAtuacao] ASC, [IdPessoa] ASC),
    CONSTRAINT [FK_SetoresAtuacao_Pessoas_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_SetoresAtuacao_Pessoas_SetoresAtuacao] FOREIGN KEY ([IdSetorAtuacao]) REFERENCES [dbo].[SetoresAtuacao] ([IdSetorAtuacao])
);

