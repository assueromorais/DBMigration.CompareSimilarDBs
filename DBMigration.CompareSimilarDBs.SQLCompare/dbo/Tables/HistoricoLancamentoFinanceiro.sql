CREATE TABLE [dbo].[HistoricoLancamentoFinanceiro] (
    [IdHistoricoLancamentoFinanceiro] INT          IDENTITY (1, 1) NOT NULL,
    [IdLancamentoFinanceiro]          INT          NOT NULL,
    [Banco]                           VARCHAR (20) NULL,
    [Agencia]                         VARCHAR (20) NULL,
    [Conta]                           VARCHAR (20) NULL,
    [IdFormaCredito]                  INT          NULL,
    PRIMARY KEY CLUSTERED ([IdHistoricoLancamentoFinanceiro] ASC),
    FOREIGN KEY ([IdFormaCredito]) REFERENCES [dbo].[FormasCredito] ([IdFormaCredito]),
    FOREIGN KEY ([IdLancamentoFinanceiro]) REFERENCES [dbo].[LancamentosFinanceiros] ([IdLancamentoFinanceiro]) ON DELETE CASCADE
);


GO
CREATE TRIGGER [TrgLog_HistoricoLancamentoFinanceiro] ON [Implanta_CRPAM].[dbo].[HistoricoLancamentoFinanceiro] 
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
SET @TableName = 'HistoricoLancamentoFinanceiro'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistoricoLancamentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdHistoricoLancamentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdLancamentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaCredito : «' + RTRIM( ISNULL( CAST (IdFormaCredito AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistoricoLancamentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdHistoricoLancamentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdLancamentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaCredito : «' + RTRIM( ISNULL( CAST (IdFormaCredito AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistoricoLancamentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdHistoricoLancamentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdLancamentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaCredito : «' + RTRIM( ISNULL( CAST (IdFormaCredito AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistoricoLancamentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdHistoricoLancamentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdLancamentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaCredito : «' + RTRIM( ISNULL( CAST (IdFormaCredito AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
