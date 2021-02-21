CREATE TABLE [dbo].[EnderecosProcesso] (
    [IdEnderecoProcesso]            INT          IDENTITY (1, 1) NOT NULL,
    [IdProfissional]                INT          NULL,
    [IdPessoaJuridica]              INT          NULL,
    [Endereco]                      VARCHAR (60) NOT NULL,
    [NomeBairro]                    VARCHAR (35) NULL,
    [NomeCidade]                    VARCHAR (30) NULL,
    [SiglaUf]                       CHAR (2)     NOT NULL,
    [CEP]                           VARCHAR (8)  NULL,
    [CaixaPostal]                   VARCHAR (15) NULL,
    [IdPessoa]                      INT          NULL,
    [UsuarioUltimaAtualizacao]      VARCHAR (35) NULL,
    [DepartamentoUltimaAtualizacao] VARCHAR (60) NULL,
    [Observacao]                    TEXT         NULL,
    [DataUltimaAtualizacao]         DATETIME     NULL,
    CONSTRAINT [PK_EnderecosProcesso] PRIMARY KEY NONCLUSTERED ([IdEnderecoProcesso] ASC),
    CONSTRAINT [FK_EnderecosProcesso_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_EnderecosProcessoPessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_EnderecosProcessoPessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica])
);


GO
CREATE TRIGGER [TrgLog_EnderecosProcesso] ON [Implanta_CRPAM].[dbo].[EnderecosProcesso] 
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
SET @TableName = 'EnderecosProcesso'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEnderecoProcesso : «' + RTRIM( ISNULL( CAST (IdEnderecoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUf : «' + RTRIM( ISNULL( CAST (SiglaUf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaixaPostal : «' + RTRIM( ISNULL( CAST (CaixaPostal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEnderecoProcesso : «' + RTRIM( ISNULL( CAST (IdEnderecoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUf : «' + RTRIM( ISNULL( CAST (SiglaUf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaixaPostal : «' + RTRIM( ISNULL( CAST (CaixaPostal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEnderecoProcesso : «' + RTRIM( ISNULL( CAST (IdEnderecoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUf : «' + RTRIM( ISNULL( CAST (SiglaUf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaixaPostal : «' + RTRIM( ISNULL( CAST (CaixaPostal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEnderecoProcesso : «' + RTRIM( ISNULL( CAST (IdEnderecoProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUf : «' + RTRIM( ISNULL( CAST (SiglaUf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CaixaPostal : «' + RTRIM( ISNULL( CAST (CaixaPostal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
