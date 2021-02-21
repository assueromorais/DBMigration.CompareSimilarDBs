CREATE TABLE [dbo].[GruposMalaDireta] (
    [IdGrupoMalaDireta] INT          IDENTITY (1, 1) NOT NULL,
    [GrupoMalaDireta]   VARCHAR (50) NOT NULL,
    [Desativado]        BIT          CONSTRAINT [DF__GruposMal__Desat__703B103B] DEFAULT ((0)) NULL,
    [GrupoGeral]        BIT          CONSTRAINT [DF__GruposMal__Grupo__712F3474] DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([IdGrupoMalaDireta] ASC)
);


GO
CREATE TRIGGER [TrgLog_GruposMalaDireta] ON [Implanta_CRPAM].[dbo].[GruposMalaDireta] 
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
SET @TableName = 'GruposMalaDireta'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdGrupoMalaDireta : «' + RTRIM( ISNULL( CAST (IdGrupoMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| GrupoMalaDireta : «' + RTRIM( ISNULL( CAST (GrupoMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GrupoGeral IS NULL THEN ' GrupoGeral : «Nulo» '
                                              WHEN  GrupoGeral = 0 THEN ' GrupoGeral : «Falso» '
                                              WHEN  GrupoGeral = 1 THEN ' GrupoGeral : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdGrupoMalaDireta : «' + RTRIM( ISNULL( CAST (IdGrupoMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| GrupoMalaDireta : «' + RTRIM( ISNULL( CAST (GrupoMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GrupoGeral IS NULL THEN ' GrupoGeral : «Nulo» '
                                              WHEN  GrupoGeral = 0 THEN ' GrupoGeral : «Falso» '
                                              WHEN  GrupoGeral = 1 THEN ' GrupoGeral : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdGrupoMalaDireta : «' + RTRIM( ISNULL( CAST (IdGrupoMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| GrupoMalaDireta : «' + RTRIM( ISNULL( CAST (GrupoMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GrupoGeral IS NULL THEN ' GrupoGeral : «Nulo» '
                                              WHEN  GrupoGeral = 0 THEN ' GrupoGeral : «Falso» '
                                              WHEN  GrupoGeral = 1 THEN ' GrupoGeral : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdGrupoMalaDireta : «' + RTRIM( ISNULL( CAST (IdGrupoMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| GrupoMalaDireta : «' + RTRIM( ISNULL( CAST (GrupoMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  GrupoGeral IS NULL THEN ' GrupoGeral : «Nulo» '
                                              WHEN  GrupoGeral = 0 THEN ' GrupoGeral : «Falso» '
                                              WHEN  GrupoGeral = 1 THEN ' GrupoGeral : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
