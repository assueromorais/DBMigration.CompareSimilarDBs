CREATE TABLE [dbo].[GruposItens] (
    [IdGrupoItem]                          INT              IDENTITY (1, 1) NOT NULL,
    [NomeGrupoItem]                        VARCHAR (60)     NOT NULL,
    [PrefixoItem]                          VARCHAR (20)     NULL,
    [SufixoItem]                           VARCHAR (20)     NULL,
    [IncrementoItem]                       INT              NULL,
    [IdPlanoContaMCASP]                    UNIQUEIDENTIFIER NULL,
    [IdPlanoContaMCASPEntradaAlmoxarifado] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_GruposItens] PRIMARY KEY NONCLUSTERED ([IdGrupoItem] ASC)
);


GO
CREATE TRIGGER [TrgLog_GruposItens] ON [Implanta_CRPAM].[dbo].[GruposItens] 
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
SET @TableName = 'GruposItens'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdGrupoItem : «' + RTRIM( ISNULL( CAST (IdGrupoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeGrupoItem : «' + RTRIM( ISNULL( CAST (NomeGrupoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoItem : «' + RTRIM( ISNULL( CAST (PrefixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoItem : «' + RTRIM( ISNULL( CAST (SufixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoItem : «' + RTRIM( ISNULL( CAST (IncrementoItem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdGrupoItem : «' + RTRIM( ISNULL( CAST (IdGrupoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeGrupoItem : «' + RTRIM( ISNULL( CAST (NomeGrupoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoItem : «' + RTRIM( ISNULL( CAST (PrefixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoItem : «' + RTRIM( ISNULL( CAST (SufixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoItem : «' + RTRIM( ISNULL( CAST (IncrementoItem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdGrupoItem : «' + RTRIM( ISNULL( CAST (IdGrupoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeGrupoItem : «' + RTRIM( ISNULL( CAST (NomeGrupoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoItem : «' + RTRIM( ISNULL( CAST (PrefixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoItem : «' + RTRIM( ISNULL( CAST (SufixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoItem : «' + RTRIM( ISNULL( CAST (IncrementoItem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdGrupoItem : «' + RTRIM( ISNULL( CAST (IdGrupoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeGrupoItem : «' + RTRIM( ISNULL( CAST (NomeGrupoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| PrefixoItem : «' + RTRIM( ISNULL( CAST (PrefixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| SufixoItem : «' + RTRIM( ISNULL( CAST (SufixoItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IncrementoItem : «' + RTRIM( ISNULL( CAST (IncrementoItem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
