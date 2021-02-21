CREATE TABLE [dbo].[HistoricoAcessoUsuarioWeb] (
    [IdHistoricoAcesso]   INT           IDENTITY (1, 1) NOT NULL,
    [IdUsuarioWeb]        INT           NULL,
    [IdProfissionalWeb]   INT           NULL,
    [IdPessoaJuridicaWeb] INT           NULL,
    [DataAcesso]          DATETIME      NOT NULL,
    [HostAcesso]          VARCHAR (50)  NULL,
    [IdRegional]          INT           NULL,
    [TipoPessoa]          VARCHAR (30)  NULL,
    [UsuarioWeb]          VARCHAR (200) NULL,
    CONSTRAINT [PK_HistoricoAcessoUsuarioWeb] PRIMARY KEY CLUSTERED ([IdHistoricoAcesso] ASC)
);


GO
CREATE TRIGGER [TrgLog_HistoricoAcessoUsuarioWeb] ON [Implanta_CRPAM].[dbo].[HistoricoAcessoUsuarioWeb] 
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
SET @TableName = 'HistoricoAcessoUsuarioWeb'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdHistoricoAcesso : «' + RTRIM( ISNULL( CAST (IdHistoricoAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioWeb : «' + RTRIM( ISNULL( CAST (IdUsuarioWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalWeb : «' + RTRIM( ISNULL( CAST (IdProfissionalWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridicaWeb : «' + RTRIM( ISNULL( CAST (IdPessoaJuridicaWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcesso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAcesso, 113 ),'Nulo'))+'» '
                         + '| HostAcesso : «' + RTRIM( ISNULL( CAST (HostAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRegional : «' + RTRIM( ISNULL( CAST (IdRegional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioWeb : «' + RTRIM( ISNULL( CAST (UsuarioWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdHistoricoAcesso : «' + RTRIM( ISNULL( CAST (IdHistoricoAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioWeb : «' + RTRIM( ISNULL( CAST (IdUsuarioWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalWeb : «' + RTRIM( ISNULL( CAST (IdProfissionalWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridicaWeb : «' + RTRIM( ISNULL( CAST (IdPessoaJuridicaWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcesso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAcesso, 113 ),'Nulo'))+'» '
                         + '| HostAcesso : «' + RTRIM( ISNULL( CAST (HostAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRegional : «' + RTRIM( ISNULL( CAST (IdRegional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioWeb : «' + RTRIM( ISNULL( CAST (UsuarioWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdHistoricoAcesso : «' + RTRIM( ISNULL( CAST (IdHistoricoAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioWeb : «' + RTRIM( ISNULL( CAST (IdUsuarioWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalWeb : «' + RTRIM( ISNULL( CAST (IdProfissionalWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridicaWeb : «' + RTRIM( ISNULL( CAST (IdPessoaJuridicaWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcesso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAcesso, 113 ),'Nulo'))+'» '
                         + '| HostAcesso : «' + RTRIM( ISNULL( CAST (HostAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRegional : «' + RTRIM( ISNULL( CAST (IdRegional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioWeb : «' + RTRIM( ISNULL( CAST (UsuarioWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdHistoricoAcesso : «' + RTRIM( ISNULL( CAST (IdHistoricoAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuarioWeb : «' + RTRIM( ISNULL( CAST (IdUsuarioWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProfissionalWeb : «' + RTRIM( ISNULL( CAST (IdProfissionalWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoaJuridicaWeb : «' + RTRIM( ISNULL( CAST (IdPessoaJuridicaWeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataAcesso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAcesso, 113 ),'Nulo'))+'» '
                         + '| HostAcesso : «' + RTRIM( ISNULL( CAST (HostAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRegional : «' + RTRIM( ISNULL( CAST (IdRegional AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoPessoa : «' + RTRIM( ISNULL( CAST (TipoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UsuarioWeb : «' + RTRIM( ISNULL( CAST (UsuarioWeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
