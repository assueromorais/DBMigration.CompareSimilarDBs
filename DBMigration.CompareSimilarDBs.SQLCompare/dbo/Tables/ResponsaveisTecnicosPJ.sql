CREATE TABLE [dbo].[ResponsaveisTecnicosPJ] (
    [IdResponsavelTecnico]      INT            IDENTITY (1, 1) NOT NULL,
    [IdExperienciaProfissional] INT            NOT NULL,
    [IdSetorResponsabilidade]   INT            NULL,
    [DataInicio]                DATETIME       NOT NULL,
    [DataFim]                   DATETIME       NULL,
    [AtualizacaoWeb]            VARCHAR (8000) NULL,
    [IdEspecialidade]           INT            NULL,
    [ObservacaoRespTec]         TEXT           NULL,
    [Certidao]                  VARCHAR (10)   NULL,
    [Livro]                     VARCHAR (10)   NULL,
    [Folha]                     VARCHAR (10)   NULL,
    [InformacaoAdicionalCargo]  VARCHAR (200)  NULL,
    CONSTRAINT [PK_ResponsaveisTecnicosPJ] PRIMARY KEY CLUSTERED ([IdResponsavelTecnico] ASC),
    CONSTRAINT [FK_ResponsaveisTecnicosPJ_Especialidades] FOREIGN KEY ([IdEspecialidade]) REFERENCES [dbo].[Especialidades] ([IdEspecialidade]),
    CONSTRAINT [FK_ResponsaveisTecnicosPJ_Experienciasprofissionais] FOREIGN KEY ([IdExperienciaProfissional]) REFERENCES [dbo].[ExperienciasProfissionais] ([IdExperienciaProfissional]),
    CONSTRAINT [FK_ResponsaveisTecnicosPJ_SetoresResponsabilidade] FOREIGN KEY ([IdSetorResponsabilidade]) REFERENCES [dbo].[SetoresResponsabilidade] ([IdSetorResponsabilidade])
);

