CREATE TABLE [dbo].[ConfiguracaoModuloGerencial] (
    [NU_CONFIG]                  NUMERIC (5)  NOT NULL,
    [DE_MODELO_PADRAO]           CHAR (10)    NULL,
    [DE_IMAGENS_CABECALHO]       VARCHAR (80) NULL,
    [DE_ARQUIVO_LOGO]            VARCHAR (80) NULL,
    [DE_COR_LINHA_MODULO]        CHAR (7)     NULL,
    [DE_TEXTO_EMPRESA]           VARCHAR (80) NULL,
    [DE_COR_FUNDO_CABECALHO_01]  CHAR (7)     NULL,
    [DE_COR_FUNDO_CABECALHO_02]  CHAR (7)     NULL,
    [DE_COR_FUNDO_MENU_01]       CHAR (7)     NULL,
    [DE_COR_FUNDO_MENU_02]       CHAR (7)     NULL,
    [DE_COR_LINHA_ABAIXO_MENU]   CHAR (7)     NULL,
    [DE_COR_LINHA_CIMA_RODAPE]   CHAR (7)     NULL,
    [DE_COR_FUNDO_RODAPE_01]     CHAR (7)     NULL,
    [DE_COR_FUNDO_RODAPE_02]     CHAR (7)     NULL,
    [DE_COR_LINHA_ABAIXO_RODAPE] CHAR (7)     NULL
);


GO
CREATE TRIGGER [TrgLog_ConfiguracaoModuloGerencial] ON [Implanta_CRPAM].[dbo].[ConfiguracaoModuloGerencial] 
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
SET @TableName = 'ConfiguracaoModuloGerencial'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'NU_CONFIG : «' + RTRIM( ISNULL( CAST (NU_CONFIG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_MODELO_PADRAO : «' + RTRIM( ISNULL( CAST (DE_MODELO_PADRAO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_IMAGENS_CABECALHO : «' + RTRIM( ISNULL( CAST (DE_IMAGENS_CABECALHO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_ARQUIVO_LOGO : «' + RTRIM( ISNULL( CAST (DE_ARQUIVO_LOGO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_MODULO : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_MODULO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_TEXTO_EMPRESA : «' + RTRIM( ISNULL( CAST (DE_TEXTO_EMPRESA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_CABECALHO_01 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_CABECALHO_01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_CABECALHO_02 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_CABECALHO_02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_MENU_01 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_MENU_01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_MENU_02 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_MENU_02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_ABAIXO_MENU : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_ABAIXO_MENU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_CIMA_RODAPE : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_CIMA_RODAPE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_RODAPE_01 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_RODAPE_01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_RODAPE_02 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_RODAPE_02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_ABAIXO_RODAPE : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_ABAIXO_RODAPE AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'NU_CONFIG : «' + RTRIM( ISNULL( CAST (NU_CONFIG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_MODELO_PADRAO : «' + RTRIM( ISNULL( CAST (DE_MODELO_PADRAO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_IMAGENS_CABECALHO : «' + RTRIM( ISNULL( CAST (DE_IMAGENS_CABECALHO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_ARQUIVO_LOGO : «' + RTRIM( ISNULL( CAST (DE_ARQUIVO_LOGO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_MODULO : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_MODULO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_TEXTO_EMPRESA : «' + RTRIM( ISNULL( CAST (DE_TEXTO_EMPRESA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_CABECALHO_01 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_CABECALHO_01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_CABECALHO_02 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_CABECALHO_02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_MENU_01 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_MENU_01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_MENU_02 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_MENU_02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_ABAIXO_MENU : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_ABAIXO_MENU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_CIMA_RODAPE : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_CIMA_RODAPE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_RODAPE_01 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_RODAPE_01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_RODAPE_02 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_RODAPE_02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_ABAIXO_RODAPE : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_ABAIXO_RODAPE AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'NU_CONFIG : «' + RTRIM( ISNULL( CAST (NU_CONFIG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_MODELO_PADRAO : «' + RTRIM( ISNULL( CAST (DE_MODELO_PADRAO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_IMAGENS_CABECALHO : «' + RTRIM( ISNULL( CAST (DE_IMAGENS_CABECALHO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_ARQUIVO_LOGO : «' + RTRIM( ISNULL( CAST (DE_ARQUIVO_LOGO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_MODULO : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_MODULO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_TEXTO_EMPRESA : «' + RTRIM( ISNULL( CAST (DE_TEXTO_EMPRESA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_CABECALHO_01 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_CABECALHO_01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_CABECALHO_02 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_CABECALHO_02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_MENU_01 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_MENU_01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_MENU_02 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_MENU_02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_ABAIXO_MENU : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_ABAIXO_MENU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_CIMA_RODAPE : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_CIMA_RODAPE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_RODAPE_01 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_RODAPE_01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_RODAPE_02 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_RODAPE_02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_ABAIXO_RODAPE : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_ABAIXO_RODAPE AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'NU_CONFIG : «' + RTRIM( ISNULL( CAST (NU_CONFIG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_MODELO_PADRAO : «' + RTRIM( ISNULL( CAST (DE_MODELO_PADRAO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_IMAGENS_CABECALHO : «' + RTRIM( ISNULL( CAST (DE_IMAGENS_CABECALHO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_ARQUIVO_LOGO : «' + RTRIM( ISNULL( CAST (DE_ARQUIVO_LOGO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_MODULO : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_MODULO AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_TEXTO_EMPRESA : «' + RTRIM( ISNULL( CAST (DE_TEXTO_EMPRESA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_CABECALHO_01 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_CABECALHO_01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_CABECALHO_02 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_CABECALHO_02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_MENU_01 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_MENU_01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_MENU_02 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_MENU_02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_ABAIXO_MENU : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_ABAIXO_MENU AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_CIMA_RODAPE : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_CIMA_RODAPE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_RODAPE_01 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_RODAPE_01 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_FUNDO_RODAPE_02 : «' + RTRIM( ISNULL( CAST (DE_COR_FUNDO_RODAPE_02 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DE_COR_LINHA_ABAIXO_RODAPE : «' + RTRIM( ISNULL( CAST (DE_COR_LINHA_ABAIXO_RODAPE AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
