CREATE TABLE [dbo].[HistoricoPeriodoInativo] (
    [IdPeriodoInativo] INT           IDENTITY (1, 1) NOT NULL,
    [IdPessoa]         INT           NULL,
    [DataInicial]      DATETIME      NULL,
    [DataFinal]        DATETIME      NULL,
    [Motivo]           VARCHAR (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_HistoricoPeriodoInativo] PRIMARY KEY CLUSTERED ([IdPeriodoInativo] ASC),
    CONSTRAINT [FK_HistoricoPeriodoInativo_Pessoas] FOREIGN KEY ([IdPessoa]) REFERENCES [dbo].[Pessoas] ([IdPessoa])
);


GO
CREATE TRIGGER [TrgLog_HistoricoPeriodoInativo] ON [Implanta_CRPAM].[dbo].[HistoricoPeriodoInativo] 
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
SET @TableName = 'HistoricoPeriodoInativo'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdPeriodoInativo : «' + RTRIM( ISNULL( CAST (IdPeriodoInativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicial, 113 ),'Nulo'))+'» '
                         + '| DataFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFinal, 113 ),'Nulo'))+'» '
                         + '| Motivo : «' + RTRIM( ISNULL( CAST (Motivo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdPeriodoInativo : «' + RTRIM( ISNULL( CAST (IdPeriodoInativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicial, 113 ),'Nulo'))+'» '
                         + '| DataFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFinal, 113 ),'Nulo'))+'» '
                         + '| Motivo : «' + RTRIM( ISNULL( CAST (Motivo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdPeriodoInativo : «' + RTRIM( ISNULL( CAST (IdPeriodoInativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicial, 113 ),'Nulo'))+'» '
                         + '| DataFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFinal, 113 ),'Nulo'))+'» '
                         + '| Motivo : «' + RTRIM( ISNULL( CAST (Motivo AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdPeriodoInativo : «' + RTRIM( ISNULL( CAST (IdPeriodoInativo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataInicial : «' + RTRIM( ISNULL( CONVERT (CHAR, DataInicial, 113 ),'Nulo'))+'» '
                         + '| DataFinal : «' + RTRIM( ISNULL( CONVERT (CHAR, DataFinal, 113 ),'Nulo'))+'» '
                         + '| Motivo : «' + RTRIM( ISNULL( CAST (Motivo AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
