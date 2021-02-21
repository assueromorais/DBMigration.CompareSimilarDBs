CREATE TABLE [dbo].[PlanoContasFinanceiro] (
    [IdContaFinanceira]    INT          IDENTITY (1, 1) NOT NULL,
    [IdContaFinanceiraPai] INT          NULL,
    [NomeContaFinanceira]  VARCHAR (60) NOT NULL,
    [TipoConta]            CHAR (1)     NULL,
    [IdConta]              INT          NULL,
    [ChequeEspecial]       MONEY        NULL,
    [Exercicio]            VARCHAR (4)  NULL,
    CONSTRAINT [PK_ContasFinanceiras] PRIMARY KEY NONCLUSTERED ([IdContaFinanceira] ASC),
    CONSTRAINT [FK_PlanoContasFinanceiro_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[PlanoContasFinanceiro] NOCHECK CONSTRAINT [FK_PlanoContasFinanceiro_PlanoContas];

