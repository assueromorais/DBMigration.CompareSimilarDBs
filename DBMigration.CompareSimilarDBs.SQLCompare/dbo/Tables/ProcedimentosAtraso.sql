CREATE TABLE [dbo].[ProcedimentosAtraso] (
    [IdProcedimentoAtraso]       INT          IDENTITY (1, 1) NOT NULL,
    [NomeProcedimentoAtraso]     VARCHAR (50) NOT NULL,
    [DescProcedimentoAtraso]     TEXT         NULL,
    [Em_Uso]                     BIT          NOT NULL,
    [PeriodoCalculoDe]           DATETIME     NULL,
    [PeriodoCalculoAte]          DATETIME     NULL,
    [TipoPessoa]                 INT          NOT NULL,
    [ParaDebVencidoDe]           DATETIME     NULL,
    [ParaDebVencidoAte]          DATETIME     NULL,
    [TodosDebExcetoRen]          BIT          NULL,
    [AplicaProcedimentoParcela]  INT          CONSTRAINT [DF_ProcedimentosAtrasoAplicaProcedimentoParcela] DEFAULT ((0)) NULL,
    [DataVencimentoAnuidade]     VARCHAR (4)  NULL,
    [IdProcedimentoAtrasoOrigem] INT          NULL,
    CONSTRAINT [PK_ProcedimentosAtraso] PRIMARY KEY CLUSTERED ([IdProcedimentoAtraso] ASC)
);

