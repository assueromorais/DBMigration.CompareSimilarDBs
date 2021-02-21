CREATE TABLE [dbo].[RegistrosCursos] (
    [IdRegistroCurso]        INT          IDENTITY (1, 1) NOT NULL,
    [IdCursoEventoRealizado] INT          NOT NULL,
    [IdPessoa]               INT          NULL,
    [NumeroRegistro]         VARCHAR (18) NULL,
    [LivroRegistro]          VARCHAR (10) NULL,
    [FolhaRegistro]          VARCHAR (10) NULL,
    [DataRegistro]           DATETIME     NULL,
    CONSTRAINT [PK_RegistrosCursos] PRIMARY KEY CLUSTERED ([IdRegistroCurso] ASC),
    CONSTRAINT [FK_RegistrosCursos_CursosEventosRealizado] FOREIGN KEY ([IdCursoEventoRealizado]) REFERENCES [dbo].[CursosEventosRealizado] ([IdCursoEventoRealizado]),
    CONSTRAINT [FK_RegistrosCursos_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION
);

