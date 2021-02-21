CREATE TABLE [dbo].[Ordens] (
    [IdOrdem]                   INT           IDENTITY (1, 1) NOT NULL,
    [IdProcesso]                INT           NULL,
    [IdContrato]                INT           NULL,
    [IdServico]                 INT           NULL,
    [IdPessoa]                  INT           NULL,
    [NumeroOrdem]               VARCHAR (20)  NOT NULL,
    [Valor]                     MONEY         NOT NULL,
    [Empenho]                   VARCHAR (30)  NULL,
    [DataOrdem]                 DATETIME      NOT NULL,
    [DataPrevista]              DATETIME      NULL,
    [NotaFiscal]                VARCHAR (20)  NULL,
    [NumeroProcesso]            VARCHAR (20)  NULL,
    [Descricao]                 TEXT          NULL,
    [GeradaSolicitacao]         BIT           NULL,
    [CondicaoPagamento]         TEXT          NULL,
    [Desconto]                  MONEY         NULL,
    [ValorSemDesconto]          MONEY         NULL,
    [Situacao]                  INT           NOT NULL,
    [DataCancelamento]          DATETIME      NULL,
    [AnoEmpenho]                SMALLINT      NULL,
    [NumeroMemorando]           VARCHAR (50)  NULL,
    [VencimentoNotaFiscal]      DATETIME      NULL,
    [FreteValor]                MONEY         NULL,
    [NumeroProtocolo]           VARCHAR (20)  NULL,
    [IdModalidadeCompra]        INT           NULL,
    [IdResponsavelComprador]    INT           NULL,
    [NumeroAutorizacao]         NVARCHAR (20) NULL,
    [IdNaturezaOrdem]           INT           NULL,
    [IdLocalEntregaOrdem]       INT           NULL,
    [EmailEnviado]              DATETIME      NULL,
    [IdResponsavelRequisitante] INT           NULL,
    CONSTRAINT [PK_Ordens] PRIMARY KEY CLUSTERED ([IdOrdem] ASC),
    CONSTRAINT [FK_Ordens_Contratos] FOREIGN KEY ([IdContrato]) REFERENCES [dbo].[Contratos] ([IdContrato]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ordens_LocaisEntregaOrdem] FOREIGN KEY ([IdLocalEntregaOrdem]) REFERENCES [dbo].[LocaisEntregaOrdem] ([IdLocalEntregaOrdem]),
    CONSTRAINT [FK_Ordens_ModalidadesCompra] FOREIGN KEY ([IdModalidadeCompra]) REFERENCES [dbo].[ModalidadesCompra] ([IdModalidadeCompra]),
    CONSTRAINT [FK_Ordens_NaturezasOrdens] FOREIGN KEY ([IdNaturezaOrdem]) REFERENCES [dbo].[NaturezasOrdens] ([IdNaturezaOrdem]),
    CONSTRAINT [FK_Ordens_ProcessosCompServ] FOREIGN KEY ([IdProcesso]) REFERENCES [dbo].[ProcessosCompServ] ([IdProcesso]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ordens_Requisitante] FOREIGN KEY ([IdResponsavelRequisitante]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]),
    CONSTRAINT [FK_Ordens_Responsaveis] FOREIGN KEY ([IdResponsavelComprador]) REFERENCES [dbo].[Responsaveis] ([IdResponsavel]),
    CONSTRAINT [FK_Ordens_Servicos] FOREIGN KEY ([IdServico]) REFERENCES [dbo].[Servicos] ([IdServico]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[Ordens] NOCHECK CONSTRAINT [FK_Ordens_Contratos];


GO
ALTER TABLE [dbo].[Ordens] NOCHECK CONSTRAINT [FK_Ordens_ProcessosCompServ];


GO
CREATE TRIGGER [TrgLog_Ordens] ON [Implanta_CRPAM].[dbo].[Ordens] 
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
SET @TableName = 'Ordens'
IF   ( @CountI   =   1  )  AND 
     ( @CountD   =   1  ) 
BEGIN 
	SET @TipoOperacao = 'Alteração' 
 	SELECT @Conteudo = 'IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroOrdem : «' + RTRIM( ISNULL( CAST (NumeroOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Empenho : «' + RTRIM( ISNULL( CAST (Empenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOrdem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOrdem, 113 ),'Nulo'))+'» '
                         + '| DataPrevista : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevista, 113 ),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeradaSolicitacao IS NULL THEN ' GeradaSolicitacao : «Nulo» '
                                              WHEN  GeradaSolicitacao = 0 THEN ' GeradaSolicitacao : «Falso» '
                                              WHEN  GeradaSolicitacao = 1 THEN ' GeradaSolicitacao : «Verdadeiro» '
                                    END 
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorSemDesconto : «' + RTRIM( ISNULL( CAST (ValorSemDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| AnoEmpenho : «' + RTRIM( ISNULL( CAST (AnoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroMemorando : «' + RTRIM( ISNULL( CAST (NumeroMemorando AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VencimentoNotaFiscal : «' + RTRIM( ISNULL( CONVERT (CHAR, VencimentoNotaFiscal, 113 ),'Nulo'))+'» '
                         + '| FreteValor : «' + RTRIM( ISNULL( CAST (FreteValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModalidadeCompra : «' + RTRIM( ISNULL( CAST (IdModalidadeCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelComprador : «' + RTRIM( ISNULL( CAST (IdResponsavelComprador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNaturezaOrdem : «' + RTRIM( ISNULL( CAST (IdNaturezaOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLocalEntregaOrdem : «' + RTRIM( ISNULL( CAST (IdLocalEntregaOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailEnviado : «' + RTRIM( ISNULL( CONVERT (CHAR, EmailEnviado, 113 ),'Nulo'))+'» '
                         + '| IdResponsavelRequisitante : «' + RTRIM( ISNULL( CAST (IdResponsavelRequisitante AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	SELECT @Conteudo2 = 'IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroOrdem : «' + RTRIM( ISNULL( CAST (NumeroOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Empenho : «' + RTRIM( ISNULL( CAST (Empenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOrdem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOrdem, 113 ),'Nulo'))+'» '
                         + '| DataPrevista : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevista, 113 ),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeradaSolicitacao IS NULL THEN ' GeradaSolicitacao : «Nulo» '
                                              WHEN  GeradaSolicitacao = 0 THEN ' GeradaSolicitacao : «Falso» '
                                              WHEN  GeradaSolicitacao = 1 THEN ' GeradaSolicitacao : «Verdadeiro» '
                                    END 
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorSemDesconto : «' + RTRIM( ISNULL( CAST (ValorSemDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| AnoEmpenho : «' + RTRIM( ISNULL( CAST (AnoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroMemorando : «' + RTRIM( ISNULL( CAST (NumeroMemorando AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VencimentoNotaFiscal : «' + RTRIM( ISNULL( CONVERT (CHAR, VencimentoNotaFiscal, 113 ),'Nulo'))+'» '
                         + '| FreteValor : «' + RTRIM( ISNULL( CAST (FreteValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModalidadeCompra : «' + RTRIM( ISNULL( CAST (IdModalidadeCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelComprador : «' + RTRIM( ISNULL( CAST (IdResponsavelComprador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNaturezaOrdem : «' + RTRIM( ISNULL( CAST (IdNaturezaOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLocalEntregaOrdem : «' + RTRIM( ISNULL( CAST (IdLocalEntregaOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailEnviado : «' + RTRIM( ISNULL( CONVERT (CHAR, EmailEnviado, 113 ),'Nulo'))+'» '
                         + '| IdResponsavelRequisitante : «' + RTRIM( ISNULL( CAST (IdResponsavelRequisitante AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
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
		SELECT @Conteudo = 'IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroOrdem : «' + RTRIM( ISNULL( CAST (NumeroOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Empenho : «' + RTRIM( ISNULL( CAST (Empenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOrdem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOrdem, 113 ),'Nulo'))+'» '
                         + '| DataPrevista : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevista, 113 ),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeradaSolicitacao IS NULL THEN ' GeradaSolicitacao : «Nulo» '
                                              WHEN  GeradaSolicitacao = 0 THEN ' GeradaSolicitacao : «Falso» '
                                              WHEN  GeradaSolicitacao = 1 THEN ' GeradaSolicitacao : «Verdadeiro» '
                                    END 
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorSemDesconto : «' + RTRIM( ISNULL( CAST (ValorSemDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| AnoEmpenho : «' + RTRIM( ISNULL( CAST (AnoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroMemorando : «' + RTRIM( ISNULL( CAST (NumeroMemorando AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VencimentoNotaFiscal : «' + RTRIM( ISNULL( CONVERT (CHAR, VencimentoNotaFiscal, 113 ),'Nulo'))+'» '
                         + '| FreteValor : «' + RTRIM( ISNULL( CAST (FreteValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModalidadeCompra : «' + RTRIM( ISNULL( CAST (IdModalidadeCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelComprador : «' + RTRIM( ISNULL( CAST (IdResponsavelComprador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNaturezaOrdem : «' + RTRIM( ISNULL( CAST (IdNaturezaOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLocalEntregaOrdem : «' + RTRIM( ISNULL( CAST (IdLocalEntregaOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailEnviado : «' + RTRIM( ISNULL( CONVERT (CHAR, EmailEnviado, 113 ),'Nulo'))+'» '
                         + '| IdResponsavelRequisitante : «' + RTRIM( ISNULL( CAST (IdResponsavelRequisitante AS VARCHAR(3500)),'Nulo'))+'» ' FROM INSERTED 
	END 
	ELSE 
	IF    @CountD    =    1 
	BEGIN 
		SET @TipoOperacao = 'Exclusão' 
		SELECT @Conteudo = 'IdOrdem : «' + RTRIM( ISNULL( CAST (IdOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdProcesso : «' + RTRIM( ISNULL( CAST (IdProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdContrato : «' + RTRIM( ISNULL( CAST (IdContrato AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdServico : «' + RTRIM( ISNULL( CAST (IdServico AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdPessoa : «' + RTRIM( ISNULL( CAST (IdPessoa AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroOrdem : «' + RTRIM( ISNULL( CAST (NumeroOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Valor : «' + RTRIM( ISNULL( CAST (Valor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Empenho : «' + RTRIM( ISNULL( CAST (Empenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataOrdem : «' + RTRIM( ISNULL( CONVERT (CHAR, DataOrdem, 113 ),'Nulo'))+'» '
                         + '| DataPrevista : «' + RTRIM( ISNULL( CONVERT (CHAR, DataPrevista, 113 ),'Nulo'))+'» '
                         + '| NotaFiscal : «' + RTRIM( ISNULL( CAST (NotaFiscal AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProcesso : «' + RTRIM( ISNULL( CAST (NumeroProcesso AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ' +  CASE 
                                              WHEN  GeradaSolicitacao IS NULL THEN ' GeradaSolicitacao : «Nulo» '
                                              WHEN  GeradaSolicitacao = 0 THEN ' GeradaSolicitacao : «Falso» '
                                              WHEN  GeradaSolicitacao = 1 THEN ' GeradaSolicitacao : «Verdadeiro» '
                                    END 
                         + '| Desconto : «' + RTRIM( ISNULL( CAST (Desconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| ValorSemDesconto : «' + RTRIM( ISNULL( CAST (ValorSemDesconto AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| Situacao : «' + RTRIM( ISNULL( CAST (Situacao AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| DataCancelamento : «' + RTRIM( ISNULL( CONVERT (CHAR, DataCancelamento, 113 ),'Nulo'))+'» '
                         + '| AnoEmpenho : «' + RTRIM( ISNULL( CAST (AnoEmpenho AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroMemorando : «' + RTRIM( ISNULL( CAST (NumeroMemorando AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| VencimentoNotaFiscal : «' + RTRIM( ISNULL( CONVERT (CHAR, VencimentoNotaFiscal, 113 ),'Nulo'))+'» '
                         + '| FreteValor : «' + RTRIM( ISNULL( CAST (FreteValor AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| NumeroProtocolo : «' + RTRIM( ISNULL( CAST (NumeroProtocolo AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdModalidadeCompra : «' + RTRIM( ISNULL( CAST (IdModalidadeCompra AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdResponsavelComprador : «' + RTRIM( ISNULL( CAST (IdResponsavelComprador AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdNaturezaOrdem : «' + RTRIM( ISNULL( CAST (IdNaturezaOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| IdLocalEntregaOrdem : «' + RTRIM( ISNULL( CAST (IdLocalEntregaOrdem AS VARCHAR(3500)),'Nulo'))+'» '
                         + '| EmailEnviado : «' + RTRIM( ISNULL( CONVERT (CHAR, EmailEnviado, 113 ),'Nulo'))+'» '
                         + '| IdResponsavelRequisitante : «' + RTRIM( ISNULL( CAST (IdResponsavelRequisitante AS VARCHAR(3500)),'Nulo'))+'» ' FROM DELETED 
	END 
IF @TipoOperacao IS NOT NULL 
 INSERT [implantaLog].[dbo].[LOG] (Sistema, Usuario, Tabela, TipoOperacao, Conteudo, NomeBanco) 
	VALUES (app_name(), host_name(), @TableName, @TipoOperacao, @Conteudo, DB_NAME()) 
END 
