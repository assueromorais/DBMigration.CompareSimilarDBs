CREATE TABLE [dbo].[ConfigXImpressao] (
    [IdConfigXImpressao]     INT          IDENTITY (1, 1) NOT NULL,
    [TipoCarteirinha]        VARCHAR (10) NULL,
    [CampoCartRegiao]        FLOAT (53)   NULL,
    [CampoCartInscricao]     FLOAT (53)   NULL,
    [CampoCartDataInscricao] FLOAT (53)   NULL,
    [CampoCartJurisdicao]    FLOAT (53)   NULL,
    [CampoCartVia]           FLOAT (53)   NULL,
    [CampoCartNome]          FLOAT (53)   NULL,
    [CampoCartFiliacao]      FLOAT (53)   NULL,
    [CampoCartNaturalidade]  FLOAT (53)   NULL,
    [CampoCartNacionalidade] FLOAT (53)   NULL,
    [CampoCartDataNasc]      FLOAT (53)   NULL,
    [CampoCartLocalExped]    FLOAT (53)   NULL,
    [CampoCartDataExped]     FLOAT (53)   NULL,
    [CampoCartAssinatura]    FLOAT (53)   NULL,
    [CampoCartCPF]           FLOAT (53)   NULL,
    [CampoCartRG]            FLOAT (53)   NULL,
    [CampoCartDataExpedRG]   FLOAT (53)   NULL,
    [CampoCartUFRG]          FLOAT (53)   NULL
);


GO
CREATE TRIGGER [TrgLog_ConfigXImpressao] ON [Implanta_CRPAM].[dbo].[ConfigXImpressao] 
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
SET @TableName = 'ConfigXImpressao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConfigXImpressao : «' + RTRIM( ISNULL( CAST (IdConfigXImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCarteirinha : «' + RTRIM( ISNULL( CAST (TipoCarteirinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartRegiao : «' + RTRIM( ISNULL( CAST (CampoCartRegiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartInscricao : «' + RTRIM( ISNULL( CAST (CampoCartInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataInscricao : «' + RTRIM( ISNULL( CAST (CampoCartDataInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartJurisdicao : «' + RTRIM( ISNULL( CAST (CampoCartJurisdicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartVia : «' + RTRIM( ISNULL( CAST (CampoCartVia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartNome : «' + RTRIM( ISNULL( CAST (CampoCartNome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartFiliacao : «' + RTRIM( ISNULL( CAST (CampoCartFiliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartNaturalidade : «' + RTRIM( ISNULL( CAST (CampoCartNaturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartNacionalidade : «' + RTRIM( ISNULL( CAST (CampoCartNacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataNasc : «' + RTRIM( ISNULL( CAST (CampoCartDataNasc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartLocalExped : «' + RTRIM( ISNULL( CAST (CampoCartLocalExped AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataExped : «' + RTRIM( ISNULL( CAST (CampoCartDataExped AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartAssinatura : «' + RTRIM( ISNULL( CAST (CampoCartAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartCPF : «' + RTRIM( ISNULL( CAST (CampoCartCPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartRG : «' + RTRIM( ISNULL( CAST (CampoCartRG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataExpedRG : «' + RTRIM( ISNULL( CAST (CampoCartDataExpedRG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartUFRG : «' + RTRIM( ISNULL( CAST (CampoCartUFRG AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConfigXImpressao : «' + RTRIM( ISNULL( CAST (IdConfigXImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCarteirinha : «' + RTRIM( ISNULL( CAST (TipoCarteirinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartRegiao : «' + RTRIM( ISNULL( CAST (CampoCartRegiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartInscricao : «' + RTRIM( ISNULL( CAST (CampoCartInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataInscricao : «' + RTRIM( ISNULL( CAST (CampoCartDataInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartJurisdicao : «' + RTRIM( ISNULL( CAST (CampoCartJurisdicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartVia : «' + RTRIM( ISNULL( CAST (CampoCartVia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartNome : «' + RTRIM( ISNULL( CAST (CampoCartNome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartFiliacao : «' + RTRIM( ISNULL( CAST (CampoCartFiliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartNaturalidade : «' + RTRIM( ISNULL( CAST (CampoCartNaturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartNacionalidade : «' + RTRIM( ISNULL( CAST (CampoCartNacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataNasc : «' + RTRIM( ISNULL( CAST (CampoCartDataNasc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartLocalExped : «' + RTRIM( ISNULL( CAST (CampoCartLocalExped AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataExped : «' + RTRIM( ISNULL( CAST (CampoCartDataExped AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartAssinatura : «' + RTRIM( ISNULL( CAST (CampoCartAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartCPF : «' + RTRIM( ISNULL( CAST (CampoCartCPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartRG : «' + RTRIM( ISNULL( CAST (CampoCartRG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataExpedRG : «' + RTRIM( ISNULL( CAST (CampoCartDataExpedRG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartUFRG : «' + RTRIM( ISNULL( CAST (CampoCartUFRG AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConfigXImpressao : «' + RTRIM( ISNULL( CAST (IdConfigXImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCarteirinha : «' + RTRIM( ISNULL( CAST (TipoCarteirinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartRegiao : «' + RTRIM( ISNULL( CAST (CampoCartRegiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartInscricao : «' + RTRIM( ISNULL( CAST (CampoCartInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataInscricao : «' + RTRIM( ISNULL( CAST (CampoCartDataInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartJurisdicao : «' + RTRIM( ISNULL( CAST (CampoCartJurisdicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartVia : «' + RTRIM( ISNULL( CAST (CampoCartVia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartNome : «' + RTRIM( ISNULL( CAST (CampoCartNome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartFiliacao : «' + RTRIM( ISNULL( CAST (CampoCartFiliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartNaturalidade : «' + RTRIM( ISNULL( CAST (CampoCartNaturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartNacionalidade : «' + RTRIM( ISNULL( CAST (CampoCartNacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataNasc : «' + RTRIM( ISNULL( CAST (CampoCartDataNasc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartLocalExped : «' + RTRIM( ISNULL( CAST (CampoCartLocalExped AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataExped : «' + RTRIM( ISNULL( CAST (CampoCartDataExped AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartAssinatura : «' + RTRIM( ISNULL( CAST (CampoCartAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartCPF : «' + RTRIM( ISNULL( CAST (CampoCartCPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartRG : «' + RTRIM( ISNULL( CAST (CampoCartRG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataExpedRG : «' + RTRIM( ISNULL( CAST (CampoCartDataExpedRG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartUFRG : «' + RTRIM( ISNULL( CAST (CampoCartUFRG AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConfigXImpressao : «' + RTRIM( ISNULL( CAST (IdConfigXImpressao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoCarteirinha : «' + RTRIM( ISNULL( CAST (TipoCarteirinha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartRegiao : «' + RTRIM( ISNULL( CAST (CampoCartRegiao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartInscricao : «' + RTRIM( ISNULL( CAST (CampoCartInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataInscricao : «' + RTRIM( ISNULL( CAST (CampoCartDataInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartJurisdicao : «' + RTRIM( ISNULL( CAST (CampoCartJurisdicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartVia : «' + RTRIM( ISNULL( CAST (CampoCartVia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartNome : «' + RTRIM( ISNULL( CAST (CampoCartNome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartFiliacao : «' + RTRIM( ISNULL( CAST (CampoCartFiliacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartNaturalidade : «' + RTRIM( ISNULL( CAST (CampoCartNaturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartNacionalidade : «' + RTRIM( ISNULL( CAST (CampoCartNacionalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataNasc : «' + RTRIM( ISNULL( CAST (CampoCartDataNasc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartLocalExped : «' + RTRIM( ISNULL( CAST (CampoCartLocalExped AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataExped : «' + RTRIM( ISNULL( CAST (CampoCartDataExped AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartAssinatura : «' + RTRIM( ISNULL( CAST (CampoCartAssinatura AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartCPF : «' + RTRIM( ISNULL( CAST (CampoCartCPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartRG : «' + RTRIM( ISNULL( CAST (CampoCartRG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartDataExpedRG : «' + RTRIM( ISNULL( CAST (CampoCartDataExpedRG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CampoCartUFRG : «' + RTRIM( ISNULL( CAST (CampoCartUFRG AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
