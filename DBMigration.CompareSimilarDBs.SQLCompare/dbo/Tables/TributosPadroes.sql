CREATE TABLE [dbo].[TributosPadroes] (
    [IdTributo] INT NOT NULL,
    [IdConta]   INT NOT NULL,
    CONSTRAINT [FK_TributosPadroes_Tributos] FOREIGN KEY ([IdTributo]) REFERENCES [dbo].[Tributos] ([IdTributo])
);

