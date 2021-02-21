CREATE TABLE [dbo].[Acessos] (
    [IdSistema]           INT            NOT NULL,
    [IdUsuario]           INT            NOT NULL,
    [IdPessoa]            INT            NULL,
    [CodigoAcesso]        VARCHAR (1000) NULL,
    [DataValidadeAcesso]  DATETIME       NULL,
    [UltimaVersao]        VARCHAR (20)   NULL,
    [CodigosCentroCustos] TEXT           NULL,
    [IdCentroCusto]       INT            NULL,
    [CodigoAcessoAntigo]  VARCHAR (400)  NULL,
    CONSTRAINT [FK_Acesso_Sistemas] FOREIGN KEY ([IdSistema]) REFERENCES [dbo].[Sistemas] ([IdSistema]),
    CONSTRAINT [FK_Acesso_Usuarios] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([IdUsuario]),
    CONSTRAINT [FK_Acessos_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]),
    CONSTRAINT [FK_Acessos_Pessoas_Conselhos] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]) NOT FOR REPLICATION
);


GO
CREATE NONCLUSTERED INDEX [IX_Acessos_IdCentroCusto]
    ON [dbo].[Acessos]([IdCentroCusto] ASC);


GO
CREATE TRIGGER [TrgLog_Acessos] ON [Implanta_CRPAM].[dbo].[Acessos] 
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
SET @TableName = 'Acessos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAcesso : «' + RTRIM( ISNULL( CAST (CodigoAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataValidadeAcesso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidadeAcesso, 113 ),'Nulo'))+'» '
                         + '| UltimaVersao : «' + RTRIM( ISNULL( CAST (UltimaVersao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAcessoAntigo : «' + RTRIM( ISNULL( CAST (CodigoAcessoAntigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAcesso : «' + RTRIM( ISNULL( CAST (CodigoAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataValidadeAcesso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidadeAcesso, 113 ),'Nulo'))+'» '
                         + '| UltimaVersao : «' + RTRIM( ISNULL( CAST (UltimaVersao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAcessoAntigo : «' + RTRIM( ISNULL( CAST (CodigoAcessoAntigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAcesso : «' + RTRIM( ISNULL( CAST (CodigoAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataValidadeAcesso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidadeAcesso, 113 ),'Nulo'))+'» '
                         + '| UltimaVersao : «' + RTRIM( ISNULL( CAST (UltimaVersao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAcessoAntigo : «' + RTRIM( ISNULL( CAST (CodigoAcessoAntigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdSistema : «' + RTRIM( ISNULL( CAST (IdSistema AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAcesso : «' + RTRIM( ISNULL( CAST (CodigoAcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataValidadeAcesso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataValidadeAcesso, 113 ),'Nulo'))+'» '
                         + '| UltimaVersao : «' + RTRIM( ISNULL( CAST (UltimaVersao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoAcessoAntigo : «' + RTRIM( ISNULL( CAST (CodigoAcessoAntigo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
