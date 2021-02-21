CREATE TABLE [dbo].[Lancamentos] (
    [IdLancamento]          INT           IDENTITY (1, 1) NOT NULL,
    [AnoLancamento]         SMALLINT      NOT NULL,
    [NumLancamento]         INT           NOT NULL,
    [DataLancamento]        DATETIME      NOT NULL,
    [DataModificacao]       DATETIME      NOT NULL,
    [TotalDebitos]          MONEY         NOT NULL,
    [TotalCreditos]         MONEY         NOT NULL,
    [Encerramento]          BIT           NOT NULL,
    [Origem]                VARCHAR (120) NULL,
    [DataImportacao]        DATETIME      NULL,
    [SistemaOrigem]         INT           NULL,
    [SistemaOrigemViaSipro] INT           NULL,
    [IdEvento]              INT           NULL,
    [RegistraLog]           BIT           DEFAULT ('1') NULL,
    CONSTRAINT [PK_Lancamentos] PRIMARY KEY NONCLUSTERED ([IdLancamento] ASC)
);


GO
CREATE TRIGGER [TrgLog_Lancamentos] ON [Implanta_CRPAM].[dbo].[Lancamentos] 
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
SET @TableName = 'Lancamentos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoLancamento : «' + RTRIM( ISNULL( CAST (AnoLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumLancamento : «' + RTRIM( ISNULL( CAST (NumLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLancamento, 113 ),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| TotalDebitos : «' + RTRIM( ISNULL( CAST (TotalDebitos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalCreditos : «' + RTRIM( ISNULL( CAST (TotalCreditos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Encerramento IS NULL THEN ' Encerramento : «Nulo» '
                                              WHEN  Encerramento = 0 THEN ' Encerramento : «Falso» '
                                              WHEN  Encerramento = 1 THEN ' Encerramento : «Verdadeiro» '
                                    END 
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| SistemaOrigem : «' + RTRIM( ISNULL( CAST (SistemaOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SistemaOrigemViaSipro : «' + RTRIM( ISNULL( CAST (SistemaOrigemViaSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoLancamento : «' + RTRIM( ISNULL( CAST (AnoLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumLancamento : «' + RTRIM( ISNULL( CAST (NumLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLancamento, 113 ),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| TotalDebitos : «' + RTRIM( ISNULL( CAST (TotalDebitos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalCreditos : «' + RTRIM( ISNULL( CAST (TotalCreditos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Encerramento IS NULL THEN ' Encerramento : «Nulo» '
                                              WHEN  Encerramento = 0 THEN ' Encerramento : «Falso» '
                                              WHEN  Encerramento = 1 THEN ' Encerramento : «Verdadeiro» '
                                    END 
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| SistemaOrigem : «' + RTRIM( ISNULL( CAST (SistemaOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SistemaOrigemViaSipro : «' + RTRIM( ISNULL( CAST (SistemaOrigemViaSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END  FROM INSERTED 
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
		SELECT @Conteudo = 'IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoLancamento : «' + RTRIM( ISNULL( CAST (AnoLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumLancamento : «' + RTRIM( ISNULL( CAST (NumLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLancamento, 113 ),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| TotalDebitos : «' + RTRIM( ISNULL( CAST (TotalDebitos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalCreditos : «' + RTRIM( ISNULL( CAST (TotalCreditos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Encerramento IS NULL THEN ' Encerramento : «Nulo» '
                                              WHEN  Encerramento = 0 THEN ' Encerramento : «Falso» '
                                              WHEN  Encerramento = 1 THEN ' Encerramento : «Verdadeiro» '
                                    END 
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| SistemaOrigem : «' + RTRIM( ISNULL( CAST (SistemaOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SistemaOrigemViaSipro : «' + RTRIM( ISNULL( CAST (SistemaOrigemViaSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
AND @RegistraLogD = 1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoLancamento : «' + RTRIM( ISNULL( CAST (AnoLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumLancamento : «' + RTRIM( ISNULL( CAST (NumLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLancamento, 113 ),'Nulo'))+'» '
                         + '| DataModificacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataModificacao, 113 ),'Nulo'))+'» '
                         + '| TotalDebitos : «' + RTRIM( ISNULL( CAST (TotalDebitos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalCreditos : «' + RTRIM( ISNULL( CAST (TotalCreditos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Encerramento IS NULL THEN ' Encerramento : «Nulo» '
                                              WHEN  Encerramento = 0 THEN ' Encerramento : «Falso» '
                                              WHEN  Encerramento = 1 THEN ' Encerramento : «Verdadeiro» '
                                    END 
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataImportacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataImportacao, 113 ),'Nulo'))+'» '
                         + '| SistemaOrigem : «' + RTRIM( ISNULL( CAST (SistemaOrigem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SistemaOrigemViaSipro : «' + RTRIM( ISNULL( CAST (SistemaOrigemViaSipro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
