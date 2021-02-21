CREATE TABLE [dbo].[ConfigDetalheArquivosRetorno] (
    [IdConfigDetalhe]         INT          IDENTITY (1, 1) NOT NULL,
    [IdConfigHeader]          INT          NULL,
    [PosIni]                  INT          NULL,
    [QtdDig]                  INT          NULL,
    [Conteudo]                VARCHAR (50) NULL,
    [DataType]                VARCHAR (10) NULL,
    [Segmento]                VARCHAR (1)  NULL,
    [CondicaoIni01]           INT          NULL,
    [CondicaoQtd01]           INT          NULL,
    [CondicaoEsperado01]      VARCHAR (50) NULL,
    [CondicaoResultadoIniV01] INT          NULL,
    [CondicaoResultadoQtdV01] INT          NULL,
    [CondicaoResultadoIniF01] INT          NULL,
    [CondicaoResultadoQtdF01] INT          NULL,
    [CondicaoIni02]           INT          NULL,
    [CondicaoQtd02]           INT          NULL,
    [CondicaoEsperado02]      VARCHAR (50) NULL,
    [CondicaoResultadoIniV02] INT          NULL,
    [CondicaoResultadoQtdV02] INT          NULL,
    [CondicaoResultadoIniF02] INT          NULL,
    [CondicaoResultadoQtdF02] INT          NULL,
    CONSTRAINT [PK_ConfigDetalheArquivosRetorno] PRIMARY KEY CLUSTERED ([IdConfigDetalhe] ASC)
);


GO
CREATE TRIGGER [TrgLog_ConfigDetalheArquivosRetorno] ON [Implanta_CRPAM].[dbo].[ConfigDetalheArquivosRetorno] 
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
SET @TableName = 'ConfigDetalheArquivosRetorno'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfigDetalhe : «' + RTRIM( ISNULL( CAST (IdConfigDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigHeader : «' + RTRIM( ISNULL( CAST (IdConfigHeader AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PosIni : «' + RTRIM( ISNULL( CAST (PosIni AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDig : «' + RTRIM( ISNULL( CAST (QtdDig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conteudo : «' + RTRIM( ISNULL( CAST (Conteudo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataType : «' + RTRIM( ISNULL( CAST (DataType AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Segmento : «' + RTRIM( ISNULL( CAST (Segmento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoIni01 : «' + RTRIM( ISNULL( CAST (CondicaoIni01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoQtd01 : «' + RTRIM( ISNULL( CAST (CondicaoQtd01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoEsperado01 : «' + RTRIM( ISNULL( CAST (CondicaoEsperado01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniV01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniV01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdV01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdV01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniF01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniF01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdF01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdF01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoIni02 : «' + RTRIM( ISNULL( CAST (CondicaoIni02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoQtd02 : «' + RTRIM( ISNULL( CAST (CondicaoQtd02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoEsperado02 : «' + RTRIM( ISNULL( CAST (CondicaoEsperado02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniV02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniV02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdV02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdV02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniF02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniF02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdF02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdF02 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConfigDetalhe : «' + RTRIM( ISNULL( CAST (IdConfigDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigHeader : «' + RTRIM( ISNULL( CAST (IdConfigHeader AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PosIni : «' + RTRIM( ISNULL( CAST (PosIni AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDig : «' + RTRIM( ISNULL( CAST (QtdDig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conteudo : «' + RTRIM( ISNULL( CAST (Conteudo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataType : «' + RTRIM( ISNULL( CAST (DataType AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Segmento : «' + RTRIM( ISNULL( CAST (Segmento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoIni01 : «' + RTRIM( ISNULL( CAST (CondicaoIni01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoQtd01 : «' + RTRIM( ISNULL( CAST (CondicaoQtd01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoEsperado01 : «' + RTRIM( ISNULL( CAST (CondicaoEsperado01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniV01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniV01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdV01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdV01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniF01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniF01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdF01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdF01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoIni02 : «' + RTRIM( ISNULL( CAST (CondicaoIni02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoQtd02 : «' + RTRIM( ISNULL( CAST (CondicaoQtd02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoEsperado02 : «' + RTRIM( ISNULL( CAST (CondicaoEsperado02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniV02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniV02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdV02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdV02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniF02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniF02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdF02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdF02 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConfigDetalhe : «' + RTRIM( ISNULL( CAST (IdConfigDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigHeader : «' + RTRIM( ISNULL( CAST (IdConfigHeader AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PosIni : «' + RTRIM( ISNULL( CAST (PosIni AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDig : «' + RTRIM( ISNULL( CAST (QtdDig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conteudo : «' + RTRIM( ISNULL( CAST (Conteudo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataType : «' + RTRIM( ISNULL( CAST (DataType AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Segmento : «' + RTRIM( ISNULL( CAST (Segmento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoIni01 : «' + RTRIM( ISNULL( CAST (CondicaoIni01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoQtd01 : «' + RTRIM( ISNULL( CAST (CondicaoQtd01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoEsperado01 : «' + RTRIM( ISNULL( CAST (CondicaoEsperado01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniV01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniV01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdV01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdV01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniF01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniF01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdF01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdF01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoIni02 : «' + RTRIM( ISNULL( CAST (CondicaoIni02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoQtd02 : «' + RTRIM( ISNULL( CAST (CondicaoQtd02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoEsperado02 : «' + RTRIM( ISNULL( CAST (CondicaoEsperado02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniV02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniV02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdV02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdV02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniF02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniF02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdF02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdF02 AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfigDetalhe : «' + RTRIM( ISNULL( CAST (IdConfigDetalhe AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConfigHeader : «' + RTRIM( ISNULL( CAST (IdConfigHeader AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PosIni : «' + RTRIM( ISNULL( CAST (PosIni AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdDig : «' + RTRIM( ISNULL( CAST (QtdDig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conteudo : «' + RTRIM( ISNULL( CAST (Conteudo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataType : «' + RTRIM( ISNULL( CAST (DataType AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Segmento : «' + RTRIM( ISNULL( CAST (Segmento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoIni01 : «' + RTRIM( ISNULL( CAST (CondicaoIni01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoQtd01 : «' + RTRIM( ISNULL( CAST (CondicaoQtd01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoEsperado01 : «' + RTRIM( ISNULL( CAST (CondicaoEsperado01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniV01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniV01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdV01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdV01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniF01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniF01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdF01 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdF01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoIni02 : «' + RTRIM( ISNULL( CAST (CondicaoIni02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoQtd02 : «' + RTRIM( ISNULL( CAST (CondicaoQtd02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoEsperado02 : «' + RTRIM( ISNULL( CAST (CondicaoEsperado02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniV02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniV02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdV02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdV02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoIniF02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoIniF02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CondicaoResultadoQtdF02 : «' + RTRIM( ISNULL( CAST (CondicaoResultadoQtdF02 AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
