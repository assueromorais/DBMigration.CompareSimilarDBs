CREATE TABLE [dbo].[Tributos] (
    [IdTributo]                 INT          IDENTITY (1, 1) NOT NULL,
    [NomeTributo]               VARCHAR (30) NOT NULL,
    [IdConta]                   INT          NULL,
    [IdPessoa]                  INT          NOT NULL,
    [Percentual]                BIT          NOT NULL,
    [CodTributo]                VARCHAR (10) NULL,
    [IdTipoMovimentoFinanceiro] INT          NULL,
    [Recolhimento]              INT          NULL,
    [TipoRecolhimento]          VARCHAR (20) NULL,
    [DES]                       BIT          CONSTRAINT [DF__Tributos__DES__2ACB39A2] DEFAULT ((0)) NULL,
    [TributoPCS]                BIT          CONSTRAINT [DF_TributosTributoPCS] DEFAULT ((0)) NULL,
    [Ativo]                     BIT          CONSTRAINT [DF_TributosAtivo] DEFAULT ((0)) NULL,
    [IdContaPCS]                INT          CONSTRAINT [DF_TributosIdContaPCS] DEFAULT ((0)) NULL,
    [TributoAtivo]              BIT          NULL,
    [Exercicio]                 VARCHAR (4)  NULL,
    [Historico]                 TEXT         NULL,
    CONSTRAINT [PK_Tributos] PRIMARY KEY CLUSTERED ([IdTributo] ASC),
    CONSTRAINT [FK_Tributos_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Tributos_TiposMovimentoFinanceiro] FOREIGN KEY ([IdTipoMovimentoFinanceiro]) REFERENCES [dbo].[TiposMovimentoFinanceiro] ([IdTipoMovimentoFinanceiro]) NOT FOR REPLICATION
);

