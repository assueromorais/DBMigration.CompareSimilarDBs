CREATE TABLE [dbo].[TransferenciaSIPROSISCONT] (
    [IdLancamento]          INT      NOT NULL,
    [IdPagamento]           INT      NULL,
    [IdMovimentoFinanceiro] INT      NULL,
    [IdUsuario]             INT      NULL,
    [Data]                  DATETIME CONSTRAINT [DF_TransferenciaSIPROSISCONT_Data] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_TransferenciaSIPROSISCONT] PRIMARY KEY CLUSTERED ([IdLancamento] ASC)
);

