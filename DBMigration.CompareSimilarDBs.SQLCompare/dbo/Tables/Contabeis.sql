CREATE TABLE [dbo].[Contabeis] (
    [IdLancamentoContabil]  INT          IDENTITY (1, 1) NOT NULL,
    [IdDebito]              INT          NULL,
    [CodigoMovimentoDebito] VARCHAR (2)  NULL,
    [Exercicio]             VARCHAR (4)  NULL,
    [TipoMovimento]         VARCHAR (1)  NULL,
    [ValorCorrente]         MONEY        NULL,
    [ValorAnterior]         MONEY        NULL,
    [DataEfetiva]           DATETIME     NULL,
    [DataCorrente]          DATETIME     NULL,
    [LocalPagamento]        VARCHAR (1)  NULL,
    [CodigoBanco]           VARCHAR (3)  NULL,
    [CodigoAgencia]         VARCHAR (6)  NULL,
    [ContaCorrente]         VARCHAR (10) NULL,
    [NumeroDocumento]       INT          NULL,
    [Historico]             TEXT         NULL,
    [Tratado]               BIT          NULL,
    [CodigoTipoPessoa]      VARCHAR (1)  NULL,
    CONSTRAINT [PK__CONTABIL__4CF5691D] PRIMARY KEY NONCLUSTERED ([IdLancamentoContabil] ASC),
    CONSTRAINT [FK_CONTABIL_Debito] FOREIGN KEY ([IdDebito]) REFERENCES [dbo].[Debitos] ([IdDebito])
);


GO
CREATE TRIGGER [TrgLog_Contabeis] ON [Implanta_CRPAM].[dbo].[Contabeis] 
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
SET @TableName = 'Contabeis'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLancamentoContabil : «' + RTRIM( ISNULL( CAST (IdLancamentoContabil AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoMovimentoDebito : «' + RTRIM( ISNULL( CAST (CodigoMovimentoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMovimento : «' + RTRIM( ISNULL( CAST (TipoMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCorrente : «' + RTRIM( ISNULL( CAST (ValorCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAnterior : «' + RTRIM( ISNULL( CAST (ValorAnterior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEfetiva : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEfetiva, 113 ),'Nulo'))+'» '
                         + '| DataCorrente : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCorrente, 113 ),'Nulo'))+'» '
                         + '| LocalPagamento : «' + RTRIM( ISNULL( CAST (LocalPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Tratado IS NULL THEN ' Tratado : «Nulo» '
                                              WHEN  Tratado = 0 THEN ' Tratado : «Falso» '
                                              WHEN  Tratado = 1 THEN ' Tratado : «Verdadeiro» '
                                    END 
                         + '| CodigoTipoPessoa : «' + RTRIM( ISNULL( CAST (CodigoTipoPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLancamentoContabil : «' + RTRIM( ISNULL( CAST (IdLancamentoContabil AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoMovimentoDebito : «' + RTRIM( ISNULL( CAST (CodigoMovimentoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMovimento : «' + RTRIM( ISNULL( CAST (TipoMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCorrente : «' + RTRIM( ISNULL( CAST (ValorCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAnterior : «' + RTRIM( ISNULL( CAST (ValorAnterior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEfetiva : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEfetiva, 113 ),'Nulo'))+'» '
                         + '| DataCorrente : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCorrente, 113 ),'Nulo'))+'» '
                         + '| LocalPagamento : «' + RTRIM( ISNULL( CAST (LocalPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Tratado IS NULL THEN ' Tratado : «Nulo» '
                                              WHEN  Tratado = 0 THEN ' Tratado : «Falso» '
                                              WHEN  Tratado = 1 THEN ' Tratado : «Verdadeiro» '
                                    END 
                         + '| CodigoTipoPessoa : «' + RTRIM( ISNULL( CAST (CodigoTipoPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLancamentoContabil : «' + RTRIM( ISNULL( CAST (IdLancamentoContabil AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoMovimentoDebito : «' + RTRIM( ISNULL( CAST (CodigoMovimentoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMovimento : «' + RTRIM( ISNULL( CAST (TipoMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCorrente : «' + RTRIM( ISNULL( CAST (ValorCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAnterior : «' + RTRIM( ISNULL( CAST (ValorAnterior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEfetiva : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEfetiva, 113 ),'Nulo'))+'» '
                         + '| DataCorrente : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCorrente, 113 ),'Nulo'))+'» '
                         + '| LocalPagamento : «' + RTRIM( ISNULL( CAST (LocalPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Tratado IS NULL THEN ' Tratado : «Nulo» '
                                              WHEN  Tratado = 0 THEN ' Tratado : «Falso» '
                                              WHEN  Tratado = 1 THEN ' Tratado : «Verdadeiro» '
                                    END 
                         + '| CodigoTipoPessoa : «' + RTRIM( ISNULL( CAST (CodigoTipoPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLancamentoContabil : «' + RTRIM( ISNULL( CAST (IdLancamentoContabil AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoMovimentoDebito : «' + RTRIM( ISNULL( CAST (CodigoMovimentoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMovimento : «' + RTRIM( ISNULL( CAST (TipoMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCorrente : «' + RTRIM( ISNULL( CAST (ValorCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAnterior : «' + RTRIM( ISNULL( CAST (ValorAnterior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEfetiva : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEfetiva, 113 ),'Nulo'))+'» '
                         + '| DataCorrente : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCorrente, 113 ),'Nulo'))+'» '
                         + '| LocalPagamento : «' + RTRIM( ISNULL( CAST (LocalPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAgencia : «' + RTRIM( ISNULL( CAST (CodigoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Tratado IS NULL THEN ' Tratado : «Nulo» '
                                              WHEN  Tratado = 0 THEN ' Tratado : «Falso» '
                                              WHEN  Tratado = 1 THEN ' Tratado : «Verdadeiro» '
                                    END 
                         + '| CodigoTipoPessoa : «' + RTRIM( ISNULL( CAST (CodigoTipoPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
