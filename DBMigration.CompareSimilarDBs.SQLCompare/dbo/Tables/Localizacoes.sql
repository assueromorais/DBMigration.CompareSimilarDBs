CREATE TABLE [dbo].[Localizacoes] (
    [IdLocalizacao]  INT  IDENTITY (1, 1) NOT NULL,
    [IdSubItem]      INT  NOT NULL,
    [IdAlmoxarifado] INT  NOT NULL,
    [Localizacao]    TEXT NULL,
    [Desativado]     BIT  CONSTRAINT [DF_LocalizacoesDesativado] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Localizacoes] PRIMARY KEY NONCLUSTERED ([IdLocalizacao] ASC),
    CONSTRAINT [FK_Localizacoes_Almoxarifados] FOREIGN KEY ([IdAlmoxarifado]) REFERENCES [dbo].[Almoxarifados] ([IdAlmoxarifado]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Localizacoes_SubItens] FOREIGN KEY ([IdSubItem]) REFERENCES [dbo].[SubItens] ([IdSubItem]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_Localizacoes] ON [Implanta_CRPAM].[dbo].[Localizacoes] 
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
SET @TableName = 'Localizacoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLocalizacao : «' + RTRIM( ISNULL( CAST (IdLocalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desativado IS NULL THEN ' Desativado : «Nulo» '
                                              WHEN  Desativado = 0 THEN ' Desativado : «Falso» '
                                              WHEN  Desativado = 1 THEN ' Desativado : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdLocalizacao : «' + RTRIM( ISNULL( CAST (IdLocalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
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
		SELECT @Conteudo = 'IdLocalizacao : «' + RTRIM( ISNULL( CAST (IdLocalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
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
		SELECT @Conteudo = 'IdLocalizacao : «' + RTRIM( ISNULL( CAST (IdLocalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSubItem : «' + RTRIM( ISNULL( CAST (IdSubItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAlmoxarifado : «' + RTRIM( ISNULL( CAST (IdAlmoxarifado AS VARCHAR(3500)),'Nulo'))+'» '
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
