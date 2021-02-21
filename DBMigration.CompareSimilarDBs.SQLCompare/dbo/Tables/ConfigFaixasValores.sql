CREATE TABLE [dbo].[ConfigFaixasValores] (
    [IdConfigFaixaValor]    INT        IDENTITY (1, 1) NOT NULL,
    [IdConfigGeracaoDebito] INT        NOT NULL,
    [QtdeParcelas]          INT        NOT NULL,
    [ValorInicialFaixa]     FLOAT (53) NULL,
    [ValorFinalFaixa]       FLOAT (53) NULL,
    CONSTRAINT [PK_ConfigFaixasValores] PRIMARY KEY CLUSTERED ([IdConfigFaixaValor] ASC),
    CONSTRAINT [FK_ConfigFaixasValores_ConfigGeracaoDebitos] FOREIGN KEY ([IdConfigGeracaoDebito]) REFERENCES [dbo].[ConfigGeracaoDebito] ([IdConfigGeracaoDebito])
);


GO
CREATE TRIGGER [TrgLog_ConfigFaixasValores] ON [Implanta_CRPAM].[dbo].[ConfigFaixasValores] 
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
SET @TableName = 'ConfigFaixasValores'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfigFaixaValor : «' + RTRIM( ISNULL( CAST (IdConfigFaixaValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeParcelas : «' + RTRIM( ISNULL( CAST (QtdeParcelas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorInicialFaixa : «' + RTRIM( ISNULL( CAST (ValorInicialFaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorFinalFaixa : «' + RTRIM( ISNULL( CAST (ValorFinalFaixa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConfigFaixaValor : «' + RTRIM( ISNULL( CAST (IdConfigFaixaValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeParcelas : «' + RTRIM( ISNULL( CAST (QtdeParcelas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorInicialFaixa : «' + RTRIM( ISNULL( CAST (ValorInicialFaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorFinalFaixa : «' + RTRIM( ISNULL( CAST (ValorFinalFaixa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConfigFaixaValor : «' + RTRIM( ISNULL( CAST (IdConfigFaixaValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeParcelas : «' + RTRIM( ISNULL( CAST (QtdeParcelas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorInicialFaixa : «' + RTRIM( ISNULL( CAST (ValorInicialFaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorFinalFaixa : «' + RTRIM( ISNULL( CAST (ValorFinalFaixa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfigFaixaValor : «' + RTRIM( ISNULL( CAST (IdConfigFaixaValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeParcelas : «' + RTRIM( ISNULL( CAST (QtdeParcelas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorInicialFaixa : «' + RTRIM( ISNULL( CAST (ValorInicialFaixa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorFinalFaixa : «' + RTRIM( ISNULL( CAST (ValorFinalFaixa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
