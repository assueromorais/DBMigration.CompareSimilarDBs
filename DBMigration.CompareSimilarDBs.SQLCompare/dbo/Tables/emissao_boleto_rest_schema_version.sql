CREATE TABLE [dbo].[emissao_boleto_rest_schema_version] (
    [version_rank]   INT             NOT NULL,
    [installed_rank] INT             NOT NULL,
    [version]        NVARCHAR (50)   NOT NULL,
    [description]    NVARCHAR (200)  NULL,
    [type]           NVARCHAR (20)   NOT NULL,
    [script]         NVARCHAR (1000) NOT NULL,
    [checksum]       INT             NULL,
    [installed_by]   NVARCHAR (100)  NOT NULL,
    [installed_on]   DATETIME        DEFAULT (getdate()) NOT NULL,
    [execution_time] INT             NOT NULL,
    [success]        BIT             NOT NULL,
    CONSTRAINT [emissao_boleto_rest_schema_version_pk] PRIMARY KEY CLUSTERED ([version] ASC)
);


GO
CREATE NONCLUSTERED INDEX [emissao_boleto_rest_schema_version_vr_idx]
    ON [dbo].[emissao_boleto_rest_schema_version]([version_rank] ASC);


GO
CREATE NONCLUSTERED INDEX [emissao_boleto_rest_schema_version_ir_idx]
    ON [dbo].[emissao_boleto_rest_schema_version]([installed_rank] ASC);


GO
CREATE NONCLUSTERED INDEX [emissao_boleto_rest_schema_version_s_idx]
    ON [dbo].[emissao_boleto_rest_schema_version]([success] ASC);


GO
CREATE TRIGGER [TrgLog_emissao_boleto_rest_schema_version] ON [Implanta_CRPAM].[dbo].[emissao_boleto_rest_schema_version] 
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
SET @TableName = 'emissao_boleto_rest_schema_version'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'version_rank : «' + RTRIM( ISNULL( CAST (version_rank AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| installed_rank : «' + RTRIM( ISNULL( CAST (installed_rank AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| checksum : «' + RTRIM( ISNULL( CAST (checksum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| installed_on : «' + RTRIM( ISNULL( CONVERT (CHAR, installed_on, 113 ),'Nulo'))+'» '
                         + '| execution_time : «' + RTRIM( ISNULL( CAST (execution_time AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  success IS NULL THEN ' success : «Nulo» '
                                              WHEN  success = 0 THEN ' success : «Falso» '
                                              WHEN  success = 1 THEN ' success : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'version_rank : «' + RTRIM( ISNULL( CAST (version_rank AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| installed_rank : «' + RTRIM( ISNULL( CAST (installed_rank AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| checksum : «' + RTRIM( ISNULL( CAST (checksum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| installed_on : «' + RTRIM( ISNULL( CONVERT (CHAR, installed_on, 113 ),'Nulo'))+'» '
                         + '| execution_time : «' + RTRIM( ISNULL( CAST (execution_time AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  success IS NULL THEN ' success : «Nulo» '
                                              WHEN  success = 0 THEN ' success : «Falso» '
                                              WHEN  success = 1 THEN ' success : «Verdadeiro» '
                                    END  FROM INSERTED 
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
		SELECT @Conteudo = 'version_rank : «' + RTRIM( ISNULL( CAST (version_rank AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| installed_rank : «' + RTRIM( ISNULL( CAST (installed_rank AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| checksum : «' + RTRIM( ISNULL( CAST (checksum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| installed_on : «' + RTRIM( ISNULL( CONVERT (CHAR, installed_on, 113 ),'Nulo'))+'» '
                         + '| execution_time : «' + RTRIM( ISNULL( CAST (execution_time AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  success IS NULL THEN ' success : «Nulo» '
                                              WHEN  success = 0 THEN ' success : «Falso» '
                                              WHEN  success = 1 THEN ' success : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'version_rank : «' + RTRIM( ISNULL( CAST (version_rank AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| installed_rank : «' + RTRIM( ISNULL( CAST (installed_rank AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| checksum : «' + RTRIM( ISNULL( CAST (checksum AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| installed_on : «' + RTRIM( ISNULL( CONVERT (CHAR, installed_on, 113 ),'Nulo'))+'» '
                         + '| execution_time : «' + RTRIM( ISNULL( CAST (execution_time AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  success IS NULL THEN ' success : «Nulo» '
                                              WHEN  success = 0 THEN ' success : «Falso» '
                                              WHEN  success = 1 THEN ' success : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
