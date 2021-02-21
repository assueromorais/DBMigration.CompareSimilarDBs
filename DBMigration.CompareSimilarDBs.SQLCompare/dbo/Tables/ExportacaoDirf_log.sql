CREATE TABLE [dbo].[ExportacaoDirf_log] (
    [IdLog]        INT            IDENTITY (1, 1) NOT NULL,
    [ANTES_DEPOIS] VARCHAR (6)    NULL,
    [Data]         DATETIME       NOT NULL,
    [Usuario]      VARCHAR (128)  NOT NULL,
    [IdDirf]       INT            NOT NULL,
    [Origem]       VARCHAR (1)    NOT NULL,
    [Exercicio]    INT            NOT NULL,
    [TipoRegistro] VARCHAR (1)    NOT NULL,
    [CPFCNPJ]      VARCHAR (14)   NULL,
    [LinhaArquivo] VARCHAR (2000) NOT NULL,
    [Ativo]        VARCHAR (1)    NULL,
    CONSTRAINT [PK_ExportacaoDirf_log] PRIMARY KEY CLUSTERED ([IdLog] ASC)
);


GO
CREATE TRIGGER [TrgLog_ExportacaoDirf_log] ON [Implanta_CRPAM].[dbo].[ExportacaoDirf_log] 
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
SET @TableName = 'ExportacaoDirf_log'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdLog : «' + RTRIM( ISNULL( CAST (IdLog AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ANTES_DEPOIS : «' + RTRIM( ISNULL( CAST (ANTES_DEPOIS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDirf : «' + RTRIM( ISNULL( CAST (IdDirf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRegistro : «' + RTRIM( ISNULL( CAST (TipoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJ : «' + RTRIM( ISNULL( CAST (CPFCNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinhaArquivo : «' + RTRIM( ISNULL( CAST (LinhaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ativo : «' + RTRIM( ISNULL( CAST (Ativo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdLog : «' + RTRIM( ISNULL( CAST (IdLog AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ANTES_DEPOIS : «' + RTRIM( ISNULL( CAST (ANTES_DEPOIS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDirf : «' + RTRIM( ISNULL( CAST (IdDirf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRegistro : «' + RTRIM( ISNULL( CAST (TipoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJ : «' + RTRIM( ISNULL( CAST (CPFCNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinhaArquivo : «' + RTRIM( ISNULL( CAST (LinhaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ativo : «' + RTRIM( ISNULL( CAST (Ativo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdLog : «' + RTRIM( ISNULL( CAST (IdLog AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ANTES_DEPOIS : «' + RTRIM( ISNULL( CAST (ANTES_DEPOIS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDirf : «' + RTRIM( ISNULL( CAST (IdDirf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRegistro : «' + RTRIM( ISNULL( CAST (TipoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJ : «' + RTRIM( ISNULL( CAST (CPFCNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinhaArquivo : «' + RTRIM( ISNULL( CAST (LinhaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ativo : «' + RTRIM( ISNULL( CAST (Ativo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdLog : «' + RTRIM( ISNULL( CAST (IdLog AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ANTES_DEPOIS : «' + RTRIM( ISNULL( CAST (ANTES_DEPOIS AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDirf : «' + RTRIM( ISNULL( CAST (IdDirf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRegistro : «' + RTRIM( ISNULL( CAST (TipoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJ : «' + RTRIM( ISNULL( CAST (CPFCNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinhaArquivo : «' + RTRIM( ISNULL( CAST (LinhaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ativo : «' + RTRIM( ISNULL( CAST (Ativo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
