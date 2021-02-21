CREATE TABLE [dbo].[ProcedimentosRenegociacao] (
    [IdProcedRenegociacao] INT          IDENTITY (1, 1) NOT NULL,
    [NomeProcedReneg]      VARCHAR (50) NOT NULL,
    [DescProcedReneg]      TEXT         NULL,
    [Em_Uso]               BIT          NOT NULL,
    [QtdMaxParcelas]       INT          NULL,
    [DiasVenc1aParc]       INT          NULL,
    [ValorParcelaMinima]   MONEY        NULL,
    [IdMensagemPadrao]     INT          NULL,
    [IdInstrucaoPadrao]    INT          NULL,
    CONSTRAINT [PK_ProcedimentosRenegociacao] PRIMARY KEY CLUSTERED ([IdProcedRenegociacao] ASC),
    CONSTRAINT [FK_ProcedimentosRenegociacao_MsgBoletosBancarios_1] FOREIGN KEY ([IdMensagemPadrao]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario]),
    CONSTRAINT [FK_ProcedimentosRenegociacao_MsgBoletosBancarios_2] FOREIGN KEY ([IdInstrucaoPadrao]) REFERENCES [dbo].[MsgBoletosBancarios] ([IdMsgBoletoBancario])
);

