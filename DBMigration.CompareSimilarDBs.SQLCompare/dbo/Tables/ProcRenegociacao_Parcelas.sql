CREATE TABLE [dbo].[ProcRenegociacao_Parcelas] (
    [IdProcRenegociacao_Parcelas] INT        IDENTITY (1, 1) NOT NULL,
    [IdProcedRenegociacao]        INT        NOT NULL,
    [Parcela]                     INT        NOT NULL,
    [ReducaoMulta]                FLOAT (53) NULL,
    [ReducaoJuros]                FLOAT (53) NULL,
    [ReducaoAtualizacao]          FLOAT (53) NULL,
    [AnoInicio]                   INT        NULL,
    [AnoFim]                      INT        NULL,
    [ReducaoPrincipal]            FLOAT (53) NULL,
    CONSTRAINT [PK_ProcRenegociacao_Parcelas] PRIMARY KEY CLUSTERED ([IdProcRenegociacao_Parcelas] ASC),
    CONSTRAINT [FK_ProcRenegociacao_Parcelas_ProcedimentosRenegociacao] FOREIGN KEY ([IdProcedRenegociacao]) REFERENCES [dbo].[ProcedimentosRenegociacao] ([IdProcedRenegociacao])
);

