CREATE TABLE [dbo].[ContratosTermos] (
    [IdContratosTermos]         INT            IDENTITY (1, 1) NOT NULL,
    [IdContrato]                INT            NOT NULL,
    [TipoTermo]                 VARCHAR (5)    NOT NULL,
    [NumeroProtocolo]           VARCHAR (20)   NULL,
    [DataEntradaNota]           DATETIME       NULL,
    [NumeroNotaFiscal]          VARCHAR (20)   NULL,
    [NumeroDeposito]            VARCHAR (20)   NULL,
    [Vencimento]                VARCHAR (80)   NULL,
    [Valor]                     MONEY          NULL,
    [Observacoes]               VARCHAR (4000) NULL,
    [Prazo]                     VARCHAR (30)   NULL,
    [FormaPagamento]            VARCHAR (50)   NULL,
    [ValorPorPeriodo]           MONEY          NULL,
    [RepactDataInicio]          DATETIME       NULL,
    [RepactDataFim]             DATETIME       NULL,
    [RepactDataNovaRepactuacao] DATETIME       NULL,
    [ResponsavelContrato]       VARCHAR (120)  NULL,
    [DocumentoResponsavel]      VARCHAR (50)   NULL,
    CONSTRAINT [PK_ContratosTermos] PRIMARY KEY CLUSTERED ([IdContratosTermos] ASC),
    CONSTRAINT [FK_ContratosTermos_Contratos] FOREIGN KEY ([IdContrato]) REFERENCES [dbo].[Contratos] ([IdContrato])
);


GO
CREATE TRIGGER [TrgLog_ContratosTermos] ON [Implanta_CRPAM].[dbo].[ContratosTermos] 
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
SET @TableName = 'ContratosTermos'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdContratosTermos : «' + RTRIM( ISNULL( CAST (IdContratosTermos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoTermo : «' + RTRIM( ISNULL( CAST (TipoTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEntradaNota : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntradaNota, 113 ),'Nulo'))+'» '
                         + '| NumeroNotaFiscal : «' + RTRIM( ISNULL( CAST (NumeroNotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDeposito : «' + RTRIM( ISNULL( CAST (NumeroDeposito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Vencimento : «' + RTRIM( ISNULL( CAST (Vencimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Observacoes : «' + RTRIM( ISNULL( CAST (Observacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Prazo : «' + RTRIM( ISNULL( CAST (Prazo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaPagamento : «' + RTRIM( ISNULL( CAST (FormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPorPeriodo : «' + RTRIM( ISNULL( CAST (ValorPorPeriodo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RepactDataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, RepactDataInicio, 113 ),'Nulo'))+'» '
                         + '| RepactDataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, RepactDataFim, 113 ),'Nulo'))+'» '
                         + '| RepactDataNovaRepactuacao : «' + RTRIM( ISNULL( CONVERT (CHAR, RepactDataNovaRepactuacao, 113 ),'Nulo'))+'» '
                         + '| ResponsavelContrato : «' + RTRIM( ISNULL( CAST (ResponsavelContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DocumentoResponsavel : «' + RTRIM( ISNULL( CAST (DocumentoResponsavel AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdContratosTermos : «' + RTRIM( ISNULL( CAST (IdContratosTermos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoTermo : «' + RTRIM( ISNULL( CAST (TipoTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEntradaNota : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntradaNota, 113 ),'Nulo'))+'» '
                         + '| NumeroNotaFiscal : «' + RTRIM( ISNULL( CAST (NumeroNotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDeposito : «' + RTRIM( ISNULL( CAST (NumeroDeposito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Vencimento : «' + RTRIM( ISNULL( CAST (Vencimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Observacoes : «' + RTRIM( ISNULL( CAST (Observacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Prazo : «' + RTRIM( ISNULL( CAST (Prazo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaPagamento : «' + RTRIM( ISNULL( CAST (FormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPorPeriodo : «' + RTRIM( ISNULL( CAST (ValorPorPeriodo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RepactDataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, RepactDataInicio, 113 ),'Nulo'))+'» '
                         + '| RepactDataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, RepactDataFim, 113 ),'Nulo'))+'» '
                         + '| RepactDataNovaRepactuacao : «' + RTRIM( ISNULL( CONVERT (CHAR, RepactDataNovaRepactuacao, 113 ),'Nulo'))+'» '
                         + '| ResponsavelContrato : «' + RTRIM( ISNULL( CAST (ResponsavelContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DocumentoResponsavel : «' + RTRIM( ISNULL( CAST (DocumentoResponsavel AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdContratosTermos : «' + RTRIM( ISNULL( CAST (IdContratosTermos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoTermo : «' + RTRIM( ISNULL( CAST (TipoTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEntradaNota : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntradaNota, 113 ),'Nulo'))+'» '
                         + '| NumeroNotaFiscal : «' + RTRIM( ISNULL( CAST (NumeroNotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDeposito : «' + RTRIM( ISNULL( CAST (NumeroDeposito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Vencimento : «' + RTRIM( ISNULL( CAST (Vencimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Observacoes : «' + RTRIM( ISNULL( CAST (Observacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Prazo : «' + RTRIM( ISNULL( CAST (Prazo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaPagamento : «' + RTRIM( ISNULL( CAST (FormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPorPeriodo : «' + RTRIM( ISNULL( CAST (ValorPorPeriodo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RepactDataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, RepactDataInicio, 113 ),'Nulo'))+'» '
                         + '| RepactDataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, RepactDataFim, 113 ),'Nulo'))+'» '
                         + '| RepactDataNovaRepactuacao : «' + RTRIM( ISNULL( CONVERT (CHAR, RepactDataNovaRepactuacao, 113 ),'Nulo'))+'» '
                         + '| ResponsavelContrato : «' + RTRIM( ISNULL( CAST (ResponsavelContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DocumentoResponsavel : «' + RTRIM( ISNULL( CAST (DocumentoResponsavel AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdContratosTermos : «' + RTRIM( ISNULL( CAST (IdContratosTermos AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| TipoTermo : «' + RTRIM( ISNULL( CAST (TipoTermo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataEntradaNota : «' + RTRIM( ISNULL( CONVERT (CHAR, DataEntradaNota, 113 ),'Nulo'))+'» '
                         + '| NumeroNotaFiscal : «' + RTRIM( ISNULL( CAST (NumeroNotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroDeposito : «' + RTRIM( ISNULL( CAST (NumeroDeposito AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Vencimento : «' + RTRIM( ISNULL( CAST (Vencimento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Observacoes : «' + RTRIM( ISNULL( CAST (Observacoes AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Prazo : «' + RTRIM( ISNULL( CAST (Prazo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| FormaPagamento : «' + RTRIM( ISNULL( CAST (FormaPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorPorPeriodo : «' + RTRIM( ISNULL( CAST (ValorPorPeriodo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| RepactDataInicio : «' + RTRIM( ISNULL( CONVERT (CHAR, RepactDataInicio, 113 ),'Nulo'))+'» '
                         + '| RepactDataFim : «' + RTRIM( ISNULL( CONVERT (CHAR, RepactDataFim, 113 ),'Nulo'))+'» '
                         + '| RepactDataNovaRepactuacao : «' + RTRIM( ISNULL( CONVERT (CHAR, RepactDataNovaRepactuacao, 113 ),'Nulo'))+'» '
                         + '| ResponsavelContrato : «' + RTRIM( ISNULL( CAST (ResponsavelContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DocumentoResponsavel : «' + RTRIM( ISNULL( CAST (DocumentoResponsavel AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
