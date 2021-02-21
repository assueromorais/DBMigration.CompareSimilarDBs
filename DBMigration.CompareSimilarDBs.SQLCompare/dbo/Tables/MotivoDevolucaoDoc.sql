CREATE TABLE [dbo].[MotivoDevolucaoDoc] (
    [IdMotivoDevolucao]   INT          IDENTITY (1, 1) NOT NULL,
    [MotivoDevolucao]     VARCHAR (30) NOT NULL,
    [DesatualizaEndereco] BIT          NULL,
    [Desativado]          BIT          NULL,
    CONSTRAINT [PK_MotivoDevolucaoDoc] PRIMARY KEY CLUSTERED ([IdMotivoDevolucao] ASC)
);


GO
CREATE TRIGGER [TrgLog_MotivoDevolucaoDoc] ON [Implanta_CRPAM].[dbo].[MotivoDevolucaoDoc] 
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
SET @TableName = 'MotivoDevolucaoDoc'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMotivoDevolucao : «' + RTRIM( ISNULL( CAST (IdMotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoDevolucao : «' + RTRIM( ISNULL( CAST (MotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesatualizaEndereco IS NULL THEN ' DesatualizaEndereco : «Nulo» '
                                              WHEN  DesatualizaEndereco = 0 THEN ' DesatualizaEndereco : «Falso» '
                                              WHEN  DesatualizaEndereco = 1 THEN ' DesatualizaEndereco : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdMotivoDevolucao : «' + RTRIM( ISNULL( CAST (IdMotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoDevolucao : «' + RTRIM( ISNULL( CAST (MotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesatualizaEndereco IS NULL THEN ' DesatualizaEndereco : «Nulo» '
                                              WHEN  DesatualizaEndereco = 0 THEN ' DesatualizaEndereco : «Falso» '
                                              WHEN  DesatualizaEndereco = 1 THEN ' DesatualizaEndereco : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdMotivoDevolucao : «' + RTRIM( ISNULL( CAST (IdMotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoDevolucao : «' + RTRIM( ISNULL( CAST (MotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesatualizaEndereco IS NULL THEN ' DesatualizaEndereco : «Nulo» '
                                              WHEN  DesatualizaEndereco = 0 THEN ' DesatualizaEndereco : «Falso» '
                                              WHEN  DesatualizaEndereco = 1 THEN ' DesatualizaEndereco : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMotivoDevolucao : «' + RTRIM( ISNULL( CAST (IdMotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MotivoDevolucao : «' + RTRIM( ISNULL( CAST (MotivoDevolucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  DesatualizaEndereco IS NULL THEN ' DesatualizaEndereco : «Nulo» '
                                              WHEN  DesatualizaEndereco = 0 THEN ' DesatualizaEndereco : «Falso» '
                                              WHEN  DesatualizaEndereco = 1 THEN ' DesatualizaEndereco : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
