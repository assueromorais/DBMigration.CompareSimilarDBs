CREATE TABLE [dbo].[PlenarioRepresentacao] (
    [IdPlenarioRepresentacao] INT IDENTITY (1, 1) NOT NULL,
    [IdPlenario]              INT NOT NULL,
    [IdRepresentacao]         INT NOT NULL,
    [QuantidadeCadeiras]      INT NULL,
    CONSTRAINT [PK_PlenarioRepresentacao] PRIMARY KEY CLUSTERED ([IdPlenarioRepresentacao] ASC),
    CONSTRAINT [FK_PlenarioRepresentacao_Plenario] FOREIGN KEY ([IdPlenario]) REFERENCES [dbo].[Plenario] ([IdPlenario]),
    CONSTRAINT [FK_PlenarioRepresentacao_Representacao] FOREIGN KEY ([IdRepresentacao]) REFERENCES [dbo].[Representacao] ([IdRepresentacao])
);

