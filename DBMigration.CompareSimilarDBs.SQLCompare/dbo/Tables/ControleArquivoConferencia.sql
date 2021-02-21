CREATE TABLE [dbo].[ControleArquivoConferencia] (
    [IdArquivoConferencia] INT          IDENTITY (1, 1) NOT NULL,
    [NomeArquivo]          VARCHAR (50) NULL,
    [PrefixoAgencia]       INT          NULL,
    [DVPrefixoAgencia]     CHAR (1)     NULL,
    [CodigoCedente]        INT          NULL,
    [DVCodigoCedente]      CHAR (1)     NULL,
    [NomeEmpresa]          CHAR (30)    NULL,
    [Banco]                CHAR (18)    NULL,
    [DataGravacao]         DATETIME     NULL,
    [NSA]                  INT          NULL,
    [NumeroConvenio]       INT          NULL,
    [ValotTotalArquivo]    MONEY        NULL,
    [QtdLinhasArquivo]     VARCHAR (20) NULL,
    [SomaDataCredito]      VARCHAR (20) NULL,
    [SomaDataPgto]         VARCHAR (20) NULL,
    [ConvenioCalculado]    VARCHAR (20) NULL,
    CONSTRAINT [PK_ControleArquivoConferencia] PRIMARY KEY CLUSTERED ([IdArquivoConferencia] ASC)
);


GO
CREATE TRIGGER [TrgLog_ControleArquivoConferencia] ON [Implanta_CRPAM].[dbo].[ControleArquivoConferencia] 
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
SET @TableName = 'ControleArquivoConferencia'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivoConferencia : «' + RTRIM( ISNULL( CAST (IdArquivoConferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoAgencia : «' + RTRIM( ISNULL( CAST (PrefixoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVPrefixoAgencia : «' + RTRIM( ISNULL( CAST (DVPrefixoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCedente : «' + RTRIM( ISNULL( CAST (CodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVCodigoCedente : «' + RTRIM( ISNULL( CAST (DVCodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEmpresa : «' + RTRIM( ISNULL( CAST (NomeEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGravacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGravacao, 113 ),'Nulo'))+'» '
                         + '| NSA : «' + RTRIM( ISNULL( CAST (NSA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroConvenio : «' + RTRIM( ISNULL( CAST (NumeroConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValotTotalArquivo : «' + RTRIM( ISNULL( CAST (ValotTotalArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdLinhasArquivo : «' + RTRIM( ISNULL( CAST (QtdLinhasArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SomaDataCredito : «' + RTRIM( ISNULL( CAST (SomaDataCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SomaDataPgto : «' + RTRIM( ISNULL( CAST (SomaDataPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioCalculado : «' + RTRIM( ISNULL( CAST (ConvenioCalculado AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivoConferencia : «' + RTRIM( ISNULL( CAST (IdArquivoConferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoAgencia : «' + RTRIM( ISNULL( CAST (PrefixoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVPrefixoAgencia : «' + RTRIM( ISNULL( CAST (DVPrefixoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCedente : «' + RTRIM( ISNULL( CAST (CodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVCodigoCedente : «' + RTRIM( ISNULL( CAST (DVCodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEmpresa : «' + RTRIM( ISNULL( CAST (NomeEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGravacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGravacao, 113 ),'Nulo'))+'» '
                         + '| NSA : «' + RTRIM( ISNULL( CAST (NSA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroConvenio : «' + RTRIM( ISNULL( CAST (NumeroConvenio AS VARCHAR(3500)),'Nulo'))+'» '
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
ELSE 
BEGIN 
   IF    @CountI    =    1 
	BEGIN 
		SET @TipoOperacao = 'Inclusão' 
		SELECT @Conteudo = 'IdArquivoConferencia : «' + RTRIM( ISNULL( CAST (IdArquivoConferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoAgencia : «' + RTRIM( ISNULL( CAST (PrefixoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVPrefixoAgencia : «' + RTRIM( ISNULL( CAST (DVPrefixoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCedente : «' + RTRIM( ISNULL( CAST (CodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVCodigoCedente : «' + RTRIM( ISNULL( CAST (DVCodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEmpresa : «' + RTRIM( ISNULL( CAST (NomeEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGravacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGravacao, 113 ),'Nulo'))+'» '
                         + '| NSA : «' + RTRIM( ISNULL( CAST (NSA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroConvenio : «' + RTRIM( ISNULL( CAST (NumeroConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValotTotalArquivo : «' + RTRIM( ISNULL( CAST (ValotTotalArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdLinhasArquivo : «' + RTRIM( ISNULL( CAST (QtdLinhasArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SomaDataCredito : «' + RTRIM( ISNULL( CAST (SomaDataCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SomaDataPgto : «' + RTRIM( ISNULL( CAST (SomaDataPgto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ConvenioCalculado : «' + RTRIM( ISNULL( CAST (ConvenioCalculado AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivoConferencia : «' + RTRIM( ISNULL( CAST (IdArquivoConferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeArquivo : «' + RTRIM( ISNULL( CAST (NomeArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoAgencia : «' + RTRIM( ISNULL( CAST (PrefixoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVPrefixoAgencia : «' + RTRIM( ISNULL( CAST (DVPrefixoAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoCedente : «' + RTRIM( ISNULL( CAST (CodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVCodigoCedente : «' + RTRIM( ISNULL( CAST (DVCodigoCedente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEmpresa : «' + RTRIM( ISNULL( CAST (NomeEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Banco : «' + RTRIM( ISNULL( CAST (Banco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataGravacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataGravacao, 113 ),'Nulo'))+'» '
                         + '| NSA : «' + RTRIM( ISNULL( CAST (NSA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroConvenio : «' + RTRIM( ISNULL( CAST (NumeroConvenio AS VARCHAR(3500)),'Nulo'))+'» '
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
