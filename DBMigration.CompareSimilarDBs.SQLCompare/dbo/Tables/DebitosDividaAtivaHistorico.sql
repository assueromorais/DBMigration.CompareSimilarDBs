CREATE TABLE [dbo].[DebitosDividaAtivaHistorico] (
    [IdDebitoDividaAtiva] INT          NOT NULL,
    [Data]                DATETIME     NOT NULL,
    [Usuario]             VARCHAR (30) NULL,
    [Departamento]        VARCHAR (60) NULL,
    [ValorPrincipal]      MONEY        NULL,
    [ValorAtualizacao]    MONEY        NULL,
    [ValorMulta]          MONEY        NULL,
    [ValorJuros]          MONEY        NULL,
    CONSTRAINT [FK_DebitosDividaAtivaHistorico_DebitosDividaAtiva] FOREIGN KEY ([IdDebitoDividaAtiva]) REFERENCES [dbo].[DebitosDividaAtiva] ([IdDebitoDividaAtiva])
);


GO
CREATE TRIGGER [TrgLog_DebitosDividaAtivaHistorico] ON [Implanta_CRPAM].[dbo].[DebitosDividaAtivaHistorico] 
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
SET @TableName = 'DebitosDividaAtivaHistorico'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDebitoDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDebitoDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDebitoDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDebitoDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDebitoDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDebitoDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDebitoDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDebitoDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
