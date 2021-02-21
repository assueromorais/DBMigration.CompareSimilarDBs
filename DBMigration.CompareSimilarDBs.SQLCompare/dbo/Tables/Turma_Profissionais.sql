CREATE TABLE [dbo].[Turma_Profissionais] (
    [id]             INT IDENTITY (1, 1) NOT NULL,
    [IdProfissional] INT NULL,
    [IdTurma]        INT NULL,
    [Presidente]     BIT CONSTRAINT [DF_Turma_ProfissionaisPresidente] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Turma_Profissionais] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_Turma_Profissionais_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_Turma_Profissionais_Turmas] FOREIGN KEY ([IdTurma]) REFERENCES [dbo].[Turmas] ([IdTurma])
);


GO
ALTER TABLE [dbo].[Turma_Profissionais] NOCHECK CONSTRAINT [FK_Turma_Profissionais_Profissionais];


GO
ALTER TABLE [dbo].[Turma_Profissionais] NOCHECK CONSTRAINT [FK_Turma_Profissionais_Turmas];

