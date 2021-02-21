CREATE TABLE [dbo].[LancamentosExtratos] (
    [IdLancamentoExtrato] INT          IDENTITY (1, 1) NOT NULL,
    [IdBanco]             INT          NULL,
    [IdArquivo]           INT          NULL,
    [DataLancamento]      DATETIME     NULL,
    [ValorLancamento]     MONEY        NULL,
    [TipoLancamento]      CHAR (1)     NULL,
    [CategoriaLancamento] CHAR (3)     NULL,
    [CodigoLancamento]    CHAR (4)     NULL,
    [Historico]           VARCHAR (25) NULL,
    [NumDoc]              VARCHAR (20) NULL,
    [FITID]               VARCHAR (50) NULL,
    [IdImportacao]        VARCHAR (14) NULL,
    CONSTRAINT [PK_LancamentosExtratos] PRIMARY KEY CLUSTERED ([IdLancamentoExtrato] ASC),
    CONSTRAINT [FK_LancamentosExtratos_Bancos] FOREIGN KEY ([IdBanco]) REFERENCES [dbo].[Bancos] ([IdBanco]),
    CONSTRAINT [FK_LancamentosExtratos_ControleArquivos] FOREIGN KEY ([IdArquivo]) REFERENCES [dbo].[ControleArquivos] ([IdArquivo])
);


GO
CREATE TRIGGER [TrgLog_LancamentosExtratos] ON [Implanta_CRPAM].[dbo].[LancamentosExtratos] 
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
SET @TableName = 'LancamentosExtratos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLancamentoExtrato : «' + RTRIM( ISNULL( CAST (IdLancamentoExtrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLancamento, 113 ),'Nulo'))+'» '
                         + '| ValorLancamento : «' + RTRIM( ISNULL( CAST (ValorLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoLancamento : «' + RTRIM( ISNULL( CAST (TipoLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CategoriaLancamento : «' + RTRIM( ISNULL( CAST (CategoriaLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoLancamento : «' + RTRIM( ISNULL( CAST (CodigoLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumDoc : «' + RTRIM( ISNULL( CAST (NumDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FITID : «' + RTRIM( ISNULL( CAST (FITID AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdImportacao : «' + RTRIM( ISNULL( CAST (IdImportacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLancamentoExtrato : «' + RTRIM( ISNULL( CAST (IdLancamentoExtrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLancamento, 113 ),'Nulo'))+'» '
                         + '| ValorLancamento : «' + RTRIM( ISNULL( CAST (ValorLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoLancamento : «' + RTRIM( ISNULL( CAST (TipoLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CategoriaLancamento : «' + RTRIM( ISNULL( CAST (CategoriaLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoLancamento : «' + RTRIM( ISNULL( CAST (CodigoLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumDoc : «' + RTRIM( ISNULL( CAST (NumDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FITID : «' + RTRIM( ISNULL( CAST (FITID AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdImportacao : «' + RTRIM( ISNULL( CAST (IdImportacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLancamentoExtrato : «' + RTRIM( ISNULL( CAST (IdLancamentoExtrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLancamento, 113 ),'Nulo'))+'» '
                         + '| ValorLancamento : «' + RTRIM( ISNULL( CAST (ValorLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoLancamento : «' + RTRIM( ISNULL( CAST (TipoLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CategoriaLancamento : «' + RTRIM( ISNULL( CAST (CategoriaLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoLancamento : «' + RTRIM( ISNULL( CAST (CodigoLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumDoc : «' + RTRIM( ISNULL( CAST (NumDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FITID : «' + RTRIM( ISNULL( CAST (FITID AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdImportacao : «' + RTRIM( ISNULL( CAST (IdImportacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLancamentoExtrato : «' + RTRIM( ISNULL( CAST (IdLancamentoExtrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdArquivo : «' + RTRIM( ISNULL( CAST (IdArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLancamento, 113 ),'Nulo'))+'» '
                         + '| ValorLancamento : «' + RTRIM( ISNULL( CAST (ValorLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoLancamento : «' + RTRIM( ISNULL( CAST (TipoLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CategoriaLancamento : «' + RTRIM( ISNULL( CAST (CategoriaLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoLancamento : «' + RTRIM( ISNULL( CAST (CodigoLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumDoc : «' + RTRIM( ISNULL( CAST (NumDoc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FITID : «' + RTRIM( ISNULL( CAST (FITID AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdImportacao : «' + RTRIM( ISNULL( CAST (IdImportacao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
