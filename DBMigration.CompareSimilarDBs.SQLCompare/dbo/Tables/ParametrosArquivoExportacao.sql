CREATE TABLE [dbo].[ParametrosArquivoExportacao] (
    [IdArquivoExportacao]   INT           IDENTITY (1, 1) NOT NULL,
    [NomeArquivoExportacao] VARCHAR (50)  NOT NULL,
    [CaminhoGravacao]       VARCHAR (100) NOT NULL,
    [HoraGeracao]           CHAR (8)      NOT NULL,
    [DescricaoArquivo]      TEXT          NULL,
    [EnvioFTP]              BIT           CONSTRAINT [DF_ParametrosArquivoExportacao_EnvioFTP] DEFAULT ((0)) NOT NULL,
    [ServidorFTP]           VARCHAR (50)  NULL,
    [PortaFTP]              INT           NULL,
    [UsuarioFTP]            VARCHAR (50)  NULL,
    [SenhaFTP]              VARCHAR (50)  NULL,
    [EnvioEmail]            BIT           CONSTRAINT [DF_ParametrosArquivoExportacao_EnvioEmail] DEFAULT ((0)) NOT NULL,
    [ServidorSMTP]          VARCHAR (50)  NULL,
    [PortaSMTP]             INT           NULL,
    [UsuarioSMTP]           VARCHAR (50)  NULL,
    [SenhaSMTP]             VARCHAR (50)  NULL,
    [EmailRemetente]        VARCHAR (100) NULL,
    [EmailDestinatario]     VARCHAR (100) NULL,
    [EmailAssunto]          VARCHAR (200) NULL,
    [EmailNomeRemetente]    VARCHAR (100) NULL,
    [EmailMensagem]         TEXT          NULL,
    [CaminhoFTP]            VARCHAR (100) NULL,
    [ConsiderarSituacao]    BIT           CONSTRAINT [DF_ParametrosArquivoExportacao_ConsiderarSituacao] DEFAULT ((0)) NOT NULL,
    [EmailAutenticaSSL]     BIT           DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ParametrosArquivoExportacao] PRIMARY KEY CLUSTERED ([IdArquivoExportacao] ASC)
);


GO
CREATE TRIGGER [TrgLog_ParametrosArquivoExportacao] ON [Implanta_CRPAM].[dbo].[ParametrosArquivoExportacao] 
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
SET @TableName = 'ParametrosArquivoExportacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoExportacao : «' + RTRIM( ISNULL( CAST (NomeArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoGravacao : «' + RTRIM( ISNULL( CAST (CaminhoGravacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HoraGeracao : «' + RTRIM( ISNULL( CAST (HoraGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnvioFTP IS NULL THEN ' EnvioFTP : «Nulo» '
                                              WHEN  EnvioFTP = 0 THEN ' EnvioFTP : «Falso» '
                                              WHEN  EnvioFTP = 1 THEN ' EnvioFTP : «Verdadeiro» '
                                    END 
                         + '| ServidorFTP : «' + RTRIM( ISNULL( CAST (ServidorFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaFTP : «' + RTRIM( ISNULL( CAST (PortaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioFTP : «' + RTRIM( ISNULL( CAST (UsuarioFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaFTP : «' + RTRIM( ISNULL( CAST (SenhaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnvioEmail IS NULL THEN ' EnvioEmail : «Nulo» '
                                              WHEN  EnvioEmail = 0 THEN ' EnvioEmail : «Falso» '
                                              WHEN  EnvioEmail = 1 THEN ' EnvioEmail : «Verdadeiro» '
                                    END 
                         + '| ServidorSMTP : «' + RTRIM( ISNULL( CAST (ServidorSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaSMTP : «' + RTRIM( ISNULL( CAST (PortaSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioSMTP : «' + RTRIM( ISNULL( CAST (UsuarioSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaSMTP : «' + RTRIM( ISNULL( CAST (SenhaSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailRemetente : «' + RTRIM( ISNULL( CAST (EmailRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailDestinatario : «' + RTRIM( ISNULL( CAST (EmailDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailAssunto : «' + RTRIM( ISNULL( CAST (EmailAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailNomeRemetente : «' + RTRIM( ISNULL( CAST (EmailNomeRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoFTP : «' + RTRIM( ISNULL( CAST (CaminhoFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConsiderarSituacao IS NULL THEN ' ConsiderarSituacao : «Nulo» '
                                              WHEN  ConsiderarSituacao = 0 THEN ' ConsiderarSituacao : «Falso» '
                                              WHEN  ConsiderarSituacao = 1 THEN ' ConsiderarSituacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSL IS NULL THEN ' EmailAutenticaSSL : «Nulo» '
                                              WHEN  EmailAutenticaSSL = 0 THEN ' EmailAutenticaSSL : «Falso» '
                                              WHEN  EmailAutenticaSSL = 1 THEN ' EmailAutenticaSSL : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoExportacao : «' + RTRIM( ISNULL( CAST (NomeArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoGravacao : «' + RTRIM( ISNULL( CAST (CaminhoGravacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HoraGeracao : «' + RTRIM( ISNULL( CAST (HoraGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnvioFTP IS NULL THEN ' EnvioFTP : «Nulo» '
                                              WHEN  EnvioFTP = 0 THEN ' EnvioFTP : «Falso» '
                                              WHEN  EnvioFTP = 1 THEN ' EnvioFTP : «Verdadeiro» '
                                    END 
                         + '| ServidorFTP : «' + RTRIM( ISNULL( CAST (ServidorFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaFTP : «' + RTRIM( ISNULL( CAST (PortaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioFTP : «' + RTRIM( ISNULL( CAST (UsuarioFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaFTP : «' + RTRIM( ISNULL( CAST (SenhaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnvioEmail IS NULL THEN ' EnvioEmail : «Nulo» '
                                              WHEN  EnvioEmail = 0 THEN ' EnvioEmail : «Falso» '
                                              WHEN  EnvioEmail = 1 THEN ' EnvioEmail : «Verdadeiro» '
                                    END 
                         + '| ServidorSMTP : «' + RTRIM( ISNULL( CAST (ServidorSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaSMTP : «' + RTRIM( ISNULL( CAST (PortaSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioSMTP : «' + RTRIM( ISNULL( CAST (UsuarioSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaSMTP : «' + RTRIM( ISNULL( CAST (SenhaSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailRemetente : «' + RTRIM( ISNULL( CAST (EmailRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailDestinatario : «' + RTRIM( ISNULL( CAST (EmailDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailAssunto : «' + RTRIM( ISNULL( CAST (EmailAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailNomeRemetente : «' + RTRIM( ISNULL( CAST (EmailNomeRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoFTP : «' + RTRIM( ISNULL( CAST (CaminhoFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConsiderarSituacao IS NULL THEN ' ConsiderarSituacao : «Nulo» '
                                              WHEN  ConsiderarSituacao = 0 THEN ' ConsiderarSituacao : «Falso» '
                                              WHEN  ConsiderarSituacao = 1 THEN ' ConsiderarSituacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSL IS NULL THEN ' EmailAutenticaSSL : «Nulo» '
                                              WHEN  EmailAutenticaSSL = 0 THEN ' EmailAutenticaSSL : «Falso» '
                                              WHEN  EmailAutenticaSSL = 1 THEN ' EmailAutenticaSSL : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoExportacao : «' + RTRIM( ISNULL( CAST (NomeArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoGravacao : «' + RTRIM( ISNULL( CAST (CaminhoGravacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HoraGeracao : «' + RTRIM( ISNULL( CAST (HoraGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnvioFTP IS NULL THEN ' EnvioFTP : «Nulo» '
                                              WHEN  EnvioFTP = 0 THEN ' EnvioFTP : «Falso» '
                                              WHEN  EnvioFTP = 1 THEN ' EnvioFTP : «Verdadeiro» '
                                    END 
                         + '| ServidorFTP : «' + RTRIM( ISNULL( CAST (ServidorFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaFTP : «' + RTRIM( ISNULL( CAST (PortaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioFTP : «' + RTRIM( ISNULL( CAST (UsuarioFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaFTP : «' + RTRIM( ISNULL( CAST (SenhaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnvioEmail IS NULL THEN ' EnvioEmail : «Nulo» '
                                              WHEN  EnvioEmail = 0 THEN ' EnvioEmail : «Falso» '
                                              WHEN  EnvioEmail = 1 THEN ' EnvioEmail : «Verdadeiro» '
                                    END 
                         + '| ServidorSMTP : «' + RTRIM( ISNULL( CAST (ServidorSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaSMTP : «' + RTRIM( ISNULL( CAST (PortaSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioSMTP : «' + RTRIM( ISNULL( CAST (UsuarioSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaSMTP : «' + RTRIM( ISNULL( CAST (SenhaSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailRemetente : «' + RTRIM( ISNULL( CAST (EmailRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailDestinatario : «' + RTRIM( ISNULL( CAST (EmailDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailAssunto : «' + RTRIM( ISNULL( CAST (EmailAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailNomeRemetente : «' + RTRIM( ISNULL( CAST (EmailNomeRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoFTP : «' + RTRIM( ISNULL( CAST (CaminhoFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConsiderarSituacao IS NULL THEN ' ConsiderarSituacao : «Nulo» '
                                              WHEN  ConsiderarSituacao = 0 THEN ' ConsiderarSituacao : «Falso» '
                                              WHEN  ConsiderarSituacao = 1 THEN ' ConsiderarSituacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSL IS NULL THEN ' EmailAutenticaSSL : «Nulo» '
                                              WHEN  EmailAutenticaSSL = 0 THEN ' EmailAutenticaSSL : «Falso» '
                                              WHEN  EmailAutenticaSSL = 1 THEN ' EmailAutenticaSSL : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivoExportacao : «' + RTRIM( ISNULL( CAST (IdArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoExportacao : «' + RTRIM( ISNULL( CAST (NomeArquivoExportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoGravacao : «' + RTRIM( ISNULL( CAST (CaminhoGravacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HoraGeracao : «' + RTRIM( ISNULL( CAST (HoraGeracao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnvioFTP IS NULL THEN ' EnvioFTP : «Nulo» '
                                              WHEN  EnvioFTP = 0 THEN ' EnvioFTP : «Falso» '
                                              WHEN  EnvioFTP = 1 THEN ' EnvioFTP : «Verdadeiro» '
                                    END 
                         + '| ServidorFTP : «' + RTRIM( ISNULL( CAST (ServidorFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaFTP : «' + RTRIM( ISNULL( CAST (PortaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioFTP : «' + RTRIM( ISNULL( CAST (UsuarioFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaFTP : «' + RTRIM( ISNULL( CAST (SenhaFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnvioEmail IS NULL THEN ' EnvioEmail : «Nulo» '
                                              WHEN  EnvioEmail = 0 THEN ' EnvioEmail : «Falso» '
                                              WHEN  EnvioEmail = 1 THEN ' EnvioEmail : «Verdadeiro» '
                                    END 
                         + '| ServidorSMTP : «' + RTRIM( ISNULL( CAST (ServidorSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaSMTP : «' + RTRIM( ISNULL( CAST (PortaSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioSMTP : «' + RTRIM( ISNULL( CAST (UsuarioSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SenhaSMTP : «' + RTRIM( ISNULL( CAST (SenhaSMTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailRemetente : «' + RTRIM( ISNULL( CAST (EmailRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailDestinatario : «' + RTRIM( ISNULL( CAST (EmailDestinatario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailAssunto : «' + RTRIM( ISNULL( CAST (EmailAssunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailNomeRemetente : «' + RTRIM( ISNULL( CAST (EmailNomeRemetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaminhoFTP : «' + RTRIM( ISNULL( CAST (CaminhoFTP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  ConsiderarSituacao IS NULL THEN ' ConsiderarSituacao : «Nulo» '
                                              WHEN  ConsiderarSituacao = 0 THEN ' ConsiderarSituacao : «Falso» '
                                              WHEN  ConsiderarSituacao = 1 THEN ' ConsiderarSituacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  EmailAutenticaSSL IS NULL THEN ' EmailAutenticaSSL : «Nulo» '
                                              WHEN  EmailAutenticaSSL = 0 THEN ' EmailAutenticaSSL : «Falso» '
                                              WHEN  EmailAutenticaSSL = 1 THEN ' EmailAutenticaSSL : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
