CREATE TABLE [dbo].[EstadosMunicipiosDES] (
    [IdEstadoMunicipio] INT           IDENTITY (1, 1) NOT NULL,
    [Estado]            CHAR (2)      NULL,
    [Municipio]         VARCHAR (100) NULL,
    CONSTRAINT [PK_EstadosMunicipiosDES] PRIMARY KEY CLUSTERED ([IdEstadoMunicipio] ASC)
);


GO
CREATE TRIGGER [TrgLog_EstadosMunicipiosDES] ON [Implanta_CRPAM].[dbo].[EstadosMunicipiosDES] 
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
SET @TableName = 'EstadosMunicipiosDES'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEstadoMunicipio : «' + RTRIM( ISNULL( CAST (IdEstadoMunicipio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Estado : «' + RTRIM( ISNULL( CAST (Estado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Municipio : «' + RTRIM( ISNULL( CAST (Municipio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEstadoMunicipio : «' + RTRIM( ISNULL( CAST (IdEstadoMunicipio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Estado : «' + RTRIM( ISNULL( CAST (Estado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Municipio : «' + RTRIM( ISNULL( CAST (Municipio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEstadoMunicipio : «' + RTRIM( ISNULL( CAST (IdEstadoMunicipio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Estado : «' + RTRIM( ISNULL( CAST (Estado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Municipio : «' + RTRIM( ISNULL( CAST (Municipio AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEstadoMunicipio : «' + RTRIM( ISNULL( CAST (IdEstadoMunicipio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Estado : «' + RTRIM( ISNULL( CAST (Estado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Municipio : «' + RTRIM( ISNULL( CAST (Municipio AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
