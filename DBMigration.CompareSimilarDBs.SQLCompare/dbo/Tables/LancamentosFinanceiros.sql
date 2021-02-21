CREATE TABLE [dbo].[LancamentosFinanceiros] (
    [IdLancamentoFinanceiro]              INT          IDENTITY (1, 1) NOT NULL,
    [IdContaFinanceira]                   INT          NOT NULL,
    [IdContaFinanceiraDestino]            INT          NULL,
    [IdPessoa]                            INT          NULL,
    [IdFormaPagamento]                    INT          NULL,
    [IdLancamentoFinanceiroTransferencia] INT          NULL,
    [DataPrevisao]                        DATETIME     NULL,
    [ValorPrevisao]                       MONEY        NULL,
    [DataExecucao]                        DATETIME     NULL,
    [ValorExecucao]                       MONEY        NULL,
    [Origem]                              TEXT         NULL,
    [TipoInvestimento]                    TEXT         NULL,
    [NumeroCotas]                         VARCHAR (50) NULL,
    [Observacao]                          TEXT         NULL,
    [Transferencia]                       BIT          NOT NULL,
    [Processo]                            VARCHAR (30) NULL,
    [NotaFiscal]                          VARCHAR (30) NULL,
    [IdPagamento]                         INT          NULL,
    [IdReceita]                           INT          NULL,
    [IdMovimentoFinanceiro]               INT          NULL,
    [IdTributo]                           INT          NULL,
    [IdRestosPagamento]                   INT          NULL,
    CONSTRAINT [PK_LancamentosFinanceiros] PRIMARY KEY CLUSTERED ([IdLancamentoFinanceiro] ASC),
    CONSTRAINT [FK_LancamentosFinanceiros_LancamentosFinanceiros] FOREIGN KEY ([IdLancamentoFinanceiroTransferencia]) REFERENCES [dbo].[LancamentosFinanceiros] ([IdLancamentoFinanceiro]) NOT FOR REPLICATION,
    CONSTRAINT [FK_LancamentosFinanceiros_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_LancamentosFinanceiros_PlanoContasFinanceiro] FOREIGN KEY ([IdContaFinanceira]) REFERENCES [dbo].[PlanoContasFinanceiro] ([IdContaFinanceira]) NOT FOR REPLICATION,
    CONSTRAINT [FK_LancamentosFinanceiros_PlanoContasFinanceiro1] FOREIGN KEY ([IdContaFinanceiraDestino]) REFERENCES [dbo].[PlanoContasFinanceiro] ([IdContaFinanceira]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[LancamentosFinanceiros] NOCHECK CONSTRAINT [FK_LancamentosFinanceiros_Pessoas];


GO
CREATE TRIGGER [TrgLog_LancamentosFinanceiros] ON [Implanta_CRPAM].[dbo].[LancamentosFinanceiros] 
FOR INSERT, UPDATE, DELETE 
AS 
DECLARE 	@CountI		Integer 
DECLARE 	@CountD		Integer 
DECLARE 	@TipoOperacao 	VARCHAR(9) 
DECLARE 	@TableName 	VARCHAR(50) 
DECLARE 	@Conteudo 	VARCHAR(3700) 
DECLARE 	@Conteudo2 	VARCHAR(3700) 
SELECT @CountI = COUNT(*) FROM INSERTED 
SELECT @CountD = COUNT(*) FROM DELETED 
SET @TipoOperacao = Null 
SET @Conteudo = Null 
SET @Conteudo2 = Null 
SET @TableName = 'LancamentosFinanceiros'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLancamentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdLancamentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaFinanceira : «' + RTRIM( ISNULL( CAST (IdContaFinanceira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaFinanceiraDestino : «' + RTRIM( ISNULL( CAST (IdContaFinanceiraDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoFinanceiroTransferencia : «' + RTRIM( ISNULL( CAST (IdLancamentoFinanceiroTransferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevisao, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisao : «' + RTRIM( ISNULL( CAST (ValorPrevisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExecucao, 113 ),'Nulo'))+'» '
                         + '| ValorExecucao : «' + RTRIM( ISNULL( CAST (ValorExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCotas : «' + RTRIM( ISNULL( CAST (NumeroCotas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Transferencia IS NULL THEN ' Transferencia : «Nulo» '
                                              WHEN  Transferencia = 0 THEN ' Transferencia : «Falso» '
                                              WHEN  Transferencia = 1 THEN ' Transferencia : «Verdadeiro» '
                                    END 
                         + '| Processo : «' + RTRIM( ISNULL( CAST (Processo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTributo : «' + RTRIM( ISNULL( CAST (IdTributo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLancamentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdLancamentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaFinanceira : «' + RTRIM( ISNULL( CAST (IdContaFinanceira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaFinanceiraDestino : «' + RTRIM( ISNULL( CAST (IdContaFinanceiraDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoFinanceiroTransferencia : «' + RTRIM( ISNULL( CAST (IdLancamentoFinanceiroTransferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevisao, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisao : «' + RTRIM( ISNULL( CAST (ValorPrevisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExecucao, 113 ),'Nulo'))+'» '
                         + '| ValorExecucao : «' + RTRIM( ISNULL( CAST (ValorExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCotas : «' + RTRIM( ISNULL( CAST (NumeroCotas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Transferencia IS NULL THEN ' Transferencia : «Nulo» '
                                              WHEN  Transferencia = 0 THEN ' Transferencia : «Falso» '
                                              WHEN  Transferencia = 1 THEN ' Transferencia : «Verdadeiro» '
                                    END 
                         + '| Processo : «' + RTRIM( ISNULL( CAST (Processo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTributo : «' + RTRIM( ISNULL( CAST (IdTributo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
   IF @Conteudo <> @Conteudo2 
   BEGIN 
		INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, Conteudo2, NomeBanco) 
		VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, @Conteudo2, DB_NAME()) 
   END 
END 
ELSE 
BEGIN 
   IF    @CountI    =    1 
	BEGIN 
		SET @TipoOperacao = 'Inclusão' 
		SELECT @Conteudo = 'IdLancamentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdLancamentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaFinanceira : «' + RTRIM( ISNULL( CAST (IdContaFinanceira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaFinanceiraDestino : «' + RTRIM( ISNULL( CAST (IdContaFinanceiraDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoFinanceiroTransferencia : «' + RTRIM( ISNULL( CAST (IdLancamentoFinanceiroTransferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevisao, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisao : «' + RTRIM( ISNULL( CAST (ValorPrevisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExecucao, 113 ),'Nulo'))+'» '
                         + '| ValorExecucao : «' + RTRIM( ISNULL( CAST (ValorExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCotas : «' + RTRIM( ISNULL( CAST (NumeroCotas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Transferencia IS NULL THEN ' Transferencia : «Nulo» '
                                              WHEN  Transferencia = 0 THEN ' Transferencia : «Falso» '
                                              WHEN  Transferencia = 1 THEN ' Transferencia : «Verdadeiro» '
                                    END 
                         + '| Processo : «' + RTRIM( ISNULL( CAST (Processo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTributo : «' + RTRIM( ISNULL( CAST (IdTributo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLancamentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdLancamentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaFinanceira : «' + RTRIM( ISNULL( CAST (IdContaFinanceira AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaFinanceiraDestino : «' + RTRIM( ISNULL( CAST (IdContaFinanceiraDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoFinanceiroTransferencia : «' + RTRIM( ISNULL( CAST (IdLancamentoFinanceiroTransferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrevisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevisao, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisao : «' + RTRIM( ISNULL( CAST (ValorPrevisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataExecucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataExecucao, 113 ),'Nulo'))+'» '
                         + '| ValorExecucao : «' + RTRIM( ISNULL( CAST (ValorExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCotas : «' + RTRIM( ISNULL( CAST (NumeroCotas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Transferencia IS NULL THEN ' Transferencia : «Nulo» '
                                              WHEN  Transferencia = 0 THEN ' Transferencia : «Falso» '
                                              WHEN  Transferencia = 1 THEN ' Transferencia : «Verdadeiro» '
                                    END 
                         + '| Processo : «' + RTRIM( ISNULL( CAST (Processo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTributo : «' + RTRIM( ISNULL( CAST (IdTributo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
