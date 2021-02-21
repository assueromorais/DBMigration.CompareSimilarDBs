CREATE TABLE [dbo].[CriteriosManual] (
    [IdReferencia] INT NOT NULL,
    [IdCriterios]  INT NOT NULL,
    CONSTRAINT [PK_CriteriosManual] PRIMARY KEY CLUSTERED ([IdReferencia] ASC, [IdCriterios] ASC),
    CONSTRAINT [FK_Criterios] FOREIGN KEY ([IdCriterios]) REFERENCES [dbo].[Criterios] ([IdCriterios])
);


GO
CREATE TRIGGER [TrgLog_CriteriosManual] ON [Implanta_CRPAM].[dbo].[CriteriosManual] 
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
SET @TableName = 'CriteriosManual'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdReferencia : «' + RTRIM( ISNULL( CAST (IdReferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCriterios : «' + RTRIM( ISNULL( CAST (IdCriterios AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdReferencia : «' + RTRIM( ISNULL( CAST (IdReferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCriterios : «' + RTRIM( ISNULL( CAST (IdCriterios AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdReferencia : «' + RTRIM( ISNULL( CAST (IdReferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCriterios : «' + RTRIM( ISNULL( CAST (IdCriterios AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdReferencia : «' + RTRIM( ISNULL( CAST (IdReferencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCriterios : «' + RTRIM( ISNULL( CAST (IdCriterios AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
