CREATE TABLE [dbo].[LancamentosConciliados] (
    [IdLancamento]     INT IDENTITY (1, 1) NOT NULL,
    [IdArquivo]        INT NULL,
    [IdFormaPagamento] INT NULL,
    [IdReceita]        INT NULL,
    [Linha]            INT NULL,
    CONSTRAINT [PK_LancamentosConciliados] PRIMARY KEY CLUSTERED ([IdLancamento] ASC),
    CONSTRAINT [FK_LancamentosConciliados_ControleArquivos] FOREIGN KEY ([IdArquivo]) REFERENCES [dbo].[ControleArquivos] ([IdArquivo]),
    CONSTRAINT [FK_LancamentosConciliados_FormasPagamento] FOREIGN KEY ([IdFormaPagamento]) REFERENCES [dbo].[FormasPagamento] ([IdFormaPagamento]),
    CONSTRAINT [FK_LancamentosConciliados_Receitas] FOREIGN KEY ([IdReceita]) REFERENCES [dbo].[Receitas] ([IdReceita])
);


GO
CREATE TRIGGER [TrgLog_LancamentosConciliados] ON [Implanta_CRPAM].[dbo].[LancamentosConciliados] 
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
SET @TableName = 'LancamentosConciliados'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Linha : «' + RTRIM( ISNULL( CAST (Linha AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Linha : «' + RTRIM( ISNULL( CAST (Linha AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Linha : «' + RTRIM( ISNULL( CAST (Linha AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagamento : «' + RTRIM( ISNULL( CAST (IdFormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdReceita : «' + RTRIM( ISNULL( CAST (IdReceita AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Linha : «' + RTRIM( ISNULL( CAST (Linha AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
