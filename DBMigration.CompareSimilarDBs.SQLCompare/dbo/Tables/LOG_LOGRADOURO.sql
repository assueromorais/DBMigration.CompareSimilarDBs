CREATE TABLE [dbo].[LOG_LOGRADOURO] (
    [LOG_NU]          NUMERIC (8)   NULL,
    [UFE_SG]          CHAR (2)      NULL,
    [LOC_NU]          NUMERIC (8)   NULL,
    [BAI_NU_INI]      NUMERIC (8)   NULL,
    [BAI_NU_FIM]      NUMERIC (8)   NULL,
    [LOG_NO]          VARCHAR (100) NULL,
    [LOG_COMPLEMENTO] VARCHAR (100) NULL,
    [CEP]             CHAR (8)      NULL,
    [TLO_TX]          VARCHAR (36)  NULL,
    [LOG_STA_TLO]     CHAR (1)      NULL,
    [LOG_NO_ABREV]    VARCHAR (36)  NULL
);


GO
CREATE TRIGGER [TrgLog_LOG_LOGRADOURO] ON [Implanta_CRPAM].[dbo].[LOG_LOGRADOURO] 
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
SET @TableName = 'LOG_LOGRADOURO'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'LOG_NU : «' + RTRIM( ISNULL( CAST (LOG_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NU_INI : «' + RTRIM( ISNULL( CAST (BAI_NU_INI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NU_FIM : «' + RTRIM( ISNULL( CAST (BAI_NU_FIM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_NO : «' + RTRIM( ISNULL( CAST (LOG_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_COMPLEMENTO : «' + RTRIM( ISNULL( CAST (LOG_COMPLEMENTO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TLO_TX : «' + RTRIM( ISNULL( CAST (TLO_TX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_STA_TLO : «' + RTRIM( ISNULL( CAST (LOG_STA_TLO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_NO_ABREV : «' + RTRIM( ISNULL( CAST (LOG_NO_ABREV AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'LOG_NU : «' + RTRIM( ISNULL( CAST (LOG_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NU_INI : «' + RTRIM( ISNULL( CAST (BAI_NU_INI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NU_FIM : «' + RTRIM( ISNULL( CAST (BAI_NU_FIM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_NO : «' + RTRIM( ISNULL( CAST (LOG_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_COMPLEMENTO : «' + RTRIM( ISNULL( CAST (LOG_COMPLEMENTO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TLO_TX : «' + RTRIM( ISNULL( CAST (TLO_TX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_STA_TLO : «' + RTRIM( ISNULL( CAST (LOG_STA_TLO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_NO_ABREV : «' + RTRIM( ISNULL( CAST (LOG_NO_ABREV AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'LOG_NU : «' + RTRIM( ISNULL( CAST (LOG_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NU_INI : «' + RTRIM( ISNULL( CAST (BAI_NU_INI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NU_FIM : «' + RTRIM( ISNULL( CAST (BAI_NU_FIM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_NO : «' + RTRIM( ISNULL( CAST (LOG_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_COMPLEMENTO : «' + RTRIM( ISNULL( CAST (LOG_COMPLEMENTO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TLO_TX : «' + RTRIM( ISNULL( CAST (TLO_TX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_STA_TLO : «' + RTRIM( ISNULL( CAST (LOG_STA_TLO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_NO_ABREV : «' + RTRIM( ISNULL( CAST (LOG_NO_ABREV AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'LOG_NU : «' + RTRIM( ISNULL( CAST (LOG_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NU_INI : «' + RTRIM( ISNULL( CAST (BAI_NU_INI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NU_FIM : «' + RTRIM( ISNULL( CAST (BAI_NU_FIM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_NO : «' + RTRIM( ISNULL( CAST (LOG_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_COMPLEMENTO : «' + RTRIM( ISNULL( CAST (LOG_COMPLEMENTO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TLO_TX : «' + RTRIM( ISNULL( CAST (TLO_TX AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_STA_TLO : «' + RTRIM( ISNULL( CAST (LOG_STA_TLO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_NO_ABREV : «' + RTRIM( ISNULL( CAST (LOG_NO_ABREV AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
