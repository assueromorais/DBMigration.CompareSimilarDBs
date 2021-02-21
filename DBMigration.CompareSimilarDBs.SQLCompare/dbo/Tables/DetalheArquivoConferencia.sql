CREATE TABLE [dbo].[DetalheArquivoConferencia] (
    [IdDetalheArquivo]            INT      IDENTITY (1, 1) NOT NULL,
    [IdArquivoConferencia]        INT      NULL,
    [NumeroConvenio]              CHAR (7) NULL,
    [DataLiquidacao]              DATETIME NULL,
    [DataCredito]                 DATETIME NULL,
    [ValorRecebido]               MONEY    NULL,
    [ValorLancamento]             MONEY    NULL,
    [IndicativoCompartilhamento]  INT      NULL,
    [ValorOriginal]               MONEY    NULL,
    [NumeroConvenioCompartilhado] CHAR (7) NULL,
    [ValorCompartilhado]          MONEY    NULL,
    [CanalPagamento]              INT      NULL,
    [CustoDespesa]                INT      NULL,
    [Tarifa]                      INT      NULL,
    [OutrasDespesas]              INT      NULL,
    [JurosDesconto]               INT      NULL,
    [IofDesconto]                 INT      NULL,
    [ValorAbatimento]             INT      NULL,
    [DescontoConcedido]           INT      NULL,
    [JurosMora]                   INT      NULL,
    [OutrosRecebimentos]          INT      NULL,
    [LinhaArquivo]                INT      NULL,
    [ValorRecebidoTotal]          MONEY    NULL,
    CONSTRAINT [PK_DetalheArquivoConferencia] PRIMARY KEY CLUSTERED ([IdDetalheArquivo] ASC),
    CONSTRAINT [FK_DetalheArquivoConferencia_ControleArquivoConferencia] FOREIGN KEY ([IdArquivoConferencia]) REFERENCES [dbo].[ControleArquivoConferencia] ([IdArquivoConferencia])
);


GO
CREATE TRIGGER [TrgLog_DetalheArquivoConferencia] ON [Implanta_CRPAM].[dbo].[DetalheArquivoConferencia] 
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
SET @TableName = 'DetalheArquivoConferencia'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDetalheArquivo : «' + RTRIM( ISNULL( CAST (IdDetalheArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoConferencia : «' + RTRIM( ISNULL( CAST (IdArquivoConferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroConvenio : «' + RTRIM( ISNULL( CAST (NumeroConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLiquidacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLiquidacao, 113 ),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| ValorRecebido : «' + RTRIM( ISNULL( CAST (ValorRecebido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorLancamento : «' + RTRIM( ISNULL( CAST (ValorLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoCompartilhamento : «' + RTRIM( ISNULL( CAST (IndicativoCompartilhamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorOriginal : «' + RTRIM( ISNULL( CAST (ValorOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroConvenioCompartilhado : «' + RTRIM( ISNULL( CAST (NumeroConvenioCompartilhado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCompartilhado : «' + RTRIM( ISNULL( CAST (ValorCompartilhado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanalPagamento : «' + RTRIM( ISNULL( CAST (CanalPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CustoDespesa : «' + RTRIM( ISNULL( CAST (CustoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tarifa : «' + RTRIM( ISNULL( CAST (Tarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OutrasDespesas : «' + RTRIM( ISNULL( CAST (OutrasDespesas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurosDesconto : «' + RTRIM( ISNULL( CAST (JurosDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IofDesconto : «' + RTRIM( ISNULL( CAST (IofDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAbatimento : «' + RTRIM( ISNULL( CAST (ValorAbatimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoConcedido : «' + RTRIM( ISNULL( CAST (DescontoConcedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurosMora : «' + RTRIM( ISNULL( CAST (JurosMora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OutrosRecebimentos : «' + RTRIM( ISNULL( CAST (OutrosRecebimentos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinhaArquivo : «' + RTRIM( ISNULL( CAST (LinhaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorRecebidoTotal : «' + RTRIM( ISNULL( CAST (ValorRecebidoTotal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDetalheArquivo : «' + RTRIM( ISNULL( CAST (IdDetalheArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoConferencia : «' + RTRIM( ISNULL( CAST (IdArquivoConferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroConvenio : «' + RTRIM( ISNULL( CAST (NumeroConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLiquidacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLiquidacao, 113 ),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| ValorRecebido : «' + RTRIM( ISNULL( CAST (ValorRecebido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorLancamento : «' + RTRIM( ISNULL( CAST (ValorLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoCompartilhamento : «' + RTRIM( ISNULL( CAST (IndicativoCompartilhamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorOriginal : «' + RTRIM( ISNULL( CAST (ValorOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroConvenioCompartilhado : «' + RTRIM( ISNULL( CAST (NumeroConvenioCompartilhado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCompartilhado : «' + RTRIM( ISNULL( CAST (ValorCompartilhado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanalPagamento : «' + RTRIM( ISNULL( CAST (CanalPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CustoDespesa : «' + RTRIM( ISNULL( CAST (CustoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tarifa : «' + RTRIM( ISNULL( CAST (Tarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OutrasDespesas : «' + RTRIM( ISNULL( CAST (OutrasDespesas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurosDesconto : «' + RTRIM( ISNULL( CAST (JurosDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IofDesconto : «' + RTRIM( ISNULL( CAST (IofDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAbatimento : «' + RTRIM( ISNULL( CAST (ValorAbatimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoConcedido : «' + RTRIM( ISNULL( CAST (DescontoConcedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurosMora : «' + RTRIM( ISNULL( CAST (JurosMora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OutrosRecebimentos : «' + RTRIM( ISNULL( CAST (OutrosRecebimentos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinhaArquivo : «' + RTRIM( ISNULL( CAST (LinhaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorRecebidoTotal : «' + RTRIM( ISNULL( CAST (ValorRecebidoTotal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDetalheArquivo : «' + RTRIM( ISNULL( CAST (IdDetalheArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoConferencia : «' + RTRIM( ISNULL( CAST (IdArquivoConferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroConvenio : «' + RTRIM( ISNULL( CAST (NumeroConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLiquidacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLiquidacao, 113 ),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| ValorRecebido : «' + RTRIM( ISNULL( CAST (ValorRecebido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorLancamento : «' + RTRIM( ISNULL( CAST (ValorLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoCompartilhamento : «' + RTRIM( ISNULL( CAST (IndicativoCompartilhamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorOriginal : «' + RTRIM( ISNULL( CAST (ValorOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroConvenioCompartilhado : «' + RTRIM( ISNULL( CAST (NumeroConvenioCompartilhado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCompartilhado : «' + RTRIM( ISNULL( CAST (ValorCompartilhado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanalPagamento : «' + RTRIM( ISNULL( CAST (CanalPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CustoDespesa : «' + RTRIM( ISNULL( CAST (CustoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tarifa : «' + RTRIM( ISNULL( CAST (Tarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OutrasDespesas : «' + RTRIM( ISNULL( CAST (OutrasDespesas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurosDesconto : «' + RTRIM( ISNULL( CAST (JurosDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IofDesconto : «' + RTRIM( ISNULL( CAST (IofDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAbatimento : «' + RTRIM( ISNULL( CAST (ValorAbatimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoConcedido : «' + RTRIM( ISNULL( CAST (DescontoConcedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurosMora : «' + RTRIM( ISNULL( CAST (JurosMora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OutrosRecebimentos : «' + RTRIM( ISNULL( CAST (OutrosRecebimentos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinhaArquivo : «' + RTRIM( ISNULL( CAST (LinhaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorRecebidoTotal : «' + RTRIM( ISNULL( CAST (ValorRecebidoTotal AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDetalheArquivo : «' + RTRIM( ISNULL( CAST (IdDetalheArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivoConferencia : «' + RTRIM( ISNULL( CAST (IdArquivoConferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroConvenio : «' + RTRIM( ISNULL( CAST (NumeroConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLiquidacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLiquidacao, 113 ),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» '
                         + '| ValorRecebido : «' + RTRIM( ISNULL( CAST (ValorRecebido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorLancamento : «' + RTRIM( ISNULL( CAST (ValorLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoCompartilhamento : «' + RTRIM( ISNULL( CAST (IndicativoCompartilhamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorOriginal : «' + RTRIM( ISNULL( CAST (ValorOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroConvenioCompartilhado : «' + RTRIM( ISNULL( CAST (NumeroConvenioCompartilhado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCompartilhado : «' + RTRIM( ISNULL( CAST (ValorCompartilhado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CanalPagamento : «' + RTRIM( ISNULL( CAST (CanalPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CustoDespesa : «' + RTRIM( ISNULL( CAST (CustoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tarifa : «' + RTRIM( ISNULL( CAST (Tarifa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OutrasDespesas : «' + RTRIM( ISNULL( CAST (OutrasDespesas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurosDesconto : «' + RTRIM( ISNULL( CAST (JurosDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IofDesconto : «' + RTRIM( ISNULL( CAST (IofDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAbatimento : «' + RTRIM( ISNULL( CAST (ValorAbatimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescontoConcedido : «' + RTRIM( ISNULL( CAST (DescontoConcedido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| JurosMora : «' + RTRIM( ISNULL( CAST (JurosMora AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OutrosRecebimentos : «' + RTRIM( ISNULL( CAST (OutrosRecebimentos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinhaArquivo : «' + RTRIM( ISNULL( CAST (LinhaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorRecebidoTotal : «' + RTRIM( ISNULL( CAST (ValorRecebidoTotal AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
