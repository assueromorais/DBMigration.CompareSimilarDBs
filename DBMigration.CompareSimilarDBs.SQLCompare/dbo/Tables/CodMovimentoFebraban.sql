CREATE TABLE [dbo].[CodMovimentoFebraban] (
    [IdCodMovimento] INT           IDENTITY (1, 1) NOT NULL,
    [Codigo]         CHAR (2)      NOT NULL,
    [Descricao]      VARCHAR (150) NOT NULL,
    [CodAssociado]   CHAR (1)      NULL,
    [CodigoBanco]    CHAR (3)      NOT NULL,
    CONSTRAINT [PK_IdCodMovimento] PRIMARY KEY CLUSTERED ([IdCodMovimento] ASC),
    CONSTRAINT [AK_Codigo] UNIQUE NONCLUSTERED ([Codigo] ASC, [CodigoBanco] ASC)
);


GO
CREATE TRIGGER [TrgLog_CodMovimentoFebraban] ON [Implanta_CRPAM].[dbo].[CodMovimentoFebraban] 
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
SET @TableName = 'CodMovimentoFebraban'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCodMovimento : «' + RTRIM( ISNULL( CAST (IdCodMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAssociado : «' + RTRIM( ISNULL( CAST (CodAssociado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdCodMovimento : «' + RTRIM( ISNULL( CAST (IdCodMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAssociado : «' + RTRIM( ISNULL( CAST (CodAssociado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdCodMovimento : «' + RTRIM( ISNULL( CAST (IdCodMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAssociado : «' + RTRIM( ISNULL( CAST (CodAssociado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCodMovimento : «' + RTRIM( ISNULL( CAST (IdCodMovimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Codigo : «' + RTRIM( ISNULL( CAST (Codigo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Descricao : «' + RTRIM( ISNULL( CAST (Descricao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodAssociado : «' + RTRIM( ISNULL( CAST (CodAssociado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodigoBanco : «' + RTRIM( ISNULL( CAST (CodigoBanco AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
