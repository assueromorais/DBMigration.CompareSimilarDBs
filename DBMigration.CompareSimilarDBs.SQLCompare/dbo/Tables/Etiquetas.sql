CREATE TABLE [dbo].[Etiquetas] (
    [IdEtiqueta]          INT          IDENTITY (1, 1) NOT NULL,
    [CamposSelecionados]  TEXT         NULL,
    [MargemSuperior]      FLOAT (53)   NOT NULL,
    [MargemLateral]       FLOAT (53)   NOT NULL,
    [DistanciaVertical]   FLOAT (53)   NOT NULL,
    [DistanciaHorizontal] FLOAT (53)   NOT NULL,
    [Altura]              FLOAT (53)   NOT NULL,
    [Largura]             FLOAT (53)   NOT NULL,
    [QtdeEtiquetasLinha]  INT          NOT NULL,
    [QtdeEtiquetasColuna] INT          NOT NULL,
    [QuebraLinha]         BIT          NULL,
    [LarguraPapel]        FLOAT (53)   NULL,
    [AlturaPapel]         FLOAT (53)   NULL,
    [Retrato]             BIT          NULL,
    [TamanhoPapel]        VARCHAR (30) NULL,
    [IdRelatorio]         INT          NULL,
    [TipoImpressora]      INT          DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Etiquetas] PRIMARY KEY CLUSTERED ([IdEtiqueta] ASC),
    CONSTRAINT [FK_IdRelatorio_Relatorios] FOREIGN KEY ([IdRelatorio]) REFERENCES [dbo].[Relatorios] ([IdRelatorio])
);


GO
CREATE TRIGGER [TrgLog_Etiquetas] ON [Implanta_CRPAM].[dbo].[Etiquetas] 
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
SET @TableName = 'Etiquetas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEtiqueta : «' + RTRIM( ISNULL( CAST (IdEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemLateral : «' + RTRIM( ISNULL( CAST (MargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaVertical : «' + RTRIM( ISNULL( CAST (DistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaHorizontal : «' + RTRIM( ISNULL( CAST (DistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Altura : «' + RTRIM( ISNULL( CAST (Altura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Largura : «' + RTRIM( ISNULL( CAST (Largura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasLinha : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasColuna : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  QuebraLinha IS NULL THEN ' QuebraLinha : «Nulo» '
                                              WHEN  QuebraLinha = 0 THEN ' QuebraLinha : «Falso» '
                                              WHEN  QuebraLinha = 1 THEN ' QuebraLinha : «Verdadeiro» '
                                    END 
                         + '| LarguraPapel : «' + RTRIM( ISNULL( CAST (LarguraPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlturaPapel : «' + RTRIM( ISNULL( CAST (AlturaPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Retrato IS NULL THEN ' Retrato : «Nulo» '
                                              WHEN  Retrato = 0 THEN ' Retrato : «Falso» '
                                              WHEN  Retrato = 1 THEN ' Retrato : «Verdadeiro» '
                                    END 
                         + '| TamanhoPapel : «' + RTRIM( ISNULL( CAST (TamanhoPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImpressora : «' + RTRIM( ISNULL( CAST (TipoImpressora AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEtiqueta : «' + RTRIM( ISNULL( CAST (IdEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemLateral : «' + RTRIM( ISNULL( CAST (MargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaVertical : «' + RTRIM( ISNULL( CAST (DistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaHorizontal : «' + RTRIM( ISNULL( CAST (DistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Altura : «' + RTRIM( ISNULL( CAST (Altura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Largura : «' + RTRIM( ISNULL( CAST (Largura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasLinha : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasColuna : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  QuebraLinha IS NULL THEN ' QuebraLinha : «Nulo» '
                                              WHEN  QuebraLinha = 0 THEN ' QuebraLinha : «Falso» '
                                              WHEN  QuebraLinha = 1 THEN ' QuebraLinha : «Verdadeiro» '
                                    END 
                         + '| LarguraPapel : «' + RTRIM( ISNULL( CAST (LarguraPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlturaPapel : «' + RTRIM( ISNULL( CAST (AlturaPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Retrato IS NULL THEN ' Retrato : «Nulo» '
                                              WHEN  Retrato = 0 THEN ' Retrato : «Falso» '
                                              WHEN  Retrato = 1 THEN ' Retrato : «Verdadeiro» '
                                    END 
                         + '| TamanhoPapel : «' + RTRIM( ISNULL( CAST (TamanhoPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
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
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemLateral : «' + RTRIM( ISNULL( CAST (MargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaVertical : «' + RTRIM( ISNULL( CAST (DistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaHorizontal : «' + RTRIM( ISNULL( CAST (DistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Altura : «' + RTRIM( ISNULL( CAST (Altura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Largura : «' + RTRIM( ISNULL( CAST (Largura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasLinha : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasColuna : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  QuebraLinha IS NULL THEN ' QuebraLinha : «Nulo» '
                                              WHEN  QuebraLinha = 0 THEN ' QuebraLinha : «Falso» '
                                              WHEN  QuebraLinha = 1 THEN ' QuebraLinha : «Verdadeiro» '
                                    END 
                         + '| LarguraPapel : «' + RTRIM( ISNULL( CAST (LarguraPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlturaPapel : «' + RTRIM( ISNULL( CAST (AlturaPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Retrato IS NULL THEN ' Retrato : «Nulo» '
                                              WHEN  Retrato = 0 THEN ' Retrato : «Falso» '
                                              WHEN  Retrato = 1 THEN ' Retrato : «Verdadeiro» '
                                    END 
                         + '| TamanhoPapel : «' + RTRIM( ISNULL( CAST (TamanhoPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImpressora : «' + RTRIM( ISNULL( CAST (TipoImpressora AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEtiqueta : «' + RTRIM( ISNULL( CAST (IdEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemLateral : «' + RTRIM( ISNULL( CAST (MargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaVertical : «' + RTRIM( ISNULL( CAST (DistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaHorizontal : «' + RTRIM( ISNULL( CAST (DistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Altura : «' + RTRIM( ISNULL( CAST (Altura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Largura : «' + RTRIM( ISNULL( CAST (Largura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasLinha : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdeEtiquetasColuna : «' + RTRIM( ISNULL( CAST (QtdeEtiquetasColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  QuebraLinha IS NULL THEN ' QuebraLinha : «Nulo» '
                                              WHEN  QuebraLinha = 0 THEN ' QuebraLinha : «Falso» '
                                              WHEN  QuebraLinha = 1 THEN ' QuebraLinha : «Verdadeiro» '
                                    END 
                         + '| LarguraPapel : «' + RTRIM( ISNULL( CAST (LarguraPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlturaPapel : «' + RTRIM( ISNULL( CAST (AlturaPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Retrato IS NULL THEN ' Retrato : «Nulo» '
                                              WHEN  Retrato = 0 THEN ' Retrato : «Falso» '
                                              WHEN  Retrato = 1 THEN ' Retrato : «Verdadeiro» '
                                    END 
                         + '| TamanhoPapel : «' + RTRIM( ISNULL( CAST (TamanhoPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoImpressora : «' + RTRIM( ISNULL( CAST (TipoImpressora AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
