﻿CREATE TABLE [dbo].[ReceitasARealizar] (
    [IdReceitaARealizar]                    INT          IDENTITY (1, 1) NOT NULL,
    [DataRegistro]                          DATETIME     NULL,
    [DataPrevista]                          DATETIME     NULL,
    [ValorPrevisto]                         MONEY        NULL,
    [IdMovimentoFinanceiroTransferencia]    INT          NULL,
    [IdMovimentoFinanceiroEfetivacao]       INT          NULL,
    [IdMovimentoFinanceiroCustodia]         INT          NULL,
    [IdMovimentoFinanceiroDevolucao]        INT          NULL,
    [TipoReceita]                           CHAR (2)     NULL,
    [Numero]                                VARCHAR (50) NULL,
    [Bandeira]                              VARCHAR (10) NULL,
    [CodBanco]                              CHAR (3)     NULL,
    [CPFCNPJ]                               VARCHAR (14) NULL,
    [Origem]                                TEXT         NULL,
    [QtdParcelas]                           INT          NULL,
    [NumParcela]                            INT          NULL,
    [Situacao]                              VARCHAR (50) NULL,
    [IdRetornoCartao]                       INT          NULL,
    [Historico]                             TEXT         NULL,
    [NumControle]                           VARCHAR (6)  NULL,
    [IdMovimentoFinanceiroCancelamento]     INT          NULL,
    [IdMovimentoFinanceiroRetiradaCustodia] INT          NULL,
    [IdMovimentoFinanceiroReapresentacao]   INT          NULL,
    [IdReceitaARealizarChequeSubstituido]   INT          NULL,
    [IdContaBancoOriginalChequeSubstituido] INT          NULL,
    [DataPrevistaOriginalChequeSubstituido] DATETIME     NULL,
    [IdMovimentoFinanceiroDevolucao2]       INT          NULL,
    [IdMovimentoFinanceiroQuitacao]         INT          NULL,
    [IdMovimentoFinanceiroReintegracao]     INT          NULL,
    [IdReceitaARealizarOrigem]              INT          NULL,
    [IdControleArquivoCob]                  INT          NULL,
    [SituacaoEstorno]                       VARCHAR (50) NULL,
    [IdLancamentoDA]                        INT          NULL,
    [ContaDebitoDA]                         VARCHAR (18) NULL,
    [ContaCreditoDA]                        VARCHAR (18) NULL,
    [ValorDA]                               MONEY        NULL,
    [IndReceita]                            INT          NULL,
    CONSTRAINT [PK_ReceitasARealizar] PRIMARY KEY CLUSTERED ([IdReceitaARealizar] ASC),
    CONSTRAINT [FK_ReceitasARealizar_ControleArquivosCobranca] FOREIGN KEY ([IdControleArquivoCob]) REFERENCES [dbo].[ControleArquivosCobranca] ([IdControleArquivoCob]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ReceitasARealizar_MovimentoFinanceiro] FOREIGN KEY ([IdMovimentoFinanceiroCancelamento]) REFERENCES [dbo].[MovimentoFinanceiro] ([IdMovimentoFinanceiro]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ReceitasARealizar_MovimentoFinanceiro_IdMovimentoFinanceiroEfetivacao] FOREIGN KEY ([IdMovimentoFinanceiroEfetivacao]) REFERENCES [dbo].[MovimentoFinanceiro] ([IdMovimentoFinanceiro]),
    CONSTRAINT [FK_ReceitasARealizar_MovimentoFinanceiro_IdMovimentoFinanceiroRetiradaCustodia] FOREIGN KEY ([IdMovimentoFinanceiroRetiradaCustodia]) REFERENCES [dbo].[MovimentoFinanceiro] ([IdMovimentoFinanceiro]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ReceitasARealizar_MovimentoFinanceiro_IdMovimentoFinanceiroTransferencia] FOREIGN KEY ([IdMovimentoFinanceiroTransferencia]) REFERENCES [dbo].[MovimentoFinanceiro] ([IdMovimentoFinanceiro]),
    CONSTRAINT [FK_ReceitasARealizar_MovimentoFinanceiro1] FOREIGN KEY ([IdMovimentoFinanceiroCustodia]) REFERENCES [dbo].[MovimentoFinanceiro] ([IdMovimentoFinanceiro]),
    CONSTRAINT [FK_ReceitasARealizar_MovimentoFinanceiro3] FOREIGN KEY ([IdMovimentoFinanceiroDevolucao]) REFERENCES [dbo].[MovimentoFinanceiro] ([IdMovimentoFinanceiro]),
    CONSTRAINT [FK_ReceitasARealizar_ReceitasARealizar] FOREIGN KEY ([IdReceitaARealizarOrigem]) REFERENCES [dbo].[ReceitasARealizar] ([IdReceitaARealizar]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ReceitasARealizar_RetornoCartoes_IdRetornoCartao] FOREIGN KEY ([IdRetornoCartao]) REFERENCES [dbo].[RetornoCartoes] ([IdRetornoCartao]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ReceitasARealizarChequeSubstituido_ReceitasARealizar] FOREIGN KEY ([IdReceitaARealizarChequeSubstituido]) REFERENCES [dbo].[ReceitasARealizar] ([IdReceitaARealizar]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ReceitasARealizarDevolucao2_MovimentoFinanceiro] FOREIGN KEY ([IdMovimentoFinanceiroDevolucao2]) REFERENCES [dbo].[MovimentoFinanceiro] ([IdMovimentoFinanceiro]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ReceitasARealizarIdContaBancoOriginalChequeSubstituido_PlanoContas] FOREIGN KEY ([IdContaBancoOriginalChequeSubstituido]) REFERENCES [dbo].[PlanoContas] ([IdConta]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ReceitasARealizarQuitacao_MovimentoFinanceiro] FOREIGN KEY ([IdMovimentoFinanceiroQuitacao]) REFERENCES [dbo].[MovimentoFinanceiro] ([IdMovimentoFinanceiro]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ReceitasARealizarReapresentacao_MovimentoFinanceiro] FOREIGN KEY ([IdMovimentoFinanceiroReapresentacao]) REFERENCES [dbo].[MovimentoFinanceiro] ([IdMovimentoFinanceiro]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ReceitasARealizarReintegracao_MovimentoFinanceiro] FOREIGN KEY ([IdMovimentoFinanceiroReintegracao]) REFERENCES [dbo].[MovimentoFinanceiro] ([IdMovimentoFinanceiro]) NOT FOR REPLICATION,
    CONSTRAINT [FkReceitasARealizarLancamentos] FOREIGN KEY ([IdLancamentoDA]) REFERENCES [dbo].[Lancamentos] ([IdLancamento])
);

