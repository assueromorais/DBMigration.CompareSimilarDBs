CREATE TABLE [dbo].[Secao] (
    [IdSecao]        INT      IDENTITY (1, 1) NOT NULL,
    [IdTurma]        INT      NULL,
    [data]           DATETIME NULL,
    [IdProfissional] INT      NULL,
    [Desativado]     BIT      CONSTRAINT [DF_SecaoDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Secao] PRIMARY KEY CLUSTERED ([IdSecao] ASC),
    CONSTRAINT [FK_Secao_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_Secao_Turmas] FOREIGN KEY ([IdTurma]) REFERENCES [dbo].[Turmas] ([IdTurma])
);


GO
ALTER TABLE [dbo].[Secao] NOCHECK CONSTRAINT [FK_Secao_Profissionais];


GO
ALTER TABLE [dbo].[Secao] NOCHECK CONSTRAINT [FK_Secao_Turmas];

