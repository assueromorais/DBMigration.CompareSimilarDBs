CREATE TABLE [dbo].[DotacoesConta] (
    [IdDotacaoConta] INT      IDENTITY (1, 1) NOT NULL,
    [IdTransposicao] INT      NULL,
    [IdConta]        INT      NOT NULL,
    [TipoMov]        INT      NOT NULL,
    [DataDotacao]    DATETIME NOT NULL,
    [ValorDotacao]   MONEY    NOT NULL,
    [SaldoDotacao]   MONEY    NOT NULL,
    [TotalOrcado]    MONEY    NULL,
    CONSTRAINT [PK_DotacoesConta] PRIMARY KEY NONCLUSTERED ([IdDotacaoConta] ASC),
    CONSTRAINT [FK_DotacoesConta_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
CREATE STATISTICS [STAT_DotacoesConta_IdDotacaoConta_IdConta]
    ON [dbo].[DotacoesConta]([IdDotacaoConta], [IdConta]);


GO
CREATE TRIGGER [TrgLog_DotacoesConta] ON [Implanta_CRPAM].[dbo].[DotacoesConta] 
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
SET @TableName = 'DotacoesConta'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDotacaoConta : «' + RTRIM( ISNULL( CAST (IdDotacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTransposicao : «' + RTRIM( ISNULL( CAST (IdTransposicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDotacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDotacao, 113 ),'Nulo'))+'» '
                         + '| ValorDotacao : «' + RTRIM( ISNULL( CAST (ValorDotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoDotacao : «' + RTRIM( ISNULL( CAST (SaldoDotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalOrcado : «' + RTRIM( ISNULL( CAST (TotalOrcado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDotacaoConta : «' + RTRIM( ISNULL( CAST (IdDotacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTransposicao : «' + RTRIM( ISNULL( CAST (IdTransposicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDotacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDotacao, 113 ),'Nulo'))+'» '
                         + '| ValorDotacao : «' + RTRIM( ISNULL( CAST (ValorDotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoDotacao : «' + RTRIM( ISNULL( CAST (SaldoDotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalOrcado : «' + RTRIM( ISNULL( CAST (TotalOrcado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDotacaoConta : «' + RTRIM( ISNULL( CAST (IdDotacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTransposicao : «' + RTRIM( ISNULL( CAST (IdTransposicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDotacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDotacao, 113 ),'Nulo'))+'» '
                         + '| ValorDotacao : «' + RTRIM( ISNULL( CAST (ValorDotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoDotacao : «' + RTRIM( ISNULL( CAST (SaldoDotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalOrcado : «' + RTRIM( ISNULL( CAST (TotalOrcado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDotacaoConta : «' + RTRIM( ISNULL( CAST (IdDotacaoConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTransposicao : «' + RTRIM( ISNULL( CAST (IdTransposicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoMov : «' + RTRIM( ISNULL( CAST (TipoMov AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataDotacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDotacao, 113 ),'Nulo'))+'» '
                         + '| ValorDotacao : «' + RTRIM( ISNULL( CAST (ValorDotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SaldoDotacao : «' + RTRIM( ISNULL( CAST (SaldoDotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalOrcado : «' + RTRIM( ISNULL( CAST (TotalOrcado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
