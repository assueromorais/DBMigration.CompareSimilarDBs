CREATE TABLE [dbo].[AnB_Resultado] (
    [IdResultadoAnalise] INT           IDENTITY (1, 1) NOT NULL,
    [DataAnalise]        DATETIME      NOT NULL,
    [IdSituacaoAnalise]  TINYINT       NOT NULL,
    [DataTerminoAnalise] DATETIME      NULL,
    [QtdeOcorrencias]    INT           NULL,
    [NomeServidor]       VARCHAR (200) NULL,
    [NomeBancoDados]     VARCHAR (200) NULL,
    [VersaoArquivoDat]   VARCHAR (50)  NULL,
    [UsuarioExecucao]    VARCHAR (35)  NULL,
    [HostName]           VARCHAR (50)  NULL,
    [SiglaCliente]       VARCHAR (50)  NULL,
    [VersãoSQL]          VARCHAR (255) NULL,
    CONSTRAINT [PK_ResultadoAnaliseBase] PRIMARY KEY CLUSTERED ([IdResultadoAnalise] ASC),
    CONSTRAINT [FK_AnB_Resultado_Anb_SituacaoAnalise] FOREIGN KEY ([IdSituacaoAnalise]) REFERENCES [dbo].[AnB_SituacaoAnalise] ([IdSituacaoAnalise])
);


GO
CREATE TRIGGER [TrgLog_AnB_Resultado] ON [Implanta_CRPAM].[dbo].[AnB_Resultado] 
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
SET @TableName = 'AnB_Resultado'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdResultadoAnalise : «' + RTRIM( ISNULL( CAST (IdResultadoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAnalise : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAnalise, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoAnalise : «' + RTRIM( ISNULL( CAST (IdSituacaoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataTerminoAnalise : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTerminoAnalise, 113 ),'Nulo'))+'» '
                         + '| QtdeOcorrencias : «' + RTRIM( ISNULL( CAST (QtdeOcorrencias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeServidor : «' + RTRIM( ISNULL( CAST (NomeServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBancoDados : «' + RTRIM( ISNULL( CAST (NomeBancoDados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersaoArquivoDat : «' + RTRIM( ISNULL( CAST (VersaoArquivoDat AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioExecucao : «' + RTRIM( ISNULL( CAST (UsuarioExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HostName : «' + RTRIM( ISNULL( CAST (HostName AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCliente : «' + RTRIM( ISNULL( CAST (SiglaCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersãoSQL : «' + RTRIM( ISNULL( CAST (VersãoSQL AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdResultadoAnalise : «' + RTRIM( ISNULL( CAST (IdResultadoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAnalise : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAnalise, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoAnalise : «' + RTRIM( ISNULL( CAST (IdSituacaoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataTerminoAnalise : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTerminoAnalise, 113 ),'Nulo'))+'» '
                         + '| QtdeOcorrencias : «' + RTRIM( ISNULL( CAST (QtdeOcorrencias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeServidor : «' + RTRIM( ISNULL( CAST (NomeServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBancoDados : «' + RTRIM( ISNULL( CAST (NomeBancoDados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersaoArquivoDat : «' + RTRIM( ISNULL( CAST (VersaoArquivoDat AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioExecucao : «' + RTRIM( ISNULL( CAST (UsuarioExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HostName : «' + RTRIM( ISNULL( CAST (HostName AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCliente : «' + RTRIM( ISNULL( CAST (SiglaCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersãoSQL : «' + RTRIM( ISNULL( CAST (VersãoSQL AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdResultadoAnalise : «' + RTRIM( ISNULL( CAST (IdResultadoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAnalise : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAnalise, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoAnalise : «' + RTRIM( ISNULL( CAST (IdSituacaoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataTerminoAnalise : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTerminoAnalise, 113 ),'Nulo'))+'» '
                         + '| QtdeOcorrencias : «' + RTRIM( ISNULL( CAST (QtdeOcorrencias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeServidor : «' + RTRIM( ISNULL( CAST (NomeServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBancoDados : «' + RTRIM( ISNULL( CAST (NomeBancoDados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersaoArquivoDat : «' + RTRIM( ISNULL( CAST (VersaoArquivoDat AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioExecucao : «' + RTRIM( ISNULL( CAST (UsuarioExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HostName : «' + RTRIM( ISNULL( CAST (HostName AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCliente : «' + RTRIM( ISNULL( CAST (SiglaCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersãoSQL : «' + RTRIM( ISNULL( CAST (VersãoSQL AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdResultadoAnalise : «' + RTRIM( ISNULL( CAST (IdResultadoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAnalise : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAnalise, 113 ),'Nulo'))+'» '
                         + '| IdSituacaoAnalise : «' + RTRIM( ISNULL( CAST (IdSituacaoAnalise AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataTerminoAnalise : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTerminoAnalise, 113 ),'Nulo'))+'» '
                         + '| QtdeOcorrencias : «' + RTRIM( ISNULL( CAST (QtdeOcorrencias AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeServidor : «' + RTRIM( ISNULL( CAST (NomeServidor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBancoDados : «' + RTRIM( ISNULL( CAST (NomeBancoDados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersaoArquivoDat : «' + RTRIM( ISNULL( CAST (VersaoArquivoDat AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioExecucao : «' + RTRIM( ISNULL( CAST (UsuarioExecucao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| HostName : «' + RTRIM( ISNULL( CAST (HostName AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaCliente : «' + RTRIM( ISNULL( CAST (SiglaCliente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VersãoSQL : «' + RTRIM( ISNULL( CAST (VersãoSQL AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
