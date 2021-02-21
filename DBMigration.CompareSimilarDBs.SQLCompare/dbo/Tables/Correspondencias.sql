CREATE TABLE [dbo].[Correspondencias] (
    [IdCorrespondencia]     INT             IDENTITY (1, 1) NOT NULL,
    [IdProfissional]        INT             NULL,
    [IdPessoaJuridica]      INT             NULL,
    [IdPessoa]              INT             NULL,
    [IdFormaNotificacao]    INT             NOT NULL,
    [IdFormaPagto]          INT             NULL,
    [Nome]                  NVARCHAR (50)   NOT NULL,
    [NumeroCorrespondencia] VARCHAR (15)    NULL,
    [CodigoBarras]          NVARCHAR (50)   NULL,
    [Logradouro]            NVARCHAR (50)   NOT NULL,
    [Complemento]           NVARCHAR (50)   NULL,
    [Bairro]                NVARCHAR (50)   NOT NULL,
    [Cidade]                NVARCHAR (50)   NOT NULL,
    [UF]                    CHAR (2)        NOT NULL,
    [CEP]                   NCHAR (10)      NOT NULL,
    [DataCorrespondencia]   DATETIME        NOT NULL,
    [IndSituacao]           INT             NOT NULL,
    [IdDeptoCriacao]        INT             NOT NULL,
    [IdUsuarioCriacao]      INT             NOT NULL,
    [Peso]                  DECIMAL (18, 2) NULL,
    [Despesa]               MONEY           NULL,
    [Taxa]                  MONEY           NULL,
    [TxSedex]               MONEY           NULL,
    [DataRetorno]           DATETIME        NULL,
    [DataRecebimento]       DATETIME        NULL,
    [DataPostagem]          DATETIME        NULL,
    CONSTRAINT [PK_Correspondencia] PRIMARY KEY CLUSTERED ([IdCorrespondencia] ASC),
    CONSTRAINT [FK_Correspodencias_FormasNotificacao] FOREIGN KEY ([IdFormaNotificacao]) REFERENCES [dbo].[FormasNotificacao] ([IdFormaNotificacao]),
    CONSTRAINT [FK_Correspodencias_FormasPagamento] FOREIGN KEY ([IdFormaPagto]) REFERENCES [dbo].[TiposPagamentos] ([IdTipoPagamento]),
    CONSTRAINT [FK_Correspodencias_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_Correspodencias_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_Correspodencias_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
CREATE TRIGGER [TrgLog_Correspondencias] ON [Implanta_CRPAM].[dbo].[Correspondencias] 
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
SET @TableName = 'Correspondencias'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCorrespondencia : «' + RTRIM( ISNULL( CAST (IdCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaNotificacao : «' + RTRIM( ISNULL( CAST (IdFormaNotificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagto : «' + RTRIM( ISNULL( CAST (IdFormaPagto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCorrespondencia : «' + RTRIM( ISNULL( CAST (NumeroCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF : «' + RTRIM( ISNULL( CAST (UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCorrespondencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCorrespondencia, 113 ),'Nulo'))+'» '
                         + '| IndSituacao : «' + RTRIM( ISNULL( CAST (IndSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDeptoCriacao : «' + RTRIM( ISNULL( CAST (IdDeptoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Peso : «' + RTRIM( ISNULL( CAST (Peso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Despesa : «' + RTRIM( ISNULL( CAST (Despesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Taxa : «' + RTRIM( ISNULL( CAST (Taxa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TxSedex : «' + RTRIM( ISNULL( CAST (TxSedex AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRetorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetorno, 113 ),'Nulo'))+'» '
                         + '| DataRecebimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimento, 113 ),'Nulo'))+'» '
                         + '| DataPostagem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPostagem, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCorrespondencia : «' + RTRIM( ISNULL( CAST (IdCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaNotificacao : «' + RTRIM( ISNULL( CAST (IdFormaNotificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagto : «' + RTRIM( ISNULL( CAST (IdFormaPagto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCorrespondencia : «' + RTRIM( ISNULL( CAST (NumeroCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF : «' + RTRIM( ISNULL( CAST (UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCorrespondencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCorrespondencia, 113 ),'Nulo'))+'» '
                         + '| IndSituacao : «' + RTRIM( ISNULL( CAST (IndSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDeptoCriacao : «' + RTRIM( ISNULL( CAST (IdDeptoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Peso : «' + RTRIM( ISNULL( CAST (Peso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Despesa : «' + RTRIM( ISNULL( CAST (Despesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Taxa : «' + RTRIM( ISNULL( CAST (Taxa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TxSedex : «' + RTRIM( ISNULL( CAST (TxSedex AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRetorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetorno, 113 ),'Nulo'))+'» '
                         + '| DataRecebimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimento, 113 ),'Nulo'))+'» '
                         + '| DataPostagem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPostagem, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCorrespondencia : «' + RTRIM( ISNULL( CAST (IdCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaNotificacao : «' + RTRIM( ISNULL( CAST (IdFormaNotificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagto : «' + RTRIM( ISNULL( CAST (IdFormaPagto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCorrespondencia : «' + RTRIM( ISNULL( CAST (NumeroCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF : «' + RTRIM( ISNULL( CAST (UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCorrespondencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCorrespondencia, 113 ),'Nulo'))+'» '
                         + '| IndSituacao : «' + RTRIM( ISNULL( CAST (IndSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDeptoCriacao : «' + RTRIM( ISNULL( CAST (IdDeptoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Peso : «' + RTRIM( ISNULL( CAST (Peso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Despesa : «' + RTRIM( ISNULL( CAST (Despesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Taxa : «' + RTRIM( ISNULL( CAST (Taxa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TxSedex : «' + RTRIM( ISNULL( CAST (TxSedex AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRetorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetorno, 113 ),'Nulo'))+'» '
                         + '| DataRecebimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimento, 113 ),'Nulo'))+'» '
                         + '| DataPostagem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPostagem, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCorrespondencia : «' + RTRIM( ISNULL( CAST (IdCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaNotificacao : «' + RTRIM( ISNULL( CAST (IdFormaNotificacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdFormaPagto : «' + RTRIM( ISNULL( CAST (IdFormaPagto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroCorrespondencia : «' + RTRIM( ISNULL( CAST (NumeroCorrespondencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UF : «' + RTRIM( ISNULL( CAST (UF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCorrespondencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCorrespondencia, 113 ),'Nulo'))+'» '
                         + '| IndSituacao : «' + RTRIM( ISNULL( CAST (IndSituacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDeptoCriacao : «' + RTRIM( ISNULL( CAST (IdDeptoCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Peso : «' + RTRIM( ISNULL( CAST (Peso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Despesa : «' + RTRIM( ISNULL( CAST (Despesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Taxa : «' + RTRIM( ISNULL( CAST (Taxa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TxSedex : «' + RTRIM( ISNULL( CAST (TxSedex AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRetorno : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRetorno, 113 ),'Nulo'))+'» '
                         + '| DataRecebimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimento, 113 ),'Nulo'))+'» '
                         + '| DataPostagem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPostagem, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
