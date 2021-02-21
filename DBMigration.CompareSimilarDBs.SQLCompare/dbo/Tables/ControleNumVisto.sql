CREATE TABLE [dbo].[ControleNumVisto] (
    [NumeroVisto]      INT          NOT NULL,
    [DATA]             DATETIME     NULL,
    [AnoPrefixoSufixo] VARCHAR (10) NULL,
    PRIMARY KEY CLUSTERED ([NumeroVisto] ASC)
);


GO
CREATE TRIGGER [TrgLog_ControleNumVisto] ON [Implanta_CRPAM].[dbo].[ControleNumVisto] 
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
SET @TableName = 'ControleNumVisto'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'NumeroVisto : «' + RTRIM( ISNULL( CAST (NumeroVisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| AnoPrefixoSufixo : «' + RTRIM( ISNULL( CAST (AnoPrefixoSufixo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'NumeroVisto : «' + RTRIM( ISNULL( CAST (NumeroVisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| AnoPrefixoSufixo : «' + RTRIM( ISNULL( CAST (AnoPrefixoSufixo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'NumeroVisto : «' + RTRIM( ISNULL( CAST (NumeroVisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| AnoPrefixoSufixo : «' + RTRIM( ISNULL( CAST (AnoPrefixoSufixo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'NumeroVisto : «' + RTRIM( ISNULL( CAST (NumeroVisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| AnoPrefixoSufixo : «' + RTRIM( ISNULL( CAST (AnoPrefixoSufixo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
