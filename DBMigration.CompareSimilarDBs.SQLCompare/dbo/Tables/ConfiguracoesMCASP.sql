CREATE TABLE [dbo].[ConfiguracoesMCASP] (
    [IdPlanoContaMCASPDepreciacaoBM]    UNIQUEIDENTIFIER NULL,
    [CodContaMCASPDepreciacaoBM]        VARCHAR (27)     NULL,
    [NomeContaMCASPDepreciacaoBM]       VARCHAR (50)     NULL,
    [IdPlanoContaMCASPDepreciacaoAcuBM] UNIQUEIDENTIFIER NULL,
    [CodContaMCASPDepreciacaoAcuBM]     VARCHAR (27)     NULL,
    [NomeContaMCASPDepreciacaoAcuBM]    VARCHAR (50)     NULL,
    [IdPlanoContaMCASPDepreciacaoBI]    UNIQUEIDENTIFIER NULL,
    [CodContaMCASPDepreciacaoBI]        VARCHAR (27)     NULL,
    [NomeContaMCASPDepreciacaoBI]       VARCHAR (50)     NULL,
    [IdPlanoContaMCASPDepreciacaoAcuBI] UNIQUEIDENTIFIER NULL,
    [CodContaMCASPDepreciacaoAcuBI]     VARCHAR (27)     NULL,
    [NomeContaMCASPDepreciacaoAcuBI]    VARCHAR (50)     NULL,
    [TipoDePara]                        VARCHAR (1)      NULL
);


GO
CREATE TRIGGER [TrgLog_ConfiguracoesMCASP] ON [Implanta_CRPAM].[dbo].[ConfiguracoesMCASP] 
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
SET @TableName = 'ConfiguracoesMCASP'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'CodContaMCASPDepreciacaoBM : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoBM : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASPDepreciacaoAcuBM : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoAcuBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoAcuBM : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoAcuBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASPDepreciacaoBI : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoBI : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASPDepreciacaoAcuBI : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoAcuBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoAcuBI : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoAcuBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDePara : «' + RTRIM( ISNULL( CAST (TipoDePara AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'CodContaMCASPDepreciacaoBM : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoBM : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASPDepreciacaoAcuBM : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoAcuBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoAcuBM : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoAcuBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASPDepreciacaoBI : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoBI : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASPDepreciacaoAcuBI : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoAcuBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoAcuBI : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoAcuBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDePara : «' + RTRIM( ISNULL( CAST (TipoDePara AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'CodContaMCASPDepreciacaoBM : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoBM : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASPDepreciacaoAcuBM : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoAcuBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoAcuBM : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoAcuBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASPDepreciacaoBI : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoBI : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASPDepreciacaoAcuBI : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoAcuBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoAcuBI : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoAcuBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDePara : «' + RTRIM( ISNULL( CAST (TipoDePara AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'CodContaMCASPDepreciacaoBM : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoBM : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASPDepreciacaoAcuBM : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoAcuBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoAcuBM : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoAcuBM AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASPDepreciacaoBI : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoBI : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASPDepreciacaoAcuBI : «' + RTRIM( ISNULL( CAST (CodContaMCASPDepreciacaoAcuBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASPDepreciacaoAcuBI : «' + RTRIM( ISNULL( CAST (NomeContaMCASPDepreciacaoAcuBI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoDePara : «' + RTRIM( ISNULL( CAST (TipoDePara AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
