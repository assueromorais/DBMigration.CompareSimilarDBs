CREATE TABLE [dbo].[DetalheArquivosCobranca] (
    [IdDetalheArquivoCob]  INT           IDENTITY (1, 1) NOT NULL,
    [IdControleArquivoCob] INT           NULL,
    [Data]                 VARCHAR (10)  NULL,
    [Valor]                VARCHAR (15)  NULL,
    [Convenio]             VARCHAR (20)  NULL,
    [Despesa]              VARCHAR (20)  NULL,
    [DescricaoErro]        VARCHAR (150) NULL,
    [RegistroArquivo]      INT           NULL,
    [RegistraLog]          BIT           CONSTRAINT [DF__DetalheAr__Regis__3D2187D6] DEFAULT ('1') NULL,
    CONSTRAINT [PK_DetalheArquivosCobranca] PRIMARY KEY CLUSTERED ([IdDetalheArquivoCob] ASC),
    CONSTRAINT [FK_DetalheArquivosCobranca_ControleArquivosCobranca] FOREIGN KEY ([IdControleArquivoCob]) REFERENCES [dbo].[ControleArquivosCobranca] ([IdControleArquivoCob])
);


GO
CREATE TRIGGER [TrgLog_DetalheArquivosCobranca] ON [Implanta_CRPAM].[dbo].[DetalheArquivosCobranca] 
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
SET @TableName = 'DetalheArquivosCobranca'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDetalheArquivoCob : «' + RTRIM( ISNULL( CAST (IdDetalheArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CAST (Data AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Convenio : «' + RTRIM( ISNULL( CAST (Convenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Despesa : «' + RTRIM( ISNULL( CAST (Despesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoErro : «' + RTRIM( ISNULL( CAST (DescricaoErro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroArquivo : «' + RTRIM( ISNULL( CAST (RegistroArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdDetalheArquivoCob : «' + RTRIM( ISNULL( CAST (IdDetalheArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CAST (Data AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Convenio : «' + RTRIM( ISNULL( CAST (Convenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Despesa : «' + RTRIM( ISNULL( CAST (Despesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoErro : «' + RTRIM( ISNULL( CAST (DescricaoErro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroArquivo : «' + RTRIM( ISNULL( CAST (RegistroArquivo AS VARCHAR(3500)),'Nulo'))+'» '
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
		SELECT @Conteudo = 'IdDetalheArquivoCob : «' + RTRIM( ISNULL( CAST (IdDetalheArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CAST (Data AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Convenio : «' + RTRIM( ISNULL( CAST (Convenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Despesa : «' + RTRIM( ISNULL( CAST (Despesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoErro : «' + RTRIM( ISNULL( CAST (DescricaoErro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroArquivo : «' + RTRIM( ISNULL( CAST (RegistroArquivo AS VARCHAR(3500)),'Nulo'))+'» '
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
		SELECT @Conteudo = 'IdDetalheArquivoCob : «' + RTRIM( ISNULL( CAST (IdDetalheArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdControleArquivoCob : «' + RTRIM( ISNULL( CAST (IdControleArquivoCob AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CAST (Data AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Convenio : «' + RTRIM( ISNULL( CAST (Convenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Despesa : «' + RTRIM( ISNULL( CAST (Despesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoErro : «' + RTRIM( ISNULL( CAST (DescricaoErro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RegistroArquivo : «' + RTRIM( ISNULL( CAST (RegistroArquivo AS VARCHAR(3500)),'Nulo'))+'» '
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
