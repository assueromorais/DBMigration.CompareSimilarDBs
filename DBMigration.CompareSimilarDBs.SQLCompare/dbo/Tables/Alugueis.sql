CREATE TABLE [dbo].[Alugueis] (
    [IdAluguel]         INT      IDENTITY (1, 1) NOT NULL,
    [IdItem]            INT      NOT NULL,
    [IdPessoa]          INT      NOT NULL,
    [DataInicioAluguel] DATETIME NOT NULL,
    [DataFimAluguel]    DATETIME NOT NULL,
    [ValorAluguel]      MONEY    NOT NULL,
    [DiaAluguel]        TINYINT  NOT NULL,
    CONSTRAINT [PK_Alugueis] PRIMARY KEY CLUSTERED ([IdAluguel] ASC),
    CONSTRAINT [FK_Alugueis_ItensImoveis] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[ItensImoveis] ([IdItem]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_Alugueis] ON [Implanta_CRPAM].[dbo].[Alugueis] 
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
SET @TableName = 'Alugueis'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdAluguel : «' + RTRIM( ISNULL( CAST (IdAluguel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicioAluguel : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioAluguel, 113 ),'Nulo'))+'» '
                         + '| DataFimAluguel : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimAluguel, 113 ),'Nulo'))+'» '
                         + '| ValorAluguel : «' + RTRIM( ISNULL( CAST (ValorAluguel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiaAluguel : «' + RTRIM( ISNULL( CAST (DiaAluguel AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdAluguel : «' + RTRIM( ISNULL( CAST (IdAluguel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicioAluguel : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioAluguel, 113 ),'Nulo'))+'» '
                         + '| DataFimAluguel : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimAluguel, 113 ),'Nulo'))+'» '
                         + '| ValorAluguel : «' + RTRIM( ISNULL( CAST (ValorAluguel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiaAluguel : «' + RTRIM( ISNULL( CAST (DiaAluguel AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdAluguel : «' + RTRIM( ISNULL( CAST (IdAluguel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicioAluguel : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioAluguel, 113 ),'Nulo'))+'» '
                         + '| DataFimAluguel : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimAluguel, 113 ),'Nulo'))+'» '
                         + '| ValorAluguel : «' + RTRIM( ISNULL( CAST (ValorAluguel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiaAluguel : «' + RTRIM( ISNULL( CAST (DiaAluguel AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdAluguel : «' + RTRIM( ISNULL( CAST (IdAluguel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicioAluguel : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicioAluguel, 113 ),'Nulo'))+'» '
                         + '| DataFimAluguel : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFimAluguel, 113 ),'Nulo'))+'» '
                         + '| ValorAluguel : «' + RTRIM( ISNULL( CAST (ValorAluguel AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DiaAluguel : «' + RTRIM( ISNULL( CAST (DiaAluguel AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
