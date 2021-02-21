CREATE TABLE [dbo].[Web_ResponsaveisTecnicosPJ] (
    [IdWeb_ResponsavelTecnico]  INT            IDENTITY (1, 1) NOT NULL,
    [IdResponsavelTecnico]      INT            NOT NULL,
    [IdExperienciaProfissional] INT            NULL,
    [IdSetorResponsabilidade]   INT            NULL,
    [DataInicio]                DATETIME       NULL,
    [DataFim]                   DATETIME       NULL,
    [AtualizacaoWeb]            VARCHAR (5000) NULL,
    [IndAtualizacao]            BIT            NULL,
    [DataBaixa]                 DATETIME       NULL,
    [DataAtualizacao]           DATETIME       NULL,
    [IdEspecialidade]           INT            NULL,
    [ObservacaoRespTec]         VARCHAR (8000) NULL,
    [Certidao]                  VARCHAR (10)   NULL,
    [Livro]                     VARCHAR (10)   NULL,
    [Folha]                     VARCHAR (10)   NULL,
    [InformacaoAdicionalCargo]  VARCHAR (200)  NULL,
    CONSTRAINT [PK_Web_ResponsaveisTecnicosPJ] PRIMARY KEY CLUSTERED ([IdWeb_ResponsavelTecnico] ASC)
);

