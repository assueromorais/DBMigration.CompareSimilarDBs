CREATE TABLE [dbo].[ControleArquivosCobranca] (
    [IdControleArquivoCob] INT          IDENTITY (1, 1) NOT NULL,
    [NomeArquivoOriginal]  VARCHAR (50) NULL,
    [NomeArquivoProc]      VARCHAR (50) NULL,
    [DataGeracao]          DATETIME     NULL,
    [UltimaDataRepro]      DATETIME     NULL,
    [NSA]                  INT          NULL,
    [QtdRegistros]         INT          NULL,
    [ValorAcatados]        MONEY        NULL,
    [ValorCustos]          MONEY        NULL,
    [QtdRecusados]         INT          NULL,
    [ValorRecusados]       MONEY        NULL,
    [Banco]                VARCHAR (3)  NULL,
    [Conta]                VARCHAR (15) NULL,
    [Padrao]               VARCHAR (15) NULL,
    [SiglaUF]              VARCHAR (2)  NULL,
    [IdBanco]              INT          NULL,
    [Agencia]              VARCHAR (6)  NULL,
    [ConvenioArq]          VARCHAR (20) NULL,
    [RegistraLog]          BIT          CONSTRAINT [DF__ControleA__Regis__3E15AC0F] DEFAULT ('1') NULL,
    [ValotTotalArquivo]    MONEY        NULL,
    [QtdLinhasArquivo]     VARCHAR (13) NULL,
    [SomaDataCredito]      VARCHAR (20) NULL,
    [SomaDataPgto]         VARCHAR (20) NULL,
    [ConvenioCalculado]    VARCHAR (20) NULL,
    CONSTRAINT [PK_ControleArquivosCobranca] PRIMARY KEY CLUSTERED ([IdControleArquivoCob] ASC)
);


GO
CREATE TRIGGER [TrgLog_ControleArquivosCobranca] ON [Implanta_CRPAM].[dbo].[ControleArquivosCobranca] 
FOR INSERT, UPDATE, DELETE 
AS 
DECLARE 	@CountI		Integer 
DECLARE 	@CountD		Integer 
DECLARE 	@TipoOperacao 	VARCHAR(9) 
DECLARE 	@TableName 	VARCHAR(50) 
DECLARE 	@Conteudo 	VARCHAR(3700) 
DECLARE 	@Conteudo2 	VARCHAR(3700) 
DECLARE 	@RegistraLogI	BIT 
DECLARE 	@RegistraLogD	BIT 
SELECT @RegistraLogI = RegistraLog FROM INSERTED 
SELECT @RegistraLogD = RegistraLog FROM DELETED 
SELECT @CountI = COUNT(*) FROM INSERTED 
SELECT @CountD = COUNT(*) FROM DELETED 
SET @TipoOperacao = Null 
SET @Conteudo = Null 
SET @Conteudo2 = Null 
SET @TableName = 'ControleArquivosCobranca'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoOriginal : «' + RTRIM( ISNULL( CAST (NomeArquivoOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoProc : «' + RTRIM( ISNULL( CAST (NomeArquivoProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| UltimaDataRepro : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaDataRepro, 113 ),'Nulo'))+'» '
                         + '| NSA : «' + RTRIM( ISNULL( CAST (NSA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAcatados : «' + RTRIM( ISNULL( CAST (ValorAcatados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCustos : «' + RTRIM( ISNULL( CAST (ValorCustos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRecusados : «' + RTRIM( ISNULL( CAST (QtdRecusados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorRecusados : «' + RTRIM( ISNULL( CAST (ValorRecusados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Padrao : «' + RTRIM( ISNULL( CAST (Padrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioArq : «' + RTRIM( ISNULL( CAST (ConvenioArq AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ValotTotalArquivo : «' + RTRIM( ISNULL( CAST (ValotTotalArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdLinhasArquivo : «' + RTRIM( ISNULL( CAST (QtdLinhasArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SomaDataCredito : «' + RTRIM( ISNULL( CAST (SomaDataCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SomaDataPgto : «' + RTRIM( ISNULL( CAST (SomaDataPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioCalculado : «' + RTRIM( ISNULL( CAST (ConvenioCalculado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoOriginal : «' + RTRIM( ISNULL( CAST (NomeArquivoOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoProc : «' + RTRIM( ISNULL( CAST (NomeArquivoProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| UltimaDataRepro : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaDataRepro, 113 ),'Nulo'))+'» '
                         + '| NSA : «' + RTRIM( ISNULL( CAST (NSA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAcatados : «' + RTRIM( ISNULL( CAST (ValorAcatados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCustos : «' + RTRIM( ISNULL( CAST (ValorCustos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRecusados : «' + RTRIM( ISNULL( CAST (QtdRecusados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorRecusados : «' + RTRIM( ISNULL( CAST (ValorRecusados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Padrao : «' + RTRIM( ISNULL( CAST (Padrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioArq : «' + RTRIM( ISNULL( CAST (ConvenioArq AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ValotTotalArquivo : «' + RTRIM( ISNULL( CAST (ValotTotalArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdLinhasArquivo : «' + RTRIM( ISNULL( CAST (QtdLinhasArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SomaDataCredito : «' + RTRIM( ISNULL( CAST (SomaDataCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SomaDataPgto : «' + RTRIM( ISNULL( CAST (SomaDataPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioCalculado : «' + RTRIM( ISNULL( CAST (ConvenioCalculado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
   IF @Conteudo <> @Conteudo2 
   BEGIN 
		INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, Conteudo2, NomeBanco) 
		VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, @Conteudo2, DB_NAME()) 
   END 
 END 
END 
ELSE 
BEGIN 
   IF    @CountI    =    1 
AND @RegistraLogI = 1 
	BEGIN 
		SET @TipoOperacao = 'Inclusão' 
		SELECT @Conteudo = 'IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoOriginal : «' + RTRIM( ISNULL( CAST (NomeArquivoOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoProc : «' + RTRIM( ISNULL( CAST (NomeArquivoProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| UltimaDataRepro : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaDataRepro, 113 ),'Nulo'))+'» '
                         + '| NSA : «' + RTRIM( ISNULL( CAST (NSA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAcatados : «' + RTRIM( ISNULL( CAST (ValorAcatados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCustos : «' + RTRIM( ISNULL( CAST (ValorCustos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRecusados : «' + RTRIM( ISNULL( CAST (QtdRecusados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorRecusados : «' + RTRIM( ISNULL( CAST (ValorRecusados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Padrao : «' + RTRIM( ISNULL( CAST (Padrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioArq : «' + RTRIM( ISNULL( CAST (ConvenioArq AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ValotTotalArquivo : «' + RTRIM( ISNULL( CAST (ValotTotalArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdLinhasArquivo : «' + RTRIM( ISNULL( CAST (QtdLinhasArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SomaDataCredito : «' + RTRIM( ISNULL( CAST (SomaDataCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SomaDataPgto : «' + RTRIM( ISNULL( CAST (SomaDataPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioCalculado : «' + RTRIM( ISNULL( CAST (ConvenioCalculado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
AND @RegistraLogD = 1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoOriginal : «' + RTRIM( ISNULL( CAST (NomeArquivoOriginal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivoProc : «' + RTRIM( ISNULL( CAST (NomeArquivoProc AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGeracao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGeracao, 113 ),'Nulo'))+'» '
                         + '| UltimaDataRepro : «' + RTRIM( ISNULL( CONVERT (CHAR, UltimaDataRepro, 113 ),'Nulo'))+'» '
                         + '| NSA : «' + RTRIM( ISNULL( CAST (NSA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRegistros : «' + RTRIM( ISNULL( CAST (QtdRegistros AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAcatados : «' + RTRIM( ISNULL( CAST (ValorAcatados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCustos : «' + RTRIM( ISNULL( CAST (ValorCustos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdRecusados : «' + RTRIM( ISNULL( CAST (QtdRecusados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorRecusados : «' + RTRIM( ISNULL( CAST (ValorRecusados AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Conta : «' + RTRIM( ISNULL( CAST (Conta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Padrao : «' + RTRIM( ISNULL( CAST (Padrao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdBanco : «' + RTRIM( ISNULL( CAST (IdBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioArq : «' + RTRIM( ISNULL( CAST (ConvenioArq AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| ValotTotalArquivo : «' + RTRIM( ISNULL( CAST (ValotTotalArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdLinhasArquivo : «' + RTRIM( ISNULL( CAST (QtdLinhasArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SomaDataCredito : «' + RTRIM( ISNULL( CAST (SomaDataCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SomaDataPgto : «' + RTRIM( ISNULL( CAST (SomaDataPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioCalculado : «' + RTRIM( ISNULL( CAST (ConvenioCalculado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
