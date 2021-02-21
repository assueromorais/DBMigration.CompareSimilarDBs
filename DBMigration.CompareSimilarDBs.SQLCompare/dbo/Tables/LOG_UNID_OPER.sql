CREATE TABLE [dbo].[LOG_UNID_OPER] (
    [UOP_NU]       NUMERIC (8)   NULL,
    [UFE_SG]       CHAR (2)      NULL,
    [LOC_NU]       NUMERIC (8)   NULL,
    [BAI_NU]       NUMERIC (8)   NULL,
    [LOG_NU]       NUMERIC (8)   NULL,
    [UOP_NO]       VARCHAR (100) NULL,
    [UOP_ENDERECO] VARCHAR (100) NULL,
    [CEP]          CHAR (8)      NULL,
    [UOP_IN_CP]    CHAR (1)      NULL,
    [UOP_NO_ABREV] VARCHAR (36)  NULL
);


GO
CREATE TRIGGER [TrgLog_LOG_UNID_OPER] ON [Implanta_CRPAM].[dbo].[LOG_UNID_OPER] 
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
SET @TableName = 'LOG_UNID_OPER'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'UOP_NU : «' + RTRIM( ISNULL( CAST (UOP_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NU : «' + RTRIM( ISNULL( CAST (BAI_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_NU : «' + RTRIM( ISNULL( CAST (LOG_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_NO : «' + RTRIM( ISNULL( CAST (UOP_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_ENDERECO : «' + RTRIM( ISNULL( CAST (UOP_ENDERECO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_IN_CP : «' + RTRIM( ISNULL( CAST (UOP_IN_CP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_NO_ABREV : «' + RTRIM( ISNULL( CAST (UOP_NO_ABREV AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'UOP_NU : «' + RTRIM( ISNULL( CAST (UOP_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NU : «' + RTRIM( ISNULL( CAST (BAI_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_NU : «' + RTRIM( ISNULL( CAST (LOG_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_NO : «' + RTRIM( ISNULL( CAST (UOP_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_ENDERECO : «' + RTRIM( ISNULL( CAST (UOP_ENDERECO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_IN_CP : «' + RTRIM( ISNULL( CAST (UOP_IN_CP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_NO_ABREV : «' + RTRIM( ISNULL( CAST (UOP_NO_ABREV AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'UOP_NU : «' + RTRIM( ISNULL( CAST (UOP_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NU : «' + RTRIM( ISNULL( CAST (BAI_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_NU : «' + RTRIM( ISNULL( CAST (LOG_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_NO : «' + RTRIM( ISNULL( CAST (UOP_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_ENDERECO : «' + RTRIM( ISNULL( CAST (UOP_ENDERECO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_IN_CP : «' + RTRIM( ISNULL( CAST (UOP_IN_CP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_NO_ABREV : «' + RTRIM( ISNULL( CAST (UOP_NO_ABREV AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'UOP_NU : «' + RTRIM( ISNULL( CAST (UOP_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| BAI_NU : «' + RTRIM( ISNULL( CAST (BAI_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOG_NU : «' + RTRIM( ISNULL( CAST (LOG_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_NO : «' + RTRIM( ISNULL( CAST (UOP_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_ENDERECO : «' + RTRIM( ISNULL( CAST (UOP_ENDERECO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_IN_CP : «' + RTRIM( ISNULL( CAST (UOP_IN_CP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UOP_NO_ABREV : «' + RTRIM( ISNULL( CAST (UOP_NO_ABREV AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
