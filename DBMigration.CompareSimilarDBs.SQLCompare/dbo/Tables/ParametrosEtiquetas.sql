CREATE TABLE [dbo].[ParametrosEtiquetas] (
    [IdEtiqueta]                  INT          IDENTITY (1, 1) NOT NULL,
    [NomeConfiguracao]            VARCHAR (25) NOT NULL,
    [EtiquetaPadrao]              BIT          NOT NULL,
    [EtiquetaMargemSuperior]      FLOAT (53)   NULL,
    [EtiquetaMargemLateral]       FLOAT (53)   NULL,
    [EtiquetaDistanciaVertical]   FLOAT (53)   NULL,
    [EtiquetaDistanciaHorizontal] FLOAT (53)   NULL,
    [EtiquetaAltura]              FLOAT (53)   NULL,
    [EtiquetaLargura]             FLOAT (53)   NULL,
    [QtdeEtiquetasLinha]          FLOAT (53)   NULL,
    [QtdeEtiquetasColuna]         FLOAT (53)   NULL,
    [EtiquetaTamanhoPapel]        VARCHAR (30) NULL,
    [LarguraPapel]                FLOAT (53)   DEFAULT ((0)) NOT NULL,
    [AlturaPapel]                 FLOAT (53)   DEFAULT ((0)) NOT NULL,
    [TipoImpressora]              INT          DEFAULT ((0)) NOT NULL
);


GO
CREATE TRIGGER [TrgLog_ParametrosEtiquetas] ON [Implanta_CRPAM].[dbo].[ParametrosEtiquetas] 
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
SET @TableName = 'ParametrosEtiquetas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEtiqueta : «' + RTRIM( ISNULL( CAST (IdEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConfiguracao : «' + RTRIM( ISNULL( CAST (NomeConfiguracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EtiquetaPadrao IS NULL THEN ' EtiquetaPadrao : «Nulo» '
                                              WHEN  EtiquetaPadrao = 0 THEN ' EtiquetaPadrao : «Falso» '
                                              WHEN  EtiquetaPadrao = 1 THEN ' EtiquetaPadrao : «Verdadeiro» '
                                    END 
                         + '| EtiquetaMargemSuperior : «' + RTRIM( ISNULL( CAST (EtiquetaMargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaMargemLateral : «' + RTRIM( ISNULL( CAST (EtiquetaMargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaVertical : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaHorizontal : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaAltura : «' + RTRIM( ISNULL( CAST (EtiquetaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaLargura : «' + RTRIM( ISNULL( CAST (EtiquetaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasLinha : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasColuna : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaTamanhoPapel : «' + RTRIM( ISNULL( CAST (EtiquetaTamanhoPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LarguraPapel : «' + RTRIM( ISNULL( CAST (LarguraPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlturaPapel : «' + RTRIM( ISNULL( CAST (AlturaPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImpressora : «' + RTRIM( ISNULL( CAST (TipoImpressora AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEtiqueta : «' + RTRIM( ISNULL( CAST (IdEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConfiguracao : «' + RTRIM( ISNULL( CAST (NomeConfiguracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EtiquetaPadrao IS NULL THEN ' EtiquetaPadrao : «Nulo» '
                                              WHEN  EtiquetaPadrao = 0 THEN ' EtiquetaPadrao : «Falso» '
                                              WHEN  EtiquetaPadrao = 1 THEN ' EtiquetaPadrao : «Verdadeiro» '
                                    END 
                         + '| EtiquetaMargemSuperior : «' + RTRIM( ISNULL( CAST (EtiquetaMargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaMargemLateral : «' + RTRIM( ISNULL( CAST (EtiquetaMargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaVertical : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaHorizontal : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaAltura : «' + RTRIM( ISNULL( CAST (EtiquetaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaLargura : «' + RTRIM( ISNULL( CAST (EtiquetaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasLinha : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasColuna : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaTamanhoPapel : «' + RTRIM( ISNULL( CAST (EtiquetaTamanhoPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LarguraPapel : «' + RTRIM( ISNULL( CAST (LarguraPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlturaPapel : «' + RTRIM( ISNULL( CAST (AlturaPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImpressora : «' + RTRIM( ISNULL( CAST (TipoImpressora AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEtiqueta : «' + RTRIM( ISNULL( CAST (IdEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConfiguracao : «' + RTRIM( ISNULL( CAST (NomeConfiguracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EtiquetaPadrao IS NULL THEN ' EtiquetaPadrao : «Nulo» '
                                              WHEN  EtiquetaPadrao = 0 THEN ' EtiquetaPadrao : «Falso» '
                                              WHEN  EtiquetaPadrao = 1 THEN ' EtiquetaPadrao : «Verdadeiro» '
                                    END 
                         + '| EtiquetaMargemSuperior : «' + RTRIM( ISNULL( CAST (EtiquetaMargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaMargemLateral : «' + RTRIM( ISNULL( CAST (EtiquetaMargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaVertical : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaHorizontal : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaAltura : «' + RTRIM( ISNULL( CAST (EtiquetaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaLargura : «' + RTRIM( ISNULL( CAST (EtiquetaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasLinha : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasColuna : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaTamanhoPapel : «' + RTRIM( ISNULL( CAST (EtiquetaTamanhoPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LarguraPapel : «' + RTRIM( ISNULL( CAST (LarguraPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlturaPapel : «' + RTRIM( ISNULL( CAST (AlturaPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImpressora : «' + RTRIM( ISNULL( CAST (TipoImpressora AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEtiqueta : «' + RTRIM( ISNULL( CAST (IdEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeConfiguracao : «' + RTRIM( ISNULL( CAST (NomeConfiguracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EtiquetaPadrao IS NULL THEN ' EtiquetaPadrao : «Nulo» '
                                              WHEN  EtiquetaPadrao = 0 THEN ' EtiquetaPadrao : «Falso» '
                                              WHEN  EtiquetaPadrao = 1 THEN ' EtiquetaPadrao : «Verdadeiro» '
                                    END 
                         + '| EtiquetaMargemSuperior : «' + RTRIM( ISNULL( CAST (EtiquetaMargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaMargemLateral : «' + RTRIM( ISNULL( CAST (EtiquetaMargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaVertical : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaDistanciaHorizontal : «' + RTRIM( ISNULL( CAST (EtiquetaDistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaAltura : «' + RTRIM( ISNULL( CAST (EtiquetaAltura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaLargura : «' + RTRIM( ISNULL( CAST (EtiquetaLargura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasLinha : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasColuna : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetaTamanhoPapel : «' + RTRIM( ISNULL( CAST (EtiquetaTamanhoPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LarguraPapel : «' + RTRIM( ISNULL( CAST (LarguraPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlturaPapel : «' + RTRIM( ISNULL( CAST (AlturaPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImpressora : «' + RTRIM( ISNULL( CAST (TipoImpressora AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
