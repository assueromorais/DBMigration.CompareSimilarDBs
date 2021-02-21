CREATE TABLE [dbo].[CentroCustosPagamento] (
    [IdCentroCustosPagamento] INT      IDENTITY (1, 1) NOT NULL,
    [IdPagamento]             INT      NOT NULL,
    [IdCentroCusto]           INT      NOT NULL,
    [IdConta]                 INT      NOT NULL,
    [DataEvento]              DATETIME NOT NULL,
    [ValorEvento]             MONEY    NOT NULL,
    [Evento]                  BIT      NOT NULL,
    CONSTRAINT [PK_LancCusto] PRIMARY KEY NONCLUSTERED ([IdCentroCustosPagamento] ASC),
    CONSTRAINT [FK_CentroCustosPagamento_CentroCustos] FOREIGN KEY ([IdCentroCusto]) REFERENCES [dbo].[CentroCustos] ([IdCentroCusto]) NOT FOR REPLICATION,
    CONSTRAINT [FK_CentroCustosPagamento_Pagamentos] FOREIGN KEY ([IdPagamento]) REFERENCES [dbo].[Pagamentos] ([IdPagamento]),
    CONSTRAINT [FK_CentroCustosPagamento_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
CREATE STATISTICS [STAT_CentroCustosPagamento_Evento_IdConta]
    ON [dbo].[CentroCustosPagamento]([Evento], [IdConta]);


GO
CREATE STATISTICS [STAT_CentroCustosPagamento_Evento_IdCentroCusto]
    ON [dbo].[CentroCustosPagamento]([Evento], [IdCentroCusto]);


GO
CREATE TRIGGER [TrgLog_CentroCustosPagamento] ON [Implanta_CRPAM].[dbo].[CentroCustosPagamento] 
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
SET @TableName = 'CentroCustosPagamento'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdCentroCustosPagamento : «' + RTRIM( ISNULL( CAST (IdCentroCustosPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEvento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEvento, 113 ),'Nulo'))+'» '
                         + '| ValorEvento : «' + RTRIM( ISNULL( CAST (ValorEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Evento IS NULL THEN ' Evento : «Nulo» '
                                              WHEN  Evento = 0 THEN ' Evento : «Falso» '
                                              WHEN  Evento = 1 THEN ' Evento : «Verdadeiro» '
                                    END  FROM DELETED 
	SELECT @Conteudo2 = 'IdCentroCustosPagamento : «' + RTRIM( ISNULL( CAST (IdCentroCustosPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEvento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEvento, 113 ),'Nulo'))+'» '
                         + '| ValorEvento : «' + RTRIM( ISNULL( CAST (ValorEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Evento IS NULL THEN ' Evento : «Nulo» '
                                              WHEN  Evento = 0 THEN ' Evento : «Falso» '
                                              WHEN  Evento = 1 THEN ' Evento : «Verdadeiro» '
                                    END  FROM INSERTED 
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
		SELECT @Conteudo = 'IdCentroCustosPagamento : «' + RTRIM( ISNULL( CAST (IdCentroCustosPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEvento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEvento, 113 ),'Nulo'))+'» '
                         + '| ValorEvento : «' + RTRIM( ISNULL( CAST (ValorEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Evento IS NULL THEN ' Evento : «Nulo» '
                                              WHEN  Evento = 0 THEN ' Evento : «Falso» '
                                              WHEN  Evento = 1 THEN ' Evento : «Verdadeiro» '
                                    END  FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdCentroCustosPagamento : «' + RTRIM( ISNULL( CAST (IdCentroCustosPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPagamento : «' + RTRIM( ISNULL( CAST (IdPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdCentroCusto : «' + RTRIM( ISNULL( CAST (IdCentroCusto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEvento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEvento, 113 ),'Nulo'))+'» '
                         + '| ValorEvento : «' + RTRIM( ISNULL( CAST (ValorEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  Evento IS NULL THEN ' Evento : «Nulo» '
                                              WHEN  Evento = 0 THEN ' Evento : «Falso» '
                                              WHEN  Evento = 1 THEN ' Evento : «Verdadeiro» '
                                    END  FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
