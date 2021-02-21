CREATE TABLE [dbo].[SituacoesSolicitacao] (
    [IdSituacaoSolicitacao] INT          NOT NULL,
    [SituacaoSolicitacao]   VARCHAR (50) NULL,
    [Desativado]            BIT          DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SituacoesSolicitacao] PRIMARY KEY CLUSTERED ([IdSituacaoSolicitacao] ASC)
);

