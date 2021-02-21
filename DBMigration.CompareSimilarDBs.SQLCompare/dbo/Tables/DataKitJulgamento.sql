CREATE TABLE [dbo].[DataKitJulgamento] (
    [DataRecebimento]              DATETIME NULL,
    [DataTermoConclusao]           DATETIME NULL,
    [DataOfCurador]                DATETIME NULL,
    [DataOfRepresentado]           DATETIME NULL,
    [DataAcordao]                  DATETIME NULL,
    [DataOfRecursoRepresentado]    DATETIME NULL,
    [DataOfRecursoCurador]         DATETIME NULL,
    [DataDevolucaoCarteiras]       DATETIME NULL,
    [DataTermoConclusaoInscricao]  DATETIME NULL,
    [DataTermoCompromisso]         DATETIME NULL,
    [DataNotifDefesaPrevia]        DATETIME NULL,
    [DataTermoConclusaoInscricao2] DATETIME NULL,
    [DataApresDefesaPrevia]        DATETIME NULL,
    [DataNotifRazoesFinais]        DATETIME NULL,
    [DataApresRazoesFinais]        DATETIME NULL,
    [DataRemessa]                  DATETIME NULL
);


GO
CREATE TRIGGER [TrgLog_DataKitJulgamento] ON [Implanta_CRPAM].[dbo].[DataKitJulgamento] 
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
SET @TableName = 'DataKitJulgamento'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'DataRecebimento : «' + RTRIM(ISNULL(CONVERT (CHAR, DataRecebimento, 113),'Nulo')) +'» '
                         + '| DataTermoConclusao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoConclusao, 113 ),'Nulo'))+'» '
                         + '| DataOfCurador : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfCurador, 113 ),'Nulo'))+'» '
                         + '| DataOfRepresentado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfRepresentado, 113 ),'Nulo'))+'» '
                         + '| DataAcordao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAcordao, 113 ),'Nulo'))+'» '
                         + '| DataOfRecursoRepresentado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfRecursoRepresentado, 113 ),'Nulo'))+'» '
                         + '| DataOfRecursoCurador : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfRecursoCurador, 113 ),'Nulo'))+'» '
                         + '| DataDevolucaoCarteiras : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucaoCarteiras, 113 ),'Nulo'))+'» '
                         + '| DataTermoConclusaoInscricao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoConclusaoInscricao, 113 ),'Nulo'))+'» '
                         + '| DataTermoCompromisso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoCompromisso, 113 ),'Nulo'))+'» '
                         + '| DataNotifDefesaPrevia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataNotifDefesaPrevia, 113 ),'Nulo'))+'» '
                         + '| DataTermoConclusaoInscricao2 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoConclusaoInscricao2, 113 ),'Nulo'))+'» '
                         + '| DataApresDefesaPrevia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataApresDefesaPrevia, 113 ),'Nulo'))+'» '
                         + '| DataNotifRazoesFinais : «' + RTRIM( ISNULL( CONVERT (CHAR, DataNotifRazoesFinais, 113 ),'Nulo'))+'» '
                         + '| DataApresRazoesFinais : «' + RTRIM( ISNULL( CONVERT (CHAR, DataApresRazoesFinais, 113 ),'Nulo'))+'» '
                         + '| DataRemessa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRemessa, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'DataRecebimento : «' + RTRIM(ISNULL(CONVERT (CHAR, DataRecebimento, 113),'Nulo')) +'» '
                         + '| DataTermoConclusao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoConclusao, 113 ),'Nulo'))+'» '
                         + '| DataOfCurador : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfCurador, 113 ),'Nulo'))+'» '
                         + '| DataOfRepresentado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfRepresentado, 113 ),'Nulo'))+'» '
                         + '| DataAcordao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAcordao, 113 ),'Nulo'))+'» '
                         + '| DataOfRecursoRepresentado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfRecursoRepresentado, 113 ),'Nulo'))+'» '
                         + '| DataOfRecursoCurador : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfRecursoCurador, 113 ),'Nulo'))+'» '
                         + '| DataDevolucaoCarteiras : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucaoCarteiras, 113 ),'Nulo'))+'» '
                         + '| DataTermoConclusaoInscricao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoConclusaoInscricao, 113 ),'Nulo'))+'» '
                         + '| DataTermoCompromisso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoCompromisso, 113 ),'Nulo'))+'» '
                         + '| DataNotifDefesaPrevia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataNotifDefesaPrevia, 113 ),'Nulo'))+'» '
                         + '| DataTermoConclusaoInscricao2 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoConclusaoInscricao2, 113 ),'Nulo'))+'» '
                         + '| DataApresDefesaPrevia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataApresDefesaPrevia, 113 ),'Nulo'))+'» '
                         + '| DataNotifRazoesFinais : «' + RTRIM( ISNULL( CONVERT (CHAR, DataNotifRazoesFinais, 113 ),'Nulo'))+'» '
                         + '| DataApresRazoesFinais : «' + RTRIM( ISNULL( CONVERT (CHAR, DataApresRazoesFinais, 113 ),'Nulo'))+'» '
                         + '| DataRemessa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRemessa, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'DataRecebimento : «' + RTRIM(ISNULL(CONVERT (CHAR, DataRecebimento, 113),'Nulo')) +'» '
                         + '| DataTermoConclusao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoConclusao, 113 ),'Nulo'))+'» '
                         + '| DataOfCurador : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfCurador, 113 ),'Nulo'))+'» '
                         + '| DataOfRepresentado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfRepresentado, 113 ),'Nulo'))+'» '
                         + '| DataAcordao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAcordao, 113 ),'Nulo'))+'» '
                         + '| DataOfRecursoRepresentado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfRecursoRepresentado, 113 ),'Nulo'))+'» '
                         + '| DataOfRecursoCurador : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfRecursoCurador, 113 ),'Nulo'))+'» '
                         + '| DataDevolucaoCarteiras : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucaoCarteiras, 113 ),'Nulo'))+'» '
                         + '| DataTermoConclusaoInscricao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoConclusaoInscricao, 113 ),'Nulo'))+'» '
                         + '| DataTermoCompromisso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoCompromisso, 113 ),'Nulo'))+'» '
                         + '| DataNotifDefesaPrevia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataNotifDefesaPrevia, 113 ),'Nulo'))+'» '
                         + '| DataTermoConclusaoInscricao2 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoConclusaoInscricao2, 113 ),'Nulo'))+'» '
                         + '| DataApresDefesaPrevia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataApresDefesaPrevia, 113 ),'Nulo'))+'» '
                         + '| DataNotifRazoesFinais : «' + RTRIM( ISNULL( CONVERT (CHAR, DataNotifRazoesFinais, 113 ),'Nulo'))+'» '
                         + '| DataApresRazoesFinais : «' + RTRIM( ISNULL( CONVERT (CHAR, DataApresRazoesFinais, 113 ),'Nulo'))+'» '
                         + '| DataRemessa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRemessa, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'DataRecebimento : «' + RTRIM(ISNULL(CONVERT (CHAR, DataRecebimento, 113),'Nulo')) +'» '
                         + '| DataTermoConclusao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoConclusao, 113 ),'Nulo'))+'» '
                         + '| DataOfCurador : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfCurador, 113 ),'Nulo'))+'» '
                         + '| DataOfRepresentado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfRepresentado, 113 ),'Nulo'))+'» '
                         + '| DataAcordao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataAcordao, 113 ),'Nulo'))+'» '
                         + '| DataOfRecursoRepresentado : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfRecursoRepresentado, 113 ),'Nulo'))+'» '
                         + '| DataOfRecursoCurador : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOfRecursoCurador, 113 ),'Nulo'))+'» '
                         + '| DataDevolucaoCarteiras : «' + RTRIM( ISNULL( CONVERT (CHAR, DataDevolucaoCarteiras, 113 ),'Nulo'))+'» '
                         + '| DataTermoConclusaoInscricao : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoConclusaoInscricao, 113 ),'Nulo'))+'» '
                         + '| DataTermoCompromisso : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoCompromisso, 113 ),'Nulo'))+'» '
                         + '| DataNotifDefesaPrevia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataNotifDefesaPrevia, 113 ),'Nulo'))+'» '
                         + '| DataTermoConclusaoInscricao2 : «' + RTRIM( ISNULL( CONVERT (CHAR, DataTermoConclusaoInscricao2, 113 ),'Nulo'))+'» '
                         + '| DataApresDefesaPrevia : «' + RTRIM( ISNULL( CONVERT (CHAR, DataApresDefesaPrevia, 113 ),'Nulo'))+'» '
                         + '| DataNotifRazoesFinais : «' + RTRIM( ISNULL( CONVERT (CHAR, DataNotifRazoesFinais, 113 ),'Nulo'))+'» '
                         + '| DataApresRazoesFinais : «' + RTRIM( ISNULL( CONVERT (CHAR, DataApresRazoesFinais, 113 ),'Nulo'))+'» '
                         + '| DataRemessa : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRemessa, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
