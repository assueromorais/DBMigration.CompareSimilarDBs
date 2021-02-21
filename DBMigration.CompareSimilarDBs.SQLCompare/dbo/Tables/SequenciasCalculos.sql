CREATE TABLE [dbo].[SequenciasCalculos] (
    [IdSequenciaCalculo]           INT          IDENTITY (1, 1) NOT NULL,
    [IdProcedimentoAtraso]         INT          NOT NULL,
    [NumSequenciaCalculo]          INT          NOT NULL,
    [AplicarSeqCalculoDe]          DATETIME     NULL,
    [AplicarSeqCalculoAte]         DATETIME     NULL,
    [AplicarSeqCalcDe]             INT          NULL,
    [AplicarSeqCalcAte]            INT          NULL,
    [AcrescentarValorFixo]         BIT          NULL,
    [ValorFixo]                    MONEY        NULL,
    [RotinaCalculo]                INT          NULL,
    [PercentualMultaJuros]         FLOAT (53)   NULL,
    [AplicarSobreSequencia]        VARCHAR (20) NULL,
    [AplicarSobreCalculoSequencia] INT          NULL,
    [AplicarSeqCalcVctoDe]         DATETIME     NULL,
    [AplicarSeqCalcVctoAte]        DATETIME     NULL,
    [AplicaPercentual]             BIT          CONSTRAINT [DF__Sequencia__Aplic__60564F07] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_SequenciasCalculos] PRIMARY KEY CLUSTERED ([IdSequenciaCalculo] ASC),
    CONSTRAINT [FK_SequenciasCalculos_ProcedimentosAtraso] FOREIGN KEY ([IdProcedimentoAtraso]) REFERENCES [dbo].[ProcedimentosAtraso] ([IdProcedimentoAtraso])
);

