CREATE TABLE [dbo].[ParametrosLayoutSiscafweb] (
    [ID]                            INT          NOT NULL,
    [Painel_CorBorda]               VARCHAR (30) NULL,
    [Painel_CorFundo]               VARCHAR (30) NULL,
    [TituloPainel_CorFundo]         VARCHAR (30) NULL,
    [TituloPainel_FonteTexto]       VARCHAR (50) NULL,
    [TituloPainel_TamTexto]         VARCHAR (30) NULL,
    [TituloPainel_CorTexto]         VARCHAR (30) NULL,
    [InteriorPainel_FonteTexto]     VARCHAR (50) NULL,
    [InteriorPainel_TamTexto]       VARCHAR (30) NULL,
    [InteriorPainel_CorTextoNormal] VARCHAR (30) NULL,
    [InteriorPainel_CorTextoLink]   VARCHAR (30) NULL,
    [InteriorPainel_CorFundoCampo]  VARCHAR (30) NULL,
    [siglaConselho]                 VARCHAR (10) NULL
);


GO
CREATE TRIGGER [TrgLog_ParametrosLayoutSiscafweb] ON [Implanta_CRPAM].[dbo].[ParametrosLayoutSiscafweb] 
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
SET @TableName = 'ParametrosLayoutSiscafweb'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'ID : «' + RTRIM( ISNULL( CAST (ID AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Painel_CorBorda : «' + RTRIM( ISNULL( CAST (Painel_CorBorda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Painel_CorFundo : «' + RTRIM( ISNULL( CAST (Painel_CorFundo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_CorFundo : «' + RTRIM( ISNULL( CAST (TituloPainel_CorFundo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_FonteTexto : «' + RTRIM( ISNULL( CAST (TituloPainel_FonteTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_TamTexto : «' + RTRIM( ISNULL( CAST (TituloPainel_TamTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_CorTexto : «' + RTRIM( ISNULL( CAST (TituloPainel_CorTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_FonteTexto : «' + RTRIM( ISNULL( CAST (InteriorPainel_FonteTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_TamTexto : «' + RTRIM( ISNULL( CAST (InteriorPainel_TamTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_CorTextoNormal : «' + RTRIM( ISNULL( CAST (InteriorPainel_CorTextoNormal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_CorTextoLink : «' + RTRIM( ISNULL( CAST (InteriorPainel_CorTextoLink AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_CorFundoCampo : «' + RTRIM( ISNULL( CAST (InteriorPainel_CorFundoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| siglaConselho : «' + RTRIM( ISNULL( CAST (siglaConselho AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'ID : «' + RTRIM( ISNULL( CAST (ID AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Painel_CorBorda : «' + RTRIM( ISNULL( CAST (Painel_CorBorda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Painel_CorFundo : «' + RTRIM( ISNULL( CAST (Painel_CorFundo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_CorFundo : «' + RTRIM( ISNULL( CAST (TituloPainel_CorFundo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_FonteTexto : «' + RTRIM( ISNULL( CAST (TituloPainel_FonteTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_TamTexto : «' + RTRIM( ISNULL( CAST (TituloPainel_TamTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_CorTexto : «' + RTRIM( ISNULL( CAST (TituloPainel_CorTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_FonteTexto : «' + RTRIM( ISNULL( CAST (InteriorPainel_FonteTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_TamTexto : «' + RTRIM( ISNULL( CAST (InteriorPainel_TamTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_CorTextoNormal : «' + RTRIM( ISNULL( CAST (InteriorPainel_CorTextoNormal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_CorTextoLink : «' + RTRIM( ISNULL( CAST (InteriorPainel_CorTextoLink AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_CorFundoCampo : «' + RTRIM( ISNULL( CAST (InteriorPainel_CorFundoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| siglaConselho : «' + RTRIM( ISNULL( CAST (siglaConselho AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'ID : «' + RTRIM( ISNULL( CAST (ID AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Painel_CorBorda : «' + RTRIM( ISNULL( CAST (Painel_CorBorda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Painel_CorFundo : «' + RTRIM( ISNULL( CAST (Painel_CorFundo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_CorFundo : «' + RTRIM( ISNULL( CAST (TituloPainel_CorFundo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_FonteTexto : «' + RTRIM( ISNULL( CAST (TituloPainel_FonteTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_TamTexto : «' + RTRIM( ISNULL( CAST (TituloPainel_TamTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_CorTexto : «' + RTRIM( ISNULL( CAST (TituloPainel_CorTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_FonteTexto : «' + RTRIM( ISNULL( CAST (InteriorPainel_FonteTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_TamTexto : «' + RTRIM( ISNULL( CAST (InteriorPainel_TamTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_CorTextoNormal : «' + RTRIM( ISNULL( CAST (InteriorPainel_CorTextoNormal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_CorTextoLink : «' + RTRIM( ISNULL( CAST (InteriorPainel_CorTextoLink AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_CorFundoCampo : «' + RTRIM( ISNULL( CAST (InteriorPainel_CorFundoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| siglaConselho : «' + RTRIM( ISNULL( CAST (siglaConselho AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'ID : «' + RTRIM( ISNULL( CAST (ID AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Painel_CorBorda : «' + RTRIM( ISNULL( CAST (Painel_CorBorda AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Painel_CorFundo : «' + RTRIM( ISNULL( CAST (Painel_CorFundo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_CorFundo : «' + RTRIM( ISNULL( CAST (TituloPainel_CorFundo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_FonteTexto : «' + RTRIM( ISNULL( CAST (TituloPainel_FonteTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_TamTexto : «' + RTRIM( ISNULL( CAST (TituloPainel_TamTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TituloPainel_CorTexto : «' + RTRIM( ISNULL( CAST (TituloPainel_CorTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_FonteTexto : «' + RTRIM( ISNULL( CAST (InteriorPainel_FonteTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_TamTexto : «' + RTRIM( ISNULL( CAST (InteriorPainel_TamTexto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_CorTextoNormal : «' + RTRIM( ISNULL( CAST (InteriorPainel_CorTextoNormal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_CorTextoLink : «' + RTRIM( ISNULL( CAST (InteriorPainel_CorTextoLink AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| InteriorPainel_CorFundoCampo : «' + RTRIM( ISNULL( CAST (InteriorPainel_CorFundoCampo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| siglaConselho : «' + RTRIM( ISNULL( CAST (siglaConselho AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
