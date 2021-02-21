CREATE TABLE [dbo].[GruposPessoas] (
    [IdGrupoPessoa] INT           IDENTITY (1, 1) NOT NULL,
    [NomeGrupo]     VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_GruposPessoas] PRIMARY KEY CLUSTERED ([IdGrupoPessoa] ASC)
);


GO
CREATE TRIGGER [TrgLog_GruposPessoas] ON [Implanta_CRPAM].[dbo].[GruposPessoas] 
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
SET @TableName = 'GruposPessoas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdGrupoPessoa : «' + RTRIM( ISNULL( CAST (IdGrupoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeGrupo : «' + RTRIM( ISNULL( CAST (NomeGrupo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdGrupoPessoa : «' + RTRIM( ISNULL( CAST (IdGrupoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeGrupo : «' + RTRIM( ISNULL( CAST (NomeGrupo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdGrupoPessoa : «' + RTRIM( ISNULL( CAST (IdGrupoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeGrupo : «' + RTRIM( ISNULL( CAST (NomeGrupo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdGrupoPessoa : «' + RTRIM( ISNULL( CAST (IdGrupoPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeGrupo : «' + RTRIM( ISNULL( CAST (NomeGrupo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
