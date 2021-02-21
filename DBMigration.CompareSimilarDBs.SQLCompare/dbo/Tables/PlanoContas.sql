CREATE TABLE [dbo].[PlanoContas] (
    [IdConta]              INT          IDENTITY (1, 1) NOT NULL,
    [Grupo]                INT          NOT NULL,
    [CodConta]             VARCHAR (18) NOT NULL,
    [NomeConta]            VARCHAR (50) NOT NULL,
    [CodContaResumido]     INT          NULL,
    [PermiteAlteracao]     BIT          NOT NULL,
    [Analitico]            BIT          NOT NULL,
    [E_Banco]              BIT          NOT NULL,
    [Lock]                 DATETIME     NULL,
    [ContaBancoComRepasse] BIT          CONSTRAINT [DF__PlanoCont__Conta__37DF14B0] DEFAULT ((0)) NULL,
    [Exercicio]            VARCHAR (4)  NULL,
    CONSTRAINT [PK_PlanoContas] PRIMARY KEY NONCLUSTERED ([IdConta] ASC),
    CONSTRAINT [FK_PlanoContas_Grupos] FOREIGN KEY ([Grupo]) REFERENCES [dbo].[Grupos] ([IdGrupo])
);


GO
CREATE NONCLUSTERED INDEX [IX_PlanoContasCodContaLock]
    ON [dbo].[PlanoContas]([CodConta] ASC, [Lock] ASC, [Exercicio] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PlanoContasGrupoCodConta]
    ON [dbo].[PlanoContas]([Grupo] ASC, [CodConta] ASC, [Exercicio] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PlanoContasCodConta]
    ON [dbo].[PlanoContas]([CodConta] ASC, [Exercicio] ASC);


GO
CREATE STATISTICS [STAT_PlanoContas_IdConta_Exercicio]
    ON [dbo].[PlanoContas]([IdConta], [Exercicio]);

