CREATE TABLE [dbo].[HistConversaoMVR] (
    [IdDebito]         INT          NULL,
    [IdDividaAtiva]    INT          NULL,
    [ValorDevido]      MONEY        NULL,
    [ValorPrincipal]   MONEY        NULL,
    [ValorAtualizacao] MONEY        NULL,
    [ValorMulta]       MONEY        NULL,
    [ValorJuros]       MONEY        NULL,
    [DATA]             DATETIME     NULL,
    [Usuario]          VARCHAR (30) NULL,
    [Departamento]     VARCHAR (60) NULL
);


GO
CREATE TRIGGER [TrgLog_HistConversaoMVR] ON [Implanta_CRPAM].[dbo].[HistConversaoMVR] 
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
SET @TableName = 'HistConversaoMVR'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDebito : «' + RTRIM( ISNULL( CAST (IdDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDevido : «' + RTRIM( ISNULL( CAST (ValorDevido AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPrincipal : «' + RTRIM( ISNULL( CAST (ValorPrincipal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAtualizacao : «' + RTRIM( ISNULL( CAST (ValorAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorMulta : «' + RTRIM( ISNULL( CAST (ValorMulta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorJuros : «' + RTRIM( ISNULL( CAST (ValorJuros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
