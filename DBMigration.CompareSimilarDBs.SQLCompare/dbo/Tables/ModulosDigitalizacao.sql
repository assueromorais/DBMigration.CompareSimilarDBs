CREATE TABLE [dbo].[ModulosDigitalizacao] (
    [IdModuloDigitalizacao] INT          NOT NULL,
    [Modulo]                VARCHAR (30) NOT NULL,
    [Descricao]             VARCHAR (30) NULL,
    CONSTRAINT [PK_ModulosDigitalizacao] PRIMARY KEY CLUSTERED ([IdModuloDigitalizacao] ASC),
    CONSTRAINT [UN_ModulosDigitalizacao_MOdulo] UNIQUE NONCLUSTERED ([Modulo] ASC)
);


GO
CREATE TRIGGER [TrgLog_ModulosDigitalizacao] ON [Implanta_CRPAM].[dbo].[ModulosDigitalizacao] 
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
SET @TableName = 'ModulosDigitalizacao'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdModuloDigitalizacao : «' + RTRIM( ISNULL( CAST (IdModuloDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modulo : «' + RTRIM( ISNULL( CAST (Modulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdModuloDigitalizacao : «' + RTRIM( ISNULL( CAST (IdModuloDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modulo : «' + RTRIM( ISNULL( CAST (Modulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdModuloDigitalizacao : «' + RTRIM( ISNULL( CAST (IdModuloDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modulo : «' + RTRIM( ISNULL( CAST (Modulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdModuloDigitalizacao : «' + RTRIM( ISNULL( CAST (IdModuloDigitalizacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Modulo : «' + RTRIM( ISNULL( CAST (Modulo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
