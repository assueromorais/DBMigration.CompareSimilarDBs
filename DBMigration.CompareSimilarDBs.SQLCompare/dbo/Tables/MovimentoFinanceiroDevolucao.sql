CREATE TABLE [dbo].[MovimentoFinanceiroDevolucao] (
    [IdMovimentoFinanceiro]          INT      NOT NULL,
    [IdLancamentoDevolucao]          INT      NULL,
    [DataDevolucao]                  DATETIME NOT NULL,
    [ValorDevolucao]                 MONEY    NOT NULL,
    [IdMovimentoFinanceiroDevolucao] INT      NULL,
    [IdMovimentoFinanceiroRetencao]  INT      NULL,
    CONSTRAINT [PK_MovimentoFinanceiroDevolucao] PRIMARY KEY CLUSTERED ([IdMovimentoFinanceiro] ASC, [DataDevolucao] ASC),
    CONSTRAINT [FK_MovimentoFinanceiroDevolucao_Movimento] FOREIGN KEY ([IdMovimentoFinanceiro]) REFERENCES [dbo].[MovimentoFinanceiro] ([IdMovimentoFinanceiro])
);


GO
CREATE TRIGGER [TrgLog_MovimentoFinanceiroDevolucao] ON [Implanta_CRPAM].[dbo].[MovimentoFinanceiroDevolucao] 
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
SET @TableName = 'MovimentoFinanceiroDevolucao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoDevolucao : «' + RTRIM( ISNULL( CAST (IdLancamentoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDevolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucao, 113 ),'Nulo'))+'» '
                         + '| ValorDevolucao : «' + RTRIM( ISNULL( CAST (ValorDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiroDevolucao : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiroDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiroRetencao : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiroRetencao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoDevolucao : «' + RTRIM( ISNULL( CAST (IdLancamentoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDevolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucao, 113 ),'Nulo'))+'» '
                         + '| ValorDevolucao : «' + RTRIM( ISNULL( CAST (ValorDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiroDevolucao : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiroDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiroRetencao : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiroRetencao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoDevolucao : «' + RTRIM( ISNULL( CAST (IdLancamentoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDevolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucao, 113 ),'Nulo'))+'» '
                         + '| ValorDevolucao : «' + RTRIM( ISNULL( CAST (ValorDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiroDevolucao : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiroDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiroRetencao : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiroRetencao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamentoDevolucao : «' + RTRIM( ISNULL( CAST (IdLancamentoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDevolucao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucao, 113 ),'Nulo'))+'» '
                         + '| ValorDevolucao : «' + RTRIM( ISNULL( CAST (ValorDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiroDevolucao : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiroDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiroRetencao : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiroRetencao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
