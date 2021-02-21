CREATE TABLE [dbo].[ContasCorrentes_SituacoesDeb] (
    [IdContaCorrente]                INT NULL,
    [IdSituacaoDebito]               INT NOT NULL,
    [IdConvenio]                     INT NULL,
    [IdContasCorrentes_SituacoesDeb] INT IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [FK_ContasCorrentes_SituacoesDeb_ContasCorrentes] FOREIGN KEY ([IdContaCorrente]) REFERENCES [dbo].[ContasCorrentes] ([IdContaCorrente]),
    CONSTRAINT [FK_ContasCorrentes_SituacoesDeb_SituacoesDeb] FOREIGN KEY ([IdSituacaoDebito]) REFERENCES [dbo].[SituacoesDebito] ([IdSituacaoDebito])
);


GO
CREATE TRIGGER [TrgLog_ContasCorrentes_SituacoesDeb] ON [Implanta_CRPAM].[dbo].[ContasCorrentes_SituacoesDeb] 
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
SET @TableName = 'ContasCorrentes_SituacoesDeb'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContasCorrentes_SituacoesDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_SituacoesDeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContasCorrentes_SituacoesDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_SituacoesDeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
                         + '| IdSituacaoDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContasCorrentes_SituacoesDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_SituacoesDeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdSituacaoDebito : «' + RTRIM( ISNULL( CAST (IdSituacaoDebito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConvenio : «' + RTRIM( ISNULL( CAST (IdConvenio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContasCorrentes_SituacoesDeb : «' + RTRIM( ISNULL( CAST (IdContasCorrentes_SituacoesDeb AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
