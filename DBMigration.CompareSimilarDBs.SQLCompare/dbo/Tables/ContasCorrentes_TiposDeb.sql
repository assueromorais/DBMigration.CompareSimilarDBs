CREATE TABLE [dbo].[ContasCorrentes_TiposDeb] (
    [IdContaCorrente]            INT NULL,
    [IdTipoDebito]               INT NOT NULL,
    [IdConvenio]                 INT NULL,
    [IdContasCorrentes_TiposDeb] INT IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [FK_ContasCorrentes_SituacoesDeb_Convenios] FOREIGN KEY ([IdConvenio]) REFERENCES [dbo].[Convenios] ([IdConvenio]),
    CONSTRAINT [FK_ContasCorrentes_TiposDeb_ContasCorrentes] FOREIGN KEY ([IdContaCorrente]) REFERENCES [dbo].[ContasCorrentes] ([IdContaCorrente]),
    CONSTRAINT [FK_ContasCorrentes_TiposDeb_Convenios] FOREIGN KEY ([IdConvenio]) REFERENCES [dbo].[Convenios] ([IdConvenio]),
    CONSTRAINT [FK_ContasCorrentes_TiposDeb_TiposDeb] FOREIGN KEY ([IdTipoDebito]) REFERENCES [dbo].[TiposDebito] ([IdTipoDebito])
);


GO
CREATE TRIGGER [TrgLog_ContasCorrentes_TiposDeb] ON [Implanta_CRPAM].[dbo].[ContasCorrentes_TiposDeb] 
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
SET @TableName = 'ContasCorrentes_TiposDeb'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContasCorrentes_TiposDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_TiposDeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContasCorrentes_TiposDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_TiposDeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContasCorrentes_TiposDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_TiposDeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDebito : «' + RTRIM( ISNULL( CAST (IdTipoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContasCorrentes_TiposDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_TiposDeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
