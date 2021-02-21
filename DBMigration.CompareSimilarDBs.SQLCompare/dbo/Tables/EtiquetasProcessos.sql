CREATE TABLE [dbo].[EtiquetasProcessos] (
    [IdEtiquetaProcesso] INT           IDENTITY (1, 1) NOT NULL,
    [Descricao]          VARCHAR (150) NULL,
    [Modelo]             IMAGE         NULL,
    [IdTipoProcesso]     INT           NULL,
    CONSTRAINT [PK_EtiquetasProcessos] PRIMARY KEY CLUSTERED ([IdEtiquetaProcesso] ASC),
    CONSTRAINT [FK_EtiquetasProcessos_TipoProcesso] FOREIGN KEY ([IdTipoProcesso]) REFERENCES [dbo].[TipoProcesso] ([IdTipoProcesso])
);


GO
CREATE TRIGGER [TrgLog_EtiquetasProcessos] ON [Implanta_CRPAM].[dbo].[EtiquetasProcessos] 
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
SET @TableName = 'EtiquetasProcessos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEtiquetaProcesso : «' + RTRIM( ISNULL( CAST (IdEtiquetaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEtiquetaProcesso : «' + RTRIM( ISNULL( CAST (IdEtiquetaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEtiquetaProcesso : «' + RTRIM( ISNULL( CAST (IdEtiquetaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEtiquetaProcesso : «' + RTRIM( ISNULL( CAST (IdEtiquetaProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoProcesso : «' + RTRIM( ISNULL( CAST (IdTipoProcesso AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
