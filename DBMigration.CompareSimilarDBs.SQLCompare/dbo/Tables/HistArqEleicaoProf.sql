CREATE TABLE [dbo].[HistArqEleicaoProf] (
    [IdHistArqEleicaoProf] INT           IDENTITY (1, 1) NOT NULL,
    [IdHistArqEleicao]     INT           NULL,
    [IdProfissional]       INT           NULL,
    [Nome]                 VARCHAR (100) NULL,
    [Registro]             VARCHAR (20)  NULL,
    [CPF]                  VARCHAR (11)  NULL,
    [DataNascimento]       DATETIME      NULL,
    [AnoInscricao]         VARCHAR (4)   NULL,
    [NomeMae]              VARCHAR (50)  NULL,
    [RG]                   VARCHAR (20)  NULL,
    [SiglaUF]              VARCHAR (2)   NULL,
    [Cidade]               VARCHAR (30)  NULL,
    [Bairro]               VARCHAR (50)  NULL,
    [Endereco]             VARCHAR (60)  NULL,
    [CEP]                  VARCHAR (8)   NULL,
    [EMail]                VARCHAR (90)  NULL,
    [EMailAlternativo]     VARCHAR (90)  NULL,
    [EnderecoAtualizado]   BIT           NULL,
    [Situacao]             INT           NULL,
    [TelefoneCelular]      VARCHAR (500) NULL,
    [TelefoneTodos]        VARCHAR (500) NULL,
    [Naturalidade]         VARCHAR (50)  NULL,
    [NomePai]              VARCHAR (50)  NULL,
    CONSTRAINT [PK_HistArqEleicaoProf_IdHistArqEleicaoProf] PRIMARY KEY CLUSTERED ([IdHistArqEleicaoProf] ASC),
    CONSTRAINT [FK_HistArqEleicaoProf_HistArqEleicao] FOREIGN KEY ([IdHistArqEleicao]) REFERENCES [dbo].[HistArqEleicao] ([IdHistArqEleicao])
);


GO
CREATE TRIGGER [TrgLog_HistArqEleicaoProf] ON [Implanta_CRPAM].[dbo].[HistArqEleicaoProf] 
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
SET @TableName = 'HistArqEleicaoProf'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistArqEleicaoProf : «' + RTRIM( ISNULL( CAST (IdHistArqEleicaoProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdHistArqEleicao : «' + RTRIM( ISNULL( CAST (IdHistArqEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro : «' + RTRIM( ISNULL( CAST (Registro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataNascimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataNascimento, 113 ),'Nulo'))+'» '
                         + '| AnoInscricao : «' + RTRIM( ISNULL( CAST (AnoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeMae : «' + RTRIM( ISNULL( CAST (NomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RG : «' + RTRIM( ISNULL( CAST (RG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EMail : «' + RTRIM( ISNULL( CAST (EMail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EMailAlternativo : «' + RTRIM( ISNULL( CAST (EMailAlternativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnderecoAtualizado IS NULL THEN ' EnderecoAtualizado : «Nulo» '
                                              WHEN  EnderecoAtualizado = 0 THEN ' EnderecoAtualizado : «Falso» '
                                              WHEN  EnderecoAtualizado = 1 THEN ' EnderecoAtualizado : «Verdadeiro» '
                                    END 
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneCelular : «' + RTRIM( ISNULL( CAST (TelefoneCelular AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneTodos : «' + RTRIM( ISNULL( CAST (TelefoneTodos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Naturalidade : «' + RTRIM( ISNULL( CAST (Naturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePai : «' + RTRIM( ISNULL( CAST (NomePai AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistArqEleicaoProf : «' + RTRIM( ISNULL( CAST (IdHistArqEleicaoProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdHistArqEleicao : «' + RTRIM( ISNULL( CAST (IdHistArqEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro : «' + RTRIM( ISNULL( CAST (Registro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataNascimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataNascimento, 113 ),'Nulo'))+'» '
                         + '| AnoInscricao : «' + RTRIM( ISNULL( CAST (AnoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeMae : «' + RTRIM( ISNULL( CAST (NomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RG : «' + RTRIM( ISNULL( CAST (RG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EMail : «' + RTRIM( ISNULL( CAST (EMail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EMailAlternativo : «' + RTRIM( ISNULL( CAST (EMailAlternativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnderecoAtualizado IS NULL THEN ' EnderecoAtualizado : «Nulo» '
                                              WHEN  EnderecoAtualizado = 0 THEN ' EnderecoAtualizado : «Falso» '
                                              WHEN  EnderecoAtualizado = 1 THEN ' EnderecoAtualizado : «Verdadeiro» '
                                    END 
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneCelular : «' + RTRIM( ISNULL( CAST (TelefoneCelular AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneTodos : «' + RTRIM( ISNULL( CAST (TelefoneTodos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Naturalidade : «' + RTRIM( ISNULL( CAST (Naturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePai : «' + RTRIM( ISNULL( CAST (NomePai AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistArqEleicaoProf : «' + RTRIM( ISNULL( CAST (IdHistArqEleicaoProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdHistArqEleicao : «' + RTRIM( ISNULL( CAST (IdHistArqEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro : «' + RTRIM( ISNULL( CAST (Registro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataNascimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataNascimento, 113 ),'Nulo'))+'» '
                         + '| AnoInscricao : «' + RTRIM( ISNULL( CAST (AnoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeMae : «' + RTRIM( ISNULL( CAST (NomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RG : «' + RTRIM( ISNULL( CAST (RG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EMail : «' + RTRIM( ISNULL( CAST (EMail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EMailAlternativo : «' + RTRIM( ISNULL( CAST (EMailAlternativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnderecoAtualizado IS NULL THEN ' EnderecoAtualizado : «Nulo» '
                                              WHEN  EnderecoAtualizado = 0 THEN ' EnderecoAtualizado : «Falso» '
                                              WHEN  EnderecoAtualizado = 1 THEN ' EnderecoAtualizado : «Verdadeiro» '
                                    END 
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneCelular : «' + RTRIM( ISNULL( CAST (TelefoneCelular AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneTodos : «' + RTRIM( ISNULL( CAST (TelefoneTodos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Naturalidade : «' + RTRIM( ISNULL( CAST (Naturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePai : «' + RTRIM( ISNULL( CAST (NomePai AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistArqEleicaoProf : «' + RTRIM( ISNULL( CAST (IdHistArqEleicaoProf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdHistArqEleicao : «' + RTRIM( ISNULL( CAST (IdHistArqEleicao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro : «' + RTRIM( ISNULL( CAST (Registro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataNascimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataNascimento, 113 ),'Nulo'))+'» '
                         + '| AnoInscricao : «' + RTRIM( ISNULL( CAST (AnoInscricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeMae : «' + RTRIM( ISNULL( CAST (NomeMae AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RG : «' + RTRIM( ISNULL( CAST (RG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUF : «' + RTRIM( ISNULL( CAST (SiglaUF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Cidade : «' + RTRIM( ISNULL( CAST (Cidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Bairro : «' + RTRIM( ISNULL( CAST (Bairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EMail : «' + RTRIM( ISNULL( CAST (EMail AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EMailAlternativo : «' + RTRIM( ISNULL( CAST (EMailAlternativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EnderecoAtualizado IS NULL THEN ' EnderecoAtualizado : «Nulo» '
                                              WHEN  EnderecoAtualizado = 0 THEN ' EnderecoAtualizado : «Falso» '
                                              WHEN  EnderecoAtualizado = 1 THEN ' EnderecoAtualizado : «Verdadeiro» '
                                    END 
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneCelular : «' + RTRIM( ISNULL( CAST (TelefoneCelular AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TelefoneTodos : «' + RTRIM( ISNULL( CAST (TelefoneTodos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Naturalidade : «' + RTRIM( ISNULL( CAST (Naturalidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePai : «' + RTRIM( ISNULL( CAST (NomePai AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
