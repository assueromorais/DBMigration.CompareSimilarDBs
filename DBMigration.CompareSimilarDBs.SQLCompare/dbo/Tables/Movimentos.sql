CREATE TABLE [dbo].[Movimentos] (
    [IdMovimento]     INT          IDENTITY (1, 1) NOT NULL,
    [IdLancamento]    INT          NOT NULL,
    [IdConta]         INT          NOT NULL,
    [DataLancamento]  DATETIME     NOT NULL,
    [NumProcesso]     VARCHAR (20) NULL,
    [Tipo]            VARCHAR (1)  NOT NULL,
    [ValorCredito]    MONEY        NOT NULL,
    [ValorDebito]     MONEY        NOT NULL,
    [Historico]       TEXT         NULL,
    [NumeroDocumento] INT          NULL,
    [RegistraLog]     BIT          DEFAULT ('1') NULL,
    CONSTRAINT [PK_Movimentos] PRIMARY KEY NONCLUSTERED ([IdMovimento] ASC),
    CONSTRAINT [FK_Movimentos_Lancamentos] FOREIGN KEY ([IdLancamento]) REFERENCES [dbo].[Lancamentos] ([IdLancamento]),
    CONSTRAINT [FK_Movimentos_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
CREATE STATISTICS [STAT_Movimentos_Tipo_IdConta]
    ON [dbo].[Movimentos]([Tipo], [IdConta]);


GO
CREATE TRIGGER [TrgLog_Movimentos] ON [Implanta_CRPAM].[dbo].[Movimentos] 
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
SET @TableName = 'Movimentos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMovimento : «' + RTRIM( ISNULL( CAST (IdMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLancamento, 113 ),'Nulo'))+'» '
                         + '| NumProcesso : «' + RTRIM( ISNULL( CAST (NumProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCredito : «' + RTRIM( ISNULL( CAST (ValorCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDebito : «' + RTRIM( ISNULL( CAST (ValorDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdMovimento : «' + RTRIM( ISNULL( CAST (IdMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLancamento, 113 ),'Nulo'))+'» '
                         + '| NumProcesso : «' + RTRIM( ISNULL( CAST (NumProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCredito : «' + RTRIM( ISNULL( CAST (ValorCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDebito : «' + RTRIM( ISNULL( CAST (ValorDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
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
		SELECT @Conteudo = 'IdMovimento : «' + RTRIM( ISNULL( CAST (IdMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLancamento, 113 ),'Nulo'))+'» '
                         + '| NumProcesso : «' + RTRIM( ISNULL( CAST (NumProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCredito : «' + RTRIM( ISNULL( CAST (ValorCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDebito : «' + RTRIM( ISNULL( CAST (ValorDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
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
		SELECT @Conteudo = 'IdMovimento : «' + RTRIM( ISNULL( CAST (IdMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLancamento : «' + RTRIM( ISNULL( CAST (IdLancamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataLancamento, 113 ),'Nulo'))+'» '
                         + '| NumProcesso : «' + RTRIM( ISNULL( CAST (NumProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Tipo : «' + RTRIM( ISNULL( CAST (Tipo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCredito : «' + RTRIM( ISNULL( CAST (ValorCredito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDebito : «' + RTRIM( ISNULL( CAST (ValorDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDocumento : «' + RTRIM( ISNULL( CAST (NumeroDocumento AS VARCHAR(3500)),'Nulo'))+'» '
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
