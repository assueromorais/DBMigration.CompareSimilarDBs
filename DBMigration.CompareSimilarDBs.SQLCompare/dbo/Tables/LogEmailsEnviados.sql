CREATE TABLE [dbo].[LogEmailsEnviados] (
    [Data]                             DATETIME      CONSTRAINT [DF_LogDataEmail] DEFAULT (getdate()) NOT NULL,
    [Sistema]                          VARCHAR (128) NOT NULL,
    [Usuario]                          VARCHAR (128) NOT NULL,
    [ModuloOrigem]                     VARCHAR (12)  NULL,
    [EmailDestino]                     VARCHAR (100) NOT NULL,
    [ConfigEmailRemetente]             VARCHAR (100) NULL,
    [ConfigHostCotacao]                VARCHAR (30)  NULL,
    [ConfigPortaCotacao]               VARCHAR (3)   NULL,
    [ConfigLinkCotacao]                VARCHAR (50)  NULL,
    [ConfigServidorRequerAutenticacao] BIT           NULL,
    [ConfigUsuarioEmailCotacao]        VARCHAR (100) NULL,
    [ConfigSenhaEmailCotacao]          VARCHAR (30)  NULL,
    [Enviado]                          BIT           NULL
);


GO
CREATE TRIGGER [TrgLog_LogEmailsEnviados] ON [Implanta_CRPAM].[dbo].[LogEmailsEnviados] 
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
SET @TableName = 'LogEmailsEnviados'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'Data : «' + RTRIM(ISNULL(CONVERT (CHAR, Data, 113),'Nulo')) +'» '
                         + '| Sistema : «' + RTRIM( ISNULL( CAST (Sistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ModuloOrigem : «' + RTRIM( ISNULL( CAST (ModuloOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailDestino : «' + RTRIM( ISNULL( CAST (EmailDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigEmailRemetente : «' + RTRIM( ISNULL( CAST (ConfigEmailRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigHostCotacao : «' + RTRIM( ISNULL( CAST (ConfigHostCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigPortaCotacao : «' + RTRIM( ISNULL( CAST (ConfigPortaCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigLinkCotacao : «' + RTRIM( ISNULL( CAST (ConfigLinkCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfigServidorRequerAutenticacao IS NULL THEN ' ConfigServidorRequerAutenticacao : «Nulo» '
                                              WHEN  ConfigServidorRequerAutenticacao = 0 THEN ' ConfigServidorRequerAutenticacao : «Falso» '
                                              WHEN  ConfigServidorRequerAutenticacao = 1 THEN ' ConfigServidorRequerAutenticacao : «Verdadeiro» '
                                    END 
                         + '| ConfigUsuarioEmailCotacao : «' + RTRIM( ISNULL( CAST (ConfigUsuarioEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigSenhaEmailCotacao : «' + RTRIM( ISNULL( CAST (ConfigSenhaEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Enviado IS NULL THEN ' Enviado : «Nulo» '
                                              WHEN  Enviado = 0 THEN ' Enviado : «Falso» '
                                              WHEN  Enviado = 1 THEN ' Enviado : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'Data : «' + RTRIM(ISNULL(CONVERT (CHAR, Data, 113),'Nulo')) +'» '
                         + '| Sistema : «' + RTRIM( ISNULL( CAST (Sistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ModuloOrigem : «' + RTRIM( ISNULL( CAST (ModuloOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailDestino : «' + RTRIM( ISNULL( CAST (EmailDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigEmailRemetente : «' + RTRIM( ISNULL( CAST (ConfigEmailRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigHostCotacao : «' + RTRIM( ISNULL( CAST (ConfigHostCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigPortaCotacao : «' + RTRIM( ISNULL( CAST (ConfigPortaCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigLinkCotacao : «' + RTRIM( ISNULL( CAST (ConfigLinkCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfigServidorRequerAutenticacao IS NULL THEN ' ConfigServidorRequerAutenticacao : «Nulo» '
                                              WHEN  ConfigServidorRequerAutenticacao = 0 THEN ' ConfigServidorRequerAutenticacao : «Falso» '
                                              WHEN  ConfigServidorRequerAutenticacao = 1 THEN ' ConfigServidorRequerAutenticacao : «Verdadeiro» '
                                    END 
                         + '| ConfigUsuarioEmailCotacao : «' + RTRIM( ISNULL( CAST (ConfigUsuarioEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigSenhaEmailCotacao : «' + RTRIM( ISNULL( CAST (ConfigSenhaEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Enviado IS NULL THEN ' Enviado : «Nulo» '
                                              WHEN  Enviado = 0 THEN ' Enviado : «Falso» '
                                              WHEN  Enviado = 1 THEN ' Enviado : «Verdadeiro» '
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
		SELECT @Conteudo = 'Data : «' + RTRIM(ISNULL(CONVERT (CHAR, Data, 113),'Nulo')) +'» '
                         + '| Sistema : «' + RTRIM( ISNULL( CAST (Sistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ModuloOrigem : «' + RTRIM( ISNULL( CAST (ModuloOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailDestino : «' + RTRIM( ISNULL( CAST (EmailDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigEmailRemetente : «' + RTRIM( ISNULL( CAST (ConfigEmailRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigHostCotacao : «' + RTRIM( ISNULL( CAST (ConfigHostCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigPortaCotacao : «' + RTRIM( ISNULL( CAST (ConfigPortaCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigLinkCotacao : «' + RTRIM( ISNULL( CAST (ConfigLinkCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfigServidorRequerAutenticacao IS NULL THEN ' ConfigServidorRequerAutenticacao : «Nulo» '
                                              WHEN  ConfigServidorRequerAutenticacao = 0 THEN ' ConfigServidorRequerAutenticacao : «Falso» '
                                              WHEN  ConfigServidorRequerAutenticacao = 1 THEN ' ConfigServidorRequerAutenticacao : «Verdadeiro» '
                                    END 
                         + '| ConfigUsuarioEmailCotacao : «' + RTRIM( ISNULL( CAST (ConfigUsuarioEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigSenhaEmailCotacao : «' + RTRIM( ISNULL( CAST (ConfigSenhaEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Enviado IS NULL THEN ' Enviado : «Nulo» '
                                              WHEN  Enviado = 0 THEN ' Enviado : «Falso» '
                                              WHEN  Enviado = 1 THEN ' Enviado : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'Data : «' + RTRIM(ISNULL(CONVERT (CHAR, Data, 113),'Nulo')) +'» '
                         + '| Sistema : «' + RTRIM( ISNULL( CAST (Sistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ModuloOrigem : «' + RTRIM( ISNULL( CAST (ModuloOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailDestino : «' + RTRIM( ISNULL( CAST (EmailDestino AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigEmailRemetente : «' + RTRIM( ISNULL( CAST (ConfigEmailRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigHostCotacao : «' + RTRIM( ISNULL( CAST (ConfigHostCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigPortaCotacao : «' + RTRIM( ISNULL( CAST (ConfigPortaCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigLinkCotacao : «' + RTRIM( ISNULL( CAST (ConfigLinkCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConfigServidorRequerAutenticacao IS NULL THEN ' ConfigServidorRequerAutenticacao : «Nulo» '
                                              WHEN  ConfigServidorRequerAutenticacao = 0 THEN ' ConfigServidorRequerAutenticacao : «Falso» '
                                              WHEN  ConfigServidorRequerAutenticacao = 1 THEN ' ConfigServidorRequerAutenticacao : «Verdadeiro» '
                                    END 
                         + '| ConfigUsuarioEmailCotacao : «' + RTRIM( ISNULL( CAST (ConfigUsuarioEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConfigSenhaEmailCotacao : «' + RTRIM( ISNULL( CAST (ConfigSenhaEmailCotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Enviado IS NULL THEN ' Enviado : «Nulo» '
                                              WHEN  Enviado = 0 THEN ' Enviado : «Falso» '
                                              WHEN  Enviado = 1 THEN ' Enviado : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
