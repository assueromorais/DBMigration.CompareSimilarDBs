CREATE TABLE [dbo].[ColetaMensalCFA_Config] (
    [IdColetaMensalCFA_Config] INT           IDENTITY (1, 1) NOT NULL,
    [UltimaPlanilia]           VARCHAR (100) NULL,
    [Celula11a]                VARCHAR (10)  NULL,
    [Celula11i]                VARCHAR (10)  NULL,
    [Celula12a]                VARCHAR (10)  NULL,
    [Celula12i]                VARCHAR (10)  NULL,
    [Celula13a]                VARCHAR (10)  NULL,
    [Celula13i]                VARCHAR (10)  NULL,
    [Celula14a]                VARCHAR (10)  NULL,
    [Celula14i]                VARCHAR (10)  NULL,
    [Celula21a]                VARCHAR (10)  NULL,
    [Celula21i]                VARCHAR (10)  NULL,
    [Celula22a]                VARCHAR (10)  NULL,
    [Celula22i]                VARCHAR (10)  NULL,
    CONSTRAINT [PK_ColetaMensalCFA_Config] PRIMARY KEY CLUSTERED ([IdColetaMensalCFA_Config] ASC)
);


GO
CREATE TRIGGER [TrgLog_ColetaMensalCFA_Config] ON [Implanta_CRPAM].[dbo].[ColetaMensalCFA_Config] 
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
SET @TableName = 'ColetaMensalCFA_Config'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdColetaMensalCFA_Config : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Config AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaPlanilia : «' + RTRIM( ISNULL( CAST (UltimaPlanilia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula11a : «' + RTRIM( ISNULL( CAST (Celula11a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula11i : «' + RTRIM( ISNULL( CAST (Celula11i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula12a : «' + RTRIM( ISNULL( CAST (Celula12a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula12i : «' + RTRIM( ISNULL( CAST (Celula12i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula13a : «' + RTRIM( ISNULL( CAST (Celula13a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula13i : «' + RTRIM( ISNULL( CAST (Celula13i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula14a : «' + RTRIM( ISNULL( CAST (Celula14a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula14i : «' + RTRIM( ISNULL( CAST (Celula14i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula21a : «' + RTRIM( ISNULL( CAST (Celula21a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula21i : «' + RTRIM( ISNULL( CAST (Celula21i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula22a : «' + RTRIM( ISNULL( CAST (Celula22a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula22i : «' + RTRIM( ISNULL( CAST (Celula22i AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdColetaMensalCFA_Config : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Config AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaPlanilia : «' + RTRIM( ISNULL( CAST (UltimaPlanilia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula11a : «' + RTRIM( ISNULL( CAST (Celula11a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula11i : «' + RTRIM( ISNULL( CAST (Celula11i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula12a : «' + RTRIM( ISNULL( CAST (Celula12a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula12i : «' + RTRIM( ISNULL( CAST (Celula12i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula13a : «' + RTRIM( ISNULL( CAST (Celula13a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula13i : «' + RTRIM( ISNULL( CAST (Celula13i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula14a : «' + RTRIM( ISNULL( CAST (Celula14a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula14i : «' + RTRIM( ISNULL( CAST (Celula14i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula21a : «' + RTRIM( ISNULL( CAST (Celula21a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula21i : «' + RTRIM( ISNULL( CAST (Celula21i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula22a : «' + RTRIM( ISNULL( CAST (Celula22a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula22i : «' + RTRIM( ISNULL( CAST (Celula22i AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdColetaMensalCFA_Config : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Config AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaPlanilia : «' + RTRIM( ISNULL( CAST (UltimaPlanilia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula11a : «' + RTRIM( ISNULL( CAST (Celula11a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula11i : «' + RTRIM( ISNULL( CAST (Celula11i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula12a : «' + RTRIM( ISNULL( CAST (Celula12a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula12i : «' + RTRIM( ISNULL( CAST (Celula12i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula13a : «' + RTRIM( ISNULL( CAST (Celula13a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula13i : «' + RTRIM( ISNULL( CAST (Celula13i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula14a : «' + RTRIM( ISNULL( CAST (Celula14a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula14i : «' + RTRIM( ISNULL( CAST (Celula14i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula21a : «' + RTRIM( ISNULL( CAST (Celula21a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula21i : «' + RTRIM( ISNULL( CAST (Celula21i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula22a : «' + RTRIM( ISNULL( CAST (Celula22a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula22i : «' + RTRIM( ISNULL( CAST (Celula22i AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdColetaMensalCFA_Config : «' + RTRIM( ISNULL( CAST (IdColetaMensalCFA_Config AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| UltimaPlanilia : «' + RTRIM( ISNULL( CAST (UltimaPlanilia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula11a : «' + RTRIM( ISNULL( CAST (Celula11a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula11i : «' + RTRIM( ISNULL( CAST (Celula11i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula12a : «' + RTRIM( ISNULL( CAST (Celula12a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula12i : «' + RTRIM( ISNULL( CAST (Celula12i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula13a : «' + RTRIM( ISNULL( CAST (Celula13a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula13i : «' + RTRIM( ISNULL( CAST (Celula13i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula14a : «' + RTRIM( ISNULL( CAST (Celula14a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula14i : «' + RTRIM( ISNULL( CAST (Celula14i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula21a : «' + RTRIM( ISNULL( CAST (Celula21a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula21i : «' + RTRIM( ISNULL( CAST (Celula21i AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula22a : «' + RTRIM( ISNULL( CAST (Celula22a AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Celula22i : «' + RTRIM( ISNULL( CAST (Celula22i AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
