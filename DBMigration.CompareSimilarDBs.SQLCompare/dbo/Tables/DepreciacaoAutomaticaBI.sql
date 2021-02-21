CREATE TABLE [dbo].[DepreciacaoAutomaticaBI] (
    [IdDepreciacaoAutomatica] INT              IDENTITY (1, 1) NOT NULL,
    [Data]                    DATETIME         NOT NULL,
    [IdUsuario]               INT              NULL,
    [TotalItens]              INT              NULL,
    [IdsItensDepreciados]     TEXT             NULL,
    [IdsReavaliacoes]         TEXT             NULL,
    [IdLancamento]            UNIQUEIDENTIFIER NULL,
    [Exercicio]               INT              NULL,
    [IdTipoBem]               INT              NULL,
    CONSTRAINT [PK_DepreAutomaticaBIIdDepAuto] PRIMARY KEY CLUSTERED ([IdDepreciacaoAutomatica] ASC),
    CONSTRAINT [FK_DepreciacaoAutomaticaBI_TiposBens] FOREIGN KEY ([IdTipoBem]) REFERENCES [dbo].[TiposBens] ([IdTipo])
);


GO
CREATE TRIGGER [TrgLog_DepreciacaoAutomaticaBI] ON [Implanta_CRPAM].[dbo].[DepreciacaoAutomaticaBI] 
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
SET @TableName = 'DepreciacaoAutomaticaBI'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDepreciacaoAutomatica : «' + RTRIM( ISNULL( CAST (IdDepreciacaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalItens : «' + RTRIM( ISNULL( CAST (TotalItens AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoBem : «' + RTRIM( ISNULL( CAST (IdTipoBem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDepreciacaoAutomatica : «' + RTRIM( ISNULL( CAST (IdDepreciacaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalItens : «' + RTRIM( ISNULL( CAST (TotalItens AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoBem : «' + RTRIM( ISNULL( CAST (IdTipoBem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDepreciacaoAutomatica : «' + RTRIM( ISNULL( CAST (IdDepreciacaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalItens : «' + RTRIM( ISNULL( CAST (TotalItens AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoBem : «' + RTRIM( ISNULL( CAST (IdTipoBem AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDepreciacaoAutomatica : «' + RTRIM( ISNULL( CAST (IdDepreciacaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Data : «' + RTRIM( ISNULL( CONVERT (CHAR, Data, 113 ),'Nulo'))+'» '
                         + '| IdUsuario : «' + RTRIM( ISNULL( CAST (IdUsuario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TotalItens : «' + RTRIM( ISNULL( CAST (TotalItens AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoBem : «' + RTRIM( ISNULL( CAST (IdTipoBem AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
