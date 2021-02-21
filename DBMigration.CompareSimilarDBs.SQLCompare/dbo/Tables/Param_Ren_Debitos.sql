CREATE TABLE [dbo].[Param_Ren_Debitos] (
    [IdParam_Ren_Deb] INT NOT NULL,
    [IdTipoDebito]    INT NOT NULL,
    [Permite]         BIT NOT NULL
);


GO
CREATE TRIGGER [TrgLog_Param_Ren_Debitos] ON [Implanta_CRPAM].[dbo].[Param_Ren_Debitos] 
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
SET @TableName = 'Param_Ren_Debitos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdParam_Ren_Deb : «' + RTRIM( ISNULL( CAST (IdParam_Ren_Deb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Permite IS NULL THEN ' Permite : «Nulo» '
                                              WHEN  Permite = 0 THEN ' Permite : «Falso» '
                                              WHEN  Permite = 1 THEN ' Permite : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdParam_Ren_Deb : «' + RTRIM( ISNULL( CAST (IdParam_Ren_Deb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Permite IS NULL THEN ' Permite : «Nulo» '
                                              WHEN  Permite = 0 THEN ' Permite : «Falso» '
                                              WHEN  Permite = 1 THEN ' Permite : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdParam_Ren_Deb : «' + RTRIM( ISNULL( CAST (IdParam_Ren_Deb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Permite IS NULL THEN ' Permite : «Nulo» '
                                              WHEN  Permite = 0 THEN ' Permite : «Falso» '
                                              WHEN  Permite = 1 THEN ' Permite : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdParam_Ren_Deb : «' + RTRIM( ISNULL( CAST (IdParam_Ren_Deb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Permite IS NULL THEN ' Permite : «Nulo» '
                                              WHEN  Permite = 0 THEN ' Permite : «Falso» '
                                              WHEN  Permite = 1 THEN ' Permite : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
