CREATE TABLE [dbo].[HistoricosExtrato] (
    [IdHistorico]     INT           IDENTITY (1, 1) NOT NULL,
    [CodHistorico]    CHAR (4)      NULL,
    [Historico]       VARCHAR (250) NULL,
    [Transacao]       CHAR (3)      NULL,
    [IdCentroCusto]   INT           NULL,
    [IdTipoPagamento] INT           NULL,
    [Exercicio]       VARCHAR (4)   NULL,
    CONSTRAINT [PK_HistoricosExtrato] PRIMARY KEY CLUSTERED ([IdHistorico] ASC),
    CONSTRAINT [FK_HistoricosExtrato_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_HistoricosExtrato_TiposPagamentos] FOREIGN KEY ([IdTipoPagamento]) REFERENCES [dbo].[TiposPagamentos] ([IdTipoPagamento])
);


GO
CREATE TRIGGER [TrgLog_HistoricosExtrato] ON [Implanta_CRPAM].[dbo].[HistoricosExtrato] 
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
SET @TableName = 'HistoricosExtrato'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistorico : «' + RTRIM( ISNULL( CAST (IdHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodHistorico : «' + RTRIM( ISNULL( CAST (CodHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Transacao : «' + RTRIM( ISNULL( CAST (Transacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistorico : «' + RTRIM( ISNULL( CAST (IdHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodHistorico : «' + RTRIM( ISNULL( CAST (CodHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Transacao : «' + RTRIM( ISNULL( CAST (Transacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistorico : «' + RTRIM( ISNULL( CAST (IdHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodHistorico : «' + RTRIM( ISNULL( CAST (CodHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Transacao : «' + RTRIM( ISNULL( CAST (Transacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistorico : «' + RTRIM( ISNULL( CAST (IdHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodHistorico : «' + RTRIM( ISNULL( CAST (CodHistorico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Transacao : «' + RTRIM( ISNULL( CAST (Transacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
