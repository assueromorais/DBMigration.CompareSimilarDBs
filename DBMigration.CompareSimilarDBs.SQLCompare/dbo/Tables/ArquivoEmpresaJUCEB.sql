CREATE TABLE [dbo].[ArquivoEmpresaJUCEB] (
    [IdArquivoEmpresa] INT           IDENTITY (1, 1) NOT NULL,
    [IdImportacao]     INT           NOT NULL,
    [NIRE]             VARCHAR (20)  NOT NULL,
    [CNPJ]             VARCHAR (14)  NOT NULL,
    [Chave]            INT           NOT NULL,
    [NomeEmpresa]      VARCHAR (200) NOT NULL,
    [Logradouro]       VARCHAR (60)  NULL,
    [NumLogradouro]    VARCHAR (10)  NULL,
    [ComplementoLogra] VARCHAR (60)  NULL,
    [Bairro]           VARCHAR (35)  NULL,
    [Cidade]           VARCHAR (30)  NULL,
    [CEP]              VARCHAR (8)   NULL,
    [UF]               VARCHAR (2)   NULL,
    [ValorCapital]     MONEY         NULL,
    [DtConstitutiva]   DATETIME      NULL,
    [CNAE]             VARCHAR (10)  NULL,
    [Atividade]        TEXT          NULL,
    CONSTRAINT [PK_ArquivoEmpresaJUCEB] PRIMARY KEY CLUSTERED ([IdArquivoEmpresa] ASC)
);


GO
CREATE TRIGGER [TrgLog_ArquivoEmpresaJUCEB] ON [Implanta_CRPAM].[dbo].[ArquivoEmpresaJUCEB] 
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
SET @TableName = 'ArquivoEmpresaJUCEB'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdArquivoEmpresa : «' + RTRIM( ISNULL( CAST (IdArquivoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdImportacao : «' + RTRIM( ISNULL( CAST (IdImportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NIRE : «' + RTRIM( ISNULL( CAST (NIRE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNPJ : «' + RTRIM( ISNULL( CAST (CNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Chave : «' + RTRIM( ISNULL( CAST (Chave AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEmpresa : «' + RTRIM( ISNULL( CAST (NomeEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumLogradouro : «' + RTRIM( ISNULL( CAST (NumLogradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoLogra : «' + RTRIM( ISNULL( CAST (ComplementoLogra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF : «' + RTRIM( ISNULL( CAST (UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCapital : «' + RTRIM( ISNULL( CAST (ValorCapital AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtConstitutiva : «' + RTRIM( ISNULL( CONVERT (CHAR, DtConstitutiva, 113 ),'Nulo'))+'» '
                         + '| CNAE : «' + RTRIM( ISNULL( CAST (CNAE AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdArquivoEmpresa : «' + RTRIM( ISNULL( CAST (IdArquivoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdImportacao : «' + RTRIM( ISNULL( CAST (IdImportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NIRE : «' + RTRIM( ISNULL( CAST (NIRE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNPJ : «' + RTRIM( ISNULL( CAST (CNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Chave : «' + RTRIM( ISNULL( CAST (Chave AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEmpresa : «' + RTRIM( ISNULL( CAST (NomeEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumLogradouro : «' + RTRIM( ISNULL( CAST (NumLogradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoLogra : «' + RTRIM( ISNULL( CAST (ComplementoLogra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF : «' + RTRIM( ISNULL( CAST (UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCapital : «' + RTRIM( ISNULL( CAST (ValorCapital AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtConstitutiva : «' + RTRIM( ISNULL( CONVERT (CHAR, DtConstitutiva, 113 ),'Nulo'))+'» '
                         + '| CNAE : «' + RTRIM( ISNULL( CAST (CNAE AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdArquivoEmpresa : «' + RTRIM( ISNULL( CAST (IdArquivoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdImportacao : «' + RTRIM( ISNULL( CAST (IdImportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NIRE : «' + RTRIM( ISNULL( CAST (NIRE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNPJ : «' + RTRIM( ISNULL( CAST (CNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Chave : «' + RTRIM( ISNULL( CAST (Chave AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEmpresa : «' + RTRIM( ISNULL( CAST (NomeEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumLogradouro : «' + RTRIM( ISNULL( CAST (NumLogradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoLogra : «' + RTRIM( ISNULL( CAST (ComplementoLogra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF : «' + RTRIM( ISNULL( CAST (UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCapital : «' + RTRIM( ISNULL( CAST (ValorCapital AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtConstitutiva : «' + RTRIM( ISNULL( CONVERT (CHAR, DtConstitutiva, 113 ),'Nulo'))+'» '
                         + '| CNAE : «' + RTRIM( ISNULL( CAST (CNAE AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdArquivoEmpresa : «' + RTRIM( ISNULL( CAST (IdArquivoEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdImportacao : «' + RTRIM( ISNULL( CAST (IdImportacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NIRE : «' + RTRIM( ISNULL( CAST (NIRE AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CNPJ : «' + RTRIM( ISNULL( CAST (CNPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Chave : «' + RTRIM( ISNULL( CAST (Chave AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeEmpresa : «' + RTRIM( ISNULL( CAST (NomeEmpresa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumLogradouro : «' + RTRIM( ISNULL( CAST (NumLogradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoLogra : «' + RTRIM( ISNULL( CAST (ComplementoLogra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF : «' + RTRIM( ISNULL( CAST (UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorCapital : «' + RTRIM( ISNULL( CAST (ValorCapital AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtConstitutiva : «' + RTRIM( ISNULL( CONVERT (CHAR, DtConstitutiva, 113 ),'Nulo'))+'» '
                         + '| CNAE : «' + RTRIM( ISNULL( CAST (CNAE AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
