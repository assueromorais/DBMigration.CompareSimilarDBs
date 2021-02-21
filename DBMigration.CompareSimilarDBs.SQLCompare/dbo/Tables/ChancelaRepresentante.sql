CREATE TABLE [dbo].[ChancelaRepresentante] (
    [IdChancelaRepresentante] INT IDENTITY (1, 1) NOT NULL,
    [IdChancelaRepresentado]  INT NOT NULL,
    [IdPessoa]                INT NOT NULL,
    CONSTRAINT [PK_ChancelaRepresentante] PRIMARY KEY CLUSTERED ([IdChancelaRepresentante] ASC),
    CONSTRAINT [FK_ChancelaRepresentante_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa]),
    CONSTRAINT [FK_ChancelaRepresentante_Representado] FOREIGN KEY ([IdChancelaRepresentado]) REFERENCES [dbo].[ChancelaRepresentado] ([IdChancelaRepresentado])
);


GO
CREATE TRIGGER [TrgLog_ChancelaRepresentante] ON [Implanta_CRPAM].[dbo].[ChancelaRepresentante] 
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
SET @TableName = 'ChancelaRepresentante'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdChancelaRepresentante : «' + RTRIM( ISNULL( CAST (IdChancelaRepresentante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdChancelaRepresentado : «' + RTRIM( ISNULL( CAST (IdChancelaRepresentado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdChancelaRepresentante : «' + RTRIM( ISNULL( CAST (IdChancelaRepresentante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdChancelaRepresentado : «' + RTRIM( ISNULL( CAST (IdChancelaRepresentado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdChancelaRepresentante : «' + RTRIM( ISNULL( CAST (IdChancelaRepresentante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdChancelaRepresentado : «' + RTRIM( ISNULL( CAST (IdChancelaRepresentado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdChancelaRepresentante : «' + RTRIM( ISNULL( CAST (IdChancelaRepresentante AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdChancelaRepresentado : «' + RTRIM( ISNULL( CAST (IdChancelaRepresentado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
