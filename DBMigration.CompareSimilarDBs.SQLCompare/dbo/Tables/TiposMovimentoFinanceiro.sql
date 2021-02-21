CREATE TABLE [dbo].[TiposMovimentoFinanceiro] (
    [IdTipoMovimentoFinanceiro] INT          IDENTITY (1, 1) NOT NULL,
    [TipoMovimentoFinanceiro]   VARCHAR (60) NOT NULL,
    CONSTRAINT [PK_TiposMovimentoFinanceiro] PRIMARY KEY CLUSTERED ([IdTipoMovimentoFinanceiro] ASC)
);

