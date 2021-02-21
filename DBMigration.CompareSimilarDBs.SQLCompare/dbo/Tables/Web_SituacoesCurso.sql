CREATE TABLE [dbo].[Web_SituacoesCurso] (
    [IdWeb_SituacaoCurso] INT          IDENTITY (1, 1) NOT NULL,
    [IdSituacaoCurso]     INT          NOT NULL,
    [SituacaoCurso]       VARCHAR (20) NULL,
    [IndCriacaoWeb]       BIT          CONSTRAINT [DF_SituacoesCursoIndCriacaoWeb_WEB] DEFAULT ((0)) NULL,
    [DataBaixa]           DATETIME     NULL,
    [DataAtualizacao]     DATETIME     NULL,
    [E_Impedido]          BIT          NULL,
    [IndCricacaoWeb]      BIT          CONSTRAINT [DF_SituacoesCursoIndCricacaoWeb_WEB] DEFAULT ((0)) NOT NULL,
    [Desativado]          BIT          CONSTRAINT [DF_SituacoesCursoDesativado_WEB] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Web_SituacoesCurso] PRIMARY KEY CLUSTERED ([IdWeb_SituacaoCurso] ASC)
);

