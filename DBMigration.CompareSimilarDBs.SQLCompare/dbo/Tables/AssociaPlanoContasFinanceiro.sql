CREATE TABLE [dbo].[AssociaPlanoContasFinanceiro] (
    [IdContaFinanceiraPai]   INT NOT NULL,
    [IdContaFinanceiraFilha] INT NOT NULL,
    CONSTRAINT [PK_AssociaPlanoContasFinanceiro] PRIMARY KEY CLUSTERED ([IdContaFinanceiraPai] ASC, [IdContaFinanceiraFilha] ASC),
    CONSTRAINT [FK_AssociaPlanoContasFinanceiro_PlanoContasFinanceiro] FOREIGN KEY ([IdContaFinanceiraPai]) REFERENCES [dbo].[PlanoContasFinanceiro] ([IdContaFinanceira]) NOT FOR REPLICATION,
    CONSTRAINT [FK_AssociaPlanoContasFinanceiro_PlanoContasFinanceiro1] FOREIGN KEY ([IdContaFinanceiraFilha]) REFERENCES [dbo].[PlanoContasFinanceiro] ([IdContaFinanceira]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_AssociaPlanoContasFinanceiro] ON [Implanta_CRPAM].[dbo].[AssociaPlanoContasFinanceiro] 
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
SET @TableName = 'AssociaPlanoContasFinanceiro'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdContaFinanceiraPai : «' + RTRIM( ISNULL( CAST (IdContaFinanceiraPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaFinanceiraFilha : «' + RTRIM( ISNULL( CAST (IdContaFinanceiraFilha AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdContaFinanceiraPai : «' + RTRIM( ISNULL( CAST (IdContaFinanceiraPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaFinanceiraFilha : «' + RTRIM( ISNULL( CAST (IdContaFinanceiraFilha AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdContaFinanceiraPai : «' + RTRIM( ISNULL( CAST (IdContaFinanceiraPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaFinanceiraFilha : «' + RTRIM( ISNULL( CAST (IdContaFinanceiraFilha AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdContaFinanceiraPai : «' + RTRIM( ISNULL( CAST (IdContaFinanceiraPai AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaFinanceiraFilha : «' + RTRIM( ISNULL( CAST (IdContaFinanceiraFilha AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
