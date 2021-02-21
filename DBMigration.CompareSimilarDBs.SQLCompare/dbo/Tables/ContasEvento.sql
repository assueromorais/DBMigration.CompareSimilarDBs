CREATE TABLE [dbo].[ContasEvento] (
    [IdContasEvento] INT           IDENTITY (1, 1) NOT NULL,
    [IdEvento]       INT           NOT NULL,
    [IdConta]        INT           NOT NULL,
    [Percentual]     FLOAT (53)    NOT NULL,
    [CreditoDebito]  BIT           NOT NULL,
    [Historico]      VARCHAR (255) NULL,
    CONSTRAINT [PK_ContasEvento] PRIMARY KEY NONCLUSTERED ([IdContasEvento] ASC),
    CONSTRAINT [FK_ContasEvento_Eventos] FOREIGN KEY ([IdEvento]) REFERENCES [dbo].[Eventos] ([IdEvento]),
    CONSTRAINT [FK_ContasEvento_PlanoContas] FOREIGN KEY ([IdConta]) REFERENCES [dbo].[PlanoContas] ([IdConta])
);


GO
CREATE TRIGGER [TrgLog_ContasEvento] ON [Implanta_CRPAM].[dbo].[ContasEvento] 
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
SET @TableName = 'ContasEvento'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdContasEvento : «' + RTRIM( ISNULL( CAST (IdContasEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Percentual : «' + RTRIM( ISNULL( CAST (Percentual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CreditoDebito IS NULL THEN ' CreditoDebito : «Nulo» '
                                              WHEN  CreditoDebito = 0 THEN ' CreditoDebito : «Falso» '
                                              WHEN  CreditoDebito = 1 THEN ' CreditoDebito : «Verdadeiro» '
                                    END 
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdContasEvento : «' + RTRIM( ISNULL( CAST (IdContasEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Percentual : «' + RTRIM( ISNULL( CAST (Percentual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CreditoDebito IS NULL THEN ' CreditoDebito : «Nulo» '
                                              WHEN  CreditoDebito = 0 THEN ' CreditoDebito : «Falso» '
                                              WHEN  CreditoDebito = 1 THEN ' CreditoDebito : «Verdadeiro» '
                                    END 
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdContasEvento : «' + RTRIM( ISNULL( CAST (IdContasEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Percentual : «' + RTRIM( ISNULL( CAST (Percentual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CreditoDebito IS NULL THEN ' CreditoDebito : «Nulo» '
                                              WHEN  CreditoDebito = 0 THEN ' CreditoDebito : «Falso» '
                                              WHEN  CreditoDebito = 1 THEN ' CreditoDebito : «Verdadeiro» '
                                    END 
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdContasEvento : «' + RTRIM( ISNULL( CAST (IdContasEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEvento : «' + RTRIM( ISNULL( CAST (IdEvento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdConta : «' + RTRIM( ISNULL( CAST (IdConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Percentual : «' + RTRIM( ISNULL( CAST (Percentual AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  CreditoDebito IS NULL THEN ' CreditoDebito : «Nulo» '
                                              WHEN  CreditoDebito = 0 THEN ' CreditoDebito : «Falso» '
                                              WHEN  CreditoDebito = 1 THEN ' CreditoDebito : «Verdadeiro» '
                                    END 
                         + '| Historico : «' + RTRIM( ISNULL( CAST (Historico AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
