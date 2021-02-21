CREATE TABLE [dbo].[ReuniaoPlenario] (
    [IdReuniaoPlenario] INT            IDENTITY (1, 1) NOT NULL,
    [IdPlenario]        INT            NULL,
    [Nome]              NVARCHAR (150) NULL,
    [DataRealizacao]    DATETIME       NULL,
    [LocalRealizacao]   NVARCHAR (100) NULL,
    [Observacao]        NTEXT          NULL,
    CONSTRAINT [PK_ReuniaoPlenario] PRIMARY KEY CLUSTERED ([IdReuniaoPlenario] ASC),
    CONSTRAINT [FK_ReuniaoPlenario_Plenario] FOREIGN KEY ([IdPlenario]) REFERENCES [dbo].[Plenario] ([IdPlenario])
);

