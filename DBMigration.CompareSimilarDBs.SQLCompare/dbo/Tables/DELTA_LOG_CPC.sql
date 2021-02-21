CREATE TABLE [dbo].[DELTA_LOG_CPC] (
    [CPC_NU]       NUMERIC (8)   NOT NULL,
    [UFE_SG]       CHAR (2)      NULL,
    [LOC_NU]       NUMERIC (8)   NULL,
    [CPC_NO]       VARCHAR (72)  NULL,
    [CPC_ENDERECO] VARCHAR (100) NULL,
    [CEP]          CHAR (8)      NULL,
    [CPC_OPERACAO] CHAR (3)      NULL,
    [CEP_ANT]      CHAR (8)      NULL,
    CONSTRAINT [PK_DELTA_LOG_CPC] PRIMARY KEY CLUSTERED ([CPC_NU] ASC)
);


GO
CREATE TRIGGER [TrgLog_DELTA_LOG_CPC] ON [Implanta_CRPAM].[dbo].[DELTA_LOG_CPC] 
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
SET @TableName = 'DELTA_LOG_CPC'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'CPC_NU : «' + RTRIM( ISNULL( CAST (CPC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPC_NO : «' + RTRIM( ISNULL( CAST (CPC_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPC_ENDERECO : «' + RTRIM( ISNULL( CAST (CPC_ENDERECO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPC_OPERACAO : «' + RTRIM( ISNULL( CAST (CPC_OPERACAO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP_ANT : «' + RTRIM( ISNULL( CAST (CEP_ANT AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'CPC_NU : «' + RTRIM( ISNULL( CAST (CPC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPC_NO : «' + RTRIM( ISNULL( CAST (CPC_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPC_ENDERECO : «' + RTRIM( ISNULL( CAST (CPC_ENDERECO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPC_OPERACAO : «' + RTRIM( ISNULL( CAST (CPC_OPERACAO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP_ANT : «' + RTRIM( ISNULL( CAST (CEP_ANT AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'CPC_NU : «' + RTRIM( ISNULL( CAST (CPC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPC_NO : «' + RTRIM( ISNULL( CAST (CPC_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPC_ENDERECO : «' + RTRIM( ISNULL( CAST (CPC_ENDERECO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPC_OPERACAO : «' + RTRIM( ISNULL( CAST (CPC_OPERACAO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP_ANT : «' + RTRIM( ISNULL( CAST (CEP_ANT AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'CPC_NU : «' + RTRIM( ISNULL( CAST (CPC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UFE_SG : «' + RTRIM( ISNULL( CAST (UFE_SG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LOC_NU : «' + RTRIM( ISNULL( CAST (LOC_NU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPC_NO : «' + RTRIM( ISNULL( CAST (CPC_NO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPC_ENDERECO : «' + RTRIM( ISNULL( CAST (CPC_ENDERECO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPC_OPERACAO : «' + RTRIM( ISNULL( CAST (CPC_OPERACAO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP_ANT : «' + RTRIM( ISNULL( CAST (CEP_ANT AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
