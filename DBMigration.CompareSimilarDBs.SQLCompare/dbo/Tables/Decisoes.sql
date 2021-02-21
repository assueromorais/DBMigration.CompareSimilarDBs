CREATE TABLE [dbo].[Decisoes] (
    [IdDecisao]       INT          IDENTITY (1, 1) NOT NULL,
    [Decisao]         VARCHAR (60) NOT NULL,
    [Procedente]      BIT          NULL,
    [Inativo]         BIT          NULL,
    [AplicarVigencia] BIT          NULL,
    CONSTRAINT [PK_DecisoesProcesso] PRIMARY KEY CLUSTERED ([IdDecisao] ASC)
);


GO
CREATE TRIGGER [TrgLog_Decisoes] ON [Implanta_CRPAM].[dbo].[Decisoes] 
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
SET @TableName = 'Decisoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDecisao : «' + RTRIM( ISNULL( CAST (IdDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Decisao : «' + RTRIM( ISNULL( CAST (Decisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Procedente IS NULL THEN ' Procedente : «Nulo» '
                                              WHEN  Procedente = 0 THEN ' Procedente : «Falso» '
                                              WHEN  Procedente = 1 THEN ' Procedente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Inativo IS NULL THEN ' Inativo : «Nulo» '
                                              WHEN  Inativo = 0 THEN ' Inativo : «Falso» '
                                              WHEN  Inativo = 1 THEN ' Inativo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AplicarVigencia IS NULL THEN ' AplicarVigencia : «Nulo» '
                                              WHEN  AplicarVigencia = 0 THEN ' AplicarVigencia : «Falso» '
                                              WHEN  AplicarVigencia = 1 THEN ' AplicarVigencia : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdDecisao : «' + RTRIM( ISNULL( CAST (IdDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Decisao : «' + RTRIM( ISNULL( CAST (Decisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Procedente IS NULL THEN ' Procedente : «Nulo» '
                                              WHEN  Procedente = 0 THEN ' Procedente : «Falso» '
                                              WHEN  Procedente = 1 THEN ' Procedente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Inativo IS NULL THEN ' Inativo : «Nulo» '
                                              WHEN  Inativo = 0 THEN ' Inativo : «Falso» '
                                              WHEN  Inativo = 1 THEN ' Inativo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AplicarVigencia IS NULL THEN ' AplicarVigencia : «Nulo» '
                                              WHEN  AplicarVigencia = 0 THEN ' AplicarVigencia : «Falso» '
                                              WHEN  AplicarVigencia = 1 THEN ' AplicarVigencia : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdDecisao : «' + RTRIM( ISNULL( CAST (IdDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Decisao : «' + RTRIM( ISNULL( CAST (Decisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Procedente IS NULL THEN ' Procedente : «Nulo» '
                                              WHEN  Procedente = 0 THEN ' Procedente : «Falso» '
                                              WHEN  Procedente = 1 THEN ' Procedente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Inativo IS NULL THEN ' Inativo : «Nulo» '
                                              WHEN  Inativo = 0 THEN ' Inativo : «Falso» '
                                              WHEN  Inativo = 1 THEN ' Inativo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AplicarVigencia IS NULL THEN ' AplicarVigencia : «Nulo» '
                                              WHEN  AplicarVigencia = 0 THEN ' AplicarVigencia : «Falso» '
                                              WHEN  AplicarVigencia = 1 THEN ' AplicarVigencia : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDecisao : «' + RTRIM( ISNULL( CAST (IdDecisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Decisao : «' + RTRIM( ISNULL( CAST (Decisao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Procedente IS NULL THEN ' Procedente : «Nulo» '
                                              WHEN  Procedente = 0 THEN ' Procedente : «Falso» '
                                              WHEN  Procedente = 1 THEN ' Procedente : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Inativo IS NULL THEN ' Inativo : «Nulo» '
                                              WHEN  Inativo = 0 THEN ' Inativo : «Falso» '
                                              WHEN  Inativo = 1 THEN ' Inativo : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  AplicarVigencia IS NULL THEN ' AplicarVigencia : «Nulo» '
                                              WHEN  AplicarVigencia = 0 THEN ' AplicarVigencia : «Falso» '
                                              WHEN  AplicarVigencia = 1 THEN ' AplicarVigencia : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
