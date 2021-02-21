CREATE TABLE [dbo].[WEB_DetalhesDespesa] (
    [IdDetalheDespesa]             INT      IDENTITY (1, 1) NOT NULL,
    [IdDespesa]                    INT      NULL,
    [IdTributo]                    INT      NULL,
    [Valor]                        MONEY    NULL,
    [dataRecolhimento]             DATETIME NULL,
    [IdUsuarioRecolhimento]        INT      NULL,
    [IdUsuarioEstornoRecolhimento] INT      NULL,
    [IdContaFinanceira]            INT      NULL,
    CONSTRAINT [PK_WEB_DetalhesDespesa] PRIMARY KEY CLUSTERED ([IdDetalheDespesa] ASC)
);

