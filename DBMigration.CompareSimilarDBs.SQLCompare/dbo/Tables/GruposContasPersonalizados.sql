CREATE TABLE [dbo].[GruposContasPersonalizados] (
    [IdGrupoContaPersonalizado] INT          IDENTITY (1, 1) NOT NULL,
    [NomePersonalizado]         VARCHAR (60) NULL,
    [IdConta]                   INT          NULL,
    CONSTRAINT [PK_GruposContasPersonalizados] PRIMARY KEY CLUSTERED ([IdGrupoContaPersonalizado] ASC),
    CONSTRAINT [FK_GruposContasPersonalizados_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
CREATE TRIGGER [TrgLog_GruposContasPersonalizados] ON [Implanta_CRPAM].[dbo].[GruposContasPersonalizados] 
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
SET @TableName = 'GruposContasPersonalizados'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdGrupoContaPersonalizado : «' + RTRIM( ISNULL( CAST (IdGrupoContaPersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePersonalizado : «' + RTRIM( ISNULL( CAST (NomePersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdGrupoContaPersonalizado : «' + RTRIM( ISNULL( CAST (IdGrupoContaPersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePersonalizado : «' + RTRIM( ISNULL( CAST (NomePersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdGrupoContaPersonalizado : «' + RTRIM( ISNULL( CAST (IdGrupoContaPersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePersonalizado : «' + RTRIM( ISNULL( CAST (NomePersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdGrupoContaPersonalizado : «' + RTRIM( ISNULL( CAST (IdGrupoContaPersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomePersonalizado : «' + RTRIM( ISNULL( CAST (NomePersonalizado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
