CREATE TABLE [dbo].[SituacoesAlertaEmpenho] (
    [IdSituacaoAlertaEmpenho] INT          IDENTITY (1, 1) NOT NULL,
    [SituacaoAlertaEmpenho]   VARCHAR (25) NOT NULL,
    CONSTRAINT [PK_SituacoesAlertaEmpenho] PRIMARY KEY NONCLUSTERED ([IdSituacaoAlertaEmpenho] ASC)
);

