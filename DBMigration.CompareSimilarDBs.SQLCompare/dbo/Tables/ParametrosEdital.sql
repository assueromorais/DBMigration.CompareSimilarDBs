CREATE TABLE [dbo].[ParametrosEdital] (
    [IdFase]                INT           NULL,
    [Assinatura]            VARCHAR (60)  NULL,
    [Cargo]                 VARCHAR (40)  NULL,
    [Especie]               VARCHAR (40)  NULL,
    [ListarNomesAbreviados] BIT           NULL,
    [textosuperior]         VARCHAR (500) NULL,
    [textoinferior]         VARCHAR (500) NULL,
    CONSTRAINT [FK_ParametrosEdital_Fases] FOREIGN KEY ([IdFase]) REFERENCES [dbo].[Fases] ([IdFase])
);


GO
CREATE TRIGGER [TrgLog_ParametrosEdital] ON [Implanta_CRPAM].[dbo].[ParametrosEdital] 
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
SET @TableName = 'ParametrosEdital'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdFase : «' + RTRIM( ISNULL( CAST (IdFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura : «' + RTRIM( ISNULL( CAST (Assinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Especie : «' + RTRIM( ISNULL( CAST (Especie AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ListarNomesAbreviados IS NULL THEN ' ListarNomesAbreviados : «Nulo» '
                                              WHEN  ListarNomesAbreviados = 0 THEN ' ListarNomesAbreviados : «Falso» '
                                              WHEN  ListarNomesAbreviados = 1 THEN ' ListarNomesAbreviados : «Verdadeiro» '
                                    END 
                         + '| textosuperior : «' + RTRIM( ISNULL( CAST (textosuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| textoinferior : «' + RTRIM( ISNULL( CAST (textoinferior AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdFase : «' + RTRIM( ISNULL( CAST (IdFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura : «' + RTRIM( ISNULL( CAST (Assinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Especie : «' + RTRIM( ISNULL( CAST (Especie AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ListarNomesAbreviados IS NULL THEN ' ListarNomesAbreviados : «Nulo» '
                                              WHEN  ListarNomesAbreviados = 0 THEN ' ListarNomesAbreviados : «Falso» '
                                              WHEN  ListarNomesAbreviados = 1 THEN ' ListarNomesAbreviados : «Verdadeiro» '
                                    END 
                         + '| textosuperior : «' + RTRIM( ISNULL( CAST (textosuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| textoinferior : «' + RTRIM( ISNULL( CAST (textoinferior AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdFase : «' + RTRIM( ISNULL( CAST (IdFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura : «' + RTRIM( ISNULL( CAST (Assinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Especie : «' + RTRIM( ISNULL( CAST (Especie AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ListarNomesAbreviados IS NULL THEN ' ListarNomesAbreviados : «Nulo» '
                                              WHEN  ListarNomesAbreviados = 0 THEN ' ListarNomesAbreviados : «Falso» '
                                              WHEN  ListarNomesAbreviados = 1 THEN ' ListarNomesAbreviados : «Verdadeiro» '
                                    END 
                         + '| textosuperior : «' + RTRIM( ISNULL( CAST (textosuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| textoinferior : «' + RTRIM( ISNULL( CAST (textoinferior AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdFase : «' + RTRIM( ISNULL( CAST (IdFase AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assinatura : «' + RTRIM( ISNULL( CAST (Assinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cargo : «' + RTRIM( ISNULL( CAST (Cargo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Especie : «' + RTRIM( ISNULL( CAST (Especie AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ListarNomesAbreviados IS NULL THEN ' ListarNomesAbreviados : «Nulo» '
                                              WHEN  ListarNomesAbreviados = 0 THEN ' ListarNomesAbreviados : «Falso» '
                                              WHEN  ListarNomesAbreviados = 1 THEN ' ListarNomesAbreviados : «Verdadeiro» '
                                    END 
                         + '| textosuperior : «' + RTRIM( ISNULL( CAST (textosuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| textoinferior : «' + RTRIM( ISNULL( CAST (textoinferior AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
