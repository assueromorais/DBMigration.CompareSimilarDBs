CREATE TABLE [dbo].[TiposRateioAssociacoes] (
    [IdTipoRateioAssociacao]    INT         IDENTITY (1, 1) NOT NULL,
    [E_Percentual]              BIT         NULL,
    [Valor]                     MONEY       NULL,
    [Exercicio]                 VARCHAR (4) NULL,
    [IdConta]                   INT         NULL,
    [IdTipoMovimentoFinanceiro] INT         NULL,
    [IdPessoa]                  INT         NULL,
    CONSTRAINT [PK_TiposRateioAssociacoes] PRIMARY KEY NONCLUSTERED ([IdTipoRateioAssociacao] ASC)
);

