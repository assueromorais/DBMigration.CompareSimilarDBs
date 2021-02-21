CREATE TABLE [dbo].[EmpenhosMCASP] (
    [IdEmpenhoMCASP] INT              IDENTITY (1, 1) NOT NULL,
    [IdEmpenho]      UNIQUEIDENTIFIER NOT NULL,
    [NumeroEmpenho]  INT              NOT NULL,
    [AnoExercicio]   INT              NOT NULL,
    [DataEmpenho]    DATETIME         NOT NULL,
    [ValorEmpenho]   NUMERIC (18, 2)  NOT NULL,
    [NumeroProcesso] VARCHAR (20)     NULL,
    [ValorAnulado]   NUMERIC (18, 2)  NOT NULL,
    [RestoAPagar]    BIT              DEFAULT ((0)) NOT NULL,
    [ValorPago]      DECIMAL (18, 2)  DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([IdEmpenhoMCASP] ASC)
);


GO
CREATE TRIGGER [TrgLog_EmpenhosMCASP] ON [Implanta_CRPAM].[dbo].[EmpenhosMCASP] 
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
SET @TableName = 'EmpenhosMCASP'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEmpenho : «' + RTRIM( ISNULL( CAST (NumeroEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmpenho : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmpenho, 113 ),'Nulo'))+'» '
                         + '| ValorEmpenho : «' + RTRIM( ISNULL( CAST (ValorEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAnulado : «' + RTRIM( ISNULL( CAST (ValorAnulado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RestoAPagar IS NULL THEN ' RestoAPagar : «Nulo» '
                                              WHEN  RestoAPagar = 0 THEN ' RestoAPagar : «Falso» '
                                              WHEN  RestoAPagar = 1 THEN ' RestoAPagar : «Verdadeiro» '
                                    END 
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEmpenho : «' + RTRIM( ISNULL( CAST (NumeroEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmpenho : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmpenho, 113 ),'Nulo'))+'» '
                         + '| ValorEmpenho : «' + RTRIM( ISNULL( CAST (ValorEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAnulado : «' + RTRIM( ISNULL( CAST (ValorAnulado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RestoAPagar IS NULL THEN ' RestoAPagar : «Nulo» '
                                              WHEN  RestoAPagar = 0 THEN ' RestoAPagar : «Falso» '
                                              WHEN  RestoAPagar = 1 THEN ' RestoAPagar : «Verdadeiro» '
                                    END 
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEmpenho : «' + RTRIM( ISNULL( CAST (NumeroEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmpenho : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmpenho, 113 ),'Nulo'))+'» '
                         + '| ValorEmpenho : «' + RTRIM( ISNULL( CAST (ValorEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAnulado : «' + RTRIM( ISNULL( CAST (ValorAnulado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RestoAPagar IS NULL THEN ' RestoAPagar : «Nulo» '
                                              WHEN  RestoAPagar = 0 THEN ' RestoAPagar : «Falso» '
                                              WHEN  RestoAPagar = 1 THEN ' RestoAPagar : «Verdadeiro» '
                                    END 
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroEmpenho : «' + RTRIM( ISNULL( CAST (NumeroEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| AnoExercicio : «' + RTRIM( ISNULL( CAST (AnoExercicio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEmpenho : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEmpenho, 113 ),'Nulo'))+'» '
                         + '| ValorEmpenho : «' + RTRIM( ISNULL( CAST (ValorEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorAnulado : «' + RTRIM( ISNULL( CAST (ValorAnulado AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  RestoAPagar IS NULL THEN ' RestoAPagar : «Nulo» '
                                              WHEN  RestoAPagar = 0 THEN ' RestoAPagar : «Falso» '
                                              WHEN  RestoAPagar = 1 THEN ' RestoAPagar : «Verdadeiro» '
                                    END 
                         + '| ValorPago : «' + RTRIM( ISNULL( CAST (ValorPago AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
