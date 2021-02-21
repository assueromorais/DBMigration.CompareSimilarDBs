CREATE TABLE [dbo].[GrupoContaRelatorioGerencial] (
    [IdRelatorioGerencial]      INT NOT NULL,
    [IdGrupoContaPersonalizado] INT NOT NULL,
    [Ordem]                     INT NULL,
    CONSTRAINT [PK_GrupoContaRelatorioGerencial] PRIMARY KEY CLUSTERED ([IdRelatorioGerencial] ASC, [IdGrupoContaPersonalizado] ASC),
    CONSTRAINT [FK_GrupoContaRelatorioGerencial_GruposContasPersonalizados] FOREIGN KEY ([IdGrupoContaPersonalizado]) REFERENCES [dbo].[GruposContasPersonalizados] ([IdGrupoContaPersonalizado]),
    CONSTRAINT [FK_GrupoContaRelatorioGerencial_RelatoriosGerenciais] FOREIGN KEY ([IdRelatorioGerencial]) REFERENCES [dbo].[RelatoriosGerenciais] ([IdRelatorioGerencial])
);


GO
CREATE TRIGGER [TrgLog_GrupoContaRelatorioGerencial] ON [Implanta_CRPAM].[dbo].[GrupoContaRelatorioGerencial] 
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
SET @TableName = 'GrupoContaRelatorioGerencial'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdRelatorioGerencial : «' + RTRIM( ISNULL( CAST (IdRelatorioGerencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoContaPersonalizado : «' + RTRIM( ISNULL( CAST (IdGrupoContaPersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdRelatorioGerencial : «' + RTRIM( ISNULL( CAST (IdRelatorioGerencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoContaPersonalizado : «' + RTRIM( ISNULL( CAST (IdGrupoContaPersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdRelatorioGerencial : «' + RTRIM( ISNULL( CAST (IdRelatorioGerencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoContaPersonalizado : «' + RTRIM( ISNULL( CAST (IdGrupoContaPersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdRelatorioGerencial : «' + RTRIM( ISNULL( CAST (IdRelatorioGerencial AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdGrupoContaPersonalizado : «' + RTRIM( ISNULL( CAST (IdGrupoContaPersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Ordem : «' + RTRIM( ISNULL( CAST (Ordem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
