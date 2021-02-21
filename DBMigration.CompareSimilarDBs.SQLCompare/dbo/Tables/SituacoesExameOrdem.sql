CREATE TABLE [dbo].[SituacoesExameOrdem] (
    [IdSituacaoExame] INT          IDENTITY (1, 1) NOT NULL,
    [Descricao]       VARCHAR (20) NOT NULL,
    [Ativo]           BIT          NOT NULL,
    [Desativado]      BIT          CONSTRAINT [DF_SituacoesExameOrdemDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SituacoesExameOrdem] PRIMARY KEY CLUSTERED ([IdSituacaoExame] ASC)
);

