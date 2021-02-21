CREATE TABLE [dbo].[SituacoesDebito] (
    [IdSituacaoDebito] INT          IDENTITY (1, 1) NOT NULL,
    [SituacaoDebito]   VARCHAR (16) NULL,
    CONSTRAINT [PK_SituacoesDebito] PRIMARY KEY NONCLUSTERED ([IdSituacaoDebito] ASC)
);

