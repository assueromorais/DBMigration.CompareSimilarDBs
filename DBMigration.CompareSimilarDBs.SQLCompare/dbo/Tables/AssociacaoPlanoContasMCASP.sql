CREATE TABLE [dbo].[AssociacaoPlanoContasMCASP] (
    [IdConta]                     INT              NULL,
    [IdPlanoContaMCASP]           UNIQUEIDENTIFIER NOT NULL,
    [CodContaMCASP]               VARCHAR (50)     NOT NULL,
    [NomeContaMCASP]              VARCHAR (100)    NOT NULL,
    [IdAssociacaoPlanoContaMCASP] INT              IDENTITY (1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([IdAssociacaoPlanoContaMCASP] ASC),
    CONSTRAINT [FK_AssociacaoPlanoContasMCASP_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
CREATE TRIGGER [TrgLog_AssociacaoPlanoContasMCASP] ON [Implanta_CRPAM].[dbo].[AssociacaoPlanoContasMCASP] 
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
SET @TableName = 'AssociacaoPlanoContasMCASP'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASP : «' + RTRIM( ISNULL( CAST (CodContaMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASP : «' + RTRIM( ISNULL( CAST (NomeContaMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssociacaoPlanoContaMCASP : «' + RTRIM( ISNULL( CAST (IdAssociacaoPlanoContaMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASP : «' + RTRIM( ISNULL( CAST (CodContaMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASP : «' + RTRIM( ISNULL( CAST (NomeContaMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssociacaoPlanoContaMCASP : «' + RTRIM( ISNULL( CAST (IdAssociacaoPlanoContaMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASP : «' + RTRIM( ISNULL( CAST (CodContaMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASP : «' + RTRIM( ISNULL( CAST (NomeContaMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssociacaoPlanoContaMCASP : «' + RTRIM( ISNULL( CAST (IdAssociacaoPlanoContaMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodContaMCASP : «' + RTRIM( ISNULL( CAST (CodContaMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeContaMCASP : «' + RTRIM( ISNULL( CAST (NomeContaMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdAssociacaoPlanoContaMCASP : «' + RTRIM( ISNULL( CAST (IdAssociacaoPlanoContaMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
