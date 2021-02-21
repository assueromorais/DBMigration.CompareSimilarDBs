CREATE TABLE [dbo].[ModeloArquivoExportacao] (
    [IdModeloExp]  INT          IDENTITY (1, 1) NOT NULL,
    [Descricao]    VARCHAR (50) NOT NULL,
    [Arquivo]      TEXT         NULL,
    [Status]       BIT          CONSTRAINT [DEF_MAEStatus] DEFAULT ('1') NOT NULL,
    [usaSeparador] BIT          CONSTRAINT [DEF_MAESUsaSeparador] DEFAULT ('0') NOT NULL,
    [Separador]    CHAR (1)     CONSTRAINT [DEF_MAESeparador] DEFAULT (';') NOT NULL,
    CONSTRAINT [PK_ModeloArquivoExportacao] PRIMARY KEY CLUSTERED ([IdModeloExp] ASC)
);


GO
CREATE TRIGGER [TrgLog_ModeloArquivoExportacao] ON [Implanta_CRPAM].[dbo].[ModeloArquivoExportacao] 
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
SET @TableName = 'ModeloArquivoExportacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdModeloExp : «' + RTRIM( ISNULL( CAST (IdModeloExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Status IS NULL THEN ' Status : «Nulo» '
                                              WHEN  Status = 0 THEN ' Status : «Falso» '
                                              WHEN  Status = 1 THEN ' Status : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  usaSeparador IS NULL THEN ' usaSeparador : «Nulo» '
                                              WHEN  usaSeparador = 0 THEN ' usaSeparador : «Falso» '
                                              WHEN  usaSeparador = 1 THEN ' usaSeparador : «Verdadeiro» '
                                    END 
                         + '| Separador : «' + RTRIM( ISNULL( CAST (Separador AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdModeloExp : «' + RTRIM( ISNULL( CAST (IdModeloExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Status IS NULL THEN ' Status : «Nulo» '
                                              WHEN  Status = 0 THEN ' Status : «Falso» '
                                              WHEN  Status = 1 THEN ' Status : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  usaSeparador IS NULL THEN ' usaSeparador : «Nulo» '
                                              WHEN  usaSeparador = 0 THEN ' usaSeparador : «Falso» '
                                              WHEN  usaSeparador = 1 THEN ' usaSeparador : «Verdadeiro» '
                                    END 
                         + '| Separador : «' + RTRIM( ISNULL( CAST (Separador AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdModeloExp : «' + RTRIM( ISNULL( CAST (IdModeloExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Status IS NULL THEN ' Status : «Nulo» '
                                              WHEN  Status = 0 THEN ' Status : «Falso» '
                                              WHEN  Status = 1 THEN ' Status : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  usaSeparador IS NULL THEN ' usaSeparador : «Nulo» '
                                              WHEN  usaSeparador = 0 THEN ' usaSeparador : «Falso» '
                                              WHEN  usaSeparador = 1 THEN ' usaSeparador : «Verdadeiro» '
                                    END 
                         + '| Separador : «' + RTRIM( ISNULL( CAST (Separador AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdModeloExp : «' + RTRIM( ISNULL( CAST (IdModeloExp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Status IS NULL THEN ' Status : «Nulo» '
                                              WHEN  Status = 0 THEN ' Status : «Falso» '
                                              WHEN  Status = 1 THEN ' Status : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  usaSeparador IS NULL THEN ' usaSeparador : «Nulo» '
                                              WHEN  usaSeparador = 0 THEN ' usaSeparador : «Falso» '
                                              WHEN  usaSeparador = 1 THEN ' usaSeparador : «Verdadeiro» '
                                    END 
                         + '| Separador : «' + RTRIM( ISNULL( CAST (Separador AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
