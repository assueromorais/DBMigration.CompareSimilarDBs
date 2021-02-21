CREATE TABLE [dbo].[Pagamentos] (
    [IdPagamento]          INT          IDENTITY (1, 1) NOT NULL,
    [IdEmpenho]            INT          NOT NULL,
    [IdFormaPagamento]     INT          NULL,
    [NumeroPagamento]      INT          NOT NULL,
    [AnoExercicio]         SMALLINT     NOT NULL,
    [DataPgto]             DATETIME     NULL,
    [ValorPgto]            MONEY        NULL,
    [DataVencimento]       DATETIME     NULL,
    [ValorPrevisto]        MONEY        NULL,
    [IdLancamento]         INT          NULL,
    [DataModificacao]      DATETIME     NOT NULL,
    [TipoMov]              INT          NOT NULL,
    [SaldoEmp]             MONEY        NOT NULL,
    [IdPagAnulado]         INT          NULL,
    [Historico]            TEXT         NULL,
    [Origem]               VARCHAR (60) NULL,
    [DataImportacao]       DATETIME     NULL,
    [IdContaProvisao]      INT          NULL,
    [DataProvisao]         DATETIME     NULL,
    [IdLancamentoProvisao] INT          NULL,
    [CustoFixo]            BIT          NULL,
    [IdContaDevolucao]     INT          NULL,
    [NumeroProcesso]       VARCHAR (20) NULL,
    [HistoricoProvisao]    TEXT         NULL,
    [UsuarioResponsavel]   VARCHAR (30) NULL,
    [ProvisaoAnulada]      BIT          CONSTRAINT [DF_Pagamentos_ProvisaoAnulada] DEFAULT ((0)) NULL,
    [ValorbaseCalculo]     MONEY        NULL,
    [CalculoTributo]       BIT          CONSTRAINT [DF__Pagamento__Calcu__32024716] DEFAULT ((0)) NOT NULL,
    [DataRefTributo]       DATETIME     NULL,
    [RecalcularTributos]   BIT          CONSTRAINT [DF__Pagamento__Recal__28E2F130] DEFAULT ((1)) NULL,
    [AnularEmpenho]        BIT          CONSTRAINT [DF__Pagamento__Anula__29D71569] DEFAULT ((1)) NULL,
    [IdAnulacaoEmpenho]    INT          NULL,
    CONSTRAINT [PK_Pagamentos] PRIMARY KEY NONCLUSTERED ([IdPagamento] ASC),
    CONSTRAINT [FK_Pagamentos_Empenhos] FOREIGN KEY ([IdEmpenho]) REFERENCES [dbo].[Empenhos] ([IdEmpenho]),
    CONSTRAINT [FK_Pagamentos_FormasPagamento] FOREIGN KEY ([IdFormaPagamento]) REFERENCES [dbo].[FormasPagamento] ([IdFormaPagamento]),
    CONSTRAINT [FK_Pagamentos_Lancamentos] FOREIGN KEY ([IdLancamento]) REFERENCES [dbo].[Lancamentos] ([IdLancamento]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Pagamentos_Lancamentos1] FOREIGN KEY ([IdLancamentoProvisao]) REFERENCES [dbo].[Lancamentos] ([IdLancamento]),
    CONSTRAINT [FK_Pagamentos_Pagamentos] FOREIGN KEY ([IdPagAnulado]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_Pagamentos_PlanoContas] FOREIGN KEY ([IdContaDevolucao]) REFERENCES [dbo].[PlanoContas] ([IdConta]),
    CONSTRAINT [FK_PagamentosContaProvisao_PlanoContas] FOREIGN KEY ([IdContaProvisao]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
ALTER TABLE [dbo].[Pagamentos] NOCHECK CONSTRAINT [FK_Pagamentos_Pagamentos];


GO
CREATE NONCLUSTERED INDEX [IX_Pagamentos_IdContaDevolucao_IdContaProvisao]
    ON [dbo].[Pagamentos]([IdContaDevolucao] ASC, [IdContaProvisao] ASC);


GO
CREATE STATISTICS [STAT_Pagamentos_CalculoTributo_IdContaDevolucao_IdContaProvisao]
    ON [dbo].[Pagamentos]([CalculoTributo], [IdContaDevolucao], [IdContaProvisao]);


GO
CREATE TRIGGER [TrgLog_Pagamentos] ON [Implanta_CRPAM].[dbo].[Pagamentos] 
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
SET @TableName = 'Pagamentos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroPagamento : «' + RTRIM( ISNULL( CAST (NumeroPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPgto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPgto, 113 ),'Nulo'))+'» '
                         + '| ValorPgto : «' + RTRIM( ISNULL( CAST (ValorPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisto : «' + RTRIM( ISNULL( CAST (ValorPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoEmp : «' + RTRIM( ISNULL( CAST (SaldoEmp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagAnulado : «' + RTRIM( ISNULL( CAST (IdPagAnulado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| IdContaProvisao : «' + RTRIM( ISNULL( CAST (IdContaProvisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProvisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProvisao, 113 ),'Nulo'))+'» '
                         + '| IdLancamentoProvisao : «' + RTRIM( ISNULL( CAST (IdLancamentoProvisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CustoFixo IS NULL THEN ' CustoFixo : «Nulo» '
                                              WHEN  CustoFixo = 0 THEN ' CustoFixo : «Falso» '
                                              WHEN  CustoFixo = 1 THEN ' CustoFixo : «Verdadeiro» '
                                    END 
                         + '| IdContaDevolucao : «' + RTRIM( ISNULL( CAST (IdContaDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioResponsavel : «' + RTRIM( ISNULL( CAST (UsuarioResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ProvisaoAnulada IS NULL THEN ' ProvisaoAnulada : «Nulo» '
                                              WHEN  ProvisaoAnulada = 0 THEN ' ProvisaoAnulada : «Falso» '
                                              WHEN  ProvisaoAnulada = 1 THEN ' ProvisaoAnulada : «Verdadeiro» '
                                    END 
                         + '| ValorbaseCalculo : «' + RTRIM( ISNULL( CAST (ValorbaseCalculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CalculoTributo IS NULL THEN ' CalculoTributo : «Nulo» '
                                              WHEN  CalculoTributo = 0 THEN ' CalculoTributo : «Falso» '
                                              WHEN  CalculoTributo = 1 THEN ' CalculoTributo : «Verdadeiro» '
                                    END 
                         + '| DataRefTributo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRefTributo, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RecalcularTributos IS NULL THEN ' RecalcularTributos : «Nulo» '
                                              WHEN  RecalcularTributos = 0 THEN ' RecalcularTributos : «Falso» '
                                              WHEN  RecalcularTributos = 1 THEN ' RecalcularTributos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AnularEmpenho IS NULL THEN ' AnularEmpenho : «Nulo» '
                                              WHEN  AnularEmpenho = 0 THEN ' AnularEmpenho : «Falso» '
                                              WHEN  AnularEmpenho = 1 THEN ' AnularEmpenho : «Verdadeiro» '
                                    END 
                         + '| IdAnulacaoEmpenho : «' + RTRIM( ISNULL( CAST (IdAnulacaoEmpenho AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroPagamento : «' + RTRIM( ISNULL( CAST (NumeroPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPgto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPgto, 113 ),'Nulo'))+'» '
                         + '| ValorPgto : «' + RTRIM( ISNULL( CAST (ValorPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisto : «' + RTRIM( ISNULL( CAST (ValorPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoEmp : «' + RTRIM( ISNULL( CAST (SaldoEmp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagAnulado : «' + RTRIM( ISNULL( CAST (IdPagAnulado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| IdContaProvisao : «' + RTRIM( ISNULL( CAST (IdContaProvisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProvisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProvisao, 113 ),'Nulo'))+'» '
                         + '| IdLancamentoProvisao : «' + RTRIM( ISNULL( CAST (IdLancamentoProvisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CustoFixo IS NULL THEN ' CustoFixo : «Nulo» '
                                              WHEN  CustoFixo = 0 THEN ' CustoFixo : «Falso» '
                                              WHEN  CustoFixo = 1 THEN ' CustoFixo : «Verdadeiro» '
                                    END 
                         + '| IdContaDevolucao : «' + RTRIM( ISNULL( CAST (IdContaDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioResponsavel : «' + RTRIM( ISNULL( CAST (UsuarioResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ProvisaoAnulada IS NULL THEN ' ProvisaoAnulada : «Nulo» '
                                              WHEN  ProvisaoAnulada = 0 THEN ' ProvisaoAnulada : «Falso» '
                                              WHEN  ProvisaoAnulada = 1 THEN ' ProvisaoAnulada : «Verdadeiro» '
                                    END 
                         + '| ValorbaseCalculo : «' + RTRIM( ISNULL( CAST (ValorbaseCalculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CalculoTributo IS NULL THEN ' CalculoTributo : «Nulo» '
                                              WHEN  CalculoTributo = 0 THEN ' CalculoTributo : «Falso» '
                                              WHEN  CalculoTributo = 1 THEN ' CalculoTributo : «Verdadeiro» '
                                    END 
                         + '| DataRefTributo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRefTributo, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RecalcularTributos IS NULL THEN ' RecalcularTributos : «Nulo» '
                                              WHEN  RecalcularTributos = 0 THEN ' RecalcularTributos : «Falso» '
                                              WHEN  RecalcularTributos = 1 THEN ' RecalcularTributos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AnularEmpenho IS NULL THEN ' AnularEmpenho : «Nulo» '
                                              WHEN  AnularEmpenho = 0 THEN ' AnularEmpenho : «Falso» '
                                              WHEN  AnularEmpenho = 1 THEN ' AnularEmpenho : «Verdadeiro» '
                                    END 
                         + '| IdAnulacaoEmpenho : «' + RTRIM( ISNULL( CAST (IdAnulacaoEmpenho AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroPagamento : «' + RTRIM( ISNULL( CAST (NumeroPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPgto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPgto, 113 ),'Nulo'))+'» '
                         + '| ValorPgto : «' + RTRIM( ISNULL( CAST (ValorPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisto : «' + RTRIM( ISNULL( CAST (ValorPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoEmp : «' + RTRIM( ISNULL( CAST (SaldoEmp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagAnulado : «' + RTRIM( ISNULL( CAST (IdPagAnulado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| IdContaProvisao : «' + RTRIM( ISNULL( CAST (IdContaProvisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProvisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProvisao, 113 ),'Nulo'))+'» '
                         + '| IdLancamentoProvisao : «' + RTRIM( ISNULL( CAST (IdLancamentoProvisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CustoFixo IS NULL THEN ' CustoFixo : «Nulo» '
                                              WHEN  CustoFixo = 0 THEN ' CustoFixo : «Falso» '
                                              WHEN  CustoFixo = 1 THEN ' CustoFixo : «Verdadeiro» '
                                    END 
                         + '| IdContaDevolucao : «' + RTRIM( ISNULL( CAST (IdContaDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioResponsavel : «' + RTRIM( ISNULL( CAST (UsuarioResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ProvisaoAnulada IS NULL THEN ' ProvisaoAnulada : «Nulo» '
                                              WHEN  ProvisaoAnulada = 0 THEN ' ProvisaoAnulada : «Falso» '
                                              WHEN  ProvisaoAnulada = 1 THEN ' ProvisaoAnulada : «Verdadeiro» '
                                    END 
                         + '| ValorbaseCalculo : «' + RTRIM( ISNULL( CAST (ValorbaseCalculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CalculoTributo IS NULL THEN ' CalculoTributo : «Nulo» '
                                              WHEN  CalculoTributo = 0 THEN ' CalculoTributo : «Falso» '
                                              WHEN  CalculoTributo = 1 THEN ' CalculoTributo : «Verdadeiro» '
                                    END 
                         + '| DataRefTributo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRefTributo, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RecalcularTributos IS NULL THEN ' RecalcularTributos : «Nulo» '
                                              WHEN  RecalcularTributos = 0 THEN ' RecalcularTributos : «Falso» '
                                              WHEN  RecalcularTributos = 1 THEN ' RecalcularTributos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AnularEmpenho IS NULL THEN ' AnularEmpenho : «Nulo» '
                                              WHEN  AnularEmpenho = 0 THEN ' AnularEmpenho : «Falso» '
                                              WHEN  AnularEmpenho = 1 THEN ' AnularEmpenho : «Verdadeiro» '
                                    END 
                         + '| IdAnulacaoEmpenho : «' + RTRIM( ISNULL( CAST (IdAnulacaoEmpenho AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroPagamento : «' + RTRIM( ISNULL( CAST (NumeroPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPgto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPgto, 113 ),'Nulo'))+'» '
                         + '| ValorPgto : «' + RTRIM( ISNULL( CAST (ValorPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisto : «' + RTRIM( ISNULL( CAST (ValorPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoEmp : «' + RTRIM( ISNULL( CAST (SaldoEmp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagAnulado : «' + RTRIM( ISNULL( CAST (IdPagAnulado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| IdContaProvisao : «' + RTRIM( ISNULL( CAST (IdContaProvisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProvisao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProvisao, 113 ),'Nulo'))+'» '
                         + '| IdLancamentoProvisao : «' + RTRIM( ISNULL( CAST (IdLancamentoProvisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CustoFixo IS NULL THEN ' CustoFixo : «Nulo» '
                                              WHEN  CustoFixo = 0 THEN ' CustoFixo : «Falso» '
                                              WHEN  CustoFixo = 1 THEN ' CustoFixo : «Verdadeiro» '
                                    END 
                         + '| IdContaDevolucao : «' + RTRIM( ISNULL( CAST (IdContaDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioResponsavel : «' + RTRIM( ISNULL( CAST (UsuarioResponsavel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ProvisaoAnulada IS NULL THEN ' ProvisaoAnulada : «Nulo» '
                                              WHEN  ProvisaoAnulada = 0 THEN ' ProvisaoAnulada : «Falso» '
                                              WHEN  ProvisaoAnulada = 1 THEN ' ProvisaoAnulada : «Verdadeiro» '
                                    END 
                         + '| ValorbaseCalculo : «' + RTRIM( ISNULL( CAST (ValorbaseCalculo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CalculoTributo IS NULL THEN ' CalculoTributo : «Nulo» '
                                              WHEN  CalculoTributo = 0 THEN ' CalculoTributo : «Falso» '
                                              WHEN  CalculoTributo = 1 THEN ' CalculoTributo : «Verdadeiro» '
                                    END 
                         + '| DataRefTributo : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRefTributo, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RecalcularTributos IS NULL THEN ' RecalcularTributos : «Nulo» '
                                              WHEN  RecalcularTributos = 0 THEN ' RecalcularTributos : «Falso» '
                                              WHEN  RecalcularTributos = 1 THEN ' RecalcularTributos : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AnularEmpenho IS NULL THEN ' AnularEmpenho : «Nulo» '
                                              WHEN  AnularEmpenho = 0 THEN ' AnularEmpenho : «Falso» '
                                              WHEN  AnularEmpenho = 1 THEN ' AnularEmpenho : «Verdadeiro» '
                                    END 
                         + '| IdAnulacaoEmpenho : «' + RTRIM( ISNULL( CAST (IdAnulacaoEmpenho AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
