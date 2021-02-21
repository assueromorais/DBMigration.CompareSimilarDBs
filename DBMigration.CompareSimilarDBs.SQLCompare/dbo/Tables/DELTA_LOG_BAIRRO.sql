CREATE TABLE [dbo].[DELTA_LOG_BAIRRO] (
    [BAI_NU]       NUMERIC (8)  NOT NULL,
    [UFE_SG]       CHAR (2)     NULL,
    [LOC_NU]       NUMERIC (8)  NULL,
    [BAI_NO]       VARCHAR (72) NULL,
    [BAI_NO_ABREV] VARCHAR (36) NULL,
    [BAI_OPERACAO] CHAR (3)     NULL,
    CONSTRAINT [PK_DELTA_LOG_BAIRRO] PRIMARY KEY CLUSTERED ([BAI_NU] ASC)
);


GO
CREATE TRIGGER [TrgLog_DELTA_LOG_BAIRRO] ON [Implanta_CRPAM].[dbo].[DELTA_LOG_BAIRRO] 
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
SET @TableName = 'DELTA_LOG_BAIRRO'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'BAI_NU : «' + RTRIM( ISNULL( CAST (BAI_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NO : «' + RTRIM( ISNULL( CAST (BAI_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NO_ABREV : «' + RTRIM( ISNULL( CAST (BAI_NO_ABREV AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_OPERACAO : «' + RTRIM( ISNULL( CAST (BAI_OPERACAO AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'BAI_NU : «' + RTRIM( ISNULL( CAST (BAI_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NO : «' + RTRIM( ISNULL( CAST (BAI_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NO_ABREV : «' + RTRIM( ISNULL( CAST (BAI_NO_ABREV AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_OPERACAO : «' + RTRIM( ISNULL( CAST (BAI_OPERACAO AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'BAI_NU : «' + RTRIM( ISNULL( CAST (BAI_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NO : «' + RTRIM( ISNULL( CAST (BAI_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NO_ABREV : «' + RTRIM( ISNULL( CAST (BAI_NO_ABREV AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_OPERACAO : «' + RTRIM( ISNULL( CAST (BAI_OPERACAO AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'BAI_NU : «' + RTRIM( ISNULL( CAST (BAI_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NO : «' + RTRIM( ISNULL( CAST (BAI_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NO_ABREV : «' + RTRIM( ISNULL( CAST (BAI_NO_ABREV AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_OPERACAO : «' + RTRIM( ISNULL( CAST (BAI_OPERACAO AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
