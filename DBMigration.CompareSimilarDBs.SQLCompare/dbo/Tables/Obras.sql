CREATE TABLE [dbo].[Obras] (
    [IdObra]        INT            IDENTITY (1, 1) NOT NULL,
    [Exercicio]     VARCHAR (4)    NOT NULL,
    [IdConta]       INT            NOT NULL,
    [CodConta]      VARCHAR (18)   NULL,
    [IdPessoa]      INT            NULL,
    [IdEmpenho]     INT            NULL,
    [TipoObra]      VARCHAR (100)  NULL,
    [CEI]           VARCHAR (12)   NULL,
    [DescricaoObra] VARCHAR (3000) NULL
);


GO
CREATE TRIGGER [TrgLog_Obras] ON [Implanta_CRPAM].[dbo].[Obras] 
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
SET @TableName = 'Obras'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdObra : «' + RTRIM( ISNULL( CAST (IdObra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConta : «' + RTRIM( ISNULL( CAST (CodConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoObra : «' + RTRIM( ISNULL( CAST (TipoObra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEI : «' + RTRIM( ISNULL( CAST (CEI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoObra : «' + RTRIM( ISNULL( CAST (DescricaoObra AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdObra : «' + RTRIM( ISNULL( CAST (IdObra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConta : «' + RTRIM( ISNULL( CAST (CodConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoObra : «' + RTRIM( ISNULL( CAST (TipoObra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEI : «' + RTRIM( ISNULL( CAST (CEI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoObra : «' + RTRIM( ISNULL( CAST (DescricaoObra AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdObra : «' + RTRIM( ISNULL( CAST (IdObra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConta : «' + RTRIM( ISNULL( CAST (CodConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoObra : «' + RTRIM( ISNULL( CAST (TipoObra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEI : «' + RTRIM( ISNULL( CAST (CEI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoObra : «' + RTRIM( ISNULL( CAST (DescricaoObra AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdObra : «' + RTRIM( ISNULL( CAST (IdObra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodConta : «' + RTRIM( ISNULL( CAST (CodConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoObra : «' + RTRIM( ISNULL( CAST (TipoObra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CEI : «' + RTRIM( ISNULL( CAST (CEI AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DescricaoObra : «' + RTRIM( ISNULL( CAST (DescricaoObra AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
