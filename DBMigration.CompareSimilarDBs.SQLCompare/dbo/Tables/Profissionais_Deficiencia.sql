CREATE TABLE [dbo].[Profissionais_Deficiencia] (
    [IdProfissional] INT NOT NULL,
    [IdDeficiencia]  INT NOT NULL,
    CONSTRAINT [PK_Profissionais_Deficiencia] PRIMARY KEY CLUSTERED ([IdProfissional] ASC, [IdDeficiencia] ASC),
    CONSTRAINT [FK_Deficiencia_Profissionais_Deficiencia] FOREIGN KEY ([IdDeficiencia]) REFERENCES [dbo].[Deficiencia] ([IdDeficiencia]),
    CONSTRAINT [FK_Profissionais_Profissionais_Deficiencia] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);

