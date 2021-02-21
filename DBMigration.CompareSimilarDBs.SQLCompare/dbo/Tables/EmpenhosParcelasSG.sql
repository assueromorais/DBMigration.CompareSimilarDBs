CREATE TABLE [dbo].[EmpenhosParcelasSG] (
    [IdEmpenhoParcelaSG]       INT          IDENTITY (1, 1) NOT NULL,
    [IdEmpenho]                INT          NULL,
    [IdRestosEmpenho]          INT          NULL,
    [DataVencimento]           DATETIME     NULL,
    [ValorPrevisto]            MONEY        NULL,
    [DataRecebimento]          DATETIME     NULL,
    [NotaFiscal]               VARCHAR (20) NULL,
    [IdTipoDocumentoPagamento] INT          NULL,
    [IdEmpenhoMCASP]           INT          NULL,
    CONSTRAINT [PK_EmpenhosParcelasSG] PRIMARY KEY CLUSTERED ([IdEmpenhoParcelaSG] ASC),
    FOREIGN KEY ([IdEmpenhoMCASP]) REFERENCES [dbo].[EmpenhosMCASP] ([IdEmpenhoMCASP]),
    CONSTRAINT [FK_EmpenhosParcelasSG_Empenhos] FOREIGN KEY ([IdEmpenho]) REFERENCES [dbo].[Empenhos] ([IdEmpenho]),
    CONSTRAINT [FK_EmpenhosParcelasSG_RestosEmpenho] FOREIGN KEY ([IdRestosEmpenho]) REFERENCES [dbo].[RestosEmpenho] ([IdRestosEmpenho]),
    CONSTRAINT [FK_EmpenhosParcelasSG_TiposDocumentosPagamentos] FOREIGN KEY ([IdTipoDocumentoPagamento]) REFERENCES [dbo].[TiposDocumentosPagamentos] ([IdTipoDocumentoPagamento]) NOT FOR REPLICATION
);


GO
CREATE TRIGGER [TrgLog_EmpenhosParcelasSG] ON [Implanta_CRPAM].[dbo].[EmpenhosParcelasSG] 
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
SET @TableName = 'EmpenhosParcelasSG'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdEmpenhoParcelaSG : «' + RTRIM( ISNULL( CAST (IdEmpenhoParcelaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosEmpenho : «' + RTRIM( ISNULL( CAST (IdRestosEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisto : «' + RTRIM( ISNULL( CAST (ValorPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecebimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimento, 113 ),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdEmpenhoParcelaSG : «' + RTRIM( ISNULL( CAST (IdEmpenhoParcelaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosEmpenho : «' + RTRIM( ISNULL( CAST (IdRestosEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisto : «' + RTRIM( ISNULL( CAST (ValorPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecebimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimento, 113 ),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdEmpenhoParcelaSG : «' + RTRIM( ISNULL( CAST (IdEmpenhoParcelaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosEmpenho : «' + RTRIM( ISNULL( CAST (IdRestosEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisto : «' + RTRIM( ISNULL( CAST (ValorPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecebimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimento, 113 ),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdEmpenhoParcelaSG : «' + RTRIM( ISNULL( CAST (IdEmpenhoParcelaSG AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenho : «' + RTRIM( ISNULL( CAST (IdEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdRestosEmpenho : «' + RTRIM( ISNULL( CAST (IdRestosEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataVencimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataVencimento, 113 ),'Nulo'))+'» '
                         + '| ValorPrevisto : «' + RTRIM( ISNULL( CAST (ValorPrevisto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataRecebimento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataRecebimento, 113 ),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdTipoDocumentoPagamento : «' + RTRIM( ISNULL( CAST (IdTipoDocumentoPagamento AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdEmpenhoMCASP : «' + RTRIM( ISNULL( CAST (IdEmpenhoMCASP AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
