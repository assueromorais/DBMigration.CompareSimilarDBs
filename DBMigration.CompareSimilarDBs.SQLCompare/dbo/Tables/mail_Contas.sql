CREATE TABLE [dbo].[mail_Contas] (
    [IdConta]         INT           IDENTITY (1, 1) NOT NULL,
    [Descricao]       VARCHAR (200) NULL,
    [QuantEnviar]     INT           NULL,
    [TempoAguardar]   INT           NULL,
    [TipoEnvio]       INT           NULL,
    [HorarioEnvio]    DATETIME      NULL,
    [DiasEnvio]       VARCHAR (100) NULL,
    [DataProxEnvio]   DATETIME      NULL,
    [ServidorEnviar]  VARCHAR (200) NULL,
    [PortaEnviar]     INT           NULL,
    [TipoServidor]    INT           NULL,
    [ServidorReceber] VARCHAR (200) NULL,
    [PortaReceber]    INT           NULL,
    [Usuario]         VARCHAR (200) NULL,
    [Senha]           VARCHAR (200) NULL,
    [AutenticaSSL]    BIT           CONSTRAINT [DEF_mail_Contas_AutenticaSSL] DEFAULT ((0)) NOT NULL,
    [Ativa]           BIT           CONSTRAINT [DEF_mail_Contas_Ativa] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_mail_Contas] PRIMARY KEY CLUSTERED ([IdConta] ASC)
);


GO
CREATE TRIGGER [TrgLog_mail_Contas] ON [Implanta_CRPAM].[dbo].[mail_Contas] 
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
SET @TableName = 'mail_Contas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantEnviar : «' + RTRIM( ISNULL( CAST (QuantEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAguardar : «' + RTRIM( ISNULL( CAST (TempoAguardar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEnvio : «' + RTRIM( ISNULL( CAST (TipoEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HorarioEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, HorarioEnvio, 113 ),'Nulo'))+'» '
                         + '| DiasEnvio : «' + RTRIM( ISNULL( CAST (DiasEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProxEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProxEnvio, 113 ),'Nulo'))+'» '
                         + '| ServidorEnviar : «' + RTRIM( ISNULL( CAST (ServidorEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaEnviar : «' + RTRIM( ISNULL( CAST (PortaEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoServidor : «' + RTRIM( ISNULL( CAST (TipoServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ServidorReceber : «' + RTRIM( ISNULL( CAST (ServidorReceber AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaReceber : «' + RTRIM( ISNULL( CAST (PortaReceber AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Senha : «' + RTRIM( ISNULL( CAST (Senha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutenticaSSL IS NULL THEN ' AutenticaSSL : «Nulo» '
                                              WHEN  AutenticaSSL = 0 THEN ' AutenticaSSL : «Falso» '
                                              WHEN  AutenticaSSL = 1 THEN ' AutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Ativa IS NULL THEN ' Ativa : «Nulo» '
                                              WHEN  Ativa = 0 THEN ' Ativa : «Falso» '
                                              WHEN  Ativa = 1 THEN ' Ativa : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantEnviar : «' + RTRIM( ISNULL( CAST (QuantEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAguardar : «' + RTRIM( ISNULL( CAST (TempoAguardar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEnvio : «' + RTRIM( ISNULL( CAST (TipoEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HorarioEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, HorarioEnvio, 113 ),'Nulo'))+'» '
                         + '| DiasEnvio : «' + RTRIM( ISNULL( CAST (DiasEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProxEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProxEnvio, 113 ),'Nulo'))+'» '
                         + '| ServidorEnviar : «' + RTRIM( ISNULL( CAST (ServidorEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaEnviar : «' + RTRIM( ISNULL( CAST (PortaEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoServidor : «' + RTRIM( ISNULL( CAST (TipoServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ServidorReceber : «' + RTRIM( ISNULL( CAST (ServidorReceber AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaReceber : «' + RTRIM( ISNULL( CAST (PortaReceber AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Senha : «' + RTRIM( ISNULL( CAST (Senha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutenticaSSL IS NULL THEN ' AutenticaSSL : «Nulo» '
                                              WHEN  AutenticaSSL = 0 THEN ' AutenticaSSL : «Falso» '
                                              WHEN  AutenticaSSL = 1 THEN ' AutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Ativa IS NULL THEN ' Ativa : «Nulo» '
                                              WHEN  Ativa = 0 THEN ' Ativa : «Falso» '
                                              WHEN  Ativa = 1 THEN ' Ativa : «Verdadeiro» '
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
		SELECT @Conteudo = 'IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantEnviar : «' + RTRIM( ISNULL( CAST (QuantEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAguardar : «' + RTRIM( ISNULL( CAST (TempoAguardar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEnvio : «' + RTRIM( ISNULL( CAST (TipoEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HorarioEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, HorarioEnvio, 113 ),'Nulo'))+'» '
                         + '| DiasEnvio : «' + RTRIM( ISNULL( CAST (DiasEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProxEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProxEnvio, 113 ),'Nulo'))+'» '
                         + '| ServidorEnviar : «' + RTRIM( ISNULL( CAST (ServidorEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaEnviar : «' + RTRIM( ISNULL( CAST (PortaEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoServidor : «' + RTRIM( ISNULL( CAST (TipoServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ServidorReceber : «' + RTRIM( ISNULL( CAST (ServidorReceber AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaReceber : «' + RTRIM( ISNULL( CAST (PortaReceber AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Senha : «' + RTRIM( ISNULL( CAST (Senha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutenticaSSL IS NULL THEN ' AutenticaSSL : «Nulo» '
                                              WHEN  AutenticaSSL = 0 THEN ' AutenticaSSL : «Falso» '
                                              WHEN  AutenticaSSL = 1 THEN ' AutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Ativa IS NULL THEN ' Ativa : «Nulo» '
                                              WHEN  Ativa = 0 THEN ' Ativa : «Falso» '
                                              WHEN  Ativa = 1 THEN ' Ativa : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QuantEnviar : «' + RTRIM( ISNULL( CAST (QuantEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TempoAguardar : «' + RTRIM( ISNULL( CAST (TempoAguardar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoEnvio : «' + RTRIM( ISNULL( CAST (TipoEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HorarioEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, HorarioEnvio, 113 ),'Nulo'))+'» '
                         + '| DiasEnvio : «' + RTRIM( ISNULL( CAST (DiasEnvio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataProxEnvio : «' + RTRIM( ISNULL( CONVERT (CHAR, DataProxEnvio, 113 ),'Nulo'))+'» '
                         + '| ServidorEnviar : «' + RTRIM( ISNULL( CAST (ServidorEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaEnviar : «' + RTRIM( ISNULL( CAST (PortaEnviar AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoServidor : «' + RTRIM( ISNULL( CAST (TipoServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ServidorReceber : «' + RTRIM( ISNULL( CAST (ServidorReceber AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PortaReceber : «' + RTRIM( ISNULL( CAST (PortaReceber AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Senha : «' + RTRIM( ISNULL( CAST (Senha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  AutenticaSSL IS NULL THEN ' AutenticaSSL : «Nulo» '
                                              WHEN  AutenticaSSL = 0 THEN ' AutenticaSSL : «Falso» '
                                              WHEN  AutenticaSSL = 1 THEN ' AutenticaSSL : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Ativa IS NULL THEN ' Ativa : «Nulo» '
                                              WHEN  Ativa = 0 THEN ' Ativa : «Falso» '
                                              WHEN  Ativa = 1 THEN ' Ativa : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
