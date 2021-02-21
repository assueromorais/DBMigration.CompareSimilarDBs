CREATE TABLE [dbo].[DividaAtiva] (
    [IdDividaAtiva]    INT            IDENTITY (1, 1) NOT NULL,
    [IdLivro]          INT            NULL,
    [IdProcesso]       INT            NULL,
    [DtInscricao]      DATETIME       NULL,
    [DtLancamento]     DATETIME       NULL,
    [Folha]            INT            NULL,
    [RegistraLog]      BIT            CONSTRAINT [DF__DividaAti__Regis__09F455BC] DEFAULT ((1)) NULL,
    [Usuario]          VARCHAR (30)   NULL,
    [IdProfissional]   INT            NULL,
    [IdPessoaJuridica] INT            NULL,
    [IdPessoa]         INT            NULL,
    [NumCertidao]      VARCHAR (20)   NULL,
    [NumeroProcesso]   VARCHAR (20)   NULL,
    [Observacoes]      VARCHAR (1000) NULL,
    [idMotivoDA]       INT            NULL,
    [NumAutoInfracao]  VARCHAR (30)   NULL,
    CONSTRAINT [PK__DebitosDividaAti__0C50D423] PRIMARY KEY CLUSTERED ([IdDividaAtiva] ASC),
    CONSTRAINT [FK_DebDivAt_Livro] FOREIGN KEY ([IdLivro]) REFERENCES [dbo].[LivrosDividaAtiva] ([IdLivro]),
    CONSTRAINT [FK_DividaAtiva_MotivosDividaAtiva] FOREIGN KEY ([idMotivoDA]) REFERENCES [dbo].[MotivosDividaAtiva] ([IDMotivo]),
    CONSTRAINT [FK_DividaAtiva_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_DividaAtiva_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]),
    CONSTRAINT [FK_DividaAtiva_Processos] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[Processos] ([IdProcesso]),
    CONSTRAINT [FK_DividaAtiva_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional])
);


GO
CREATE TRIGGER [TrgLog_DividaAtiva] ON [Implanta_CRPAM].[dbo].[DividaAtiva] 
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
SET @TableName = 'DividaAtiva'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
IF (@RegistraLogI <> 0 AND @RegistraLogD <> 0) BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLivro : «' + RTRIM( ISNULL( CAST (IdLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtInscricao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInscricao, 113 ),'Nulo'))+'» '
                         + '| DtLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DtLancamento, 113 ),'Nulo'))+'» '
                         + '| Folha : «' + RTRIM( ISNULL( CAST (Folha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumCertidao : «' + RTRIM( ISNULL( CAST (NumCertidao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Observacoes : «' + RTRIM( ISNULL( CAST (Observacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idMotivoDA : «' + RTRIM( ISNULL( CAST (idMotivoDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumAutoInfracao : «' + RTRIM( ISNULL( CAST (NumAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLivro : «' + RTRIM( ISNULL( CAST (IdLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtInscricao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInscricao, 113 ),'Nulo'))+'» '
                         + '| DtLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DtLancamento, 113 ),'Nulo'))+'» '
                         + '| Folha : «' + RTRIM( ISNULL( CAST (Folha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumCertidao : «' + RTRIM( ISNULL( CAST (NumCertidao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Observacoes : «' + RTRIM( ISNULL( CAST (Observacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idMotivoDA : «' + RTRIM( ISNULL( CAST (idMotivoDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumAutoInfracao : «' + RTRIM( ISNULL( CAST (NumAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLivro : «' + RTRIM( ISNULL( CAST (IdLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtInscricao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInscricao, 113 ),'Nulo'))+'» '
                         + '| DtLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DtLancamento, 113 ),'Nulo'))+'» '
                         + '| Folha : «' + RTRIM( ISNULL( CAST (Folha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumCertidao : «' + RTRIM( ISNULL( CAST (NumCertidao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Observacoes : «' + RTRIM( ISNULL( CAST (Observacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idMotivoDA : «' + RTRIM( ISNULL( CAST (idMotivoDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumAutoInfracao : «' + RTRIM( ISNULL( CAST (NumAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
AND @RegistraLogD = 1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDividaAtiva : «' + RTRIM( ISNULL( CAST (IdDividaAtiva AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLivro : «' + RTRIM( ISNULL( CAST (IdLivro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DtInscricao : «' + RTRIM( ISNULL( CONVERT (CHAR, DtInscricao, 113 ),'Nulo'))+'» '
                         + '| DtLancamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DtLancamento, 113 ),'Nulo'))+'» '
                         + '| Folha : «' + RTRIM( ISNULL( CAST (Folha AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RegistraLog IS NULL THEN ' RegistraLog : «Nulo» '
                                              WHEN  RegistraLog = 0 THEN ' RegistraLog : «Falso» '
                                              WHEN  RegistraLog = 1 THEN ' RegistraLog : «Verdadeiro» '
                                    END 
                         + '| Usuario : «' + RTRIM( ISNULL( CAST (Usuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumCertidao : «' + RTRIM( ISNULL( CAST (NumCertidao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Observacoes : «' + RTRIM( ISNULL( CAST (Observacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idMotivoDA : «' + RTRIM( ISNULL( CAST (idMotivoDA AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumAutoInfracao : «' + RTRIM( ISNULL( CAST (NumAutoInfracao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
