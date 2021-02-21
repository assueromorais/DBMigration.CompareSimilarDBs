CREATE TABLE [dbo].[Atividades] (
    [IdAtividade]      INT          IDENTITY (1, 1) NOT NULL,
    [NomeAtividade]    VARCHAR (40) NOT NULL,
    [IdGrupoAtividade] INT          NULL,
    [Desativado]       BIT          CONSTRAINT [DF_AtividadesDesativado] DEFAULT ((0)) NULL,
    [IndCriacaoWeb]    BIT          CONSTRAINT [DF_AtividadesIndCriacaoWeb] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Atividades] PRIMARY KEY NONCLUSTERED ([IdAtividade] ASC),
    CONSTRAINT [FK_Atividades_Atividades] FOREIGN KEY ([IdGrupoAtividade]) REFERENCES [dbo].[Atividades] ([IdAtividade]) NOT FOR REPLICATION
);


GO
CREATE NONCLUSTERED INDEX [IdGrupoAtividade]
    ON [dbo].[Atividades]([IdGrupoAtividade] ASC);


GO
CREATE NONCLUSTERED INDEX [IndNomeAtividade]
    ON [dbo].[Atividades]([NomeAtividade] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Atividades]
    ON [dbo].[Atividades]([IdGrupoAtividade] ASC, [NomeAtividade] ASC);


GO
CREATE TRIGGER [TrgLog_Atividades] ON [Implanta_CRPAM].[dbo].[Atividades] 
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
SET @TableName = 'Atividades'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAtividade : «' + RTRIM( ISNULL( CAST (IdAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeAtividade : «' + RTRIM( ISNULL( CAST (NomeAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoAtividade : «' + RTRIM( ISNULL( CAST (IdGrupoAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdAtividade : «' + RTRIM( ISNULL( CAST (IdAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeAtividade : «' + RTRIM( ISNULL( CAST (NomeAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoAtividade : «' + RTRIM( ISNULL( CAST (IdGrupoAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdAtividade : «' + RTRIM( ISNULL( CAST (IdAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeAtividade : «' + RTRIM( ISNULL( CAST (NomeAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoAtividade : «' + RTRIM( ISNULL( CAST (IdGrupoAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAtividade : «' + RTRIM( ISNULL( CAST (IdAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeAtividade : «' + RTRIM( ISNULL( CAST (NomeAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoAtividade : «' + RTRIM( ISNULL( CAST (IdGrupoAtividade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  IndCriacaoWeb IS NULL THEN ' IndCriacaoWeb : «Nulo» '
                                              WHEN  IndCriacaoWeb = 0 THEN ' IndCriacaoWeb : «Falso» '
                                              WHEN  IndCriacaoWeb = 1 THEN ' IndCriacaoWeb : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
