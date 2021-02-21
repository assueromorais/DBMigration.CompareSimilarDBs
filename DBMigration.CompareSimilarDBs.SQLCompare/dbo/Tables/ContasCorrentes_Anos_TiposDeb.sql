CREATE TABLE [dbo].[ContasCorrentes_Anos_TiposDeb] (
    [IdContasCorrentes_Anos_TiposDeb] INT         IDENTITY (1, 1) NOT NULL,
    [IdContasCorrentes_TiposDeb]      INT         NOT NULL,
    [AnoReferencia]                   VARCHAR (4) NOT NULL,
    CONSTRAINT [PK_ContasCorrentes_Anos_TiposDeb] PRIMARY KEY CLUSTERED ([IdContasCorrentes_Anos_TiposDeb] ASC)
);


GO
CREATE TRIGGER [TrgLog_ContasCorrentes_Anos_TiposDeb] ON [Implanta_CRPAM].[dbo].[ContasCorrentes_Anos_TiposDeb] 
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
SET @TableName = 'ContasCorrentes_Anos_TiposDeb'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdContasCorrentes_Anos_TiposDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_Anos_TiposDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContasCorrentes_TiposDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_TiposDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoReferencia : «' + RTRIM( ISNULL( CAST (AnoReferencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdContasCorrentes_Anos_TiposDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_Anos_TiposDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContasCorrentes_TiposDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_TiposDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoReferencia : «' + RTRIM( ISNULL( CAST (AnoReferencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdContasCorrentes_Anos_TiposDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_Anos_TiposDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContasCorrentes_TiposDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_TiposDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoReferencia : «' + RTRIM( ISNULL( CAST (AnoReferencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdContasCorrentes_Anos_TiposDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_Anos_TiposDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContasCorrentes_TiposDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_TiposDeb AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoReferencia : «' + RTRIM( ISNULL( CAST (AnoReferencia AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
