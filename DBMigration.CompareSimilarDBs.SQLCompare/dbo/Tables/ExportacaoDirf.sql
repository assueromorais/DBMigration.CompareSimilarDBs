CREATE TABLE [dbo].[ExportacaoDirf] (
    [IdDirf]       INT            IDENTITY (1, 1) NOT NULL,
    [Origem]       VARCHAR (1)    NOT NULL,
    [Exercicio]    INT            NOT NULL,
    [TipoRegistro] VARCHAR (1)    NOT NULL,
    [LinhaArquivo] VARCHAR (2000) NOT NULL,
    [CPFCNPJ]      VARCHAR (14)   NULL,
    [Ativo]        VARCHAR (1)    NULL,
    [Ordem]        INT            NULL,
    CONSTRAINT [PK_ExportacaoDirf] PRIMARY KEY CLUSTERED ([IdDirf] ASC)
);


GO
CREATE TRIGGER [TrgLog_ExportacaoDirf] ON [Implanta_CRPAM].[dbo].[ExportacaoDirf] 
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
SET @TableName = 'ExportacaoDirf'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDirf : «' + RTRIM( ISNULL( CAST (IdDirf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRegistro : «' + RTRIM( ISNULL( CAST (TipoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinhaArquivo : «' + RTRIM( ISNULL( CAST (LinhaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJ : «' + RTRIM( ISNULL( CAST (CPFCNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ativo : «' + RTRIM( ISNULL( CAST (Ativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDirf : «' + RTRIM( ISNULL( CAST (IdDirf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRegistro : «' + RTRIM( ISNULL( CAST (TipoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinhaArquivo : «' + RTRIM( ISNULL( CAST (LinhaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJ : «' + RTRIM( ISNULL( CAST (CPFCNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ativo : «' + RTRIM( ISNULL( CAST (Ativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDirf : «' + RTRIM( ISNULL( CAST (IdDirf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRegistro : «' + RTRIM( ISNULL( CAST (TipoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinhaArquivo : «' + RTRIM( ISNULL( CAST (LinhaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJ : «' + RTRIM( ISNULL( CAST (CPFCNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ativo : «' + RTRIM( ISNULL( CAST (Ativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDirf : «' + RTRIM( ISNULL( CAST (IdDirf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Origem : «' + RTRIM( ISNULL( CAST (Origem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoRegistro : «' + RTRIM( ISNULL( CAST (TipoRegistro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| LinhaArquivo : «' + RTRIM( ISNULL( CAST (LinhaArquivo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPFCNPJ : «' + RTRIM( ISNULL( CAST (CPFCNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ativo : «' + RTRIM( ISNULL( CAST (Ativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
