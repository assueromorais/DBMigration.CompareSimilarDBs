CREATE TABLE [dbo].[PlenarioMandato] (
    [IdPlenarioMandato] INT   IDENTITY (1, 1) NOT NULL,
    [IdReuniaoPlenario] INT   NULL,
    [IdMandato]         INT   NULL,
    [TipoRepresentacao] INT   NULL,
    [Observacao]        NTEXT NULL,
    CONSTRAINT [PK_PlenarioMandato] PRIMARY KEY CLUSTERED ([IdPlenarioMandato] ASC),
    CONSTRAINT [FK_PlenarioMandato_Mandatos] FOREIGN KEY ([IdMandato]) REFERENCES [dbo].[Mandatos] ([IdMandato]),
    CONSTRAINT [FK_PlenarioMandato_Plenario] FOREIGN KEY ([IdReuniaoPlenario]) REFERENCES [dbo].[ReuniaoPlenario] ([IdReuniaoPlenario])
);

