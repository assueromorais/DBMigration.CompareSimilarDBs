CREATE TABLE [dbo].[DepreciacaoAutomaticaMCASPBI] (
    [IdDAMCASP]                    INT              IDENTITY (1, 1) NOT NULL,
    [IdDepreciacaoAutomatica]      INT              NOT NULL,
    [IdItem]                       INT              NOT NULL,
    [DataPrimeiraDepreciacao]      DATETIME         NULL,
    [DataUltimaDepreciacao]        DATETIME         NULL,
    [ValorAcumuladoDepreciacao]    MONEY            NOT NULL,
    [IdLancamento]                 UNIQUEIDENTIFIER NULL,
    [Exercicio]                    INT              NULL,
    [QtdMesesDepreciacaoAcumulada] INT              NULL,
    CONSTRAINT [PK_DepreciacaoAutomaticaMCASPBIdDAMCASPI] PRIMARY KEY CLUSTERED ([IdDAMCASP] ASC),
    CONSTRAINT [FK_DepreAutoMCASPBIIdDeprAutomatica] FOREIGN KEY ([IdDepreciacaoAutomatica]) REFERENCES [dbo].[DepreciacaoAutomaticaBI] ([IdDepreciacaoAutomatica]),
    CONSTRAINT [FK_DepreAutoMCASPBIIdItem] FOREIGN KEY ([IdItem]) REFERENCES [dbo].[ItensImoveis] ([IdItem])
);


GO
CREATE TRIGGER [TrgLog_DepreciacaoAutomaticaMCASPBI] ON [Implanta_CRPAM].[dbo].[DepreciacaoAutomaticaMCASPBI] 
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
SET @TableName = 'DepreciacaoAutomaticaMCASPBI'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdDAMCASP : «' + RTRIM( ISNULL( CAST (IdDAMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepreciacaoAutomatica : «' + RTRIM( ISNULL( CAST (IdDepreciacaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrimeiraDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrimeiraDepreciacao, 113 ),'Nulo'))+'» '
                         + '| DataUltimaDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaDepreciacao, 113 ),'Nulo'))+'» '
                         + '| ValorAcumuladoDepreciacao : «' + RTRIM( ISNULL( CAST (ValorAcumuladoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMesesDepreciacaoAcumulada : «' + RTRIM( ISNULL( CAST (QtdMesesDepreciacaoAcumulada AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdDAMCASP : «' + RTRIM( ISNULL( CAST (IdDAMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepreciacaoAutomatica : «' + RTRIM( ISNULL( CAST (IdDepreciacaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrimeiraDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrimeiraDepreciacao, 113 ),'Nulo'))+'» '
                         + '| DataUltimaDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaDepreciacao, 113 ),'Nulo'))+'» '
                         + '| ValorAcumuladoDepreciacao : «' + RTRIM( ISNULL( CAST (ValorAcumuladoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMesesDepreciacaoAcumulada : «' + RTRIM( ISNULL( CAST (QtdMesesDepreciacaoAcumulada AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdDAMCASP : «' + RTRIM( ISNULL( CAST (IdDAMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepreciacaoAutomatica : «' + RTRIM( ISNULL( CAST (IdDepreciacaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrimeiraDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrimeiraDepreciacao, 113 ),'Nulo'))+'» '
                         + '| DataUltimaDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaDepreciacao, 113 ),'Nulo'))+'» '
                         + '| ValorAcumuladoDepreciacao : «' + RTRIM( ISNULL( CAST (ValorAcumuladoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMesesDepreciacaoAcumulada : «' + RTRIM( ISNULL( CAST (QtdMesesDepreciacaoAcumulada AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdDAMCASP : «' + RTRIM( ISNULL( CAST (IdDAMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdDepreciacaoAutomatica : «' + RTRIM( ISNULL( CAST (IdDepreciacaoAutomatica AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdItem : «' + RTRIM( ISNULL( CAST (IdItem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataPrimeiraDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrimeiraDepreciacao, 113 ),'Nulo'))+'» '
                         + '| DataUltimaDepreciacao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataUltimaDepreciacao, 113 ),'Nulo'))+'» '
                         + '| ValorAcumuladoDepreciacao : «' + RTRIM( ISNULL( CAST (ValorAcumuladoDepreciacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Exercicio : «' + RTRIM( ISNULL( CAST (Exercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| QtdMesesDepreciacaoAcumulada : «' + RTRIM( ISNULL( CAST (QtdMesesDepreciacaoAcumulada AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
