CREATE TABLE [dbo].[AdiantamentoSolicitacao] (
    [IdAdiantamentoSolicitacao] INT      IDENTITY (1, 1) NOT NULL,
    [IdEvento]                  INT      NULL,
    [DataSolicitacao]           DATETIME CONSTRAINT [DF_AdiantamentoSolicitacao_DataSolicitacao] DEFAULT (getdate()) NULL,
    [ValorAdiantamento]         MONEY    NULL,
    [IdMovimentoFinanceiro]     INT      NULL,
    CONSTRAINT [PK_AdiantamentoSolicitacao] PRIMARY KEY CLUSTERED ([IdAdiantamentoSolicitacao] ASC),
    CONSTRAINT [FK_AdiantamentoSolicitacao_EventosSispad] FOREIGN KEY ([IdEvento]) REFERENCES [dbo].[EventosSispad] ([IdEvento]),
    CONSTRAINT [FK_AdiantamentoSolicitacao_MovimentoFinanceiro] FOREIGN KEY ([IdMovimentoFinanceiro]) REFERENCES [dbo].[MovimentoFinanceiro] ([IdMovimentoFinanceiro])
);


GO
CREATE TRIGGER [TrgLog_AdiantamentoSolicitacao] ON [Implanta_CRPAM].[dbo].[AdiantamentoSolicitacao] 
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
SET @TableName = 'AdiantamentoSolicitacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAdiantamentoSolicitacao : «' + RTRIM( ISNULL( CAST (IdAdiantamentoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» '
                         + '| ValorAdiantamento : «' + RTRIM( ISNULL( CAST (ValorAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAdiantamentoSolicitacao : «' + RTRIM( ISNULL( CAST (IdAdiantamentoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» '
                         + '| ValorAdiantamento : «' + RTRIM( ISNULL( CAST (ValorAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAdiantamentoSolicitacao : «' + RTRIM( ISNULL( CAST (IdAdiantamentoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» '
                         + '| ValorAdiantamento : «' + RTRIM( ISNULL( CAST (ValorAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAdiantamentoSolicitacao : «' + RTRIM( ISNULL( CAST (IdAdiantamentoSolicitacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataSolicitacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataSolicitacao, 113 ),'Nulo'))+'» '
                         + '| ValorAdiantamento : «' + RTRIM( ISNULL( CAST (ValorAdiantamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMovimentoFinanceiro : «' + RTRIM( ISNULL( CAST (IdMovimentoFinanceiro AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
