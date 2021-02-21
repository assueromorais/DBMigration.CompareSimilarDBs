CREATE TABLE [dbo].[OutrasDespesasHoteis] (
    [IdOutraDespesa]   INT          IDENTITY (1, 1) NOT NULL,
    [IdPessoa]         INT          NOT NULL,
    [DescricaoDespesa] VARCHAR (50) NOT NULL,
    [ValorDespesa]     MONEY        NULL,
    CONSTRAINT [PK_OutrasDespesasHoteis] PRIMARY KEY CLUSTERED ([IdOutraDespesa] ASC),
    CONSTRAINT [FK_OutrasDespesasHoteis_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);


GO
CREATE TRIGGER [TrgLog_OutrasDespesasHoteis] ON [Implanta_CRPAM].[dbo].[OutrasDespesasHoteis] 
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
SET @TableName = 'OutrasDespesasHoteis'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdOutraDespesa : «' + RTRIM( ISNULL( CAST (IdOutraDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoDespesa : «' + RTRIM( ISNULL( CAST (DescricaoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesa : «' + RTRIM( ISNULL( CAST (ValorDespesa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdOutraDespesa : «' + RTRIM( ISNULL( CAST (IdOutraDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoDespesa : «' + RTRIM( ISNULL( CAST (DescricaoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesa : «' + RTRIM( ISNULL( CAST (ValorDespesa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdOutraDespesa : «' + RTRIM( ISNULL( CAST (IdOutraDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoDespesa : «' + RTRIM( ISNULL( CAST (DescricaoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesa : «' + RTRIM( ISNULL( CAST (ValorDespesa AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdOutraDespesa : «' + RTRIM( ISNULL( CAST (IdOutraDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoDespesa : «' + RTRIM( ISNULL( CAST (DescricaoDespesa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorDespesa : «' + RTRIM( ISNULL( CAST (ValorDespesa AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
