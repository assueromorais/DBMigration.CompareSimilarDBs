CREATE TABLE [dbo].[OcorrenciasPFPJ] (
    [IdOcorrenciaPFPJ]      INT           IDENTITY (1, 1) NOT NULL,
    [IdProfissional]        INT           NULL,
    [IdPessoaJuridica]      INT           NULL,
    [IdOcorrencia]          INT           NOT NULL,
    [DataOcorrencia]        DATETIME      NULL,
    [Documento]             VARCHAR (50)  NULL,
    [Protocolo]             VARCHAR (5)   NULL,
    [Observacoes]           TEXT          NULL,
    [IdUsuarioCriacao]      INT           NULL,
    [DataFimOcorrencia]     DATETIME      NULL,
    [IdDetalheOcorrencia]   INT           NULL,
    [Nome]                  VARCHAR (100) NULL,
    [Registro]              VARCHAR (20)  NULL,
    [CPF]                   VARCHAR (11)  NULL,
    [RG]                    VARCHAR (15)  NULL,
    [IdDepartamento]        INT           NULL,
    [NomeSocial]            VARCHAR (50)  NULL,
    [NomeUsuarioAlterou]    VARCHAR (100) NULL,
    [Departamento]          VARCHAR (100) NULL,
    [DataUltimaAtualizacao] DATETIME      NULL,
    [ObsultimaAlteracao]    TEXT          NULL,
    CONSTRAINT [PK_OcorrenciasPFPJ] PRIMARY KEY CLUSTERED ([IdOcorrenciaPFPJ] ASC),
    CONSTRAINT [FK_OcorrenciasPFPJ_Departamentos] FOREIGN KEY ([IdDepartamento]) REFERENCES [dbo].[Departamentos] ([IdDepto]) NOT FOR REPLICATION,
    CONSTRAINT [FK_OcorrenciasPFPJ_DetalhesOcorrenciasSiscafw] FOREIGN KEY ([IdDetalheOcorrencia]) REFERENCES [dbo].[DetalhesOcorrenciasSiscafw] ([IdDetalheOcorrencia]),
    CONSTRAINT [FK_OcorrenciasPFPJ_OcorrenciaSiscafw] FOREIGN KEY ([IdOcorrencia]) REFERENCES [dbo].[OcorrenciasSiscafw] ([IdOcorrencia]),
    CONSTRAINT [FK_OcorrenciasPFPJ_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]) NOT FOR REPLICATION,
    CONSTRAINT [FK_OcorrenciasPFPJ_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]) NOT FOR REPLICATION,
    CONSTRAINT [FK_OcorrenciasPFPJ_Usuarios] FOREIGN KEY ([IdUsuarioCriacao]) REFERENCES [dbo].[Usuarios] ([IdUsuario]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[OcorrenciasPFPJ] NOCHECK CONSTRAINT [FK_OcorrenciasPFPJ_Usuarios];


GO
CREATE TRIGGER [TrgLog_OcorrenciasPFPJ] ON [Implanta_CRPAM].[dbo].[OcorrenciasPFPJ] 
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
SET @TableName = 'OcorrenciasPFPJ'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdOcorrenciaPFPJ : «' + RTRIM( ISNULL( CAST (IdOcorrenciaPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOcorrencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOcorrencia, 113 ),'Nulo'))+'» '
                         + '| Documento : «' + RTRIM( ISNULL( CAST (Documento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Protocolo : «' + RTRIM( ISNULL( CAST (Protocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataFimOcorrencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimOcorrencia, 113 ),'Nulo'))+'» '
                         + '| IdDetalheOcorrencia : «' + RTRIM( ISNULL( CAST (IdDetalheOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro : «' + RTRIM( ISNULL( CAST (Registro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RG : «' + RTRIM( ISNULL( CAST (RG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSocial : «' + RTRIM( ISNULL( CAST (NomeSocial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeUsuarioAlterou : «' + RTRIM( ISNULL( CAST (NomeUsuarioAlterou AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdOcorrenciaPFPJ : «' + RTRIM( ISNULL( CAST (IdOcorrenciaPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOcorrencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOcorrencia, 113 ),'Nulo'))+'» '
                         + '| Documento : «' + RTRIM( ISNULL( CAST (Documento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Protocolo : «' + RTRIM( ISNULL( CAST (Protocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataFimOcorrencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimOcorrencia, 113 ),'Nulo'))+'» '
                         + '| IdDetalheOcorrencia : «' + RTRIM( ISNULL( CAST (IdDetalheOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro : «' + RTRIM( ISNULL( CAST (Registro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RG : «' + RTRIM( ISNULL( CAST (RG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSocial : «' + RTRIM( ISNULL( CAST (NomeSocial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeUsuarioAlterou : «' + RTRIM( ISNULL( CAST (NomeUsuarioAlterou AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» '
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
		SELECT @Conteudo = 'IdOcorrenciaPFPJ : «' + RTRIM( ISNULL( CAST (IdOcorrenciaPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOcorrencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOcorrencia, 113 ),'Nulo'))+'» '
                         + '| Documento : «' + RTRIM( ISNULL( CAST (Documento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Protocolo : «' + RTRIM( ISNULL( CAST (Protocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataFimOcorrencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimOcorrencia, 113 ),'Nulo'))+'» '
                         + '| IdDetalheOcorrencia : «' + RTRIM( ISNULL( CAST (IdDetalheOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro : «' + RTRIM( ISNULL( CAST (Registro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RG : «' + RTRIM( ISNULL( CAST (RG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSocial : «' + RTRIM( ISNULL( CAST (NomeSocial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeUsuarioAlterou : «' + RTRIM( ISNULL( CAST (NomeUsuarioAlterou AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdOcorrenciaPFPJ : «' + RTRIM( ISNULL( CAST (IdOcorrenciaPFPJ AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdOcorrencia : «' + RTRIM( ISNULL( CAST (IdOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOcorrencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOcorrencia, 113 ),'Nulo'))+'» '
                         + '| Documento : «' + RTRIM( ISNULL( CAST (Documento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Protocolo : «' + RTRIM( ISNULL( CAST (Protocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioCriacao : «' + RTRIM( ISNULL( CAST (IdUsuarioCriacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataFimOcorrencia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimOcorrencia, 113 ),'Nulo'))+'» '
                         + '| IdDetalheOcorrencia : «' + RTRIM( ISNULL( CAST (IdDetalheOcorrencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Nome : «' + RTRIM( ISNULL( CAST (Nome AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Registro : «' + RTRIM( ISNULL( CAST (Registro AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CPF : «' + RTRIM( ISNULL( CAST (CPF AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RG : «' + RTRIM( ISNULL( CAST (RG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepartamento : «' + RTRIM( ISNULL( CAST (IdDepartamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeSocial : «' + RTRIM( ISNULL( CAST (NomeSocial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeUsuarioAlterou : «' + RTRIM( ISNULL( CAST (NomeUsuarioAlterou AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Departamento : «' + RTRIM( ISNULL( CAST (Departamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataUltimaAtualizacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaAtualizacao, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
