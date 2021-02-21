CREATE TABLE [dbo].[HistoricoScript] (
    [IdHistScript]  INT      IDENTITY (1, 1) NOT NULL,
    [NumVersao]     INT      NULL,
    [Data]          DATETIME NULL,
    [FormaExecucao] INT      NULL,
    [NumScript]     INT      NULL,
    [Erro]          BIT      NULL
);


GO
CREATE TRIGGER [TrgLog_HistoricoScript] ON [Implanta_CRPAM].[dbo].[HistoricoScript] 
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
SET @TableName = 'HistoricoScript'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistScript : «' + RTRIM( ISNULL( CAST (IdHistScript AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumVersao : «' + RTRIM( ISNULL( CAST (NumVersao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| FormaExecucao : «' + RTRIM( ISNULL( CAST (FormaExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumScript : «' + RTRIM( ISNULL( CAST (NumScript AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Erro IS NULL THEN ' Erro : «Nulo» '
                                              WHEN  Erro = 0 THEN ' Erro : «Falso» '
                                              WHEN  Erro = 1 THEN ' Erro : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdHistScript : «' + RTRIM( ISNULL( CAST (IdHistScript AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumVersao : «' + RTRIM( ISNULL( CAST (NumVersao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| FormaExecucao : «' + RTRIM( ISNULL( CAST (FormaExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumScript : «' + RTRIM( ISNULL( CAST (NumScript AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Erro IS NULL THEN ' Erro : «Nulo» '
                                              WHEN  Erro = 0 THEN ' Erro : «Falso» '
                                              WHEN  Erro = 1 THEN ' Erro : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdHistScript : «' + RTRIM( ISNULL( CAST (IdHistScript AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumVersao : «' + RTRIM( ISNULL( CAST (NumVersao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| FormaExecucao : «' + RTRIM( ISNULL( CAST (FormaExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumScript : «' + RTRIM( ISNULL( CAST (NumScript AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Erro IS NULL THEN ' Erro : «Nulo» '
                                              WHEN  Erro = 0 THEN ' Erro : «Falso» '
                                              WHEN  Erro = 1 THEN ' Erro : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistScript : «' + RTRIM( ISNULL( CAST (IdHistScript AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumVersao : «' + RTRIM( ISNULL( CAST (NumVersao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| FormaExecucao : «' + RTRIM( ISNULL( CAST (FormaExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumScript : «' + RTRIM( ISNULL( CAST (NumScript AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Erro IS NULL THEN ' Erro : «Nulo» '
                                              WHEN  Erro = 0 THEN ' Erro : «Falso» '
                                              WHEN  Erro = 1 THEN ' Erro : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
