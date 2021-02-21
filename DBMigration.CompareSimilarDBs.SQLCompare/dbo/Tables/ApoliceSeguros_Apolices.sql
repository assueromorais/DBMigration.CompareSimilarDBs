CREATE TABLE [dbo].[ApoliceSeguros_Apolices] (
    [IdApoliceSeguroApolices] INT          IDENTITY (1, 1) NOT NULL,
    [NumeroApolice]           VARCHAR (30) NULL,
    [IdApoliceSeguro]         INT          NULL,
    PRIMARY KEY CLUSTERED ([IdApoliceSeguroApolices] ASC),
    CONSTRAINT [FK_ApoliceSeguroApolices_IdApoliceSeguro] FOREIGN KEY ([IdApoliceSeguro]) REFERENCES [dbo].[ApoliceSeguros] ([IdApoliceSeguro])
);


GO
CREATE TRIGGER [TrgLog_ApoliceSeguros_Apolices] ON [Implanta_CRPAM].[dbo].[ApoliceSeguros_Apolices] 
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
SET @TableName = 'ApoliceSeguros_Apolices'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdApoliceSeguroApolices : «' + RTRIM( ISNULL( CAST (IdApoliceSeguroApolices AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroApolice : «' + RTRIM( ISNULL( CAST (NumeroApolice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdApoliceSeguro : «' + RTRIM( ISNULL( CAST (IdApoliceSeguro AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdApoliceSeguroApolices : «' + RTRIM( ISNULL( CAST (IdApoliceSeguroApolices AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroApolice : «' + RTRIM( ISNULL( CAST (NumeroApolice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdApoliceSeguro : «' + RTRIM( ISNULL( CAST (IdApoliceSeguro AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdApoliceSeguroApolices : «' + RTRIM( ISNULL( CAST (IdApoliceSeguroApolices AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroApolice : «' + RTRIM( ISNULL( CAST (NumeroApolice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdApoliceSeguro : «' + RTRIM( ISNULL( CAST (IdApoliceSeguro AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdApoliceSeguroApolices : «' + RTRIM( ISNULL( CAST (IdApoliceSeguroApolices AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroApolice : «' + RTRIM( ISNULL( CAST (NumeroApolice AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdApoliceSeguro : «' + RTRIM( ISNULL( CAST (IdApoliceSeguro AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
