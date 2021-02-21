CREATE TABLE [dbo].[GruposMalaDiretaProfPJPessoas] (
    [IdGrupoMalaDiretaProfPJPessoas] INT IDENTITY (1, 1) NOT NULL,
    [IdGrupoMalaDireta]              INT NOT NULL,
    [IdProfissional]                 INT NULL,
    [IdPessoaJuridica]               INT NULL,
    [IdPessoa]                       INT NULL,
    PRIMARY KEY CLUSTERED ([IdGrupoMalaDiretaProfPJPessoas] ASC),
    CONSTRAINT [FK_GruposMalaDiretaProfPJPessoas_GruposMalaDireta] FOREIGN KEY ([IdGrupoMalaDireta]) REFERENCES [dbo].[GruposMalaDireta] ([IdGrupoMalaDireta]),
    CONSTRAINT [FK_GruposMalaDiretaProfPJPessoas_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) ON DELETE CASCADE,
    CONSTRAINT [FK_GruposMalaDiretaProfPJPessoas_PessoasJuridicas] FOREIGN KEY ([IdPessoaJuridica]) REFERENCES [dbo].[PessoasJuridicas] ([IdPessoaJuridica]) ON DELETE CASCADE,
    CONSTRAINT [FK_GruposMalaDiretaProfPJPessoas_Profissionais] FOREIGN KEY ([IdProfissional]) REFERENCES [dbo].[Profissionais] ([IdProfissional]) ON DELETE CASCADE
);


GO
CREATE TRIGGER [TrgLog_GruposMalaDiretaProfPJPessoas] ON [Implanta_CRPAM].[dbo].[GruposMalaDiretaProfPJPessoas] 
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
SET @TableName = 'GruposMalaDiretaProfPJPessoas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdGrupoMalaDiretaProfPJPessoas : «' + RTRIM( ISNULL( CAST (IdGrupoMalaDiretaProfPJPessoas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoMalaDireta : «' + RTRIM( ISNULL( CAST (IdGrupoMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdGrupoMalaDiretaProfPJPessoas : «' + RTRIM( ISNULL( CAST (IdGrupoMalaDiretaProfPJPessoas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoMalaDireta : «' + RTRIM( ISNULL( CAST (IdGrupoMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdGrupoMalaDiretaProfPJPessoas : «' + RTRIM( ISNULL( CAST (IdGrupoMalaDiretaProfPJPessoas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoMalaDireta : «' + RTRIM( ISNULL( CAST (IdGrupoMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdGrupoMalaDiretaProfPJPessoas : «' + RTRIM( ISNULL( CAST (IdGrupoMalaDiretaProfPJPessoas AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoMalaDireta : «' + RTRIM( ISNULL( CAST (IdGrupoMalaDireta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissional : «' + RTRIM( ISNULL( CAST (IdProfissional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridica : «' + RTRIM( ISNULL( CAST (IdPessoaJuridica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
