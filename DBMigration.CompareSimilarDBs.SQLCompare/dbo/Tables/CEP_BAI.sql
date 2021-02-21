CREATE TABLE [dbo].[CEP_BAI] (
    [CHAVE_BAI]   INT       NOT NULL,
    [EXTENSO_BAI] CHAR (60) NULL,
    [ABREV_BAI]   CHAR (30) NULL,
    [CHVLOC_BAI]  INT       NOT NULL,
    [UF_BAI]      CHAR (2)  NULL,
    [OPER_BAI]    INT       NULL,
    [DATA_BAI]    INT       NULL,
    CONSTRAINT [PK_CEP_BAI] PRIMARY KEY NONCLUSTERED ([CHAVE_BAI] ASC, [CHVLOC_BAI] ASC)
);


GO
CREATE TRIGGER [TrgLog_CEP_BAI] ON [Implanta_CRPAM].[dbo].[CEP_BAI] 
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
SET @TableName = 'CEP_BAI'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'CHAVE_BAI : «' + RTRIM( ISNULL( CAST (CHAVE_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EXTENSO_BAI : «' + RTRIM( ISNULL( CAST (EXTENSO_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ABREV_BAI : «' + RTRIM( ISNULL( CAST (ABREV_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVLOC_BAI : «' + RTRIM( ISNULL( CAST (CHVLOC_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF_BAI : «' + RTRIM( ISNULL( CAST (UF_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OPER_BAI : «' + RTRIM( ISNULL( CAST (OPER_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA_BAI : «' + RTRIM( ISNULL( CAST (DATA_BAI AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'CHAVE_BAI : «' + RTRIM( ISNULL( CAST (CHAVE_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EXTENSO_BAI : «' + RTRIM( ISNULL( CAST (EXTENSO_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ABREV_BAI : «' + RTRIM( ISNULL( CAST (ABREV_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVLOC_BAI : «' + RTRIM( ISNULL( CAST (CHVLOC_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF_BAI : «' + RTRIM( ISNULL( CAST (UF_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OPER_BAI : «' + RTRIM( ISNULL( CAST (OPER_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA_BAI : «' + RTRIM( ISNULL( CAST (DATA_BAI AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'CHAVE_BAI : «' + RTRIM( ISNULL( CAST (CHAVE_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EXTENSO_BAI : «' + RTRIM( ISNULL( CAST (EXTENSO_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ABREV_BAI : «' + RTRIM( ISNULL( CAST (ABREV_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVLOC_BAI : «' + RTRIM( ISNULL( CAST (CHVLOC_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF_BAI : «' + RTRIM( ISNULL( CAST (UF_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OPER_BAI : «' + RTRIM( ISNULL( CAST (OPER_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA_BAI : «' + RTRIM( ISNULL( CAST (DATA_BAI AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'CHAVE_BAI : «' + RTRIM( ISNULL( CAST (CHAVE_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EXTENSO_BAI : «' + RTRIM( ISNULL( CAST (EXTENSO_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ABREV_BAI : «' + RTRIM( ISNULL( CAST (ABREV_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CHVLOC_BAI : «' + RTRIM( ISNULL( CAST (CHVLOC_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF_BAI : «' + RTRIM( ISNULL( CAST (UF_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OPER_BAI : «' + RTRIM( ISNULL( CAST (OPER_BAI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA_BAI : «' + RTRIM( ISNULL( CAST (DATA_BAI AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
