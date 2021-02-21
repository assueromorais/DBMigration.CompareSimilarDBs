CREATE TABLE [dbo].[Eleicoes] (
    [IdEleicao]            INT          IDENTITY (1, 1) NOT NULL,
    [IdConselho]           INT          NOT NULL,
    [Descricao]            VARCHAR (30) NOT NULL,
    [DataInicialEleicao]   DATETIME     NULL,
    [DataTerminoEleicao]   DATETIME     NULL,
    [PorUrna]              BIT          NULL,
    [Observacoes]          TEXT         NULL,
    [EleicaoPorImportacao] BIT          CONSTRAINT [DF_Eleicoes_EleicaoPorImportacao] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Eleicoes] PRIMARY KEY CLUSTERED ([IdEleicao] ASC, [IdConselho] ASC)
);


GO
CREATE TRIGGER [TrgLog_Eleicoes] ON [Implanta_CRPAM].[dbo].[Eleicoes] 
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
SET @TableName = 'Eleicoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEleicao : «' + RTRIM( ISNULL( CAST (IdEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConselho : «' + RTRIM( ISNULL( CAST (IdConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicialEleicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicialEleicao, 113 ),'Nulo'))+'» '
                         + '| DataTerminoEleicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTerminoEleicao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PorUrna IS NULL THEN ' PorUrna : «Nulo» '
                                              WHEN  PorUrna = 0 THEN ' PorUrna : «Falso» '
                                              WHEN  PorUrna = 1 THEN ' PorUrna : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EleicaoPorImportacao IS NULL THEN ' EleicaoPorImportacao : «Nulo» '
                                              WHEN  EleicaoPorImportacao = 0 THEN ' EleicaoPorImportacao : «Falso» '
                                              WHEN  EleicaoPorImportacao = 1 THEN ' EleicaoPorImportacao : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdEleicao : «' + RTRIM( ISNULL( CAST (IdEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConselho : «' + RTRIM( ISNULL( CAST (IdConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicialEleicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicialEleicao, 113 ),'Nulo'))+'» '
                         + '| DataTerminoEleicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTerminoEleicao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PorUrna IS NULL THEN ' PorUrna : «Nulo» '
                                              WHEN  PorUrna = 0 THEN ' PorUrna : «Falso» '
                                              WHEN  PorUrna = 1 THEN ' PorUrna : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EleicaoPorImportacao IS NULL THEN ' EleicaoPorImportacao : «Nulo» '
                                              WHEN  EleicaoPorImportacao = 0 THEN ' EleicaoPorImportacao : «Falso» '
                                              WHEN  EleicaoPorImportacao = 1 THEN ' EleicaoPorImportacao : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdEleicao : «' + RTRIM( ISNULL( CAST (IdEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConselho : «' + RTRIM( ISNULL( CAST (IdConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicialEleicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicialEleicao, 113 ),'Nulo'))+'» '
                         + '| DataTerminoEleicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTerminoEleicao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PorUrna IS NULL THEN ' PorUrna : «Nulo» '
                                              WHEN  PorUrna = 0 THEN ' PorUrna : «Falso» '
                                              WHEN  PorUrna = 1 THEN ' PorUrna : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EleicaoPorImportacao IS NULL THEN ' EleicaoPorImportacao : «Nulo» '
                                              WHEN  EleicaoPorImportacao = 0 THEN ' EleicaoPorImportacao : «Falso» '
                                              WHEN  EleicaoPorImportacao = 1 THEN ' EleicaoPorImportacao : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEleicao : «' + RTRIM( ISNULL( CAST (IdEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConselho : «' + RTRIM( ISNULL( CAST (IdConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicialEleicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicialEleicao, 113 ),'Nulo'))+'» '
                         + '| DataTerminoEleicao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTerminoEleicao, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  PorUrna IS NULL THEN ' PorUrna : «Nulo» '
                                              WHEN  PorUrna = 0 THEN ' PorUrna : «Falso» '
                                              WHEN  PorUrna = 1 THEN ' PorUrna : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EleicaoPorImportacao IS NULL THEN ' EleicaoPorImportacao : «Nulo» '
                                              WHEN  EleicaoPorImportacao = 0 THEN ' EleicaoPorImportacao : «Falso» '
                                              WHEN  EleicaoPorImportacao = 1 THEN ' EleicaoPorImportacao : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
