CREATE TABLE [dbo].[ContasCorrentesRateio] (
    [IdContaCorrenteRateio] INT          IDENTITY (1, 1) NOT NULL,
    [IdContaCorrente]       INT          NULL,
    [CodBanco]              VARCHAR (3)  NULL,
    [Agencia]               VARCHAR (5)  NULL,
    [DVAgencia]             CHAR (1)     NULL,
    [ContaCorrente]         VARCHAR (12) NULL,
    [DVContaCorrente]       CHAR (1)     NULL,
    [DVAgenciaConta]        CHAR (1)     NULL,
    [NomeBeneficiario]      VARCHAR (40) NULL,
    [CodRateio]             CHAR (1)     NULL,
    [EPercentual]           BIT          NULL,
    [ValorRateio]           FLOAT (53)   NULL,
    [FloatingRateio]        VARCHAR (3)  NULL,
    [DataCredito]           DATETIME     NULL,
    CONSTRAINT [PK_ContasCorrentesRateio] PRIMARY KEY CLUSTERED ([IdContaCorrenteRateio] ASC),
    CONSTRAINT [FK_ContasCorrentesRateio_ContasCorrentes] FOREIGN KEY ([IdContaCorrente]) REFERENCES [dbo].[ContasCorrentes] ([IdContaCorrente])
);


GO
CREATE TRIGGER [TrgLog_ContasCorrentesRateio] ON [Implanta_CRPAM].[dbo].[ContasCorrentesRateio] 
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
SET @TableName = 'ContasCorrentesRateio'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdContaCorrenteRateio : «' + RTRIM( ISNULL( CAST (IdContaCorrenteRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgencia : «' + RTRIM( ISNULL( CAST (DVAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVContaCorrente : «' + RTRIM( ISNULL( CAST (DVContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgenciaConta : «' + RTRIM( ISNULL( CAST (DVAgenciaConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBeneficiario : «' + RTRIM( ISNULL( CAST (NomeBeneficiario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodRateio : «' + RTRIM( ISNULL( CAST (CodRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EPercentual IS NULL THEN ' EPercentual : «Nulo» '
                                              WHEN  EPercentual = 0 THEN ' EPercentual : «Falso» '
                                              WHEN  EPercentual = 1 THEN ' EPercentual : «Verdadeiro» '
                                    END 
                         + '| ValorRateio : «' + RTRIM( ISNULL( CAST (ValorRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FloatingRateio : «' + RTRIM( ISNULL( CAST (FloatingRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdContaCorrenteRateio : «' + RTRIM( ISNULL( CAST (IdContaCorrenteRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgencia : «' + RTRIM( ISNULL( CAST (DVAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVContaCorrente : «' + RTRIM( ISNULL( CAST (DVContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgenciaConta : «' + RTRIM( ISNULL( CAST (DVAgenciaConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBeneficiario : «' + RTRIM( ISNULL( CAST (NomeBeneficiario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodRateio : «' + RTRIM( ISNULL( CAST (CodRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EPercentual IS NULL THEN ' EPercentual : «Nulo» '
                                              WHEN  EPercentual = 0 THEN ' EPercentual : «Falso» '
                                              WHEN  EPercentual = 1 THEN ' EPercentual : «Verdadeiro» '
                                    END 
                         + '| ValorRateio : «' + RTRIM( ISNULL( CAST (ValorRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FloatingRateio : «' + RTRIM( ISNULL( CAST (FloatingRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdContaCorrenteRateio : «' + RTRIM( ISNULL( CAST (IdContaCorrenteRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgencia : «' + RTRIM( ISNULL( CAST (DVAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVContaCorrente : «' + RTRIM( ISNULL( CAST (DVContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgenciaConta : «' + RTRIM( ISNULL( CAST (DVAgenciaConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBeneficiario : «' + RTRIM( ISNULL( CAST (NomeBeneficiario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodRateio : «' + RTRIM( ISNULL( CAST (CodRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EPercentual IS NULL THEN ' EPercentual : «Nulo» '
                                              WHEN  EPercentual = 0 THEN ' EPercentual : «Falso» '
                                              WHEN  EPercentual = 1 THEN ' EPercentual : «Verdadeiro» '
                                    END 
                         + '| ValorRateio : «' + RTRIM( ISNULL( CAST (ValorRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FloatingRateio : «' + RTRIM( ISNULL( CAST (FloatingRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdContaCorrenteRateio : «' + RTRIM( ISNULL( CAST (IdContaCorrenteRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContaCorrente : «' + RTRIM( ISNULL( CAST (IdContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodBanco : «' + RTRIM( ISNULL( CAST (CodBanco AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Agencia : «' + RTRIM( ISNULL( CAST (Agencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgencia : «' + RTRIM( ISNULL( CAST (DVAgencia AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ContaCorrente : «' + RTRIM( ISNULL( CAST (ContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVContaCorrente : «' + RTRIM( ISNULL( CAST (DVContaCorrente AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DVAgenciaConta : «' + RTRIM( ISNULL( CAST (DVAgenciaConta AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NomeBeneficiario : «' + RTRIM( ISNULL( CAST (NomeBeneficiario AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| CodRateio : «' + RTRIM( ISNULL( CAST (CodRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  EPercentual IS NULL THEN ' EPercentual : «Nulo» '
                                              WHEN  EPercentual = 0 THEN ' EPercentual : «Falso» '
                                              WHEN  EPercentual = 1 THEN ' EPercentual : «Verdadeiro» '
                                    END 
                         + '| ValorRateio : «' + RTRIM( ISNULL( CAST (ValorRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FloatingRateio : «' + RTRIM( ISNULL( CAST (FloatingRateio AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCredito : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCredito, 113 ),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
