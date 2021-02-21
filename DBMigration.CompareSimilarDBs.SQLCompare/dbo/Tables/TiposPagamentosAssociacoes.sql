CREATE TABLE [dbo].[TiposPagamentosAssociacoes] (
    [IdTipoPagtoAssociacao]   INT          IDENTITY (1, 1) NOT NULL,
    [NomeTipoPagtoAssociacao] VARCHAR (30) NULL,
    [TemRateio]               BIT          NULL,
    CONSTRAINT [PK_TiposPagamentosAssociacoes] PRIMARY KEY NONCLUSTERED ([IdTipoPagtoAssociacao] ASC)
);

