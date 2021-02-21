CREATE TABLE [dbo].[Medidas] (
    [IdMedida]           INT          IDENTITY (1, 1) NOT NULL,
    [NomeMedida]         VARCHAR (60) NOT NULL,
    [FatorConversao]     REAL         NULL,
    [IdMedidaConvertida] INT          NULL,
    CONSTRAINT [PK_Medidas] PRIMARY KEY NONCLUSTERED ([IdMedida] ASC),
    CONSTRAINT [FK_Medidas_Medidas] FOREIGN KEY ([IdMedidaConvertida]) REFERENCES [dbo].[Medidas] ([IdMedida]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_Medidas] ON [Implanta_CRPAM].[dbo].[Medidas] 
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
SET @TableName = 'Medidas'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdMedida : «' + RTRIM( ISNULL( CAST (IdMedida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeMedida : «' + RTRIM( ISNULL( CAST (NomeMedida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatorConversao : «' + RTRIM( ISNULL( CAST (FatorConversao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaConvertida : «' + RTRIM( ISNULL( CAST (IdMedidaConvertida AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdMedida : «' + RTRIM( ISNULL( CAST (IdMedida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeMedida : «' + RTRIM( ISNULL( CAST (NomeMedida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatorConversao : «' + RTRIM( ISNULL( CAST (FatorConversao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaConvertida : «' + RTRIM( ISNULL( CAST (IdMedidaConvertida AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdMedida : «' + RTRIM( ISNULL( CAST (IdMedida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeMedida : «' + RTRIM( ISNULL( CAST (NomeMedida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatorConversao : «' + RTRIM( ISNULL( CAST (FatorConversao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaConvertida : «' + RTRIM( ISNULL( CAST (IdMedidaConvertida AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdMedida : «' + RTRIM( ISNULL( CAST (IdMedida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeMedida : «' + RTRIM( ISNULL( CAST (NomeMedida AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FatorConversao : «' + RTRIM( ISNULL( CAST (FatorConversao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdMedidaConvertida : «' + RTRIM( ISNULL( CAST (IdMedidaConvertida AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
