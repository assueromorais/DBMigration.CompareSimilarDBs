CREATE TABLE [dbo].[Enderecos] (
    [IdEndereco]                    INT            IDENTITY (1, 1) NOT NULL,
    [IdProfissional]                INT            NULL,
    [NomeBairro]                    VARCHAR (35)   NULL,
    [NomeCidade]                    VARCHAR (30)   NULL,
    [SiglaUf]                       CHAR (2)       NOT NULL,
    [CEP]                           VARCHAR (8)    NULL,
    [E_Exterior]                    BIT            NULL,
    [E_Residencial]                 INT            CONSTRAINT [DF_Enderecos_E_Residencial] DEFAULT ((1)) NULL,
    [Correspondencia]               BIT            NOT NULL,
    [Atualizado]                    BIT            NOT NULL,
    [DataUltimaAtualizacao]         DATETIME       NULL,
    [CaixaPostal]                   VARCHAR (15)   NULL,
    [AtualizacaoWeb]                VARCHAR (8000) NULL,
    [IdPessoa]                      INT            NULL,
    [OrdemCorresp]                  INT            NULL,
    [OrdemDtAtualiz]                DATETIME       NULL,
    [CORRESPONDENCIAPROCESSO]       BIT            CONSTRAINT [DF__ENDERECOS__CORRE__057A84B9] DEFAULT ((0)) NOT NULL,
    [IdPJTrabalho]                  INT            NULL,
    [UsuarioUltimaAtualizacao]      VARCHAR (150)  NULL,
    [DepartamentoUltimaAtualizacao] VARCHAR (60)   NULL,
    [E_Divulgacao]                  BIT            NULL,
    [MalaDireta]                    BIT            NULL,
    [Observacao]                    TEXT           NULL,
    [IdPais]                        INT            NULL,
    [ComplementoEndereco]           VARCHAR (60)   NULL,
    [IdPessoaJuridica]              INT            NULL,
    [Numero]                        VARCHAR (10)   NULL,
    [idSiscafWeb]                   INT            NULL,
    [SessaoWeb]                     VARCHAR (50)   NULL,
    [Endereco1]                     VARCHAR (200)  NULL,
    [Logradouro]                    VARCHAR (60)   NULL,
    [Endereco]                      AS             (ltrim((coalesce(isnull([Logradouro]+' ',NULL),isnull([Endereco1]+' ',NULL))+isnull([Numero]+' ',''))+isnull([ComplementoEndereco],''))),
    CONSTRAINT [PK_Enderecos] PRIMARY KEY NONCLUSTERED ([IdEndereco] ASC),
    CONSTRAINT [FK_Enderecos_Nacionalidades] FOREIGN KEY ([IdPais]) REFERENCES [dbo].[Nacionalidades] ([IdNacionalidade]),
    CONSTRAINT [FK_Enderecos_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]),
    CONSTRAINT [FK_EnderecosPessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION,
    CONSTRAINT [FK_IdPessoaJuridica_Enderecos] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica])
);


GO
CREATE TRIGGER [TrgLog_Enderecos] ON [Implanta_CRPAM].[dbo].[Enderecos] 
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
SET @TableName = 'Enderecos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEndereco : «' + RTRIM( ISNULL( CAST (IdEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUf : «' + RTRIM( ISNULL( CAST (SiglaUf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Exterior IS NULL THEN ' E_Exterior : «Nulo» '
                                              WHEN  E_Exterior = 0 THEN ' E_Exterior : «Falso» '
                                              WHEN  E_Exterior = 1 THEN ' E_Exterior : «Verdadeiro» '
                                    END 
                         + '| E_Residencial : «' + RTRIM( ISNULL( CAST (E_Residencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Correspondencia IS NULL THEN ' Correspondencia : «Nulo» '
                                              WHEN  Correspondencia = 0 THEN ' Correspondencia : «Falso» '
                                              WHEN  Correspondencia = 1 THEN ' Correspondencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Atualizado IS NULL THEN ' Atualizado : «Nulo» '
                                              WHEN  Atualizado = 0 THEN ' Atualizado : «Falso» '
                                              WHEN  Atualizado = 1 THEN ' Atualizado : «Verdadeiro» '
                                    END 
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| CaixaPostal : «' + RTRIM( ISNULL( CAST (CaixaPostal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemCorresp : «' + RTRIM( ISNULL( CAST (OrdemCorresp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemDtAtualiz : «' + RTRIM( ISNULL( CONVERT (CHAR, OrdemDtAtualiz, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CORRESPONDENCIAPROCESSO IS NULL THEN ' CORRESPONDENCIAPROCESSO : «Nulo» '
                                              WHEN  CORRESPONDENCIAPROCESSO = 0 THEN ' CORRESPONDENCIAPROCESSO : «Falso» '
                                              WHEN  CORRESPONDENCIAPROCESSO = 1 THEN ' CORRESPONDENCIAPROCESSO : «Verdadeiro» '
                                    END 
                         + '| IdPJTrabalho : «' + RTRIM( ISNULL( CAST (IdPJTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Divulgacao IS NULL THEN ' E_Divulgacao : «Nulo» '
                                              WHEN  E_Divulgacao = 0 THEN ' E_Divulgacao : «Falso» '
                                              WHEN  E_Divulgacao = 1 THEN ' E_Divulgacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MalaDireta IS NULL THEN ' MalaDireta : «Nulo» '
                                              WHEN  MalaDireta = 0 THEN ' MalaDireta : «Falso» '
                                              WHEN  MalaDireta = 1 THEN ' MalaDireta : «Verdadeiro» '
                                    END 
                         + '| IdPais : «' + RTRIM( ISNULL( CAST (IdPais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoEndereco : «' + RTRIM( ISNULL( CAST (ComplementoEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idSiscafWeb : «' + RTRIM( ISNULL( CAST (idSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SessaoWeb : «' + RTRIM( ISNULL( CAST (SessaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco1 : «' + RTRIM( ISNULL( CAST (Endereco1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEndereco : «' + RTRIM( ISNULL( CAST (IdEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUf : «' + RTRIM( ISNULL( CAST (SiglaUf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Exterior IS NULL THEN ' E_Exterior : «Nulo» '
                                              WHEN  E_Exterior = 0 THEN ' E_Exterior : «Falso» '
                                              WHEN  E_Exterior = 1 THEN ' E_Exterior : «Verdadeiro» '
                                    END 
                         + '| E_Residencial : «' + RTRIM( ISNULL( CAST (E_Residencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Correspondencia IS NULL THEN ' Correspondencia : «Nulo» '
                                              WHEN  Correspondencia = 0 THEN ' Correspondencia : «Falso» '
                                              WHEN  Correspondencia = 1 THEN ' Correspondencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Atualizado IS NULL THEN ' Atualizado : «Nulo» '
                                              WHEN  Atualizado = 0 THEN ' Atualizado : «Falso» '
                                              WHEN  Atualizado = 1 THEN ' Atualizado : «Verdadeiro» '
                                    END 
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| CaixaPostal : «' + RTRIM( ISNULL( CAST (CaixaPostal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemCorresp : «' + RTRIM( ISNULL( CAST (OrdemCorresp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemDtAtualiz : «' + RTRIM( ISNULL( CONVERT (CHAR, OrdemDtAtualiz, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CORRESPONDENCIAPROCESSO IS NULL THEN ' CORRESPONDENCIAPROCESSO : «Nulo» '
                                              WHEN  CORRESPONDENCIAPROCESSO = 0 THEN ' CORRESPONDENCIAPROCESSO : «Falso» '
                                              WHEN  CORRESPONDENCIAPROCESSO = 1 THEN ' CORRESPONDENCIAPROCESSO : «Verdadeiro» '
                                    END 
                         + '| IdPJTrabalho : «' + RTRIM( ISNULL( CAST (IdPJTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Divulgacao IS NULL THEN ' E_Divulgacao : «Nulo» '
                                              WHEN  E_Divulgacao = 0 THEN ' E_Divulgacao : «Falso» '
                                              WHEN  E_Divulgacao = 1 THEN ' E_Divulgacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MalaDireta IS NULL THEN ' MalaDireta : «Nulo» '
                                              WHEN  MalaDireta = 0 THEN ' MalaDireta : «Falso» '
                                              WHEN  MalaDireta = 1 THEN ' MalaDireta : «Verdadeiro» '
                                    END 
                         + '| IdPais : «' + RTRIM( ISNULL( CAST (IdPais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoEndereco : «' + RTRIM( ISNULL( CAST (ComplementoEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idSiscafWeb : «' + RTRIM( ISNULL( CAST (idSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SessaoWeb : «' + RTRIM( ISNULL( CAST (SessaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco1 : «' + RTRIM( ISNULL( CAST (Endereco1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEndereco : «' + RTRIM( ISNULL( CAST (IdEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUf : «' + RTRIM( ISNULL( CAST (SiglaUf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Exterior IS NULL THEN ' E_Exterior : «Nulo» '
                                              WHEN  E_Exterior = 0 THEN ' E_Exterior : «Falso» '
                                              WHEN  E_Exterior = 1 THEN ' E_Exterior : «Verdadeiro» '
                                    END 
                         + '| E_Residencial : «' + RTRIM( ISNULL( CAST (E_Residencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Correspondencia IS NULL THEN ' Correspondencia : «Nulo» '
                                              WHEN  Correspondencia = 0 THEN ' Correspondencia : «Falso» '
                                              WHEN  Correspondencia = 1 THEN ' Correspondencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Atualizado IS NULL THEN ' Atualizado : «Nulo» '
                                              WHEN  Atualizado = 0 THEN ' Atualizado : «Falso» '
                                              WHEN  Atualizado = 1 THEN ' Atualizado : «Verdadeiro» '
                                    END 
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| CaixaPostal : «' + RTRIM( ISNULL( CAST (CaixaPostal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemCorresp : «' + RTRIM( ISNULL( CAST (OrdemCorresp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemDtAtualiz : «' + RTRIM( ISNULL( CONVERT (CHAR, OrdemDtAtualiz, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CORRESPONDENCIAPROCESSO IS NULL THEN ' CORRESPONDENCIAPROCESSO : «Nulo» '
                                              WHEN  CORRESPONDENCIAPROCESSO = 0 THEN ' CORRESPONDENCIAPROCESSO : «Falso» '
                                              WHEN  CORRESPONDENCIAPROCESSO = 1 THEN ' CORRESPONDENCIAPROCESSO : «Verdadeiro» '
                                    END 
                         + '| IdPJTrabalho : «' + RTRIM( ISNULL( CAST (IdPJTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Divulgacao IS NULL THEN ' E_Divulgacao : «Nulo» '
                                              WHEN  E_Divulgacao = 0 THEN ' E_Divulgacao : «Falso» '
                                              WHEN  E_Divulgacao = 1 THEN ' E_Divulgacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MalaDireta IS NULL THEN ' MalaDireta : «Nulo» '
                                              WHEN  MalaDireta = 0 THEN ' MalaDireta : «Falso» '
                                              WHEN  MalaDireta = 1 THEN ' MalaDireta : «Verdadeiro» '
                                    END 
                         + '| IdPais : «' + RTRIM( ISNULL( CAST (IdPais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoEndereco : «' + RTRIM( ISNULL( CAST (ComplementoEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idSiscafWeb : «' + RTRIM( ISNULL( CAST (idSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SessaoWeb : «' + RTRIM( ISNULL( CAST (SessaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco1 : «' + RTRIM( ISNULL( CAST (Endereco1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEndereco : «' + RTRIM( ISNULL( CAST (IdEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBairro : «' + RTRIM( ISNULL( CAST (NomeBairro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeCidade : «' + RTRIM( ISNULL( CAST (NomeCidade AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SiglaUf : «' + RTRIM( ISNULL( CAST (SiglaUf AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEP : «' + RTRIM( ISNULL( CAST (CEP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Exterior IS NULL THEN ' E_Exterior : «Nulo» '
                                              WHEN  E_Exterior = 0 THEN ' E_Exterior : «Falso» '
                                              WHEN  E_Exterior = 1 THEN ' E_Exterior : «Verdadeiro» '
                                    END 
                         + '| E_Residencial : «' + RTRIM( ISNULL( CAST (E_Residencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Correspondencia IS NULL THEN ' Correspondencia : «Nulo» '
                                              WHEN  Correspondencia = 0 THEN ' Correspondencia : «Falso» '
                                              WHEN  Correspondencia = 1 THEN ' Correspondencia : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  Atualizado IS NULL THEN ' Atualizado : «Nulo» '
                                              WHEN  Atualizado = 0 THEN ' Atualizado : «Falso» '
                                              WHEN  Atualizado = 1 THEN ' Atualizado : «Verdadeiro» '
                                    END 
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» '
                         + '| CaixaPostal : «' + RTRIM( ISNULL( CAST (CaixaPostal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AtualizacaoWeb : «' + RTRIM( ISNULL( CAST (AtualizacaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemCorresp : «' + RTRIM( ISNULL( CAST (OrdemCorresp AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| OrdemDtAtualiz : «' + RTRIM( ISNULL( CONVERT (CHAR, OrdemDtAtualiz, 113 ),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CORRESPONDENCIAPROCESSO IS NULL THEN ' CORRESPONDENCIAPROCESSO : «Nulo» '
                                              WHEN  CORRESPONDENCIAPROCESSO = 0 THEN ' CORRESPONDENCIAPROCESSO : «Falso» '
                                              WHEN  CORRESPONDENCIAPROCESSO = 1 THEN ' CORRESPONDENCIAPROCESSO : «Verdadeiro» '
                                    END 
                         + '| IdPJTrabalho : «' + RTRIM( ISNULL( CAST (IdPJTrabalho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (UsuarioUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DepartamentoUltimaAtualizacao : «' + RTRIM( ISNULL( CAST (DepartamentoUltimaAtualizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  E_Divulgacao IS NULL THEN ' E_Divulgacao : «Nulo» '
                                              WHEN  E_Divulgacao = 0 THEN ' E_Divulgacao : «Falso» '
                                              WHEN  E_Divulgacao = 1 THEN ' E_Divulgacao : «Verdadeiro» '
                                    END 
                         + '| ' +  CASE 
                                              WHEN  MalaDireta IS NULL THEN ' MalaDireta : «Nulo» '
                                              WHEN  MalaDireta = 0 THEN ' MalaDireta : «Falso» '
                                              WHEN  MalaDireta = 1 THEN ' MalaDireta : «Verdadeiro» '
                                    END 
                         + '| IdPais : «' + RTRIM( ISNULL( CAST (IdPais AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ComplementoEndereco : «' + RTRIM( ISNULL( CAST (ComplementoEndereco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Numero : «' + RTRIM( ISNULL( CAST (Numero AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| idSiscafWeb : «' + RTRIM( ISNULL( CAST (idSiscafWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SessaoWeb : «' + RTRIM( ISNULL( CAST (SessaoWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco1 : «' + RTRIM( ISNULL( CAST (Endereco1 AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Logradouro : «' + RTRIM( ISNULL( CAST (Logradouro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Endereco : «' + RTRIM( ISNULL( CAST (Endereco AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
