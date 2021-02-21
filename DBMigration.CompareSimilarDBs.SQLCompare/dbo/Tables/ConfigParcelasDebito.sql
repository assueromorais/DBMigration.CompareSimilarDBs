CREATE TABLE [dbo].[ConfigParcelasDebito] (
    [IdConfigParcelaDebito] INT        IDENTITY (1, 1) NOT NULL,
    [IdConfigGeracaoDebito] INT        NOT NULL,
    [IdConfigFaixaValor]    INT        NULL,
    [NumeroParcela]         INT        NOT NULL,
    [DataVencimentoParcela] DATETIME   NULL,
    [ValorParcela]          FLOAT (53) NULL,
    CONSTRAINT [PK_ConfigParcelasDebito] PRIMARY KEY CLUSTERED ([IdConfigParcelaDebito] ASC),
    CONSTRAINT [FK_ConfigParcelasDebito_ConfigFaixasValores] FOREIGN KEY ([IdConfigFaixaValor]) REFERENCES [dbo].[ConfigFaixasValores] ([IdConfigFaixaValor]),
    CONSTRAINT [FK_ConfigParcelasDebito_ConfigGeracaoDebitos] FOREIGN KEY ([IdConfigGeracaoDebito]) REFERENCES [dbo].[ConfigGeracaoDebito] ([IdConfigGeracaoDebito])
);


GO
CREATE TRIGGER [TrgLog_ConfigParcelasDebito] ON [Implanta_CRPAM].[dbo].[ConfigParcelasDebito] 
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
SET @TableName = 'ConfigParcelasDebito'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfigParcelaDebito : «' + RTRIM( ISNULL( CAST (IdConfigParcelaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigFaixaValor : «' + RTRIM( ISNULL( CAST (IdConfigFaixaValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimentoParcela : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoParcela, 113 ),'Nulo'))+'» '
                         + '| ValorParcela : «' + RTRIM( ISNULL( CAST (ValorParcela AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConfigParcelaDebito : «' + RTRIM( ISNULL( CAST (IdConfigParcelaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigFaixaValor : «' + RTRIM( ISNULL( CAST (IdConfigFaixaValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimentoParcela : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoParcela, 113 ),'Nulo'))+'» '
                         + '| ValorParcela : «' + RTRIM( ISNULL( CAST (ValorParcela AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConfigParcelaDebito : «' + RTRIM( ISNULL( CAST (IdConfigParcelaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigFaixaValor : «' + RTRIM( ISNULL( CAST (IdConfigFaixaValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimentoParcela : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoParcela, 113 ),'Nulo'))+'» '
                         + '| ValorParcela : «' + RTRIM( ISNULL( CAST (ValorParcela AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfigParcelaDebito : «' + RTRIM( ISNULL( CAST (IdConfigParcelaDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigGeracaoDebito : «' + RTRIM( ISNULL( CAST (IdConfigGeracaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigFaixaValor : «' + RTRIM( ISNULL( CAST (IdConfigFaixaValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroParcela : «' + RTRIM( ISNULL( CAST (NumeroParcela AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimentoParcela : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimentoParcela, 113 ),'Nulo'))+'» '
                         + '| ValorParcela : «' + RTRIM( ISNULL( CAST (ValorParcela AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
