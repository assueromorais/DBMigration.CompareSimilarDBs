CREATE TABLE [dbo].[CEP_UFS] (
    [CHAVE_UF] CHAR (2)  NOT NULL,
    [SIGLA_UF] CHAR (2)  NULL,
    [NOME_UF]  CHAR (20) NULL,
    CONSTRAINT [PK_CEP_UFS] PRIMARY KEY NONCLUSTERED ([CHAVE_UF] ASC)
);


GO
CREATE TRIGGER [TrgLog_CEP_UFS] ON [Implanta_CRPAM].[dbo].[CEP_UFS] 
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
SET @TableName = 'CEP_UFS'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'CHAVE_UF : «' + RTRIM( ISNULL( CAST (CHAVE_UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SIGLA_UF : «' + RTRIM( ISNULL( CAST (SIGLA_UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NOME_UF : «' + RTRIM( ISNULL( CAST (NOME_UF AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'CHAVE_UF : «' + RTRIM( ISNULL( CAST (CHAVE_UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SIGLA_UF : «' + RTRIM( ISNULL( CAST (SIGLA_UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NOME_UF : «' + RTRIM( ISNULL( CAST (NOME_UF AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'CHAVE_UF : «' + RTRIM( ISNULL( CAST (CHAVE_UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SIGLA_UF : «' + RTRIM( ISNULL( CAST (SIGLA_UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NOME_UF : «' + RTRIM( ISNULL( CAST (NOME_UF AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'CHAVE_UF : «' + RTRIM( ISNULL( CAST (CHAVE_UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SIGLA_UF : «' + RTRIM( ISNULL( CAST (SIGLA_UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NOME_UF : «' + RTRIM( ISNULL( CAST (NOME_UF AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
