CREATE TABLE [dbo].[Turmas] (
    [IdTurma]    INT           IDENTITY (1, 1) NOT NULL,
    [NomeTurma]  VARCHAR (100) NULL,
    [Especial]   BIT           CONSTRAINT [DF__Turmas__Especial__7D49F575] DEFAULT ((0)) NULL,
    [Desativado] BIT           CONSTRAINT [DF_TurmasDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Turmas] PRIMARY KEY CLUSTERED ([IdTurma] ASC)
);

