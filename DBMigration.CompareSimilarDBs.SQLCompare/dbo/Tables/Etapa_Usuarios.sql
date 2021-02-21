CREATE TABLE [dbo].[Etapa_Usuarios] (
    [IdEtapaUsuarios] INT IDENTITY (1, 1) NOT NULL,
    [IdUsuario]       INT NOT NULL,
    [IdEtapa]         INT NOT NULL,
    CONSTRAINT [PK_Etapa_Usuarios] PRIMARY KEY CLUSTERED ([IdEtapaUsuarios] ASC, [IdUsuario] ASC, [IdEtapa] ASC),
    CONSTRAINT [FK_Etapa_Usuarios_Etapas] FOREIGN KEY ([IdEtapa]) REFERENCES [dbo].[Etapas] ([IdEtapa]),
    CONSTRAINT [FK_Etapa_Usuarios_Usuarios] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([IdUsuario])
);


GO
CREATE TRIGGER [TrgLog_Etapa_Usuarios] ON [Implanta_CRPAM].[dbo].[Etapa_Usuarios] 
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
SET @TableName = 'Etapa_Usuarios'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEtapaUsuarios : «' + RTRIM( ISNULL( CAST (IdEtapaUsuarios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtapa : «' + RTRIM( ISNULL( CAST (IdEtapa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEtapaUsuarios : «' + RTRIM( ISNULL( CAST (IdEtapaUsuarios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtapa : «' + RTRIM( ISNULL( CAST (IdEtapa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEtapaUsuarios : «' + RTRIM( ISNULL( CAST (IdEtapaUsuarios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtapa : «' + RTRIM( ISNULL( CAST (IdEtapa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEtapaUsuarios : «' + RTRIM( ISNULL( CAST (IdEtapaUsuarios AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEtapa : «' + RTRIM( ISNULL( CAST (IdEtapa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
