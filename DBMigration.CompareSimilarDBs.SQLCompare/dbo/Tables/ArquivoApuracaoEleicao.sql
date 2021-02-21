CREATE TABLE [dbo].[ArquivoApuracaoEleicao] (
    [IdArquivoApuracaoEleicao] INT           IDENTITY (1, 1) NOT NULL,
    [IdEleicao]                INT           NULL,
    [IdConselho]               INT           NULL,
    [AnoEleicao]               VARCHAR (4)   NULL,
    [SiglaRegional]            VARCHAR (15)  NULL,
    [RegistroProfissional]     VARCHAR (12)  NULL,
    [NumeroCPF]                VARCHAR (11)  NULL,
    [Nome]                     VARCHAR (100) NULL,
    [IndicativoVoto]           VARCHAR (1)   NULL,
    [TextoJustificativa]       TEXT          NULL,
    [DataVoto]                 DATETIME      NULL,
    [ModoVotacao]              VARCHAR (1)   NULL,
    [IndicativoAptoInapto]     VARCHAR (1)   NULL,
    [IndicativoRelacionamento] VARCHAR (1)   NULL,
    [IdProfissional]           INT           NULL,
    [DATA]                     DATETIME      NULL,
    [Usuario]                  VARCHAR (150) NULL,
    [Departamento]             VARCHAR (60)  NULL,
    CONSTRAINT [PK_ArquivoApuracaoEleicao] PRIMARY KEY CLUSTERED ([IdArquivoApuracaoEleicao] ASC)
);


GO
CREATE TRIGGER [TrgLog_ArquivoApuracaoEleicao] ON [Implanta_CRPAM].[dbo].[ArquivoApuracaoEleicao] 
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
SET @TableName = 'ArquivoApuracaoEleicao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivoApuracaoEleicao : «' + RTRIM( ISNULL( CAST (IdArquivoApuracaoEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEleicao : «' + RTRIM( ISNULL( CAST (IdEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConselho : «' + RTRIM( ISNULL( CAST (IdConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoEleicao : «' + RTRIM( ISNULL( CAST (AnoEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaRegional : «' + RTRIM( ISNULL( CAST (SiglaRegional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroProfissional : «' + RTRIM( ISNULL( CAST (RegistroProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCPF : «' + RTRIM( ISNULL( CAST (NumeroCPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoVoto : «' + RTRIM( ISNULL( CAST (IndicativoVoto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVoto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVoto, 113 ),'Nulo'))+'» '
                         + '| ModoVotacao : «' + RTRIM( ISNULL( CAST (ModoVotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoAptoInapto : «' + RTRIM( ISNULL( CAST (IndicativoAptoInapto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoRelacionamento : «' + RTRIM( ISNULL( CAST (IndicativoRelacionamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivoApuracaoEleicao : «' + RTRIM( ISNULL( CAST (IdArquivoApuracaoEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEleicao : «' + RTRIM( ISNULL( CAST (IdEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConselho : «' + RTRIM( ISNULL( CAST (IdConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoEleicao : «' + RTRIM( ISNULL( CAST (AnoEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaRegional : «' + RTRIM( ISNULL( CAST (SiglaRegional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroProfissional : «' + RTRIM( ISNULL( CAST (RegistroProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCPF : «' + RTRIM( ISNULL( CAST (NumeroCPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoVoto : «' + RTRIM( ISNULL( CAST (IndicativoVoto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVoto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVoto, 113 ),'Nulo'))+'» '
                         + '| ModoVotacao : «' + RTRIM( ISNULL( CAST (ModoVotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoAptoInapto : «' + RTRIM( ISNULL( CAST (IndicativoAptoInapto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoRelacionamento : «' + RTRIM( ISNULL( CAST (IndicativoRelacionamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdArquivoApuracaoEleicao : «' + RTRIM( ISNULL( CAST (IdArquivoApuracaoEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEleicao : «' + RTRIM( ISNULL( CAST (IdEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConselho : «' + RTRIM( ISNULL( CAST (IdConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoEleicao : «' + RTRIM( ISNULL( CAST (AnoEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaRegional : «' + RTRIM( ISNULL( CAST (SiglaRegional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroProfissional : «' + RTRIM( ISNULL( CAST (RegistroProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCPF : «' + RTRIM( ISNULL( CAST (NumeroCPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoVoto : «' + RTRIM( ISNULL( CAST (IndicativoVoto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVoto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVoto, 113 ),'Nulo'))+'» '
                         + '| ModoVotacao : «' + RTRIM( ISNULL( CAST (ModoVotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoAptoInapto : «' + RTRIM( ISNULL( CAST (IndicativoAptoInapto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoRelacionamento : «' + RTRIM( ISNULL( CAST (IndicativoRelacionamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivoApuracaoEleicao : «' + RTRIM( ISNULL( CAST (IdArquivoApuracaoEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEleicao : «' + RTRIM( ISNULL( CAST (IdEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConselho : «' + RTRIM( ISNULL( CAST (IdConselho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoEleicao : «' + RTRIM( ISNULL( CAST (AnoEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaRegional : «' + RTRIM( ISNULL( CAST (SiglaRegional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroProfissional : «' + RTRIM( ISNULL( CAST (RegistroProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCPF : «' + RTRIM( ISNULL( CAST (NumeroCPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoVoto : «' + RTRIM( ISNULL( CAST (IndicativoVoto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVoto : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVoto, 113 ),'Nulo'))+'» '
                         + '| ModoVotacao : «' + RTRIM( ISNULL( CAST (ModoVotacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoAptoInapto : «' + RTRIM( ISNULL( CAST (IndicativoAptoInapto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IndicativoRelacionamento : «' + RTRIM( ISNULL( CAST (IndicativoRelacionamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DATA : «' + RTRIM( ISNULL( CONVERT (CHAR, DATA, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
