CREATE TABLE [dbo].[PreContabilizacao] (
    [idPrecontabilizacao]             INT          IDENTITY (1, 1) NOT NULL,
    [idTipoEvento]                    INT          NOT NULL,
    [idConjuntoEvento]                INT          NOT NULL,
    [idHistoricoProcedimentoColetivo] INT          NULL,
    [idDebito]                        INT          NULL,
    [idTipoDebito]                    INT          NULL,
    [idTipoPagamento]                 INT          NULL,
    [DataEvento]                      DATETIME     NULL,
    [DataCredito]                     DATETIME     NULL,
    [ContaPagamento]                  VARCHAR (30) NULL,
    [ContaReceita]                    VARCHAR (30) NULL,
    [TipoValor]                       CHAR (1)     NULL,
    [Valor]                           MONEY        NULL,
    [Historico]                       TEXT         NULL,
    [NumeroLote]                      INT          NULL
);

