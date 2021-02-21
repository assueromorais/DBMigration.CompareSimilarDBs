CREATE TABLE [dbo].[CodFiscalPrestServicoPagto] (
    [IdPagamento]       INT NULL,
    [IdCFPS]            INT NOT NULL,
    [IdRestosPagamento] INT NULL,
    CONSTRAINT [FK_CodServico_CodFiscalPrestServicoPagto] FOREIGN KEY ([IdCFPS]) REFERENCES [dbo].[CodFiscalPrestServico] ([IdCFPS]),
    CONSTRAINT [FK_Pagamento_CodFiscalPrestServicoPagto] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento])
);


GO
CREATE TRIGGER [TrgLog_CodFiscalPrestServicoPagto] ON [Implanta_CRPAM].[dbo].[CodFiscalPrestServicoPagto] 
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
SET @TableName = 'CodFiscalPrestServicoPagto'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCFPS : «' + RTRIM( ISNULL( CAST (IdCFPS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCFPS : «' + RTRIM( ISNULL( CAST (IdCFPS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCFPS : «' + RTRIM( ISNULL( CAST (IdCFPS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCFPS : «' + RTRIM( ISNULL( CAST (IdCFPS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosPagamento : «' + RTRIM( ISNULL( CAST (IdRestosPagamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
