CREATE TABLE [dbo].[SituacoesContrato] (
    [IdSituacaoContrato] INT          IDENTITY (1, 1) NOT NULL,
    [Descricao]          VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_SituacoesContrato_IdSituacaoContrato] PRIMARY KEY CLUSTERED ([IdSituacaoContrato] ASC)
);

