CREATE TABLE [dbo].[SituacoesOcorrencia] (
    [IdSituacaoOcorrencia] INT       IDENTITY (1, 1) NOT NULL,
    [SituacaoOcorrencia]   CHAR (40) NOT NULL,
    [Desativado]           BIT       CONSTRAINT [DF_SituacoesOcorrenciaDesativado] DEFAULT ((0)) NULL,
    [AnularExibirTela]     BIT       CONSTRAINT [DF_DetalhesOcorrenciasSiscafw_AnularExibirTela] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_SituacoesOcorrencia] PRIMARY KEY CLUSTERED ([IdSituacaoOcorrencia] ASC)
);

