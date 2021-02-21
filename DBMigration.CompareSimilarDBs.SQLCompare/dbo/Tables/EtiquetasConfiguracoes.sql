CREATE TABLE [dbo].[EtiquetasConfiguracoes] (
    [IdEtiquetasConfiguracoes] INT          IDENTITY (1, 1) NOT NULL,
    [Descricao]                VARCHAR (50) NOT NULL,
    [IdEtiquetasPapel]         INT          NOT NULL,
    [EtiquetasPorLinha]        INT          NOT NULL,
    [EtiquetasPorColuna]       INT          NOT NULL,
    [AlturaEtiqueta]           FLOAT (53)   NOT NULL,
    [LarguraEtiqueta]          FLOAT (53)   NOT NULL,
    [MargemSuperior]           FLOAT (53)   NOT NULL,
    [MargemLateral]            FLOAT (53)   NOT NULL,
    [DistanciaVertical]        FLOAT (53)   NOT NULL,
    [DistanciaHorizontal]      FLOAT (53)   NOT NULL,
    [Desabilitado]             BIT          NOT NULL,
    CONSTRAINT [PK_EtiquetasConfiguracoes] PRIMARY KEY CLUSTERED ([IdEtiquetasConfiguracoes] ASC),
    CONSTRAINT [FK_EtiquetasPapel] FOREIGN KEY ([IdEtiquetasPapel]) REFERENCES [dbo].[EtiquetasPapel] ([IdEtiquetasPapel])
);


GO
CREATE TRIGGER [TrgLog_EtiquetasConfiguracoes] ON [Implanta_CRPAM].[dbo].[EtiquetasConfiguracoes] 
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
SET @TableName = 'EtiquetasConfiguracoes'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEtiquetasConfiguracoes : «' + RTRIM( ISNULL( CAST (IdEtiquetasConfiguracoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtiquetasPapel : «' + RTRIM( ISNULL( CAST (IdEtiquetasPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetasPorLinha : «' + RTRIM( ISNULL( CAST (EtiquetasPorLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetasPorColuna : «' + RTRIM( ISNULL( CAST (EtiquetasPorColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlturaEtiqueta : «' + RTRIM( ISNULL( CAST (AlturaEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LarguraEtiqueta : «' + RTRIM( ISNULL( CAST (LarguraEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemLateral : «' + RTRIM( ISNULL( CAST (MargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaVertical : «' + RTRIM( ISNULL( CAST (DistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaHorizontal : «' + RTRIM( ISNULL( CAST (DistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desabilitado IS NULL THEN ' Desabilitado : «Nulo» '
                                              WHEN  Desabilitado = 0 THEN ' Desabilitado : «Falso» '
                                              WHEN  Desabilitado = 1 THEN ' Desabilitado : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdEtiquetasConfiguracoes : «' + RTRIM( ISNULL( CAST (IdEtiquetasConfiguracoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtiquetasPapel : «' + RTRIM( ISNULL( CAST (IdEtiquetasPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetasPorLinha : «' + RTRIM( ISNULL( CAST (EtiquetasPorLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetasPorColuna : «' + RTRIM( ISNULL( CAST (EtiquetasPorColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlturaEtiqueta : «' + RTRIM( ISNULL( CAST (AlturaEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LarguraEtiqueta : «' + RTRIM( ISNULL( CAST (LarguraEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemLateral : «' + RTRIM( ISNULL( CAST (MargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaVertical : «' + RTRIM( ISNULL( CAST (DistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaHorizontal : «' + RTRIM( ISNULL( CAST (DistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desabilitado IS NULL THEN ' Desabilitado : «Nulo» '
                                              WHEN  Desabilitado = 0 THEN ' Desabilitado : «Falso» '
                                              WHEN  Desabilitado = 1 THEN ' Desabilitado : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdEtiquetasConfiguracoes : «' + RTRIM( ISNULL( CAST (IdEtiquetasConfiguracoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtiquetasPapel : «' + RTRIM( ISNULL( CAST (IdEtiquetasPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetasPorLinha : «' + RTRIM( ISNULL( CAST (EtiquetasPorLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetasPorColuna : «' + RTRIM( ISNULL( CAST (EtiquetasPorColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlturaEtiqueta : «' + RTRIM( ISNULL( CAST (AlturaEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LarguraEtiqueta : «' + RTRIM( ISNULL( CAST (LarguraEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemLateral : «' + RTRIM( ISNULL( CAST (MargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaVertical : «' + RTRIM( ISNULL( CAST (DistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaHorizontal : «' + RTRIM( ISNULL( CAST (DistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desabilitado IS NULL THEN ' Desabilitado : «Nulo» '
                                              WHEN  Desabilitado = 0 THEN ' Desabilitado : «Falso» '
                                              WHEN  Desabilitado = 1 THEN ' Desabilitado : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEtiquetasConfiguracoes : «' + RTRIM( ISNULL( CAST (IdEtiquetasConfiguracoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtiquetasPapel : «' + RTRIM( ISNULL( CAST (IdEtiquetasPapel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetasPorLinha : «' + RTRIM( ISNULL( CAST (EtiquetasPorLinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EtiquetasPorColuna : «' + RTRIM( ISNULL( CAST (EtiquetasPorColuna AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AlturaEtiqueta : «' + RTRIM( ISNULL( CAST (AlturaEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LarguraEtiqueta : «' + RTRIM( ISNULL( CAST (LarguraEtiqueta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemSuperior : «' + RTRIM( ISNULL( CAST (MargemSuperior AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| MargemLateral : «' + RTRIM( ISNULL( CAST (MargemLateral AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaVertical : «' + RTRIM( ISNULL( CAST (DistanciaVertical AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DistanciaHorizontal : «' + RTRIM( ISNULL( CAST (DistanciaHorizontal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Desabilitado IS NULL THEN ' Desabilitado : «Nulo» '
                                              WHEN  Desabilitado = 0 THEN ' Desabilitado : «Falso» '
                                              WHEN  Desabilitado = 1 THEN ' Desabilitado : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
