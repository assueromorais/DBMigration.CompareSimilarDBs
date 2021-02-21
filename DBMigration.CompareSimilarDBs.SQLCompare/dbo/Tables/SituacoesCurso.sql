CREATE TABLE [dbo].[SituacoesCurso] (
    [IdSituacaoCurso] INT          IDENTITY (1, 1) NOT NULL,
    [SituacaoCurso]   VARCHAR (20) NOT NULL,
    [IndCricacaoWeb]  BIT          CONSTRAINT [DF_SituacoesCursoIndCricacaoWeb] DEFAULT ((0)) NULL,
    [IndCriacaoWeb]   BIT          CONSTRAINT [DF_SituacoesCursoIndCriacaoWeb] DEFAULT ((0)) NULL,
    [Desativado]      BIT          CONSTRAINT [DF_SituacoesCursoDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SituacoesCurso] PRIMARY KEY CLUSTERED ([IdSituacaoCurso] ASC)
);

