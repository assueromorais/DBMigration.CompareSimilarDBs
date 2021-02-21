CREATE TABLE [dbo].[ParametrosRelatorios] (
    [IdParametrosRelatorios] INT          IDENTITY (1, 1) NOT NULL,
    [NomeRelatorio]          VARCHAR (50) NOT NULL,
    [Campo]                  VARCHAR (30) NULL,
    [CriterioSelecao]        VARCHAR (20) NULL,
    [CampoCalculado1]        VARCHAR (20) NULL,
    [CampoCalculado2]        VARCHAR (20) NULL,
    [CampoCalculado3]        VARCHAR (20) NULL
);


GO
CREATE TRIGGER [TrgLog_ParametrosRelatorios] ON [Implanta_CRPAM].[dbo].[ParametrosRelatorios] 
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
SET @TableName = 'ParametrosRelatorios'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdParametrosRelatorios : «' + RTRIM( ISNULL( CAST (IdParametrosRelatorios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeRelatorio : «' + RTRIM( ISNULL( CAST (NomeRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Campo : «' + RTRIM( ISNULL( CAST (Campo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CriterioSelecao : «' + RTRIM( ISNULL( CAST (CriterioSelecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCalculado1 : «' + RTRIM( ISNULL( CAST (CampoCalculado1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCalculado2 : «' + RTRIM( ISNULL( CAST (CampoCalculado2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCalculado3 : «' + RTRIM( ISNULL( CAST (CampoCalculado3 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdParametrosRelatorios : «' + RTRIM( ISNULL( CAST (IdParametrosRelatorios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeRelatorio : «' + RTRIM( ISNULL( CAST (NomeRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Campo : «' + RTRIM( ISNULL( CAST (Campo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CriterioSelecao : «' + RTRIM( ISNULL( CAST (CriterioSelecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCalculado1 : «' + RTRIM( ISNULL( CAST (CampoCalculado1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCalculado2 : «' + RTRIM( ISNULL( CAST (CampoCalculado2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCalculado3 : «' + RTRIM( ISNULL( CAST (CampoCalculado3 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdParametrosRelatorios : «' + RTRIM( ISNULL( CAST (IdParametrosRelatorios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeRelatorio : «' + RTRIM( ISNULL( CAST (NomeRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Campo : «' + RTRIM( ISNULL( CAST (Campo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CriterioSelecao : «' + RTRIM( ISNULL( CAST (CriterioSelecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCalculado1 : «' + RTRIM( ISNULL( CAST (CampoCalculado1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCalculado2 : «' + RTRIM( ISNULL( CAST (CampoCalculado2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCalculado3 : «' + RTRIM( ISNULL( CAST (CampoCalculado3 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdParametrosRelatorios : «' + RTRIM( ISNULL( CAST (IdParametrosRelatorios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeRelatorio : «' + RTRIM( ISNULL( CAST (NomeRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Campo : «' + RTRIM( ISNULL( CAST (Campo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CriterioSelecao : «' + RTRIM( ISNULL( CAST (CriterioSelecao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCalculado1 : «' + RTRIM( ISNULL( CAST (CampoCalculado1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCalculado2 : «' + RTRIM( ISNULL( CAST (CampoCalculado2 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCalculado3 : «' + RTRIM( ISNULL( CAST (CampoCalculado3 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
