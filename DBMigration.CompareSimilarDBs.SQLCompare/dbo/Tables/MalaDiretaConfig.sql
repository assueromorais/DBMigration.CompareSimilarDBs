CREATE TABLE [dbo].[MalaDiretaConfig] (
    [IdMalaDiretaConfig]        INT           IDENTITY (1, 1) NOT NULL,
    [Descricao]                 VARCHAR (200) NULL,
    [Assunto]                   VARCHAR (200) NULL,
    [TipoPessoa]                INT           NULL,
    [IdRelatorio]               INT           NULL,
    [Mensagem]                  TEXT          NULL,
    [AnexarBoletoCobranca]      BIT           CONSTRAINT [DEF_MalaDiretaConfigAnexarBoletoCobranca] DEFAULT ((0)) NOT NULL,
    [QuantEnviar]               INT           NULL,
    [TempoAguardar]             INT           NULL,
    [TipoEnvio]                 INT           NULL,
    [HorarioEnvio]              DATETIME      NULL,
    [DiasEnvio]                 VARCHAR (100) NULL,
    [DataProxEnvio]             DATETIME      NULL,
    [Servidor]                  VARCHAR (100) NULL,
    [Porta]                     INT           NULL,
    [Usuario]                   VARCHAR (100) NULL,
    [Senha]                     VARCHAR (100) NULL,
    [AutenticaSSL]              BIT           CONSTRAINT [DEF_MalaDiretaConfigAutenticaSSL] DEFAULT ((0)) NOT NULL,
    [EmailAuthenticationMethod] TINYINT       NULL,
    [Remetente]                 VARCHAR (100) NULL,
    [IdEmissaoConfig]           INT           NULL,
    [STATUS]                    TINYINT       NULL,
    [spid]                      INT           NULL,
    [login_time]                DATETIME      NULL,
    CONSTRAINT [PK_MalaDiretaConfig] PRIMARY KEY CLUSTERED ([IdMalaDiretaConfig] ASC),
    CONSTRAINT [FK_MalaDiretaConfig_Relatorios] FOREIGN KEY ([IdRelatorio]) REFERENCES [dbo].[Relatorios] ([IdRelatorio])
);


GO
CREATE TRIGGER [TrgLog_MalaDiretaConfig] ON [Implanta_CRPAM].[dbo].[MalaDiretaConfig] 
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
SET @TableName = 'MalaDiretaConfig'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMalaDiretaConfig : «' + RTRIM( ISNULL( CAST (IdMalaDiretaConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AnexarBoletoCobranca IS NULL THEN ' AnexarBoletoCobranca : «Nulo» '
                                              WHEN  AnexarBoletoCobranca = 0 THEN ' AnexarBoletoCobranca : «Falso» '
                                              WHEN  AnexarBoletoCobranca = 1 THEN ' AnexarBoletoCobranca : «Verdadeiro» '
                                    END 
                         + '| QuantEnviar : «' + RTRIM( ISNULL( CAST (QuantEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAguardar : «' + RTRIM( ISNULL( CAST (TempoAguardar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEnvio : «' + RTRIM( ISNULL( CAST (TipoEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HorarioEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, HorarioEnvio, 113 ),'Nulo'))+'» '
                         + '| DiasEnvio : «' + RTRIM( ISNULL( CAST (DiasEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProxEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProxEnvio, 113 ),'Nulo'))+'» '
                         + '| Servidor : «' + RTRIM( ISNULL( CAST (Servidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Porta : «' + RTRIM( ISNULL( CAST (Porta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Senha : «' + RTRIM( ISNULL( CAST (Senha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutenticaSSL IS NULL THEN ' AutenticaSSL : «Nulo» '
                                              WHEN  AutenticaSSL = 0 THEN ' AutenticaSSL : «Falso» '
                                              WHEN  AutenticaSSL = 1 THEN ' AutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| EmailAuthenticationMethod : «' + RTRIM( ISNULL( CAST (EmailAuthenticationMethod AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Remetente : «' + RTRIM( ISNULL( CAST (Remetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| STATUS : «' + RTRIM( ISNULL( CAST (STATUS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| spid : «' + RTRIM( ISNULL( CAST (spid AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| login_time : «' + RTRIM( ISNULL( CONVERT (CHAR, login_time, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMalaDiretaConfig : «' + RTRIM( ISNULL( CAST (IdMalaDiretaConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AnexarBoletoCobranca IS NULL THEN ' AnexarBoletoCobranca : «Nulo» '
                                              WHEN  AnexarBoletoCobranca = 0 THEN ' AnexarBoletoCobranca : «Falso» '
                                              WHEN  AnexarBoletoCobranca = 1 THEN ' AnexarBoletoCobranca : «Verdadeiro» '
                                    END 
                         + '| QuantEnviar : «' + RTRIM( ISNULL( CAST (QuantEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAguardar : «' + RTRIM( ISNULL( CAST (TempoAguardar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEnvio : «' + RTRIM( ISNULL( CAST (TipoEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HorarioEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, HorarioEnvio, 113 ),'Nulo'))+'» '
                         + '| DiasEnvio : «' + RTRIM( ISNULL( CAST (DiasEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProxEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProxEnvio, 113 ),'Nulo'))+'» '
                         + '| Servidor : «' + RTRIM( ISNULL( CAST (Servidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Porta : «' + RTRIM( ISNULL( CAST (Porta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Senha : «' + RTRIM( ISNULL( CAST (Senha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutenticaSSL IS NULL THEN ' AutenticaSSL : «Nulo» '
                                              WHEN  AutenticaSSL = 0 THEN ' AutenticaSSL : «Falso» '
                                              WHEN  AutenticaSSL = 1 THEN ' AutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| EmailAuthenticationMethod : «' + RTRIM( ISNULL( CAST (EmailAuthenticationMethod AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Remetente : «' + RTRIM( ISNULL( CAST (Remetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| STATUS : «' + RTRIM( ISNULL( CAST (STATUS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| spid : «' + RTRIM( ISNULL( CAST (spid AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| login_time : «' + RTRIM( ISNULL( CONVERT (CHAR, login_time, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMalaDiretaConfig : «' + RTRIM( ISNULL( CAST (IdMalaDiretaConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AnexarBoletoCobranca IS NULL THEN ' AnexarBoletoCobranca : «Nulo» '
                                              WHEN  AnexarBoletoCobranca = 0 THEN ' AnexarBoletoCobranca : «Falso» '
                                              WHEN  AnexarBoletoCobranca = 1 THEN ' AnexarBoletoCobranca : «Verdadeiro» '
                                    END 
                         + '| QuantEnviar : «' + RTRIM( ISNULL( CAST (QuantEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAguardar : «' + RTRIM( ISNULL( CAST (TempoAguardar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEnvio : «' + RTRIM( ISNULL( CAST (TipoEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HorarioEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, HorarioEnvio, 113 ),'Nulo'))+'» '
                         + '| DiasEnvio : «' + RTRIM( ISNULL( CAST (DiasEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProxEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProxEnvio, 113 ),'Nulo'))+'» '
                         + '| Servidor : «' + RTRIM( ISNULL( CAST (Servidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Porta : «' + RTRIM( ISNULL( CAST (Porta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Senha : «' + RTRIM( ISNULL( CAST (Senha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutenticaSSL IS NULL THEN ' AutenticaSSL : «Nulo» '
                                              WHEN  AutenticaSSL = 0 THEN ' AutenticaSSL : «Falso» '
                                              WHEN  AutenticaSSL = 1 THEN ' AutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| EmailAuthenticationMethod : «' + RTRIM( ISNULL( CAST (EmailAuthenticationMethod AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Remetente : «' + RTRIM( ISNULL( CAST (Remetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| STATUS : «' + RTRIM( ISNULL( CAST (STATUS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| spid : «' + RTRIM( ISNULL( CAST (spid AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| login_time : «' + RTRIM( ISNULL( CONVERT (CHAR, login_time, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMalaDiretaConfig : «' + RTRIM( ISNULL( CAST (IdMalaDiretaConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Assunto : «' + RTRIM( ISNULL( CAST (Assunto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRelatorio : «' + RTRIM( ISNULL( CAST (IdRelatorio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AnexarBoletoCobranca IS NULL THEN ' AnexarBoletoCobranca : «Nulo» '
                                              WHEN  AnexarBoletoCobranca = 0 THEN ' AnexarBoletoCobranca : «Falso» '
                                              WHEN  AnexarBoletoCobranca = 1 THEN ' AnexarBoletoCobranca : «Verdadeiro» '
                                    END 
                         + '| QuantEnviar : «' + RTRIM( ISNULL( CAST (QuantEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAguardar : «' + RTRIM( ISNULL( CAST (TempoAguardar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEnvio : «' + RTRIM( ISNULL( CAST (TipoEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HorarioEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, HorarioEnvio, 113 ),'Nulo'))+'» '
                         + '| DiasEnvio : «' + RTRIM( ISNULL( CAST (DiasEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProxEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProxEnvio, 113 ),'Nulo'))+'» '
                         + '| Servidor : «' + RTRIM( ISNULL( CAST (Servidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Porta : «' + RTRIM( ISNULL( CAST (Porta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Senha : «' + RTRIM( ISNULL( CAST (Senha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutenticaSSL IS NULL THEN ' AutenticaSSL : «Nulo» '
                                              WHEN  AutenticaSSL = 0 THEN ' AutenticaSSL : «Falso» '
                                              WHEN  AutenticaSSL = 1 THEN ' AutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| EmailAuthenticationMethod : «' + RTRIM( ISNULL( CAST (EmailAuthenticationMethod AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Remetente : «' + RTRIM( ISNULL( CAST (Remetente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmissaoConfig : «' + RTRIM( ISNULL( CAST (IdEmissaoConfig AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| STATUS : «' + RTRIM( ISNULL( CAST (STATUS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| spid : «' + RTRIM( ISNULL( CAST (spid AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| login_time : «' + RTRIM( ISNULL( CONVERT (CHAR, login_time, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
